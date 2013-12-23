From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:15 +0900
Subject: [PATCH 19/26] ARM: shmobile: Add pinctrl_register_mappings() for
 Koelsch
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <85ef14da7337ba2c9b9fc489637e3db3b956b5a0.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add code to setup the r8a7791 PFC for the Koelsch board.

At this point serial consoles are added, and in the near
future other platform-device-only devices will be added
here like for instance the r8a7791 DU.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 412e153..6e12914 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
@@ -78,9 +79,20 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+static const struct pinctrl_map koelsch_pinctrl_map[] = {
+	/* SCIF0 (CN19: DEBUG SERIAL0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7791",
+				  "scif0_data_d", "scif0"),
+	/* SCIF1 (CN20: DEBUG SERIAL1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
+				  "scif1_data_d", "scif1"),
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
+	pinctrl_register_mappings(koelsch_pinctrl_map,
+				  ARRAY_SIZE(koelsch_pinctrl_map));
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
-- 
1.8.4
