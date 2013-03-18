From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:26 +0900
Subject: [PATCH 090/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 LCD
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-91-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based LCD pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   38 ++++++++++------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 65a5e0b..7cef005 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,6 +30,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -599,6 +600,14 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
+static const struct pinctrl_map kzm_pinctrl_map[] = {
+	/* LCD */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+				  "lcd_data24", "lcd"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+				  "lcd_sync", "lcd"),
+};
+
 /*
  * FIXME
  *
@@ -660,6 +669,8 @@ static void __init kzm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
+
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA4 */
@@ -675,33 +686,6 @@ static void __init kzm_init(void)
 	gpio_request_one(224, GPIOF_IN, NULL); /* IRQ3 */
 
 	/* LCDC */
-	gpio_request(GPIO_FN_LCDD23,	NULL);
-	gpio_request(GPIO_FN_LCDD22,	NULL);
-	gpio_request(GPIO_FN_LCDD21,	NULL);
-	gpio_request(GPIO_FN_LCDD20,	NULL);
-	gpio_request(GPIO_FN_LCDD19,	NULL);
-	gpio_request(GPIO_FN_LCDD18,	NULL);
-	gpio_request(GPIO_FN_LCDD17,	NULL);
-	gpio_request(GPIO_FN_LCDD16,	NULL);
-	gpio_request(GPIO_FN_LCDD15,	NULL);
-	gpio_request(GPIO_FN_LCDD14,	NULL);
-	gpio_request(GPIO_FN_LCDD13,	NULL);
-	gpio_request(GPIO_FN_LCDD12,	NULL);
-	gpio_request(GPIO_FN_LCDD11,	NULL);
-	gpio_request(GPIO_FN_LCDD10,	NULL);
-	gpio_request(GPIO_FN_LCDD9,	NULL);
-	gpio_request(GPIO_FN_LCDD8,	NULL);
-	gpio_request(GPIO_FN_LCDD7,	NULL);
-	gpio_request(GPIO_FN_LCDD6,	NULL);
-	gpio_request(GPIO_FN_LCDD5,	NULL);
-	gpio_request(GPIO_FN_LCDD4,	NULL);
-	gpio_request(GPIO_FN_LCDD3,	NULL);
-	gpio_request(GPIO_FN_LCDD2,	NULL);
-	gpio_request(GPIO_FN_LCDD1,	NULL);
-	gpio_request(GPIO_FN_LCDD0,	NULL);
-	gpio_request(GPIO_FN_LCDDISP,	NULL);
-	gpio_request(GPIO_FN_LCDDCK,	NULL);
-
 	gpio_request_one(222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
 	gpio_request_one(226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
 
-- 
1.7.10.4
