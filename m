From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 10 Nov 2009 14:18:41 +0200
Subject: [PATCH] [ARM] pxa/cm-x300: add PWM backlight support
Message-ID: <1257855521-9611-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Kconfig   |    1 +
 arch/arm/mach-pxa/cm-x300.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 5088b7b..f239cbb 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -244,6 +244,7 @@ config MACH_COLIBRI300
 	select PXA3xx
 	select CPU_PXA300
 	select CPU_PXA310
+	select HAVE_PWM
 
 config MACH_COLIBRI320
 	bool "Toradex Colibri PXA320"
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index e475908..9ce1a4b 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -24,6 +24,7 @@
 #include <linux/dm9000.h>
 #include <linux/leds.h>
 #include <linux/rtc-v3020.h>
+#include <linux/pwm_backlight.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
@@ -50,6 +51,7 @@
 #include <asm/mach/map.h>
 
 #include "generic.h"
+#include "devices.h"
 
 #define CM_X300_ETH_PHYS	0x08000010
 
@@ -160,6 +162,9 @@ static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
 	/* Standard I2C */
 	GPIO21_I2C_SCL,
 	GPIO22_I2C_SDA,
+
+	/* PWM Backlight */
+	GPIO19_PWM2_OUT,
 };
 
 static mfp_cfg_t cm_x3xx_rev_lt130_mfp_cfg[] __initdata = {
@@ -290,6 +295,30 @@ static void __init cm_x300_init_lcd(void)
 static inline void cm_x300_init_lcd(void) {}
 #endif
 
+#if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct platform_pwm_backlight_data cm_x300_backlight_data = {
+	.pwm_id		= 2,
+	.max_brightness	= 100,
+	.dft_brightness	= 100,
+	.pwm_period_ns	= 10000,
+};
+
+static struct platform_device cm_x300_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent = &pxa27x_device_pwm0.dev,
+		.platform_data	= &cm_x300_backlight_data,
+	},
+};
+
+static void cm_x300_init_bl(void)
+{
+	platform_device_register(&cm_x300_backlight_device);
+}
+#else
+static inline void cm_x300_init_bl(void) {}
+#endif
+
 #if defined(CONFIG_SPI_GPIO) || defined(CONFIG_SPI_GPIO_MODULE)
 #define GPIO_LCD_BASE	(144)
 #define GPIO_LCD_DIN	(GPIO_LCD_BASE + 8)	/* aux_gpio3_0 */
@@ -649,6 +678,7 @@ static void __init cm_x300_init(void)
 	cm_x300_init_rtc();
 	cm_x300_init_ac97();
 	cm_x300_init_wi2wi();
+	cm_x300_init_bl();
 }
 
 static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
-- 
1.6.0.6
