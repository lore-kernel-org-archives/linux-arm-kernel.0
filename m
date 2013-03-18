From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:18 +0900
Subject: [PATCH 082/142] ARM: shmobile: ap4evb: Register pinctrl mappings for
 SDHI and MMCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-83-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   55 +++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 0a2b6e4..45f78ca 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -34,6 +34,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -1084,6 +1085,28 @@ static struct i2c_board_info i2c1_devices[] = {
 };
 
 
+static const struct pinctrl_map ap4evb_pinctrl_map[] = {
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_ctrl_0", "mmc0"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
+				  "sdhi0_wp", "sdhi0"),
+	/* SDHI1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
+				  "sdhi1_ctrl", "sdhi1"),
+};
+
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
 #define GPIO_PORT10CR	IOMEM(0xE605100A)
 #define USCCR1		IOMEM(0xE6058144)
@@ -1110,6 +1133,8 @@ static void __init ap4evb_init(void)
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
+	pinctrl_register_mappings(ap4evb_pinctrl_map,
+				  ARRAY_SIZE(ap4evb_pinctrl_map));
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -1126,36 +1151,6 @@ static void __init ap4evb_init(void)
 	gpio_request_one(34, GPIOF_IN | GPIOF_EXPORT, NULL);
 	gpio_request_one(35, GPIOF_IN | GPIOF_EXPORT, NULL);
 
-	/* SDHI0 */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
-	gpio_request(GPIO_FN_SDHIWP0, NULL);
-	gpio_request(GPIO_FN_SDHICMD0, NULL);
-	gpio_request(GPIO_FN_SDHICLK0, NULL);
-	gpio_request(GPIO_FN_SDHID0_3, NULL);
-	gpio_request(GPIO_FN_SDHID0_2, NULL);
-	gpio_request(GPIO_FN_SDHID0_1, NULL);
-	gpio_request(GPIO_FN_SDHID0_0, NULL);
-
-	/* SDHI1 */
-	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHID1_3, NULL);
-	gpio_request(GPIO_FN_SDHID1_2, NULL);
-	gpio_request(GPIO_FN_SDHID1_1, NULL);
-	gpio_request(GPIO_FN_SDHID1_0, NULL);
-
-	/* MMCIF */
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
-	gpio_request(GPIO_FN_MMCCMD0, NULL);
-	gpio_request(GPIO_FN_MMCCLK0, NULL);
-
 	/* USB enable */
 	gpio_request(GPIO_FN_VBUS0_1,    NULL);
 	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
-- 
1.7.10.4
