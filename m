From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:33 +0900
Subject: [PATCH 097/142] ARM: shmobile: mackerel: Register pinctrl mappings
 for SDHI and MMCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-98-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   68 ++++++++++++++-----------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 172d472..336ccb4 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -40,6 +40,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/pm_clock.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -1328,6 +1329,33 @@ static struct i2c_board_info i2c1_devices[] = {
 	},
 };
 
+static const struct pinctrl_map mackerel_pinctrl_map[] = {
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
+				  "sdhi0_wp", "sdhi0"),
+	/* SDHI1 */
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
+				  "sdhi1_ctrl", "sdhi1"),
+#endif
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
+				  "sdhi2_ctrl", "sdhi2"),
+};
+
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
 #define GPIO_PORT10CR	IOMEM(0xE605100A)
 #define GPIO_PORT167CR	IOMEM(0xE60520A7)
@@ -1364,6 +1392,8 @@ static void __init mackerel_init(void)
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
+	pinctrl_register_mappings(mackerel_pinctrl_map,
+				  ARRAY_SIZE(mackerel_pinctrl_map));
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -1453,53 +1483,15 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
-	/* enable SDHI0 */
-	gpio_request(GPIO_FN_SDHIWP0, NULL);
-	gpio_request(GPIO_FN_SDHICMD0, NULL);
-	gpio_request(GPIO_FN_SDHICLK0, NULL);
-	gpio_request(GPIO_FN_SDHID0_3, NULL);
-	gpio_request(GPIO_FN_SDHID0_2, NULL);
-	gpio_request(GPIO_FN_SDHID0_1, NULL);
-	gpio_request(GPIO_FN_SDHID0_0, NULL);
-
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	/* enable SDHI1 */
-	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHID1_3, NULL);
-	gpio_request(GPIO_FN_SDHID1_2, NULL);
-	gpio_request(GPIO_FN_SDHID1_1, NULL);
-	gpio_request(GPIO_FN_SDHID1_0, NULL);
-#endif
 	/* card detect pin for MMC slot (CN7) */
 	gpio_request_one(41, GPIOF_IN, NULL);
 
-	/* enable SDHI2 */
-	gpio_request(GPIO_FN_SDHICMD2, NULL);
-	gpio_request(GPIO_FN_SDHICLK2, NULL);
-	gpio_request(GPIO_FN_SDHID2_3, NULL);
-	gpio_request(GPIO_FN_SDHID2_2, NULL);
-	gpio_request(GPIO_FN_SDHID2_1, NULL);
-	gpio_request(GPIO_FN_SDHID2_0, NULL);
-
 	/* card detect pin for microSD slot (CN23) */
 	gpio_request_one(162, GPIOF_IN, NULL);
 
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
 	/* FLCTL */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
 	gpio_request(GPIO_FN_D1_NAF1, NULL);
-- 
1.7.10.4
