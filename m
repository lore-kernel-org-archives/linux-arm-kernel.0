From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:50:37 +0100
Subject: [PATCH 09/10] ARM: dmabounce: get rid of dma_needs_bounce global
	function
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QderV-0000Ze-3q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the device type specific needs_bounce function in at dmabounce
register time, avoiding the need for a platform specific global
function to do this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c        |    8 +++-
 arch/arm/common/it8152.c           |   17 +++++-----
 arch/arm/common/sa1111.c           |   60 ++++++++++++++++++-----------------
 arch/arm/include/asm/dma-mapping.h |   22 +------------
 arch/arm/mach-ixp4xx/common-pci.c  |   12 +++---
 5 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 4f13505..595ecd2 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -79,6 +79,8 @@ struct dmabounce_device_info {
 	struct dmabounce_pool	large;
 
 	rwlock_t lock;
+
+	int (*needs_bounce)(struct device *, dma_addr_t, size_t);
 };
 
 #ifdef STATS
@@ -236,7 +238,7 @@ static int needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
 			return 1;
 	}
 
-	return dma_needs_bounce(dev, dma_addr, size) ? 1 : 0;
+	return !!dev->archdata.dmabounce->needs_bounce(dev, dma_addr, size);
 }
 
 static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
@@ -430,7 +432,8 @@ static int dmabounce_init_pool(struct dmabounce_pool *pool, struct device *dev,
 }
 
 int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
