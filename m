From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Tue, 30 Aug 2011 15:52:36 +0800
Subject: [PATCH 2/2] ARM: mx53/loco: add pwm backlight device
In-Reply-To: <1314690756-19982-1-git-send-email-jason.chen@freescale.com>
References: <1314690756-19982-1-git-send-email-jason.chen@freescale.com>
Message-ID: <1314690756-19982-2-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
Signed-off-by: Jason Chen <jason.chen@linaro.org>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   11 +++++++++++
 arch/arm/mach-mx5/devices-imx53.h   |    4 ++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b4e7c58..1463cd3 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -202,6 +202,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_PWM
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select LEDS_GPIO_REGISTER
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..e2d916d 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/pwm_backlight.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -257,6 +258,13 @@ static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
 	.num_leds	= ARRAY_SIZE(mx53loco_leds),
 };
 
+static struct platform_pwm_backlight_data loco_pwm_backlight_data = {
+	.pwm_id = 1,
+	.max_brightness = 255,
+	.dft_brightness = 128,
+	.pwm_period_ns = 50000,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	imx53_soc_init();
@@ -273,6 +281,9 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
 	imx_add_gpio_keys(&loco_button_data);
 	gpio_led_register_device(-1, &mx53loco_leds_data);
+
+	imx53_add_mxc_pwm(1);
+	imx53_add_mxc_pwm_backlight(0, &loco_pwm_backlight_data);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 258e68f..2aa8ef8 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -44,3 +44,7 @@ extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
 #define imx53_add_mxc_pwm(id)	\
 	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
+
+#define imx53_add_mxc_pwm_backlight(id, pdata)			\
+	platform_device_register_resndata(NULL, "pwm-backlight",\
+			id, NULL, 0, pdata, sizeof(*pdata));
-- 
1.7.4.1
