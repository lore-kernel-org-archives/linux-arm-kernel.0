From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:21 +0200
Subject: [PATCH 5/9] ARM i.MX mx31ads: allocate irqs for expio dynamically
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx31ads.c |   45 +++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index f4dee02..d183592 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -62,11 +62,6 @@
 #define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
 
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_XUART_INTA	(MXC_EXP_IO_BASE + 10)
-#define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
-
 #define MXC_MAX_EXP_IO_LINES	16
 
 /*
@@ -76,7 +71,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.membase  = (void *)(PBC_BASE_ADDRESS + PBC_SC16C652_UARTA),
 		.mapbase  = (unsigned long)(MX31_CS4_BASE_ADDR + PBC_SC16C652_UARTA),
-		.irq      = EXPIO_INT_XUART_INTA,
 		.uartclk  = 14745600,
 		.regshift = 0,
 		.iotype   = UPIO_MEM,
@@ -84,7 +78,6 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}, {
 		.membase  = (void *)(PBC_BASE_ADDRESS + PBC_SC16C652_UARTB),
 		.mapbase  = (unsigned long)(MX31_CS4_BASE_ADDR + PBC_SC16C652_UARTB),
-		.irq      = EXPIO_INT_XUART_INTB,
 		.uartclk  = 14745600,
 		.regshift = 0,
 		.iotype   = UPIO_MEM,
@@ -101,11 +94,6 @@ static struct platform_device serial_device = {
 	},
 };
 
-static int __init mxc_init_extuart(void)
-{
-	return platform_device_register(&serial_device);
-}
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -123,6 +111,8 @@ static inline void mxc_init_imx_uart(void)
 	imx31_add_imx_uart0(&uart_pdata);
 }
 
+static int expio_base_irq;
+
 static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 imr_val;
@@ -132,7 +122,7 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
 	imr_val = __raw_readw(PBC_INTMASK_SET_REG);
 	int_valid = __raw_readw(PBC_INTSTATUS_REG) & imr_val;
 
-	expio_irq = MXC_EXP_IO_BASE;
+	expio_irq = expio_base_irq;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
 		if ((int_valid & 1) == 0)
 			continue;
@@ -147,8 +137,8 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
  */
 static void expio_mask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
-	/* mask the interrupt */
+	u32 expio = d->irq - expio_base_irq;
+
 	__raw_writew(1 << expio, PBC_INTMASK_CLEAR_REG);
 	__raw_readw(PBC_INTMASK_CLEAR_REG);
 }
@@ -159,8 +149,8 @@ static void expio_mask_irq(struct irq_data *d)
  */
 static void expio_ack_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
-	/* clear the interrupt status */
+	u32 expio = d->irq - expio_base_irq;
+
 	__raw_writew(1 << expio, PBC_INTSTATUS_REG);
 }
 
@@ -170,8 +160,8 @@ static void expio_ack_irq(struct irq_data *d)
  */
 static void expio_unmask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
-	/* unmask the interrupt */
+	u32 expio = d->irq - expio_base_irq;
+
 	__raw_writew(1 << expio, PBC_INTMASK_SET_REG);
 }
 
@@ -188,6 +178,13 @@ static void __init mx31ads_init_expio(void)
 
 	printk(KERN_INFO "MX31ADS EXPIO(CPLD) hardware\n");
 
+	/* Currently we rely on the exact irq number as this must be hardcoded
+	 * into the cs89x0 driver
+	 */
+	expio_base_irq = irq_alloc_descs(-1, MXC_EXP_IO_BASE, MXC_MAX_EXP_IO_LINES, 0);
+	if (expio_base_irq != MXC_EXP_IO_BASE)
+		return;
+
 	/*
 	 * Configure INT line as GPIO input
 	 */
@@ -196,13 +193,18 @@ static void __init mx31ads_init_expio(void)
 	/* disable the interrupt and clear the status */
 	__raw_writew(0xFFFF, PBC_INTMASK_CLEAR_REG);
 	__raw_writew(0xFFFF, PBC_INTSTATUS_REG);
-	for (i = MXC_EXP_IO_BASE; i < (MXC_EXP_IO_BASE + MXC_MAX_EXP_IO_LINES);
+	for (i = expio_base_irq; i < (expio_base_irq + MXC_MAX_EXP_IO_LINES);
 	     i++) {
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
 	irq_set_irq_type(EXPIO_PARENT_INT, IRQ_TYPE_LEVEL_HIGH);
 	irq_set_chained_handler(EXPIO_PARENT_INT, mx31ads_expio_irq_handler);
+
+	serial_platform_data[0].irq = expio_base_irq + 10;
+	serial_platform_data[1].irq = expio_base_irq + 11;
+
+	platform_device_register(&serial_device);
 }
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -511,12 +513,11 @@ static void __init mx31ads_map_io(void)
 static void __init mx31ads_init_irq(void)
 {
 	mx31_init_irq();
-	mx31ads_init_expio();
 }
 
 static void __init mx31ads_init(void)
 {
-	mxc_init_extuart();
+	mx31ads_init_expio();
 	mxc_init_imx_uart();
 	mxc_init_i2c();
 	mxc_init_audio();
-- 
1.7.4.1
