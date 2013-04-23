From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 23 Apr 2013 11:37:05 +0900
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
Message-ID: <1366684625-17256-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
support them.

Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* As suggested by Sergei Shtylyov:
  Use platform_device_register_data() instead of platform_add_devices()
* As suggested by Laurent Pinchart:
  Use -1 as device id as there is only one such device
---
 arch/arm/mach-shmobile/board-lager.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 6114edd..6a1ba38 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -21,13 +21,37 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/leds.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* LEDS */
+static struct gpio_led lager_leds[] = {
+	{
+		.name		= "led8",
+		.gpio		= RCAR_GP_PIN(5, 17),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led7",
+		.gpio		= RCAR_GP_PIN(4, 23),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led6",
+		.gpio		= RCAR_GP_PIN(4, 22),
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data lager_leds_pdata = {
+	.leds		= lager_leds,
+	.num_leds	= ARRAY_SIZE(lager_leds),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -46,6 +70,9 @@ static void __init lager_add_standard_devices(void)
 	r8a7790_pinmux_init();
 
 	r8a7790_add_standard_devices();
+	platform_device_register_data(&platform_bus, "leds-gpio", -1,
+				      &lager_leds_pdata,
+				      sizeof(lager_leds_pdata));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.2.1
