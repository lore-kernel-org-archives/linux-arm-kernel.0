From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 14 Dec 2010 22:44:58 +0100
Subject: [PATCH 1/3] ARM: s3c24xx: irq_data conversion.
Message-ID: <929a34e7a1cc775b36e3196b3e10d8cf591a7c03.1292364161.git.buytenh@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-s3c2410/bast-irq.c         |   22 ++--
 arch/arm/mach-s3c2412/irq.c              |   50 +++++-----
 arch/arm/mach-s3c2416/irq.c              |   76 +++++++-------
 arch/arm/mach-s3c2440/irq.c              |   18 ++--
 arch/arm/mach-s3c2440/s3c244x-irq.c      |   18 ++--
 arch/arm/mach-s3c2443/irq.c              |   95 ++++++++---------
 arch/arm/plat-s3c24xx/include/plat/irq.h |    4 +-
 arch/arm/plat-s3c24xx/irq-pm.c           |    9 +-
 arch/arm/plat-s3c24xx/irq.c              |  170 +++++++++++++++---------------
 9 files changed, 227 insertions(+), 235 deletions(-)

diff --git a/arch/arm/mach-s3c2410/bast-irq.c b/arch/arm/mach-s3c2410/bast-irq.c
index 217b102..606cb6b 100644
--- a/arch/arm/mach-s3c2410/bast-irq.c
+++ b/arch/arm/mach-s3c2410/bast-irq.c
@@ -75,38 +75,38 @@ static unsigned char bast_pc104_irqmasks[] = {
 static unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };
 
 static void
-bast_pc104_mask(unsigned int irqno)
+bast_pc104_mask(struct irq_data *data)
 {
 	unsigned long temp;
 
 	temp = __raw_readb(BAST_VA_PC104_IRQMASK);
-	temp &= ~bast_pc104_irqmasks[irqno];
+	temp &= ~bast_pc104_irqmasks[data->irq];
 	__raw_writeb(temp, BAST_VA_PC104_IRQMASK);
 }
 
 static void
-bast_pc104_maskack(unsigned int irqno)
+bast_pc104_maskack(struct irq_data *data)
 {
 	struct irq_desc *desc = irq_desc + IRQ_ISA;
 
-	bast_pc104_mask(irqno);
-	desc->chip->ack(IRQ_ISA);
+	bast_pc104_mask(data);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 }
 
 static void
-bast_pc104_unmask(unsigned int irqno)
+bast_pc104_unmask(struct irq_data *data)
 {
 	unsigned long temp;
 
 	temp = __raw_readb(BAST_VA_PC104_IRQMASK);
-	temp |= bast_pc104_irqmasks[irqno];
+	temp |= bast_pc104_irqmasks[data->irq];
 	__raw_writeb(temp, BAST_VA_PC104_IRQMASK);
 }
 
 static struct irq_chip  bast_pc104_chip = {
-	.mask	     = bast_pc104_mask,
-	.unmask	     = bast_pc104_unmask,
-	.ack	     = bast_pc104_maskack
+	.irq_mask	= bast_pc104_mask,
+	.irq_unmask	= bast_pc104_unmask,
+	.irq_ack	= bast_pc104_maskack
 };
 
 static void
@@ -123,7 +123,7 @@ bast_irq_pc104_demux(unsigned int irq,
 		/* ack if we get an irq with nothing (ie, startup) */
 
 		desc = irq_desc + IRQ_ISA;
-		desc->chip->ack(IRQ_ISA);
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 	} else {
 		/* handle the IRQ */
 
diff --git a/arch/arm/mach-s3c2412/irq.c b/arch/arm/mach-s3c2412/irq.c
index 6000ca9..eddb52b 100644
--- a/arch/arm/mach-s3c2412/irq.c
+++ b/arch/arm/mach-s3c2412/irq.c
@@ -49,9 +49,9 @@
 */
 
 static void
-s3c2412_irq_mask(unsigned int irqno)
+s3c2412_irq_mask(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2410_INTMSK);
@@ -62,9 +62,9 @@ s3c2412_irq_mask(unsigned int irqno)
 }
 
 static inline void
-s3c2412_irq_ack(unsigned int irqno)
+s3c2412_irq_ack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 
 	__raw_writel(bitval, S3C2412_EINTPEND);
 	__raw_writel(bitval, S3C2410_SRCPND);
@@ -72,9 +72,9 @@ s3c2412_irq_ack(unsigned int irqno)
 }
 
 static inline void
-s3c2412_irq_maskack(unsigned int irqno)
+s3c2412_irq_maskack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2410_INTMSK);
@@ -89,9 +89,9 @@ s3c2412_irq_maskack(unsigned int irqno)
 }
 
 static void
