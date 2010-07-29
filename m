From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 05:16:24 +0200
Subject: [PATCH 08/13] [ARM] pxa/balloon3: Machine file cleanup
In-Reply-To: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1280373389-32475-8-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Logically separate parts of the file that are handled by one particular driver.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c |  225 +++++++++++++++++++++++------------------
 1 files changed, 126 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f3b5ace..8adb87a 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -51,87 +51,27 @@
 #include "generic.h"
 #include "devices.h"
 
-static unsigned long balloon3_irq_enabled;
-
-static unsigned long balloon3_features_present =
-		(1 << BALLOON3_FEATURE_OHCI) | (1 << BALLOON3_FEATURE_CF) |
-		(1 << BALLOON3_FEATURE_AUDIO) |
-		(1 << BALLOON3_FEATURE_TOPPOLY);
-
-int balloon3_has(enum balloon3_features feature)
-{
-	return (balloon3_features_present & (1 << feature)) ? 1 : 0;
-}
-EXPORT_SYMBOL_GPL(balloon3_has);
-
-int __init parse_balloon3_features(char *arg)
-{
-	if (!arg)
-		return 0;
-
-	return strict_strtoul(arg, 0, &balloon3_features_present);
-}
-early_param("balloon3_features", parse_balloon3_features);
-
-static void balloon3_mask_irq(unsigned int irq)
-{
-	int balloon3_irq = (irq - BALLOON3_IRQ(0));
-	balloon3_irq_enabled &= ~(1 << balloon3_irq);
-	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
-}
+/******************************************************************************
+ * Pin configuration
+ ******************************************************************************/
+static unsigned long balloon3_pin_config[] __initdata = {
+	/* Select BTUART 'COM1/ttyS0' as IO option for pins 42/43/44/45 */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+	GPIO45_BTUART_RTS,
 
-static void balloon3_unmask_irq(unsigned int irq)
-{
-	int balloon3_irq = (irq - BALLOON3_IRQ(0));
-	balloon3_irq_enabled |= (1 << balloon3_irq);
-	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
-}
+	/* Wakeup GPIO */
+	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
 
-static struct irq_chip balloon3_irq_chip = {
-	.name		= "FPGA",
-	.ack		= balloon3_mask_irq,
-	.mask		= balloon3_mask_irq,
-	.unmask		= balloon3_unmask_irq,
+	/* NAND & IDLE LED GPIOs */
+	GPIO9_GPIO,
+	GPIO10_GPIO,
 };
 
-static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
-					balloon3_irq_enabled;
-
-	do {
-		/* clear useless edge notification */
-		if (desc->chip->ack)
-			desc->chip->ack(BALLOON3_AUX_NIRQ);
-		while (pending) {
-			irq = BALLOON3_IRQ(0) + __ffs(pending);
-			generic_handle_irq(irq);
-			pending &= pending - 1;
-		}
-		pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
-				balloon3_irq_enabled;
-	} while (pending);
-}
-
-static void __init balloon3_init_irq(void)
-{
-	int irq;
-
-	pxa27x_init_irq();
-	/* setup extra Balloon3 irqs */
-	for (irq = BALLOON3_IRQ(0); irq <= BALLOON3_IRQ(7); irq++) {
-		set_irq_chip(irq, &balloon3_irq_chip);
-		set_irq_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	set_irq_chained_handler(BALLOON3_AUX_NIRQ, balloon3_irq_handler);
-	set_irq_type(BALLOON3_AUX_NIRQ, IRQ_TYPE_EDGE_FALLING);
-
-	pr_debug("%s: chained handler installed - irq %d automatically "
-		"enabled\n", __func__, BALLOON3_AUX_NIRQ);
-}
-
+/******************************************************************************
+ * Audio and Touchscreen
+ ******************************************************************************/
 static unsigned long balloon3_ac97_pin_config[] = {
 	GPIO28_AC97_BITCLK,
 	GPIO29_AC97_SDATA_IN_0,
@@ -140,19 +80,16 @@ static unsigned long balloon3_ac97_pin_config[] = {
 	GPIO113_AC97_nRESET,
 };
 
+/******************************************************************************
+ * Framebuffer
+ ******************************************************************************/
+
 static void balloon3_backlight_power(int on)
 {
 	pr_debug("%s: power is %s\n", __func__, on ? "on" : "off");
 	gpio_set_value(BALLOON3_GPIO_RUN_BACKLIGHT, on);
 }
 
-static unsigned long balloon3_lcd_pin_config[] = {
-	/* LCD - 16bpp Active TFT */
-	GPIOxx_LCD_TFT_16BPP,
-
-	GPIO99_GPIO,		/* Backlight */
-};
-
 static struct pxafb_mode_info balloon3_lcd_modes[] = {
 	{
 		.pixclock		= 38000,
@@ -176,6 +113,9 @@ static struct pxafb_mach_info balloon3_pxafb_info = {
 	.pxafb_backlight_power	= balloon3_backlight_power,
 };
 
+/******************************************************************************
+ * SD/MMC card controller
+ ******************************************************************************/
 static unsigned long balloon3_mmc_pin_config[] = {
 	GPIO32_MMC_CLK,
 	GPIO92_MMC_DAT_0,
@@ -203,6 +143,9 @@ static struct pxamci_platform_data balloon3_mci_platform_data = {
 	.setpower 	= balloon3_mci_setpower,
 };
 
+/******************************************************************************
+ * USB Gadget
+ ******************************************************************************/
 static int balloon3_udc_is_connected(void)
 {
 	pr_debug("%s: udc connected\n", __func__);
@@ -228,10 +171,16 @@ static struct pxa2xx_udc_mach_info balloon3_udc_info = {
 	.udc_command      = balloon3_udc_command,
 };
 
+/******************************************************************************
+ * IrDA
+ ******************************************************************************/
 static struct pxaficp_platform_data balloon3_ficp_platform_data = {
 	.transceiver_cap  = IR_SIRMODE | IR_FIRMODE | IR_OFF,
 };
 
+/******************************************************************************
+ * USB Host
+ ******************************************************************************/
 static unsigned long balloon3_ohci_pin_config[] = {
 	GPIO88_USBH1_PWR,
 	GPIO89_USBH1_PEN,
@@ -242,21 +191,9 @@ static struct pxaohci_platform_data balloon3_ohci_platform_data = {
 	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW | POWER_SENSE_LOW,
 };
 
-static unsigned long balloon3_pin_config[] __initdata = {
-	/* Select BTUART 'COM1/ttyS0' as IO option for pins 42/43/44/45 */
-	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
-	GPIO44_BTUART_CTS,
-	GPIO45_BTUART_RTS,
-
-	/* Wakeup GPIO */
-	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
-
-	/* NAND & IDLE LED GPIOs */
-	GPIO9_GPIO,
-	GPIO10_GPIO,
-};
-
+/******************************************************************************
+ * LED
+ ******************************************************************************/
 static struct gpio_led balloon3_gpio_leds[] = {
 	{
 		.name			= "balloon3:green:idle",
@@ -285,6 +222,96 @@ static struct platform_device balloon3led_device = {
 	},
 };
 
+/******************************************************************************
+ * Compatibility: Parameter parsing
+ ******************************************************************************/
+static unsigned long balloon3_irq_enabled;
+
+static unsigned long balloon3_features_present =
+		(1 << BALLOON3_FEATURE_OHCI) | (1 << BALLOON3_FEATURE_CF) |
+		(1 << BALLOON3_FEATURE_AUDIO) |
+		(1 << BALLOON3_FEATURE_TOPPOLY);
+
+int balloon3_has(enum balloon3_features feature)
+{
+	return (balloon3_features_present & (1 << feature)) ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(balloon3_has);
+
+int __init parse_balloon3_features(char *arg)
+{
+	if (!arg)
+		return 0;
+
+	return strict_strtoul(arg, 0, &balloon3_features_present);
+}
+early_param("balloon3_features", parse_balloon3_features);
+
+/******************************************************************************
+ * FPGA IRQ
+ ******************************************************************************/
+static void balloon3_mask_irq(unsigned int irq)
+{
+	int balloon3_irq = (irq - BALLOON3_IRQ(0));
+	balloon3_irq_enabled &= ~(1 << balloon3_irq);
+	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
+}
+
+static void balloon3_unmask_irq(unsigned int irq)
+{
+	int balloon3_irq = (irq - BALLOON3_IRQ(0));
+	balloon3_irq_enabled |= (1 << balloon3_irq);
+	__raw_writel(~balloon3_irq_enabled, BALLOON3_INT_CONTROL_REG);
+}
+
+static struct irq_chip balloon3_irq_chip = {
+	.name		= "FPGA",
+	.ack		= balloon3_mask_irq,
+	.mask		= balloon3_mask_irq,
+	.unmask		= balloon3_unmask_irq,
+};
+
+static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
+					balloon3_irq_enabled;
+
+	do {
+		/* clear useless edge notification */
+		if (desc->chip->ack)
+			desc->chip->ack(BALLOON3_AUX_NIRQ);
+		while (pending) {
+			irq = BALLOON3_IRQ(0) + __ffs(pending);
+			generic_handle_irq(irq);
+			pending &= pending - 1;
+		}
+		pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
+				balloon3_irq_enabled;
+	} while (pending);
+}
+
+static void __init balloon3_init_irq(void)
+{
+	int irq;
+
+	pxa27x_init_irq();
+	/* setup extra Balloon3 irqs */
+	for (irq = BALLOON3_IRQ(0); irq <= BALLOON3_IRQ(7); irq++) {
+		set_irq_chip(irq, &balloon3_irq_chip);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	}
+
+	set_irq_chained_handler(BALLOON3_AUX_NIRQ, balloon3_irq_handler);
+	set_irq_type(BALLOON3_AUX_NIRQ, IRQ_TYPE_EDGE_FALLING);
+
+	pr_debug("%s: chained handler installed - irq %d automatically "
+		"enabled\n", __func__, BALLOON3_AUX_NIRQ);
+}
+
+/******************************************************************************
+ * Machine init
+ ******************************************************************************/
 static void __init balloon3_init(void)
 {
 	pr_info("Initialising Balloon3\n");
-- 
1.7.1
