From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 13 May 2013 17:53:53 +0900
Subject: [PATCH 3/3] ARM: mach-shmobile: lager: support GPIO switches
In-Reply-To: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1368435233-8587-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lager board has pins 1 - 4 of SW2 wired up to GPIO pins.
This patch allows access to those pins as KEYS 1 - 4 using
gpio-keys.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch has run time dependencies on
1. "gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH"
2. "ARM: shmobile: r8a7790: Configure R-Car GPIO for IRQ_TYPE_EDGE_BOTH"

Without those dependencies satisfied the gpio-keys driver will
fail to be initialise itself. The boot should be otherwise successful
and the board otherwise functional.
---
 arch/arm/mach-shmobile/board-lager.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 6a1ba38..4d1b42b 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -18,7 +18,10 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 #include <linux/interrupt.h>
+#include <linux/input.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
@@ -52,6 +55,22 @@ static struct gpio_led_platform_data lager_leds_pdata = {
 	.num_leds	= ARRAY_SIZE(lager_leds),
 };
 
+/* GPIO KEY */
+#define GPIO_KEY(c, g, d, ...) \
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
+
+static struct gpio_keys_button gpio_buttons[] = {
+	GPIO_KEY(KEY_4,		RCAR_GP_PIN(1, 28),	"SW2-pin4"),
+	GPIO_KEY(KEY_3,		RCAR_GP_PIN(1, 26),	"SW2-pin3"),
+	GPIO_KEY(KEY_2,		RCAR_GP_PIN(1, 24),	"SW2-pin2"),
+	GPIO_KEY(KEY_1,		RCAR_GP_PIN(1, 14),	"SW2-pin1"),
+};
+
+static struct gpio_keys_platform_data lager_keys_pdata = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -73,6 +92,9 @@ static void __init lager_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &lager_leds_pdata,
 				      sizeof(lager_leds_pdata));
+	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+				      &lager_keys_pdata,
+				      sizeof(lager_keys_pdata));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.2.1