-s3c2412_irq_unmask(unsigned int irqno)
+s3c2412_irq_unmask(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2412_EINTMASK);
@@ -102,11 +102,11 @@ s3c2412_irq_unmask(unsigned int irqno)
 }
 
 static struct irq_chip s3c2412_irq_eint0t4 = {
-	.ack	   = s3c2412_irq_ack,
-	.mask	   = s3c2412_irq_mask,
-	.unmask	   = s3c2412_irq_unmask,
-	.set_wake  = s3c_irq_wake,
-	.set_type  = s3c_irqext_type,
+	.irq_ack	= s3c2412_irq_ack,
+	.irq_mask	= s3c2412_irq_mask,
+	.irq_unmask	= s3c2412_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake,
+	.irq_set_type	= s3c_irqext_type,
 };
 
 #define INTBIT(x)	(1 << ((x) - S3C2410_IRQSUB(0)))
@@ -132,29 +132,29 @@ static void s3c2412_irq_demux_cfsdi(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_CFSDI	(1UL << (IRQ_S3C2412_CFSDI - IRQ_EINT0))
 #define SUBMSK_CFSDI	INTMSK_SUB(IRQ_S3C2412_SDI, IRQ_S3C2412_CF)
 
-static void s3c2412_irq_cfsdi_mask(unsigned int irqno)
+static void s3c2412_irq_cfsdi_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_CFSDI, SUBMSK_CFSDI);
+	s3c_irqsub_mask(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
 }
 
-static void s3c2412_irq_cfsdi_unmask(unsigned int irqno)
+static void s3c2412_irq_cfsdi_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_CFSDI);
+	s3c_irqsub_unmask(data->irq, INTMSK_CFSDI);
 }
 
-static void s3c2412_irq_cfsdi_ack(unsigned int irqno)
+static void s3c2412_irq_cfsdi_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_CFSDI, SUBMSK_CFSDI);
+	s3c_irqsub_maskack(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
 }
 
 static struct irq_chip s3c2412_irq_cfsdi = {
 	.name		= "s3c2412-cfsdi",
-	.ack		= s3c2412_irq_cfsdi_ack,
-	.mask		= s3c2412_irq_cfsdi_mask,
-	.unmask		= s3c2412_irq_cfsdi_unmask,
+	.irq_ack	= s3c2412_irq_cfsdi_ack,
+	.irq_mask	= s3c2412_irq_cfsdi_mask,
+	.irq_unmask	= s3c2412_irq_cfsdi_unmask,
 };
 
-static int s3c2412_irq_rtc_wake(unsigned int irqno, unsigned int state)
+static int s3c2412_irq_rtc_wake(struct irq_data *data, unsigned int state)
 {
 	unsigned long pwrcfg;
 
@@ -165,7 +165,7 @@ static int s3c2412_irq_rtc_wake(unsigned int irqno, unsigned int state)
 		pwrcfg |= S3C2412_PWRCFG_RTC_MASKIRQ;
 	__raw_writel(pwrcfg, S3C2412_PWRCFG);
 
-	return s3c_irq_chip.set_wake(irqno, state);
+	return s3c_irq_chip.irq_set_wake(data, state);
 }
 
 static struct irq_chip s3c2412_irq_rtc_chip;
@@ -193,7 +193,7 @@ static int s3c2412_irq_add(struct sys_device *sysdev)
 	/* change RTC IRQ's set wake method */
 
 	s3c2412_irq_rtc_chip = s3c_irq_chip;
-	s3c2412_irq_rtc_chip.set_wake = s3c2412_irq_rtc_wake;
+	s3c2412_irq_rtc_chip.irq_set_wake = s3c2412_irq_rtc_wake;
 
 	set_irq_chip(IRQ_RTC, &s3c2412_irq_rtc_chip);
 
diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
index 00174da..680fe38 100644
--- a/arch/arm/mach-s3c2416/irq.c
+++ b/arch/arm/mach-s3c2416/irq.c
@@ -77,28 +77,27 @@ static void s3c2416_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
 #define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
 
-static void s3c2416_irq_wdtac97_mask(unsigned int irqno)
+static void s3c2416_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
-static void s3c2416_irq_wdtac97_unmask(unsigned int irqno)
+static void s3c2416_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_WDTAC97);
+	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
 }
 
-static void s3c2416_irq_wdtac97_ack(unsigned int irqno)
+static void s3c2416_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static struct irq_chip s3c2416_irq_wdtac97 = {
-	.mask	    = s3c2416_irq_wdtac97_mask,
-	.unmask	    = s3c2416_irq_wdtac97_unmask,
-	.ack	    = s3c2416_irq_wdtac97_ack,
+	.irq_mask	= s3c2416_irq_wdtac97_mask,
+	.irq_unmask	= s3c2416_irq_wdtac97_unmask,
+	.irq_ack	= s3c2416_irq_wdtac97_ack,
 };
 
