From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:15:51 +0100
Subject: [PATCH v2 05/10] ARM: S3C24XX: transform s3c2442 irqs into new
 structure
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091815.51557.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply declare a correct mapping structure to use the common irq code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |   78 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 998e6a8..01358a5 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -879,27 +879,75 @@ void __init s3c2440_init_irq(void)
 #endif
 
 #ifdef CONFIG_CPU_S3C2442
-void __init s3c2442_init_irq(void)
-{
-	unsigned int irqno;
+static struct s3c_irq_data init_s3c2442base[32] = {
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_EINT, }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT4to7 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT8to23 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* CAM */
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
 
-	s3c24xx_init_irq();
+static struct s3c_irq_data init_s3c2442subint[32] = {
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
+};
 
-	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
-				 handle_level_irq);
-	set_irq_flags(IRQ_NFCON, IRQF_VALID);
+void __init s3c2442_init_irq(void)
+{
+	struct s3c_irq_intc *main_intc;
 
-	/* add chained handler for camera */
+	pr_info("S3C2442: IRQ Support\n");
 
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
+	main_intc = s3c24xx_init_intc(NULL, &init_s3c2442base[0], NULL, 0x4a000000);
+	if (IS_ERR(main_intc)) {
+		pr_err("irq: could not create main interrupt controller\n");
+		return;
 	}
+
+	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c24xx_init_intc(NULL, &init_s3c2442subint[0], main_intc, 0x4a000018);
 }
 #endif
 
-- 
1.7.2.3
