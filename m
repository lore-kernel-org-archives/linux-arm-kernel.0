From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:08 +0900
Subject: [PATCH 03/26] ARM: shmobile: Add Koelsch LED6, LED7 and LED8 support
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <87a2934ecff1e054b5d2b7cb6dea2ee0eb649ff3.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable Koelsch LEDs for GPIO output testing purpose.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index d099eaf..2299d65 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -20,6 +20,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7791.h>
@@ -27,11 +29,36 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* LEDS */
+static struct gpio_led koelsch_leds[] = {
+	{
+		.name		= "led8",
+		.gpio		= RCAR_GP_PIN(2, 21),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led7",
+		.gpio		= RCAR_GP_PIN(2, 20),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led6",
+		.gpio		= RCAR_GP_PIN(2, 19),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static const struct gpio_led_platform_data koelsch_leds_pdata __initconst = {
+	.leds		= koelsch_leds,
+	.num_leds	= ARRAY_SIZE(koelsch_leds),
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
+	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+				      &koelsch_leds_pdata,
+				      sizeof(koelsch_leds_pdata));
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.8.4