-
 /* LCD sub interrupts */
 
 static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
@@ -109,28 +108,27 @@ static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
 #define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
 
-static void s3c2416_irq_lcd_mask(unsigned int irqno)
+static void s3c2416_irq_lcd_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
 }
 
-static void s3c2416_irq_lcd_unmask(unsigned int irqno)
+static void s3c2416_irq_lcd_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_LCD);
+	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
 }
 
-static void s3c2416_irq_lcd_ack(unsigned int irqno)
+static void s3c2416_irq_lcd_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static struct irq_chip s3c2416_irq_lcd = {
-	.mask	    = s3c2416_irq_lcd_mask,
-	.unmask	    = s3c2416_irq_lcd_unmask,
-	.ack	    = s3c2416_irq_lcd_ack,
+	.irq_mask	= s3c2416_irq_lcd_mask,
+	.irq_unmask	= s3c2416_irq_lcd_unmask,
+	.irq_ack	= s3c2416_irq_lcd_ack,
 };
 
-
 /* DMA sub interrupts */
 
 static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
@@ -142,28 +140,27 @@ static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
 #define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
 
 
-static void s3c2416_irq_dma_mask(unsigned int irqno)
+static void s3c2416_irq_dma_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
 }
 
-static void s3c2416_irq_dma_unmask(unsigned int irqno)
+static void s3c2416_irq_dma_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_DMA);
+	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
 }
 
-static void s3c2416_irq_dma_ack(unsigned int irqno)
+static void s3c2416_irq_dma_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static struct irq_chip s3c2416_irq_dma = {
-	.mask	    = s3c2416_irq_dma_mask,
-	.unmask	    = s3c2416_irq_dma_unmask,
-	.ack	    = s3c2416_irq_dma_ack,
+	.irq_mask	= s3c2416_irq_dma_mask,
+	.irq_unmask	= s3c2416_irq_dma_unmask,
+	.irq_ack	= s3c2416_irq_dma_ack,
 };
 
-
 /* UART3 sub interrupts */
 
 static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
@@ -174,28 +171,27 @@ static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
 #define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
 
-static void s3c2416_irq_uart3_mask(unsigned int irqno)
+static void s3c2416_irq_uart3_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
 }
 
-static void s3c2416_irq_uart3_unmask(unsigned int irqno)
+static void s3c2416_irq_uart3_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_UART3);
+	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
 }
 
-static void s3c2416_irq_uart3_ack(unsigned int irqno)
+static void s3c2416_irq_uart3_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static struct irq_chip s3c2416_irq_uart3 = {
-	.mask	    = s3c2416_irq_uart3_mask,
-	.unmask	    = s3c2416_irq_uart3_unmask,
-	.ack	    = s3c2416_irq_uart3_ack,
+	.irq_mask	= s3c2416_irq_uart3_mask,
+	.irq_unmask	= s3c2416_irq_uart3_unmask,
+	.irq_ack	= s3c2416_irq_uart3_ack,
 };
 
-
 /* IRQ initialisation code */
 
 static int __init s3c2416_add_sub(unsigned int base,
diff --git a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c2440/irq.c
index 0c049b9..acad442 100644
--- a/arch/arm/mach-s3c2440/irq.c
+++ b/arch/arm/mach-s3c2440/irq.c
@@ -69,27 +69,27 @@ static void s3c_irq_demux_wdtac97(unsigned int irq,
 #define INTMSK_WDT	 (1UL << (IRQ_WDT - IRQ_EINT0))
 
 static void
-s3c_irq_wdtac97_mask(unsigned int irqno)
+s3c_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_WDT, 3<<13);
+	s3c_irqsub_mask(data->irq, INTMSK_WDT, 3 << 13);
 }
 
 static void
-s3c_irq_wdtac97_unmask(unsigned int irqno)
+s3c_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_WDT);
+	s3c_irqsub_unmask(data->irq, INTMSK_WDT);
 }
 
 static void
-s3c_irq_wdtac97_ack(unsigned int irqno)
+s3c_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_WDT, 3<<13);
+	s3c_irqsub_maskack(data->irq, INTMSK_WDT, 3 << 13);
 }
 
 static struct irq_chip s3c_irq_wdtac97 = {
-	.mask	    = s3c_irq_wdtac97_mask,
-	.unmask	    = s3c_irq_wdtac97_unmask,
-	.ack	    = s3c_irq_wdtac97_ack,
+	.irq_mask	= s3c_irq_wdtac97_mask,
+	.irq_unmask	= s3c_irq_wdtac97_unmask,
+	.irq_ack	= s3c_irq_wdtac97_ack,
 };
 
 static int s3c2440_irq_add(struct sys_device *sysdev)
