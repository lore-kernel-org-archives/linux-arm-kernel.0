From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:21:24 +0200
Subject: [PATCH 9/10] IXP4xx: Always ioremap() Queue Manager MMIO region at
 boot.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3d31g30or.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make much sense to map QMgr dynamically - we almost always need it
and the static mapping will be needed for little-endian data-coherent operation
(to make QMgr region value-coherent).

--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -67,6 +67,11 @@ static struct map_desc ixp4xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(IXP4XX_PCI_CFG_BASE_PHYS),
 		.length		= IXP4XX_PCI_CFG_REGION_SIZE,
 		.type		= MT_DEVICE
+	}, {	/* Queue Manager */
+		.virtual	= IXP4XX_QMGR_BASE_VIRT,
+		.pfn		= __phys_to_pfn(IXP4XX_QMGR_BASE_PHYS),
+		.length		= IXP4XX_QMGR_REGION_SIZE,
+		.type		= MT_DEVICE
 	},
 #ifdef CONFIG_DEBUG_LL
 	{	/* Debug UART mapping */
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -30,19 +30,20 @@
  *
  * 0x50000000	0x10000000	ioremap'd	EXP BUS
  *
- * 0x6000000	0x00004000	ioremap'd	QMgr
+ * 0x60000000	0x00004000	0xffbe7000	QMgr
  *
- * 0xC0000000	0x00001000	0xffbff000	PCI CFG
+ * 0xC8000000	0x00013000	0xffbeb000	On-Chip Peripherals
  *
  * 0xC4000000	0x00001000	0xffbfe000	EXP CFG
  *
- * 0xC8000000	0x00013000	0xffbeb000	On-Chip Peripherals
+ * 0xC0000000	0x00001000	0xffbff000	PCI CFG
  */
 
 /*
  * Queue Manager
  */
 #define IXP4XX_QMGR_BASE_PHYS		(0x60000000)
+#define IXP4XX_QMGR_BASE_VIRT		IOMEM(0xFFBE7000)
 #define IXP4XX_QMGR_REGION_SIZE		(0x00004000)
 
 /*
--- a/arch/arm/mach-ixp4xx/include/mach/qmgr.h
+++ b/arch/arm/mach-ixp4xx/include/mach/qmgr.h
@@ -86,7 +86,7 @@ void qmgr_release_queue(unsigned int queue);
 
 static inline void qmgr_put_entry(unsigned int queue, u32 val)
 {
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 #if DEBUG_QMGR
 	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
 
@@ -99,7 +99,7 @@ static inline void qmgr_put_entry(unsigned int queue, u32 val)
 static inline u32 qmgr_get_entry(unsigned int queue)
 {
 	u32 val;
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 	val = __raw_readl(&qmgr_regs->acc[queue][0]);
 #if DEBUG_QMGR
 	BUG_ON(!qmgr_queue_descs[queue]); /* not yet requested */
@@ -112,14 +112,14 @@ static inline u32 qmgr_get_entry(unsigned int queue)
 
 static inline int __qmgr_get_stat1(unsigned int queue)
 {
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 	return (__raw_readl(&qmgr_regs->stat1[queue >> 3])
 		>> ((queue & 7) << 2)) & 0xF;
 }
 
 static inline int __qmgr_get_stat2(unsigned int queue)
 {
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 	BUG_ON(queue >= HALF_QUEUES);
 	return (__raw_readl(&qmgr_regs->stat2[queue >> 4])
 		>> ((queue & 0xF) << 1)) & 0x3;
@@ -145,7 +145,7 @@ static inline int qmgr_stat_empty(unsigned int queue)
  */
 static inline int qmgr_stat_below_low_watermark(unsigned int queue)
 {
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 	if (queue >= HALF_QUEUES)
 		return (__raw_readl(&qmgr_regs->statne_h) >>
 			(queue - HALF_QUEUES)) & 0x01;
@@ -172,7 +172,7 @@ static inline int qmgr_stat_above_high_watermark(unsigned int queue)
  */
 static inline int qmgr_stat_full(unsigned int queue)
 {
-	extern struct qmgr_regs __iomem *qmgr_regs;
+	const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 	if (queue >= HALF_QUEUES)
 		return (__raw_readl(&qmgr_regs->statf_h) >>
 			(queue - HALF_QUEUES)) & 0x01;
--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <mach/qmgr.h>
 
-struct qmgr_regs __iomem *qmgr_regs;
+static const struct qmgr_regs __iomem *qmgr_regs = (void __iomem *)IXP4XX_QMGR_BASE_VIRT;
 static struct resource *mem_res;
 static spinlock_t qmgr_lock;
 static u32 used_sram_bitmap[4]; /* 128 16-dword pages */
@@ -32,7 +32,7 @@ void qmgr_set_irq(unsigned int queue, int src,
 
 	spin_lock_irqsave(&qmgr_lock, flags);
 	if (queue < HALF_QUEUES) {
-		u32 __iomem *reg;
+		const u32 __iomem *reg;
 		int bit;
 		BUG_ON(src > QUEUE_IRQ_SRC_NOT_FULL);
 		reg = &qmgr_regs->irqsrc[queue >> 3]; /* 8 queues per u32 */
@@ -293,12 +293,6 @@ static int qmgr_init(void)
 	if (mem_res == NULL)
 		return -EBUSY;
 
-	qmgr_regs = ioremap(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
-	if (qmgr_regs == NULL) {
-		err = -ENOMEM;
-		goto error_map;
-	}
-
 	/* reset qmgr registers */
 	for (i = 0; i < 4; i++) {
 		__raw_writel(0x33333333, &qmgr_regs->stat1[i]);
@@ -347,8 +341,6 @@ static int qmgr_init(void)
 error_irq2:
 	free_irq(IRQ_IXP4XX_QM1, NULL);
 error_irq:
-	iounmap(qmgr_regs);
-error_map:
 	release_mem_region(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
 	return err;
 }
@@ -359,7 +351,6 @@ static void qmgr_remove(void)
 	free_irq(IRQ_IXP4XX_QM2, NULL);
 	synchronize_irq(IRQ_IXP4XX_QM1);
 	synchronize_irq(IRQ_IXP4XX_QM2);
-	iounmap(qmgr_regs);
 	release_mem_region(IXP4XX_QMGR_BASE_PHYS, IXP4XX_QMGR_REGION_SIZE);
 }
 
@@ -369,7 +360,6 @@ module_exit(qmgr_remove);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Krzysztof Halasa");
 
-EXPORT_SYMBOL(qmgr_regs);
 EXPORT_SYMBOL(qmgr_set_irq);
 EXPORT_SYMBOL(qmgr_enable_irq);
 EXPORT_SYMBOL(qmgr_disable_irq);

-- 
Krzysztof Halasa
