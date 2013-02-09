From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:16:23 +0100
Subject: [PATCH v2 06/10] ARM: S3C24XX: transform s3c2440 irqs into new
 structure
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091816.24108.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As always a mapping structure is everything needed.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |  196 +++++++++++++-----------------------------
 1 files changed, 61 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 01358a5..26b17a1 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -731,150 +731,78 @@ void __init s3c2416_init_irq(void)
 
 #endif
 
-#ifdef CONFIG_CPU_S3C244X
-/* camera irq */
-
-static void s3c_irq_demux_cam(unsigned int irq,
-			      struct irq_desc *desc)
-{
-	unsigned int subsrc, submsk;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc &= ~submsk;
-	subsrc >>= 11;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1) {
-			generic_handle_irq(IRQ_S3C2440_CAM_C);
-		}
-		if (subsrc & 2) {
-			generic_handle_irq(IRQ_S3C2440_CAM_P);
-		}
-	}
-}
-
-#define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
-
-static void
-s3c_irq_cam_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_CAM, 3 << 11);
-}
-
-static void
-s3c_irq_cam_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
-}
-
-static void
-s3c_irq_cam_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_CAM, 3 << 11);
-}
-
-static struct irq_chip s3c_irq_cam = {
-	.irq_mask	= s3c_irq_cam_mask,
-	.irq_unmask	= s3c_irq_cam_unmask,
-	.irq_ack	= s3c_irq_cam_ack,
-};
-
 #ifdef CONFIG_CPU_S3C2440
-/* WDT/AC97 */
-
-static void s3c_irq_demux_wdtac97(unsigned int irq,
-				  struct irq_desc *desc)
-{
-	unsigned int subsrc, submsk;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc &= ~submsk;
-	subsrc >>= 13;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1) {
-			generic_handle_irq(IRQ_S3C2440_WDT);
-		}
-		if (subsrc & 2) {
-			generic_handle_irq(IRQ_S3C2440_AC97);
-		}
-	}
-}
-
-
-#define INTMSK_WDT	 (1UL << (IRQ_WDT - IRQ_EINT0))
-
-static void
-s3c_irq_wdtac97_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_WDT, 3 << 13);
-}
-
-static void
-s3c_irq_wdtac97_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_WDT);
-}
-
-static void
-s3c_irq_wdtac97_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_WDT, 3 << 13);
-}
+static struct s3c_irq_data init_s3c2440base[32] = {
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT4to7 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT8to23 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* CAM */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* nBATT_FLT */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TICK */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* WDT/AC97 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER3 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TIMER4 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* LCD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA2 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* DMA3 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SDI */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI0 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART1 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* NFCON */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBH */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* IIC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
+};
 
-static struct irq_chip s3c_irq_wdtac97 = {
-	.irq_mask	= s3c_irq_wdtac97_mask,
-	.irq_unmask	= s3c_irq_wdtac97_unmask,
-	.irq_ack	= s3c_irq_wdtac97_ack,
+static struct s3c_irq_data init_s3c2440subint[32] = {
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
+	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* TC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* ADC */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
 };
 
 void __init s3c2440_init_irq(void)
 {
-	unsigned int irqno;
-
-	printk("S3C2440: IRQ Support\n");
-
-	s3c24xx_init_irq();
-
-	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
-				 handle_level_irq);
-	set_irq_flags(IRQ_NFCON, IRQF_VALID);
+	struct s3c_irq_intc *main_intc;
 
-	/* add chained handler for camera */
+	pr_info("S3C2440: IRQ Support\n");
 
-	irq_set_chip_and_handler(IRQ_CAM, &s3c_irq_level_chip,
-				 handle_level_irq);
-	irq_set_chained_handler(IRQ_CAM, s3c_irq_demux_cam);
+#ifdef CONFIG_FIQ
+	init_FIQ(FIQ_START);
+#endif
 
-	for (irqno = IRQ_S3C2440_CAM_C; irqno <= IRQ_S3C2440_CAM_P; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c_irq_cam,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
+	main_intc = s3c24xx_init_intc(NULL, &init_s3c2440base[0], NULL, 0x4a000000);
+	if (IS_ERR(main_intc)) {
+		pr_err("irq: could not create main interrupt controller\n");
+		return;
 	}
 
-	/* add new chained handler for wdt, ac7 */
-
-	irq_set_chip_and_handler(IRQ_WDT, &s3c_irq_level_chip,
-				 handle_level_irq);
-	irq_set_chained_handler(IRQ_WDT, s3c_irq_demux_wdtac97);
-
-	for (irqno = IRQ_S3C2440_WDT; irqno <= IRQ_S3C2440_AC97; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c_irq_wdtac97,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
+	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c24xx_init_intc(NULL, &init_s3c2440subint[0], main_intc, 0x4a000018);
 }
 #endif
 
@@ -951,8 +879,6 @@ void __init s3c2442_init_irq(void)
 }
 #endif
 
-#endif
-
 #ifdef CONFIG_CPU_S3C2443
 static struct s3c_irq_data init_s3c2443base[32] = {
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
-- 
1.7.2.3