diff --git a/arch/arm/mach-s3c2440/s3c244x-irq.c b/arch/arm/mach-s3c2440/s3c244x-irq.c
index a75c0c2..83daf4e 100644
--- a/arch/arm/mach-s3c2440/s3c244x-irq.c
+++ b/arch/arm/mach-s3c2440/s3c244x-irq.c
@@ -68,27 +68,27 @@ static void s3c_irq_demux_cam(unsigned int irq,
 #define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
 
 static void
-s3c_irq_cam_mask(unsigned int irqno)
+s3c_irq_cam_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_CAM, 3<<11);
+	s3c_irqsub_mask(data->irq, INTMSK_CAM, 3 << 11);
 }
 
 static void
-s3c_irq_cam_unmask(unsigned int irqno)
+s3c_irq_cam_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_CAM);
+	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
 }
 
 static void
-s3c_irq_cam_ack(unsigned int irqno)
+s3c_irq_cam_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_CAM, 3<<11);
+	s3c_irqsub_maskack(data->irq, INTMSK_CAM, 3 << 11);
 }
 
 static struct irq_chip s3c_irq_cam = {
-	.mask	    = s3c_irq_cam_mask,
-	.unmask	    = s3c_irq_cam_unmask,
-	.ack	    = s3c_irq_cam_ack,
+	.irq_mask	= s3c_irq_cam_mask,
+	.irq_unmask	= s3c_irq_cam_unmask,
+	.irq_ack	= s3c_irq_cam_ack,
 };
 
 static int s3c244x_irq_add(struct sys_device *sysdev)
diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c2443/irq.c
index 8934247..c7820f9 100644
--- a/arch/arm/mach-s3c2443/irq.c
+++ b/arch/arm/mach-s3c2443/irq.c
@@ -75,28 +75,27 @@ static void s3c2443_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
 #define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
 
-static void s3c2443_irq_wdtac97_mask(unsigned int irqno)
+static void s3c2443_irq_wdtac97_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
-static void s3c2443_irq_wdtac97_unmask(unsigned int irqno)
+static void s3c2443_irq_wdtac97_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_WDTAC97);
+	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
 }
 
-static void s3c2443_irq_wdtac97_ack(unsigned int irqno)
+static void s3c2443_irq_wdtac97_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
 }
 
 static struct irq_chip s3c2443_irq_wdtac97 = {
-	.mask	    = s3c2443_irq_wdtac97_mask,
-	.unmask	    = s3c2443_irq_wdtac97_unmask,
-	.ack	    = s3c2443_irq_wdtac97_ack,
+	.irq_mask	= s3c2443_irq_wdtac97_mask,
+	.irq_unmask	= s3c2443_irq_wdtac97_unmask,
+	.irq_ack	= s3c2443_irq_wdtac97_ack,
 };
 
-
 /* LCD sub interrupts */
 
 static void s3c2443_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
@@ -107,28 +106,27 @@ static void s3c2443_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
 #define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
 
-static void s3c2443_irq_lcd_mask(unsigned int irqno)
+static void s3c2443_irq_lcd_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
 }
 
-static void s3c2443_irq_lcd_unmask(unsigned int irqno)
+static void s3c2443_irq_lcd_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_LCD);
+	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
 }
 
-static void s3c2443_irq_lcd_ack(unsigned int irqno)
+static void s3c2443_irq_lcd_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_LCD, SUBMSK_LCD);
+	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
 }
 
 static struct irq_chip s3c2443_irq_lcd = {
-	.mask	    = s3c2443_irq_lcd_mask,
-	.unmask	    = s3c2443_irq_lcd_unmask,
-	.ack	    = s3c2443_irq_lcd_ack,
+	.irq_mask	= s3c2443_irq_lcd_mask,
+	.irq_unmask	= s3c2443_irq_lcd_unmask,
+	.irq_ack	= s3c2443_irq_lcd_ack,
 };
 
-
 /* DMA sub interrupts */
 
 static void s3c2443_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
@@ -139,29 +137,27 @@ static void s3c2443_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_DMA	(1UL << (IRQ_S3C2443_DMA - IRQ_EINT0))
 #define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
 
-
-static void s3c2443_irq_dma_mask(unsigned int irqno)
+static void s3c2443_irq_dma_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
 }
 
-static void s3c2443_irq_dma_unmask(unsigned int irqno)
+static void s3c2443_irq_dma_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_DMA);
+	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
 }
 
