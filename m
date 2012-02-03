From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:59:57 +0000
Subject: [PATCH 16/20] ARM: sa1111: register sa1111 devices with dmabounce in
 bus notifier
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPIb-00044i-Ht@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the bus notifier to register sa1111 devices with dmabounce, rather
than after the device has been registered, potentially racing with
driver binding.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |  129 ++++++++++++++++++++++++++-------------------
 1 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 17694cf..7b4351b 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -603,36 +603,6 @@ sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
 }
 #endif
 
-#ifdef CONFIG_DMABOUNCE
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
-static int sa1111_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
-{
-	/*
-	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
-	 * User's Guide" mentions that jumpers R51 and R52 control the
-	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
-	 * SDRAM bank 1 on Neponset). The default configuration selects
-	 * Assabet, so any address in bank 1 is necessarily invalid.
-	 */
-	return (machine_is_assabet() || machine_is_pfs168()) &&
-		(addr >= 0xc8000000 || (addr + size) >= 0xc8000000);
-}
-#endif
-
 static void sa1111_dev_release(struct device *_dev)
 {
 	struct sa1111_dev *dev = SA1111_DEV(_dev);
@@ -660,7 +630,6 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	dev->dev.parent  = sachip->dev;
 	dev->dev.bus     = &sa1111_bus_type;
 	dev->dev.release = sa1111_dev_release;
-	dev->dev.coherent_dma_mask = sachip->dev->coherent_dma_mask;
 	dev->res.start   = sachip->phys + info->offset;
 	dev->res.end     = dev->res.start + 511;
 	dev->res.name    = dev_name(&dev->dev);
@@ -671,6 +640,16 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	for (i = 0; i < ARRAY_SIZE(info->irq); i++)
 		dev->irq[i] = sachip->irq_base + info->irq[i];
 
+	/*
+	 * If the parent device has a DMA mask associated with it,
+	 * propagate it down to the children.
+	 */
+	if (sachip->dev->dma_mask) {
+		dev->dma_mask = *sachip->dev->dma_mask;
+		dev->dev.dma_mask = &dev->dma_mask;
+		dev->dev.coherent_dma_mask = sachip->dev->coherent_dma_mask;
+	}
+
 	ret = request_resource(parent, &dev->res);
 	if (ret) {
 		printk("SA1111: failed to allocate resource for %s\n",
@@ -680,36 +659,12 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 		goto out;
 	}
 
-
 	ret = device_register(&dev->dev);
 	if (ret) {
 		release_resource(&dev->res);
 		kfree(dev);
-		goto out;
-	}
-
-#ifdef CONFIG_DMABOUNCE
-	/*
-	 * If the parent device has a DMA mask associated with it,
-	 * propagate it down to the children.
-	 */
-	if (sachip->dev->dma_mask) {
-		dev->dma_mask = *sachip->dev->dma_mask;
-		dev->dev.dma_mask = &dev->dma_mask;
-
-		if (dev->dma_mask != 0xffffffffUL) {
-			ret = dmabounce_register_dev(&dev->dev, 1024, 4096,
-					sa1111_needs_bounce);
-			if (ret) {
-				dev_err(&dev->dev, "SA1111: Failed to register"
-					" with dmabounce\n");
-				device_unregister(&dev->dev);
-			}
-		}
 	}
-#endif
 
-out:
 	return ret;
 }
 
@@ -1411,9 +1366,70 @@ void sa1111_driver_unregister(struct sa1111_driver *driver)
 }
 EXPORT_SYMBOL(sa1111_driver_unregister);
 
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
+
+static int sa1111_notifier_call(struct notifier_block *n, unsigned long action,
+	void *data)
+{
+	struct sa1111_dev *dev = SA1111_DEV(data);
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL) {
+			int ret = dmabounce_register_dev(&dev->dev, 1024, 4096,
+					sa1111_needs_bounce);
+			if (ret)
+				dev_err(&dev->dev, "failed to register with dmabounce: %d\n", ret);
+		}
+		break;
+
+	case BUS_NOTIFY_DEL_DEVICE:
+		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL)
+			dmabounce_unregister_dev(&dev->dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sa1111_bus_notifier = {
+	.notifier_call = sa1111_notifier_call,
+};
+#endif
+
 static int __init sa1111_init(void)
 {
 	int ret = bus_register(&sa1111_bus_type);
+#ifdef CONFIG_DMABOUNCE
+	if (ret == 0)
+		bus_register_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
+#endif
 	if (ret == 0)
 		platform_driver_register(&sa1111_device_driver);
 	return ret;
@@ -1422,6 +1438,9 @@ static int __init sa1111_init(void)
 static void __exit sa1111_exit(void)
 {
 	platform_driver_unregister(&sa1111_device_driver);
+#ifdef CONFIG_DMABOUNCE
+	bus_unregister_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
+#endif
 	bus_unregister(&sa1111_bus_type);
 }
 
-- 
1.7.4.4
