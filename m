From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 10:02:17 -0800
Subject: [PATCH v2 1/4] ARM: palmtreo: fix lcd initilialization on treo680
In-Reply-To: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
References: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <1356631340-30328-2-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch gets the LCD working on my Palm Treo680 by adding some code that
manages the three gpios interfaced to the lcd on the Treo 680.  The precise role
of each gpio in the hardware architecture is not entirely clear to me; this
patch is the result of trial-and-error and observing how the PalmOS code
initializes the lcd.

The need for this patch is not evident when Linux is loaded from PalmOS, because
at that point the lcd-related gpios have already been configured.  But when
booting the kernel by other means, this patch is required unless the bootloader
has performed the necessary initialializations.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 arch/arm/mach-pxa/include/mach/palmtreo.h |    3 +
 arch/arm/mach-pxa/palmtreo.c              |   61 +++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/palmtreo.h b/arch/arm/mach-pxa/include/mach/palmtreo.h
index 2d3f14e..3266194 100644
--- a/arch/arm/mach-pxa/include/mach/palmtreo.h
+++ b/arch/arm/mach-pxa/include/mach/palmtreo.h
@@ -44,6 +44,9 @@
 #define GPIO_NR_TREO680_VIBRATE_EN	44
 #define GPIO_NR_TREO680_KEYB_BL		24
 #define GPIO_NR_TREO680_BT_EN		43
+#define GPIO_NR_TREO680_LCD_POWER	77
+#define GPIO_NR_TREO680_LCD_EN		86
+#define GPIO_NR_TREO680_LCD_EN_N	25
 #endif /* CONFIG_MACH_TREO680 */
 
 /* Centro685 specific GPIOs */
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 3f3c48f..4441216 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -98,9 +98,6 @@ static unsigned long treo_pin_config[] __initdata = {
 	GPIO96_KP_MKOUT_6,
 	GPIO93_KP_DKIN_0 | WAKEUP_ON_LEVEL_HIGH,	/* Hotsync button */
 
-	/* LCD */
-	GPIOxx_LCD_TFT_16BPP,
-
 	/* Quick Capture Interface */
 	GPIO84_CIF_FV,
 	GPIO85_CIF_LV,
@@ -140,6 +137,12 @@ static unsigned long treo680_pin_config[] __initdata = {
 	/* MATRIX KEYPAD - different wake up source */
 	GPIO100_KP_MKIN_0 | WAKEUP_ON_LEVEL_HIGH,
 	GPIO99_KP_MKIN_5,
+
+	/* LCD... L_BIAS alt fn not configured on Treo680; is GPIO instead */
+	GPIOxx_LCD_16BPP,
+	GPIO74_LCD_FCLK,
+	GPIO75_LCD_LCLK,
+	GPIO76_LCD_PCLK,
 };
 #endif /* CONFIG_MACH_TREO680 */
 
@@ -155,6 +158,9 @@ static unsigned long centro685_pin_config[] __initdata = {
 	/* MATRIX KEYPAD - different wake up source */
 	GPIO100_KP_MKIN_0,
 	GPIO99_KP_MKIN_5 | WAKEUP_ON_LEVEL_HIGH,
+
+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
 };
 #endif /* CONFIG_MACH_CENTRO */
 
@@ -424,10 +430,59 @@ static void __init palmphone_common_init(void)
 }
 
 #ifdef CONFIG_MACH_TREO680
+void __init treo680_gpio_init(void)
+{
+	unsigned int gpio;
+
+	/* drive all three lcd gpios high initially */
+	const unsigned long lcd_flags = GPIOF_INIT_HIGH | GPIOF_DIR_OUT;
+
+	/*
+	 * LCD GPIO initialization...
+	 */
+
+	/*
+	 * This is likely the power to the lcd.  Toggling it low/high appears to
+	 * turn the lcd off/on.  Can be toggled after lcd is initialized without
+	 * any apparent adverse effects to the lcd operation.  Note that this
+	 * gpio line is used by the lcd controller as the L_BIAS signal, but
+	 * treo680 configures it as gpio.
+	 */
+	gpio = GPIO_NR_TREO680_LCD_POWER;
+	if (gpio_request_one(gpio, lcd_flags, "LCD power") < 0)
+		goto fail;
+
+	/*
+	 * These two are called "enables", for lack of a better understanding.
+	 * If either of these are toggled after the lcd is initialized, the
+	 * image becomes degraded.  N.B. The IPL shipped with the treo
+	 * configures GPIO_NR_TREO680_LCD_EN_N as output and drives it high.  If
+	 * the IPL is ever reprogrammed, this initialization may be need to be
+	 * revisited.
+	 */
+	gpio = GPIO_NR_TREO680_LCD_EN;
+	if (gpio_request_one(gpio, lcd_flags, "LCD enable") < 0)
+		goto fail;
+	gpio = GPIO_NR_TREO680_LCD_EN_N;
+	if (gpio_request_one(gpio, lcd_flags, "LCD enable_n") < 0)
+		goto fail;
+
+	/* driving this low turns LCD on */
+	gpio_set_value(GPIO_NR_TREO680_LCD_EN_N, 0);
+
+	return;
+ fail:
+	pr_err("gpio %d initialization failed\n", gpio);
+	gpio_free(GPIO_NR_TREO680_LCD_POWER);
+	gpio_free(GPIO_NR_TREO680_LCD_EN);
+	gpio_free(GPIO_NR_TREO680_LCD_EN_N);
+}
+
 static void __init treo680_init(void)
 {
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
 	palmphone_common_init();
+	treo680_gpio_init();
 	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
 			GPIO_NR_TREO680_SD_POWER, 0);
 }
-- 
1.7.8.6