-static void s3c2443_irq_dma_ack(unsigned int irqno)
+static void s3c2443_irq_dma_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_DMA, SUBMSK_DMA);
+	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
 }
 
 static struct irq_chip s3c2443_irq_dma = {
-	.mask	    = s3c2443_irq_dma_mask,
-	.unmask	    = s3c2443_irq_dma_unmask,
-	.ack	    = s3c2443_irq_dma_ack,
+	.irq_mask	= s3c2443_irq_dma_mask,
+	.irq_unmask	= s3c2443_irq_dma_unmask,
+	.irq_ack	= s3c2443_irq_dma_ack,
 };
 
-
 /* UART3 sub interrupts */
 
 static void s3c2443_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
@@ -172,28 +168,27 @@ static void s3c2443_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
 #define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
 
-static void s3c2443_irq_uart3_mask(unsigned int irqno)
+static void s3c2443_irq_uart3_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
 }
 
-static void s3c2443_irq_uart3_unmask(unsigned int irqno)
+static void s3c2443_irq_uart3_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_UART3);
+	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
 }
 
-static void s3c2443_irq_uart3_ack(unsigned int irqno)
+static void s3c2443_irq_uart3_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_UART3, SUBMSK_UART3);
+	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
 }
 
 static struct irq_chip s3c2443_irq_uart3 = {
-	.mask	    = s3c2443_irq_uart3_mask,
-	.unmask	    = s3c2443_irq_uart3_unmask,
-	.ack	    = s3c2443_irq_uart3_ack,
+	.irq_mask	= s3c2443_irq_uart3_mask,
+	.irq_unmask	= s3c2443_irq_uart3_unmask,
+	.irq_ack	= s3c2443_irq_uart3_ack,
 };
 
-
 /* CAM sub interrupts */
 
 static void s3c2443_irq_demux_cam(unsigned int irq, struct irq_desc *desc)
@@ -204,25 +199,25 @@ static void s3c2443_irq_demux_cam(unsigned int irq, struct irq_desc *desc)
 #define INTMSK_CAM	(1UL << (IRQ_CAM - IRQ_EINT0))
 #define SUBMSK_CAM	INTMSK(IRQ_S3C2440_CAM_C, IRQ_S3C2440_CAM_P)
 
-static void s3c2443_irq_cam_mask(unsigned int irqno)
+static void s3c2443_irq_cam_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_CAM, SUBMSK_CAM);
+	s3c_irqsub_mask(data->irq, INTMSK_CAM, SUBMSK_CAM);
 }
 
-static void s3c2443_irq_cam_unmask(unsigned int irqno)
+static void s3c2443_irq_cam_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_CAM);
+	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
 }
 
-static void s3c2443_irq_cam_ack(unsigned int irqno)
+static void s3c2443_irq_cam_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_CAM, SUBMSK_CAM);
+	s3c_irqsub_maskack(data->irq, INTMSK_CAM, SUBMSK_CAM);
 }
 
 static struct irq_chip s3c2443_irq_cam = {
-	.mask	    = s3c2443_irq_cam_mask,
-	.unmask	    = s3c2443_irq_cam_unmask,
-	.ack	    = s3c2443_irq_cam_ack,
+	.irq_mask	= s3c2443_irq_cam_mask,
+	.irq_unmask	= s3c2443_irq_cam_unmask,
+	.irq_ack	= s3c2443_irq_cam_ack,
 };
 
 /* IRQ initialisation code */
diff --git a/arch/arm/plat-s3c24xx/include/plat/irq.h b/arch/arm/plat-s3c24xx/include/plat/irq.h
index 69e1be8..ec087d6 100644
--- a/arch/arm/plat-s3c24xx/include/plat/irq.h
+++ b/arch/arm/plat-s3c24xx/include/plat/irq.h
@@ -107,9 +107,9 @@ s3c_irqsub_ack(unsigned int irqno, unsigned int parentmask, unsigned int group)
 /* exported for use in arch/arm/mach-s3c2410 */
 
 #ifdef CONFIG_PM
-extern int s3c_irq_wake(unsigned int irqno, unsigned int state);
+extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 #else
 #define s3c_irq_wake NULL
 #endif
 
-extern int s3c_irqext_type(unsigned int irq, unsigned int type);
+extern int s3c_irqext_type(struct irq_data *d, unsigned int type);
diff --git a/arch/arm/plat-s3c24xx/irq-pm.c b/arch/arm/plat-s3c24xx/irq-pm.c
index ea8dea3..c3624d8 100644
--- a/arch/arm/plat-s3c24xx/irq-pm.c
+++ b/arch/arm/plat-s3c24xx/irq-pm.c
@@ -15,11 +15,14 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/irq.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/irq.h>
 
