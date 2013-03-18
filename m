From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:19 +0900
Subject: [PATCH 083/142] ARM: shmobile: armadillo800eva: Register pinctrl
 mappings for LCDC0
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-84-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based LCDC0 pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   42 ++++++++----------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 92d7991..aa812cf 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -914,6 +915,16 @@ static struct platform_device *eva_devices[] __initdata = {
 	&i2c_gpio_device,
 };
 
+static const struct pinctrl_map eva_pinctrl_map[] = {
+	/* LCD0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_data24_0", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_lclk_1", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_sync", "lcd0"),
+};
+
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -961,6 +972,8 @@ static void __init eva_init(void)
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
+	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
+
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
@@ -970,35 +983,6 @@ static void __init eva_init(void)
 
 	/* LCDC0 */
 	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
-	gpio_request(GPIO_FN_LCD0_D0,		NULL);
-	gpio_request(GPIO_FN_LCD0_D1,		NULL);
-	gpio_request(GPIO_FN_LCD0_D2,		NULL);
-	gpio_request(GPIO_FN_LCD0_D3,		NULL);
-	gpio_request(GPIO_FN_LCD0_D4,		NULL);
-	gpio_request(GPIO_FN_LCD0_D5,		NULL);
-	gpio_request(GPIO_FN_LCD0_D6,		NULL);
-	gpio_request(GPIO_FN_LCD0_D7,		NULL);
-	gpio_request(GPIO_FN_LCD0_D8,		NULL);
-	gpio_request(GPIO_FN_LCD0_D9,		NULL);
-	gpio_request(GPIO_FN_LCD0_D10,		NULL);
-	gpio_request(GPIO_FN_LCD0_D11,		NULL);
-	gpio_request(GPIO_FN_LCD0_D12,		NULL);
-	gpio_request(GPIO_FN_LCD0_D13,		NULL);
-	gpio_request(GPIO_FN_LCD0_D14,		NULL);
-	gpio_request(GPIO_FN_LCD0_D15,		NULL);
-	gpio_request(GPIO_FN_LCD0_D16,		NULL);
-	gpio_request(GPIO_FN_LCD0_D17,		NULL);
-	gpio_request(GPIO_FN_LCD0_D18_PORT40,	NULL);
-	gpio_request(GPIO_FN_LCD0_D19_PORT4,	NULL);
-	gpio_request(GPIO_FN_LCD0_D20_PORT3,	NULL);
-	gpio_request(GPIO_FN_LCD0_D21_PORT2,	NULL);
-	gpio_request(GPIO_FN_LCD0_D22_PORT0,	NULL);
-	gpio_request(GPIO_FN_LCD0_D23_PORT1,	NULL);
-	gpio_request(GPIO_FN_LCD0_DCK,		NULL);
-	gpio_request(GPIO_FN_LCD0_VSYN,		NULL);
-	gpio_request(GPIO_FN_LCD0_HSYN,		NULL);
-	gpio_request(GPIO_FN_LCD0_DISP,		NULL);
-	gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
-- 
1.7.10.4
