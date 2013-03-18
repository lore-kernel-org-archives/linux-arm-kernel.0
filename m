From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:15 +0900
Subject: [PATCH 079/142] ARM: shmobile: ag5evm: Register pinctrl mappings for
 SDHI and MMCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-80-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   57 +++++++++++++++++----------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 178bfd1..987b9b6 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -551,6 +552,10 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 	&sdhi1_device,
 };
 
+static unsigned long pin_pullup_conf[] = {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
+};
+
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
 	/* FSIA */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
@@ -566,11 +571,36 @@ static const struct pinctrl_map ag5evm_pinctrl_map[] = {
 				  "i2c2_0", "i2c2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_0", "i2c3"),
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_ctrl_0", "mmc0"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				    "PORT279", pin_pullup_conf),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				      "mmc0_data8_0", pin_pullup_conf),
 	/* SCIFA2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
 				  "scifa2_data_0", "scifa2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
 				  "scifa2_ctrl_0", "scifa2"),
+	/* SDHI0 (CN15 [SD I/F]) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_wp", "sdhi0"),
+	/* SDHI1 (CN4 [WLAN I/F]) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				  "sdhi1_ctrl", "sdhi1"),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				      "sdhi1_data4", pin_pullup_conf),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				    "PORT263", pin_pullup_conf),
 };
 
 static void __init ag5evm_init(void)
@@ -606,16 +636,6 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
 
 	/* enable MMCIF */
-	gpio_request(GPIO_FN_MMCCLK0, NULL);
-	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_0_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_1_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_2_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_3_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_4_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_5_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_6_PU, NULL);
-	gpio_request(GPIO_FN_MMCD0_7_PU, NULL);
 	gpio_request_one(208, GPIOF_OUT_INIT_HIGH, NULL); /* Reset */
 
 	/* enable SMSC911X */
@@ -637,23 +657,6 @@ static void __init ag5evm_init(void)
 	gpio_request_one(235, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	lcd_backlight_set_brightness(0);
 
-	/* enable SDHI0 on CN15 [SD I/F] */
-	gpio_request(GPIO_FN_SDHIWP0, NULL);
-	gpio_request(GPIO_FN_SDHICMD0, NULL);
-	gpio_request(GPIO_FN_SDHICLK0, NULL);
-	gpio_request(GPIO_FN_SDHID0_3, NULL);
-	gpio_request(GPIO_FN_SDHID0_2, NULL);
-	gpio_request(GPIO_FN_SDHID0_1, NULL);
-	gpio_request(GPIO_FN_SDHID0_0, NULL);
-
-	/* enable SDHI1 on CN4 [WLAN I/F] */
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_3_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_2_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
-- 
1.7.10.4