+#include <asm/irq.h>
+
 /* state for IRQs over sleep */
 
 /* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
@@ -30,15 +33,15 @@
 unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
 unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
 
-int s3c_irq_wake(unsigned int irqno, unsigned int state)
+int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
-	unsigned long irqbit = 1 << (irqno - IRQ_EINT0);
+	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
 
 	if (!(s3c_irqwake_intallow & irqbit))
 		return -ENOENT;
 
 	printk(KERN_INFO "wake %s for irq %d\n",
-	       state ? "enabled" : "disabled", irqno);
+	       state ? "enabled" : "disabled", data->irq);
 
 	if (!state)
 		s3c_irqwake_intmask |= irqbit;
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 91ce383..45c3439 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -34,30 +34,29 @@
 #include <plat/irq.h>
 
 static void
-s3c_irq_mask(unsigned int irqno)
+s3c_irq_mask(struct irq_data *data)
 {
+	unsigned int irqno = data->irq - IRQ_EINT0;
 	unsigned long mask;
 
-	irqno -= IRQ_EINT0;
-
 	mask = __raw_readl(S3C2410_INTMSK);
 	mask |= 1UL << irqno;
 	__raw_writel(mask, S3C2410_INTMSK);
 }
 
 static inline void
-s3c_irq_ack(unsigned int irqno)
+s3c_irq_ack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 
 	__raw_writel(bitval, S3C2410_SRCPND);
 	__raw_writel(bitval, S3C2410_INTPND);
 }
 
 static inline void
-s3c_irq_maskack(unsigned int irqno)
+s3c_irq_maskack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (irqno - IRQ_EINT0);
+	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2410_INTMSK);
@@ -69,8 +68,9 @@ s3c_irq_maskack(unsigned int irqno)
 
 
 static void
-s3c_irq_unmask(unsigned int irqno)
+s3c_irq_unmask(struct irq_data *data)
 {
+	unsigned int irqno = data->irq;
 	unsigned long mask;
 
 	if (irqno != IRQ_TIMER4 && irqno != IRQ_EINT8t23)
@@ -85,40 +85,39 @@ s3c_irq_unmask(unsigned int irqno)
 
 struct irq_chip s3c_irq_level_chip = {
 	.name		= "s3c-level",
-	.ack		= s3c_irq_maskack,
-	.mask		= s3c_irq_mask,
-	.unmask		= s3c_irq_unmask,
-	.set_wake	= s3c_irq_wake
+	.irq_ack	= s3c_irq_maskack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake
 };
 
 struct irq_chip s3c_irq_chip = {
 	.name		= "s3c",
-	.ack		= s3c_irq_ack,
-	.mask		= s3c_irq_mask,
-	.unmask		= s3c_irq_unmask,
-	.set_wake	= s3c_irq_wake
+	.irq_ack	= s3c_irq_ack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake
 };
 
 static void
-s3c_irqext_mask(unsigned int irqno)
+s3c_irqext_mask(struct irq_data *data)
 {
+	unsigned int irqno = data->irq - EXTINT_OFF;
 	unsigned long mask;
 
-	irqno -= EXTINT_OFF;
-
 	mask = __raw_readl(S3C24XX_EINTMASK);
 	mask |= ( 1UL << irqno);
 	__raw_writel(mask, S3C24XX_EINTMASK);
 }
 
 static void
-s3c_irqext_ack(unsigned int irqno)
+s3c_irqext_ack(struct irq_data *data)
 {
 	unsigned long req;
 	unsigned long bit;
 	unsigned long mask;
 
-	bit = 1UL << (irqno - EXTINT_OFF);
+	bit = 1UL << (data->irq - EXTINT_OFF);
 
 	mask = __raw_readl(S3C24XX_EINTMASK);
 
@@ -129,62 +128,61 @@ s3c_irqext_ack(unsigned int irqno)
 
 	/* not sure if we should be acking the parent irq... */
 
-	if (irqno <= IRQ_EINT7 ) {
+	if (data->irq <= IRQ_EINT7 ) {
 		if ((req & 0xf0) == 0)
-			s3c_irq_ack(IRQ_EINT4t7);
+			s3c_irq_ack(irq_get_irq_data(IRQ_EINT4t7));
 	} else {
 		if ((req >> 8) == 0)
-			s3c_irq_ack(IRQ_EINT8t23);
+			s3c_irq_ack(irq_get_irq_data(IRQ_EINT8t23));
 	}
 }
 
 static void
-s3c_irqext_unmask(unsigned int irqno)
+s3c_irqext_unmask(struct irq_data *data)
 {
+	unsigned int irqno = data->irq - EXTINT_OFF;
 	unsigned long mask;
 
-	irqno -= EXTINT_OFF;
-
 	mask = __raw_readl(S3C24XX_EINTMASK);
-	mask &= ~( 1UL << irqno);
+	mask &= ~(1UL << irqno);
 	__raw_writel(mask, S3C24XX_EINTMASK);
 }
 
 int
