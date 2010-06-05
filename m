From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat,  5 Jun 2010 15:55:35 +0800
Subject: [PATCH 1/4] [ARM] Remove now unnecessary dma_needs_bounce()
In-Reply-To: <1275724538-5075-1-git-send-email-eric.y.miao@gmail.com>
References: <1275724538-5075-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1275724538-5075-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a correct dev->dma_mask before calling dmabounce_register_dev(),
dma_needs_bounce() is not necessary.

The above is true for it8152.c and ixp4xx/common-pci.c.

The sa1111, though, is a bit complicated. Until it's fully understood
and fixed, dma_needs_bounce() for sa1111 is kept if CONFIG_SA1111 is
enabled with no side effect (with the condition of machine_is_*)

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/common/it8152.c           |    8 --------
 arch/arm/include/asm/dma-mapping.h |    7 +++++++
 arch/arm/mach-ixp4xx/common-pci.c  |    5 -----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 7974baa..6c09135 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -263,14 +263,6 @@ static int it8152_pci_platform_notify_remove(struct device *dev)
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
 int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	it8152_io.start = IT8152_IO_BASE + 0x12000;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 69ce072..c80d4d2 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -298,7 +298,14 @@ extern void dmabounce_unregister_dev(struct device *);
  * DMA access and 1 if the buffer needs to be bounced.
  *
  */
+#ifdef CONFIG_SA1111
 extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
+#else
+static inline int dma_needs_bounce(struct device*, dma_addr_t, size_t)
+{
+	return 0;
+}
+#endif
 
 /*
  * The DMA API, implemented by dmabounce.c.  See below for descriptions.
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index e318153..c7aa0ac 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -337,11 +337,6 @@ static int ixp4xx_pci_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-int dma_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
-{
-	return (dev->bus == &pci_bus_type ) && ((dma_addr + size) >= SZ_64M);
-}
-
 /*
  * Only first 64MB of memory can be accessed via PCI.
  * We use GFP_DMA to allocate safe buffers to do map/unmap.
-- 
1.7.0.4
