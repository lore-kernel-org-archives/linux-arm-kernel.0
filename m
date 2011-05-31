From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 May 2011 17:07:03 +0800
Subject: [PATCH] ARM: mxs/mx28evk: add leds-gpio device for heartbeat
Message-ID: <1306832824-23037-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds LED2 on mx28evk board as heartbeat trigger for diagnostic
purpose.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 162b0b0..1d3985f 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -41,6 +41,7 @@ config MACH_MX23EVK
 config MACH_MX28EVK
 	bool "Support MX28EVK Platform"
 	select SOC_IMX28
+	select LEDS_GPIO_REGISTER
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eacdc6b..492dffa 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
 
@@ -30,6 +31,7 @@
 
 #define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
 #define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
+#define MX28EVK_GPIO_LED	MXS_GPIO_NR(3, 5)
 #define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
 #define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
 #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
@@ -179,6 +181,23 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* slot power enable */
 	MX28_PAD_PWM4__GPIO_3_29 |
 		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* led */
+	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
+};
+
+/* led */
+static const struct gpio_led mx28evk_leds[] __initconst = {
+	{
+		.name = "GPIO-LED",
+		.default_trigger = "heartbeat",
+		.gpio = MX28EVK_GPIO_LED,
+	},
+};
+
+static const struct gpio_led_platform_data mx28evk_led_data __initconst = {
+	.leds = mx28evk_leds,
+	.num_leds = ARRAY_SIZE(mx28evk_leds),
 };
 
 /* fec */
@@ -386,6 +405,8 @@ static void __init mx28evk_init(void)
 	if (ret)
 		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
 	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
+
+	gpio_led_register_device(0, &mx28evk_led_data);
 }
 
 static void __init mx28evk_timer_init(void)
-- 
1.7.4.1