-s3c_irqext_type(unsigned int irq, unsigned int type)
+s3c_irqext_type(struct irq_data *data, unsigned int type)
 {
 	void __iomem *extint_reg;
 	void __iomem *gpcon_reg;
 	unsigned long gpcon_offset, extint_offset;
 	unsigned long newvalue = 0, value;
 
-	if ((irq >= IRQ_EINT0) && (irq <= IRQ_EINT3))
+	if ((data->irq >= IRQ_EINT0) && (data->irq <= IRQ_EINT3))
 	{
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (irq - IRQ_EINT0) * 2;
-		extint_offset = (irq - IRQ_EINT0) * 4;
+		gpcon_offset = (data->irq - IRQ_EINT0) * 2;
+		extint_offset = (data->irq - IRQ_EINT0) * 4;
 	}
-	else if ((irq >= IRQ_EINT4) && (irq <= IRQ_EINT7))
+	else if ((data->irq >= IRQ_EINT4) && (data->irq <= IRQ_EINT7))
 	{
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (irq - (EXTINT_OFF)) * 2;
-		extint_offset = (irq - (EXTINT_OFF)) * 4;
+		gpcon_offset = (data->irq - (EXTINT_OFF)) * 2;
+		extint_offset = (data->irq - (EXTINT_OFF)) * 4;
 	}
-	else if ((irq >= IRQ_EINT8) && (irq <= IRQ_EINT15))
+	else if ((data->irq >= IRQ_EINT8) && (data->irq <= IRQ_EINT15))
 	{
 		gpcon_reg = S3C2410_GPGCON;
 		extint_reg = S3C24XX_EXTINT1;
-		gpcon_offset = (irq - IRQ_EINT8) * 2;
-		extint_offset = (irq - IRQ_EINT8) * 4;
+		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
+		extint_offset = (data->irq - IRQ_EINT8) * 4;
 	}
-	else if ((irq >= IRQ_EINT16) && (irq <= IRQ_EINT23))
+	else if ((data->irq >= IRQ_EINT16) && (data->irq <= IRQ_EINT23))
 	{
 		gpcon_reg = S3C2410_GPGCON;
 		extint_reg = S3C24XX_EXTINT2;
-		gpcon_offset = (irq - IRQ_EINT8) * 2;
-		extint_offset = (irq - IRQ_EINT16) * 4;
+		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
+		extint_offset = (data->irq - IRQ_EINT16) * 4;
 	} else
 		return -1;
 
@@ -234,20 +232,20 @@ s3c_irqext_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip s3c_irqext_chip = {
 	.name		= "s3c-ext",
-	.mask		= s3c_irqext_mask,
-	.unmask		= s3c_irqext_unmask,
-	.ack		= s3c_irqext_ack,
-	.set_type	= s3c_irqext_type,
+	.irq_mask	= s3c_irqext_mask,
+	.irq_unmask	= s3c_irqext_unmask,
+	.irq_ack	= s3c_irqext_ack,
+	.irq_set_type	= s3c_irqext_type,
 	.irq_set_wake	= s3c_irqext_wake
 };
 
 static struct irq_chip s3c_irq_eint0t4 = {
 	.name		= "s3c-ext0",
-	.ack		= s3c_irq_ack,
-	.mask		= s3c_irq_mask,
-	.unmask		= s3c_irq_unmask,
-	.set_wake	= s3c_irq_wake,
-	.set_type	= s3c_irqext_type,
+	.irq_ack	= s3c_irq_ack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_wake	= s3c_irq_wake,
+	.irq_set_type	= s3c_irqext_type,
 };
 
 /* mask values for the parent registers for each of the interrupt types */
@@ -261,109 +259,109 @@ static struct irq_chip s3c_irq_eint0t4 = {
 /* UART0 */
 
 static void
-s3c_irq_uart0_mask(unsigned int irqno)
+s3c_irq_uart0_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_UART0, 7);
+	s3c_irqsub_mask(data->irq, INTMSK_UART0, 7);
 }
 
 static void
-s3c_irq_uart0_unmask(unsigned int irqno)
+s3c_irq_uart0_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_UART0);
+	s3c_irqsub_unmask(data->irq, INTMSK_UART0);
 }
 
 static void