-		unsigned long large_buffer_size)
+		unsigned long large_buffer_size,
+		int (*needs_bounce_fn)(struct device *, dma_addr_t, size_t))
 {
 	struct dmabounce_device_info *device_info;
 	int ret;
@@ -466,6 +469,7 @@ int dmabounce_register_dev(struct device *dev, unsigned long small_buffer_size,
 	device_info->dev = dev;
 	INIT_LIST_HEAD(&device_info->safe_buffers);
 	rwlock_init(&device_info->lock);
+	device_info->needs_bounce = needs_bounce_fn;
 
 #ifdef STATS
 	device_info->total_allocs = 0;
diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 7a21927..80b49e1 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -243,6 +243,13 @@ static struct resource it8152_mem = {
  * ITE8152 chip can address up to 64MByte, so all the devices
  * connected to ITE8152 (PCI and USB) should have limited DMA window
  */
+static int it8152_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
+{
+	dev_dbg(dev, "%s: dma_addr %08x, size %08x\n",
+		__func__, dma_addr, size);
+	return dev->bus == &pci_bus_type &&
+		(dma_addr + size - PHYS_OFFSET) >= SZ_64M;
+}
 
 /*
  * Setup DMA mask to 64MB on devices connected to ITE8152. Ignore all
@@ -254,7 +261,7 @@ static int it8152_pci_platform_notify(struct device *dev)
 		if (dev->dma_mask)
 			*dev->dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
 		dev->coherent_dma_mask = (SZ_64M - 1) | PHYS_OFFSET;
-		dmabounce_register_dev(dev, 2048, 4096);
+		dmabounce_register_dev(dev, 2048, 4096, it8152_needs_bounce);
 	}
 	return 0;
 }
@@ -267,14 +274,6 @@ static int it8152_pci_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-int dma_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
-{
-	dev_dbg(dev, "%s: dma_addr %08x, size %08x\n",
-		__func__, dma_addr, size);
-	return (dev->bus == &pci_bus_type) &&
-		((dma_addr + size - PHYS_OFFSET) >= SZ_64M);
-}
-
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
 	if (mask >= PHYS_OFFSET + SZ_64M - 1)
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 9c49a46..0569de6 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -579,7 +579,36 @@ sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
 
 	sachip->dev->coherent_dma_mask &= sa1111_dma_mask[drac >> 2];
 }
+#endif
 
+#ifdef CONFIG_DMABOUNCE
+/*
+ * According to the "Intel StrongARM SA-1111 Microprocessor Companion
+ * Chip Specification Update" (June 2000), erratum #7, there is a
+ * significant bug in the SA1111 SDRAM shared memory controller.  If
+ * an access to a region of memory above 1MB relative to the bank base,
+ * it is important that address bit 10 _NOT_ be asserted. Depending
+ * on the configuration of the RAM, bit 10 may correspond to one
+ * of several different (processor-relative) address bits.
+ *
+ * This routine only identifies whether or not a given DMA address
+ * is susceptible to the bug.
+ *
+ * This should only get called for sa1111_device types due to the
+ * way we configure our device dma_masks.
+ */
+static int sa1111_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
+{
+	/*
+	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
+	 * User's Guide" mentions that jumpers R51 and R52 control the
+	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
+	 * SDRAM bank 1 on Neponset). The default configuration selects
+	 * Assabet, so any address in bank 1 is necessarily invalid.
+	 */
+	return (machine_is_assabet() || machine_is_pfs168()) &&
+		(addr >= 0xc8000000 || (addr + size) >= 0xc8000000);
+}
 #endif
 
 static void sa1111_dev_release(struct device *_dev)
@@ -644,7 +673,8 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 		dev->dev.dma_mask = &dev->dma_mask;
 
 		if (dev->dma_mask != 0xffffffffUL) {
-			ret = dmabounce_register_dev(&dev->dev, 1024, 4096);
+			ret = dmabounce_register_dev(&dev->dev, 1024, 4096,
+					sa1111_needs_bounce);
 			if (ret) {
 				dev_err(&dev->dev, "SA1111: Failed to register"
 					" with dmabounce\n");
@@ -818,34 +848,6 @@ static void __sa1111_remove(struct sa1111 *sachip)
 	kfree(sachip);
 }
 
-/*
- * According to the "Intel StrongARM SA-1111 Microprocessor Companion
- * Chip Specification Update" (June 2000), erratum #7, there is a
- * significant bug in the SA1111 SDRAM shared memory controller.  If
- * an access to a region of memory above 1MB relative to the bank base,
- * it is important that address bit 10 _NOT_ be asserted. Depending
- * on the configuration of the RAM, bit 10 may correspond to one
- * of several different (processor-relative) address bits.
- *
- * This routine only identifies whether or not a given DMA address
- * is susceptible to the bug.
- *
- * This should only get called for sa1111_device types due to the
- * way we configure our device dma_masks.
- */
-int dma_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
-{
-	/*
-	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
-	 * User's Guide" mentions that jumpers R51 and R52 control the
-	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
-	 * SDRAM bank 1 on Neponset). The default configuration selects
-	 * Assabet, so any address in bank 1 is necessarily invalid.
-	 */
-	return ((machine_is_assabet() || machine_is_pfs168()) &&
-		(addr >= 0xc8000000 || (addr + size) >= 0xc8000000));
-}
-
 struct sa1111_save_data {
 	unsigned int	skcr;
 	unsigned int	skpcr;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index d2903d0..4ad2533 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -256,14 +256,14 @@ int dma_mmap_writecombine(struct device *, struct vm_area_struct *,
  * @dev: valid struct device pointer
  * @small_buf_size: size of buffers to use with small buffer pool
  * @large_buf_size: size of buffers to use with large buffer pool (can be 0)
+ * @needs_bounce_fn: called to determine whether buffer needs bouncing
  *
  * This function should be called by low-level platform code to register
  * a device as requireing DMA buffer bouncing. The function will allocate
  * appropriate DMA pools for the device.
- *
  */
 extern int dmabounce_register_dev(struct device *, unsigned long,
-		unsigned long);
+		unsigned long, int (*)(struct device *, dma_addr_t, size_t));
 
 /**
  * dmabounce_unregister_dev
@@ -277,24 +277,6 @@ extern int dmabounce_register_dev(struct device *, unsigned long,
  */
 extern void dmabounce_unregister_dev(struct device *);
 
-/**
- * dma_needs_bounce
- *
- * @dev: valid struct device pointer
- * @dma_handle: dma_handle of unbounced buffer
- * @size: size of region being mapped
- *
- * Platforms that utilize the dmabounce mechanism must implement
- * this function.
- *
- * The dmabounce routines call this function whenever a dma-mapping
- * is requested to determine whether a given buffer needs to be bounced
- * or not. The function must return 0 if the buffer is OK for
- * DMA access and 1 if the buffer needs to be bounced.
- *
- */
-extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
-
 /*
  * The DMA API, implemented by dmabounce.c.  See below for descriptions.
  */
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index e9a5893..d7db10c 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -316,6 +316,11 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 }
 
 
+static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
+{
+	return dev->bus == &pci_bus_type && (dma_addr + size) >= SZ_64M;
+}
+
 /*
  * Setup DMA mask to 64MB on PCI devices. Ignore all other devices.
  */
@@ -324,7 +329,7 @@ static int ixp4xx_pci_platform_notify(struct device *dev)
 	if(dev->bus == &pci_bus_type) {
 		*dev->dma_mask =  SZ_64M - 1;
 		dev->coherent_dma_mask = SZ_64M - 1;
-		dmabounce_register_dev(dev, 2048, 4096);
+		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
 	}
 	return 0;
 }
@@ -337,11 +342,6 @@ static int ixp4xx_pci_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-int dma_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
-{
-	return (dev->bus == &pci_bus_type ) && ((dma_addr + size) >= SZ_64M);
-}
-
 void __init ixp4xx_pci_preinit(void)
 {
 	unsigned long cpuid = read_cpuid_id();
-- 
1.7.4.4
