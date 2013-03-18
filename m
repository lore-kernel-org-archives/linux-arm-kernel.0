From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:34 +0900
Subject: [PATCH 098/142] ARM: shmobile: marzen: Register pinctrl mappings for
 SDHI and MMCIF
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-99-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fec49eb..f00677f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -327,6 +328,18 @@ void __init marzen_init_late(void)
 			     ARRAY_SIZE(marzen_late_devices));
 }
 
+static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_wp", "sdhi0"),
+};
+
 static void __init marzen_init(void)
 {
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
@@ -334,6 +347,8 @@ static void __init marzen_init(void)
 	regulator_register_fixed(1, dummy_supplies,
 				ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(marzen_pinctrl_map,
+				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
 
 	/* SCIF2 (CN18: DEBUG0) */
@@ -348,16 +363,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* SD0 (CN20) */
-	gpio_request(GPIO_FN_SD0_CLK, NULL);
-	gpio_request(GPIO_FN_SD0_CMD, NULL);
-	gpio_request(GPIO_FN_SD0_DAT0, NULL);
-	gpio_request(GPIO_FN_SD0_DAT1, NULL);
-	gpio_request(GPIO_FN_SD0_DAT2, NULL);
-	gpio_request(GPIO_FN_SD0_DAT3, NULL);
-	gpio_request(GPIO_FN_SD0_CD, NULL);
-	gpio_request(GPIO_FN_SD0_WP, NULL);
-
 	/* HSPI 0 */
 	gpio_request(GPIO_FN_HSPI_CLK0,	NULL);
 	gpio_request(GPIO_FN_HSPI_CS0,	NULL);
-- 
1.7.10.4