-s3c_irq_uart0_ack(unsigned int irqno)
+s3c_irq_uart0_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_UART0, 7);
+	s3c_irqsub_maskack(data->irq, INTMSK_UART0, 7);
 }
 
 static struct irq_chip s3c_irq_uart0 = {
 	.name		= "s3c-uart0",
-	.mask		= s3c_irq_uart0_mask,
-	.unmask		= s3c_irq_uart0_unmask,
-	.ack		= s3c_irq_uart0_ack,
+	.irq_mask	= s3c_irq_uart0_mask,
+	.irq_unmask	= s3c_irq_uart0_unmask,
+	.irq_ack	= s3c_irq_uart0_ack,
 };
 
 /* UART1 */
 
 static void
-s3c_irq_uart1_mask(unsigned int irqno)
+s3c_irq_uart1_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_UART1, 7 << 3);
+	s3c_irqsub_mask(data->irq, INTMSK_UART1, 7 << 3);
 }
 
 static void
-s3c_irq_uart1_unmask(unsigned int irqno)
+s3c_irq_uart1_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_UART1);
+	s3c_irqsub_unmask(data->irq, INTMSK_UART1);
 }
 
 static void
-s3c_irq_uart1_ack(unsigned int irqno)
+s3c_irq_uart1_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_UART1, 7 << 3);
+	s3c_irqsub_maskack(data->irq, INTMSK_UART1, 7 << 3);
 }
 
 static struct irq_chip s3c_irq_uart1 = {
 	.name		= "s3c-uart1",
-	.mask		= s3c_irq_uart1_mask,
-	.unmask		= s3c_irq_uart1_unmask,
-	.ack		= s3c_irq_uart1_ack,
+	.irq_mask	= s3c_irq_uart1_mask,
+	.irq_unmask	= s3c_irq_uart1_unmask,
+	.irq_ack	= s3c_irq_uart1_ack,
 };
 
 /* UART2 */
 
 static void
-s3c_irq_uart2_mask(unsigned int irqno)
+s3c_irq_uart2_mask(struct irq_data *data)
 {
-	s3c_irqsub_mask(irqno, INTMSK_UART2, 7 << 6);
+	s3c_irqsub_mask(data->irq, INTMSK_UART2, 7 << 6);
 }
 
 static void
-s3c_irq_uart2_unmask(unsigned int irqno)
+s3c_irq_uart2_unmask(struct irq_data *data)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_UART2);
+	s3c_irqsub_unmask(data->irq, INTMSK_UART2);
 }
 
 static void
-s3c_irq_uart2_ack(unsigned int irqno)
+s3c_irq_uart2_ack(struct irq_data *data)
 {
-	s3c_irqsub_maskack(irqno, INTMSK_UART2, 7 << 6);
+	s3c_irqsub_maskack(data->irq, INTMSK_UART2, 7 << 6);
 }
 
 static struct irq_chip s3c_irq_uart2 = {
 	.name		= "s3c-uart2",
-	.mask		= s3c_irq_uart2_mask,
-	.unmask		= s3c_irq_uart2_unmask,
-	.ack		= s3c_irq_uart2_ack,
+	.irq_mask	= s3c_irq_uart2_mask,
+	.irq_unmask	= s3c_irq_uart2_unmask,
+	.irq_ack	= s3c_irq_uart2_ack,
 };
 
 /* ADC and Touchscreen */
 
 static void
-s3c_irq_adc_mask(unsigned int irqno)
+s3c_irq_adc_mask(struct irq_data *d)
 {
-	s3c_irqsub_mask(irqno, INTMSK_ADCPARENT, 3 << 9);
+	s3c_irqsub_mask(d->irq, INTMSK_ADCPARENT, 3 << 9);
 }
 
 static void
-s3c_irq_adc_unmask(unsigned int irqno)
+s3c_irq_adc_unmask(struct irq_data *d)
 {
-	s3c_irqsub_unmask(irqno, INTMSK_ADCPARENT);
+	s3c_irqsub_unmask(d->irq, INTMSK_ADCPARENT);
 }
 
 static void
-s3c_irq_adc_ack(unsigned int irqno)
+s3c_irq_adc_ack(struct irq_data *d)
 {
-	s3c_irqsub_ack(irqno, INTMSK_ADCPARENT, 3 << 9);
+	s3c_irqsub_ack(d->irq, INTMSK_ADCPARENT, 3 << 9);
 }
 
 static struct irq_chip s3c_irq_adc = {
 	.name		= "s3c-adc",
-	.mask		= s3c_irq_adc_mask,
-	.unmask		= s3c_irq_adc_unmask,
-	.ack		= s3c_irq_adc_ack,
+	.irq_mask	= s3c_irq_adc_mask,
+	.irq_unmask	= s3c_irq_adc_unmask,
+	.irq_ack	= s3c_irq_adc_ack,
 };
 
 /* irq demux for adc */
-- 
1.7.1


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-ARM-S5P-irq_data-conversion.patch"
