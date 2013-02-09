From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:19:49 +0100
Subject: [PATCH v2 10/10] ARM: S3C24XX: transform s3c2412 irqs into new
 structure
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091819.49855.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contains only the new mapping structure. The special handling
of the eint0 to eint3 interrupts still needs to be solved.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |  122 +++++++++++++++++++++++--------------------
 1 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index bf1e964..1cb1962 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -629,9 +629,58 @@ void __init s3c24xx_init_irq(void)
 }
 
 #ifdef CONFIG_CPU_S3C2412
+static struct s3c_irq_data init_s3c2412base[32] = {
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT4to7 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT8to23 */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* nBATT_FLT */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* TICK */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* WDT */
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
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* SDI/CF */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI0 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART1 */
+	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBH */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* IIC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
+};
 
-#define INTMSK(start, end) ((1 << ((end) + 1 - (start))) - 1)
-#define INTMSK_SUB(start, end) (INTMSK(start, end) << ((start - S3C2410_IRQSUB(0))))
+static struct s3c_irq_data init_s3c2412subint[32] = {
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
+	{ .type = S3C_IRQTYPE_NONE, },
+	{ .type = S3C_IRQTYPE_NONE, },
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 21 }, /* SDI */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 21 }, /* CF */
+};
 
 /* the s3c2412 changes the behaviour of IRQ_EINT0 through IRQ_EINT3 by
  * having them turn up in both the INT* and the EINT* registers. Whilst
@@ -700,72 +749,33 @@ static struct irq_chip s3c2412_irq_eint0t4 = {
 	.irq_set_type	= s3c_irqext_type,
 };
 
-#define INTBIT(x)	(1 << ((x) - S3C2410_IRQSUB(0)))
-
-/* CF and SDI sub interrupts */
-
-static void s3c2412_irq_demux_cfsdi(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int subsrc, submsk;
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc  &= ~submsk;
-
-	if (subsrc & INTBIT(IRQ_S3C2412_SDI))
-		generic_handle_irq(IRQ_S3C2412_SDI);
-
-	if (subsrc & INTBIT(IRQ_S3C2412_CF))
-		generic_handle_irq(IRQ_S3C2412_CF);
-}
-
-#define INTMSK_CFSDI	(1UL << (IRQ_S3C2412_CFSDI - IRQ_EINT0))
-#define SUBMSK_CFSDI	INTMSK_SUB(IRQ_S3C2412_SDI, IRQ_S3C2412_CF)
-
-static void s3c2412_irq_cfsdi_mask(struct irq_data *data)
+void s3c2412_init_irq(void)
 {
-	s3c_irqsub_mask(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
-}
+	struct s3c_irq_intc *main_intc;
+	unsigned int irqno;
 
-static void s3c2412_irq_cfsdi_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_CFSDI);
-}
+	pr_info("S3C2412: IRQ Support\n");
 
-static void s3c2412_irq_cfsdi_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_CFSDI, SUBMSK_CFSDI);
-}
+#ifdef CONFIG_FIQ
+	init_FIQ(FIQ_START);
+#endif
 
-static struct irq_chip s3c2412_irq_cfsdi = {
-	.name		= "s3c2412-cfsdi",
-	.irq_ack	= s3c2412_irq_cfsdi_ack,
-	.irq_mask	= s3c2412_irq_cfsdi_mask,
-	.irq_unmask	= s3c2412_irq_cfsdi_unmask,
-};
+	main_intc = s3c24xx_init_intc(NULL, &init_s3c2412base[0], NULL, 0x4a000000);
+	if (IS_ERR(main_intc)) {
+		pr_err("irq: could not create main interrupt controller\n");
+		return;
+	}
 
-void s3c2412_init_irq(void)
-{
-	unsigned int irqno;
+	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c24xx_init_intc(NULL, &init_s3c2412subint[0], main_intc, 0x4a000018);
 
-	s3c24xx_init_irq();
+	/* special handling for eints 0 to 3 */
 
 	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
 		irq_set_chip_and_handler(irqno, &s3c2412_irq_eint0t4,
 					 handle_edge_irq);
 		set_irq_flags(irqno, IRQF_VALID);
 	}
-
-	/* add demux support for CF/SDI */
-
-	irq_set_chained_handler(IRQ_S3C2412_CFSDI, s3c2412_irq_demux_cfsdi);
-
-	for (irqno = IRQ_S3C2412_SDI; irqno <= IRQ_S3C2412_CF; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c2412_irq_cfsdi,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
 }
 #endif
 
-- 
1.7.2.3
