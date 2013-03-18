From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:23 +0900
Subject: [PATCH 087/142] ARM: shmobile: kota2: Register pinctrl mappings for
 SDHI and MMCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-88-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings.

Board code used the non-pulled-up version of the function GPIOs, but
those are defined in the PFC driver as enabling the pull-ups anyway.
Enable pull-ups on the MMCIF data and command pins through the pinconf
API.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kota2.c |   63 +++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 09c4f00..7fa71f5 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -434,7 +435,20 @@ static struct platform_device *kota2_devices[] __initdata = {
 	&sdhi1_device,
 };
 
+static unsigned long pin_pullup_conf[] = {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
+};
+
 static const struct pinctrl_map kota2_pinctrl_map[] = {
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_ctrl_0", "mmc0"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				    "PORT279", pin_pullup_conf),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				      "mmc0_data8_0", pin_pullup_conf),
 	/* SCIFA2 (UART2) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
 				  "scifa2_data_0", "scifa2"),
@@ -452,6 +466,28 @@ static const struct pinctrl_map kota2_pinctrl_map[] = {
 				  "scifb_clk_0", "scifb"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-sh73a0",
 				  "scifb_ctrl_0", "scifb"),
+	/* SDHI0 (microSD) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				      "sdhi0_data4", pin_pullup_conf),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				    "PORT256", pin_pullup_conf),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				    "PORT251", pin_pullup_conf),
+	/* SDHI1 (BCM4330) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				  "sdhi1_ctrl", "sdhi1"),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				      "sdhi1_data4", pin_pullup_conf),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mobile_sdhi.1", "pfc-sh73a0",
+				    "PORT263", pin_pullup_conf),
 };
 
 static void __init kota2_init(void)
@@ -508,35 +544,8 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 
 	/* MMCIF */
-	gpio_request(GPIO_FN_MMCCLK0, NULL);
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
-	gpio_request(GPIO_FN_MMCCMD0, NULL);
 	gpio_request_one(208, GPIOF_OUT_INIT_HIGH, NULL); /* Reset */
 
-	/* SDHI0 (microSD) */
-	gpio_request(GPIO_FN_SDHICD0_PU, NULL);
-	gpio_request(GPIO_FN_SDHICMD0_PU, NULL);
-	gpio_request(GPIO_FN_SDHICLK0, NULL);
-	gpio_request(GPIO_FN_SDHID0_3_PU, NULL);
-	gpio_request(GPIO_FN_SDHID0_2_PU, NULL);
-	gpio_request(GPIO_FN_SDHID0_1_PU, NULL);
-	gpio_request(GPIO_FN_SDHID0_0_PU, NULL);
-
-	/* SDHI1 (BCM4330) */
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_3_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_2_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
-	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.10.4
