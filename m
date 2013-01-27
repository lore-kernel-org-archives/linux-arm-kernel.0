From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 27 Jan 2013 21:49:47 +0100
Subject: [PATCH v4 9/9] ARM: S3C24XX: transform s3c2443 subirqs into new
 structure
In-Reply-To: <201301272124.18530.heiko@sntech.de>
References: <201301272124.18530.heiko@sntech.de>
Message-ID: <201301272149.47956.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Share the common irq code by simply defining a correct mapping declaration
for the s3c2443.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/irq.c |  289 +++++++++++--------------------------------
 1 file changed, 75 insertions(+), 214 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 4cf3c13..969426b 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -732,230 +732,91 @@ void __init s3c2416_init_irq(void)
 #endif
 
 #ifdef CONFIG_CPU_S3C2443
-#define INTMSK(start, end) ((1 << ((end) + 1 - (start))) - 1)
-
-static inline void s3c2443_irq_demux(unsigned int irq, unsigned int len)
-{
-	unsigned int subsrc, submsk;
-	unsigned int end;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc  &= ~submsk;
-	subsrc >>= (irq - S3C2410_IRQSUB(0));
-	subsrc  &= (1 << len)-1;
-
-	end = len + irq;
-
-	for (; irq < end && subsrc; irq++) {
-		if (subsrc & 1)
-			generic_handle_irq(irq);
-
-		subsrc >>= 1;
-	}
-}
-
-/* WDT/AC97 sub interrupts */
-
-static void s3c2443_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2443_irq_demux(IRQ_S3C2443_WDT, 4);
-}
-
-#define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
-#define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
-
-static void s3c2443_irq_wdtac97_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
-}
-
-static void s3c2443_irq_wdtac97_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
-}
-
-static void s3c2443_irq_wdtac97_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
-}
-
-static struct irq_chip s3c2443_irq_wdtac97 = {
-	.irq_mask	= s3c2443_irq_wdtac97_mask,
-	.irq_unmask	= s3c2443_irq_wdtac97_unmask,
-	.irq_ack	= s3c2443_irq_wdtac97_ack,
-};
-
-/* LCD sub interrupts */
-
-static void s3c2443_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2443_irq_demux(IRQ_S3C2443_LCD1, 4);
-}
-
-#define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
-#define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
-
-static void s3c2443_irq_lcd_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
-}
-
-static void s3c2443_irq_lcd_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
-}
-
-static void s3c2443_irq_lcd_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
-}
-
-static struct irq_chip s3c2443_irq_lcd = {
-	.irq_mask	= s3c2443_irq_lcd_mask,
-	.irq_unmask	= s3c2443_irq_lcd_unmask,
-	.irq_ack	= s3c2443_irq_lcd_ack,
-};
-
-/* DMA sub interrupts */
-
-static void s3c2443_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2443_irq_demux(IRQ_S3C2443_DMA0, 6);
-}
-
-#define INTMSK_DMA	(1UL << (IRQ_S3C2443_DMA - IRQ_EINT0))
-#define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
-
-static void s3c2443_irq_dma_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
-}
-
-static void s3c2443_irq_dma_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
-}
-
-static void s3c2443_irq_dma_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
-}
-
-static struct irq_chip s3c2443_irq_dma = {
-	.irq_mask	= s3c2443_irq_dma_mask,
-	.irq_unmask	= s3c2443_irq_dma_unmask,
-	.irq_ack	= s3c2443_irq_dma_ack,
-};
-
-/* UART3 sub interrupts */
-
-static void s3c2443_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2443_irq_demux(IRQ_S3C2443_RX3, 3);
-}
-
-#define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
-#define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
-
-static void s3c2443_irq_uart3_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
-}
-
-static void s3c2443_irq_uart3_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
-}
-
-static void s3c2443_irq_uart3_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
-}
-
-static struct irq_chip s3c2443_irq_uart3 = {
-	.irq_mask	= s3c2443_irq_uart3_mask,
-	.irq_unmask	= s3c2443_irq_uart3_unmask,
-	.irq_ack	= s3c2443_irq_uart3_ack,
+static struct s3c_irq_data init_s3c2443base[32] = {
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
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* LCD */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* DMA */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART3 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* CFON */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SDI1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SDI0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI0 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* NAND */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBD */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* USBH */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* IIC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* UART0 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* SPI1 */
+	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
 };
 
-/* CAM sub interrupts */
 
-static void s3c2443_irq_demux_cam(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2443_irq_demux(IRQ_S3C2440_CAM_C, 4);
-}
-
-#define INTMSK_CAM	(1UL << (IRQ_CAM - IRQ_EINT0))
-#define SUBMSK_CAM	INTMSK(IRQ_S3C2440_CAM_C, IRQ_S3C2440_CAM_P)
-
-static void s3c2443_irq_cam_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_CAM, SUBMSK_CAM);
-}
-
-static void s3c2443_irq_cam_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
-}
-
-static void s3c2443_irq_cam_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_CAM, SUBMSK_CAM);
-}
-
-static struct irq_chip s3c2443_irq_cam = {
-	.irq_mask	= s3c2443_irq_cam_mask,
-	.irq_unmask	= s3c2443_irq_cam_unmask,
-	.irq_ack	= s3c2443_irq_cam_ack,
+static struct s3c_irq_data init_s3c2443subint[32] = {
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
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_C */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_P */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD1 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD2 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD3 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD4 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA0 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA1 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA2 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA3 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA4 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA5 */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-RX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-TX */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-ERR */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
+	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
 };
 
-/* IRQ initialisation code */
-
-static int s3c2443_add_sub(unsigned int base,
-				   void (*demux)(unsigned int,
-						 struct irq_desc *),
-				   struct irq_chip *chip,
-				   unsigned int start, unsigned int end)
-{
-	unsigned int irqno;
-
-	irq_set_chip_and_handler(base, &s3c_irq_level_chip, handle_level_irq);
-	irq_set_chained_handler(base, demux);
-
-	for (irqno = start; irqno <= end; irqno++) {
-		irq_set_chip_and_handler(irqno, chip, handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
-
-	return 0;
-}
-
 void __init s3c2443_init_irq(void)
 {
-	pr_info("S3C2443: IRQ Support\n");
-
-	s3c24xx_init_irq();
-
-	s3c2443_add_sub(IRQ_CAM, s3c2443_irq_demux_cam, &s3c2443_irq_cam,
-			IRQ_S3C2440_CAM_C, IRQ_S3C2440_CAM_P);
+	struct s3c_irq_intc *main_intc;
 
-	s3c2443_add_sub(IRQ_LCD, s3c2443_irq_demux_lcd, &s3c2443_irq_lcd,
-			IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4);
+	pr_info("S3C2443: IRQ Support\n");
 
-	s3c2443_add_sub(IRQ_S3C2443_DMA, s3c2443_irq_demux_dma,
-			&s3c2443_irq_dma, IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5);
+#ifdef CONFIG_FIQ
+	init_FIQ(FIQ_START);
+#endif
 
-	s3c2443_add_sub(IRQ_S3C2443_UART3, s3c2443_irq_demux_uart3,
-			&s3c2443_irq_uart3,
-			IRQ_S3C2443_RX3, IRQ_S3C2443_ERR3);
+	main_intc = s3c24xx_init_intc(NULL, &init_s3c2443base[0], NULL, 0x4a000000);
+	if (IS_ERR(main_intc)) {
+		pr_err("irq: could not create main interrupt controller\n");
+		return;
+	}
 
-	s3c2443_add_sub(IRQ_WDT, s3c2443_irq_demux_wdtac97,
-			&s3c2443_irq_wdtac97,
-			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
+	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c24xx_init_intc(NULL, &init_s3c2443subint[0], main_intc, 0x4a000018);
 }
 #endif
-- 
1.7.10.4
