From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 11:44:37 +0900
Subject: [PATCH 01/21] ARM: shmobile: bonito: Register pinctrl mappings for
 LCDC0
In-Reply-To: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360723497-23266-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based LCDC0 pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c |   43 ++++++++++-----------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index e50f866..a511777 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/regulator/fixed.h>
@@ -288,6 +289,15 @@ static struct platform_device lcdc0_device = {
 	},
 };
 
+static const struct pinctrl_map lcdc0_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_data24_1", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_lclk_1", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_sync", "lcd0"),
+};
+
 /*
  * SMSC 9221
  */
@@ -430,36 +440,9 @@ static void __init bonito_init(void)
 		 */
 		if (BIT_ON(bsw2, 3) &&	/* S38.1 = OFF */
 		    BIT_ON(bsw2, 2)) {	/* S38.2 = OFF */
-			gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
-			gpio_request(GPIO_FN_LCD0_D0,		NULL);
-			gpio_request(GPIO_FN_LCD0_D1,		NULL);
-			gpio_request(GPIO_FN_LCD0_D2,		NULL);
-			gpio_request(GPIO_FN_LCD0_D3,		NULL);
-			gpio_request(GPIO_FN_LCD0_D4,		NULL);
-			gpio_request(GPIO_FN_LCD0_D5,		NULL);
-			gpio_request(GPIO_FN_LCD0_D6,		NULL);
-			gpio_request(GPIO_FN_LCD0_D7,		NULL);
-			gpio_request(GPIO_FN_LCD0_D8,		NULL);
-			gpio_request(GPIO_FN_LCD0_D9,		NULL);
-			gpio_request(GPIO_FN_LCD0_D10,		NULL);
-			gpio_request(GPIO_FN_LCD0_D11,		NULL);
-			gpio_request(GPIO_FN_LCD0_D12,		NULL);
-			gpio_request(GPIO_FN_LCD0_D13,		NULL);
-			gpio_request(GPIO_FN_LCD0_D14,		NULL);
-			gpio_request(GPIO_FN_LCD0_D15,		NULL);
-			gpio_request(GPIO_FN_LCD0_D16,		NULL);
-			gpio_request(GPIO_FN_LCD0_D17,		NULL);
-			gpio_request(GPIO_FN_LCD0_D18_PORT163,	NULL);
-			gpio_request(GPIO_FN_LCD0_D19_PORT162,	NULL);
-			gpio_request(GPIO_FN_LCD0_D20_PORT161,	NULL);
-			gpio_request(GPIO_FN_LCD0_D21_PORT158,	NULL);
-			gpio_request(GPIO_FN_LCD0_D22_PORT160,	NULL);
-			gpio_request(GPIO_FN_LCD0_D23_PORT159,	NULL);
-			gpio_request(GPIO_FN_LCD0_DCK,		NULL);
-			gpio_request(GPIO_FN_LCD0_VSYN,		NULL);
-			gpio_request(GPIO_FN_LCD0_HSYN,		NULL);
-			gpio_request(GPIO_FN_LCD0_DISP,		NULL);
-			gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
+			pinctrl_register_mappings(lcdc0_pinctrl_map,
+						  ARRAY_SIZE(lcdc0_pinctrl_map));
+			gpio_request(GPIO_FN_LCDC0_SELECT, NULL);
 
 			gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH,
 					 NULL); /* LCDDON */
-- 
1.7.10.4
