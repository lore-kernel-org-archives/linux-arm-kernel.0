From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 12:40:08 +0900
Subject: [PATCH 08/08] ARM: shmobile: Add Koelsch SW2 support
In-Reply-To: <20131008033851.20455.68845.sendpatchset@w520>
References: <20131008033851.20455.68845.sendpatchset@w520>
Message-ID: <20131008034008.20455.77595.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable Koelsch GPIO switch for GPIO input and IRQ testing purpose.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- 0012/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-07 14:05:22.000000000 +0900
@@ -19,6 +19,9 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/platform_data/gpio-rcar.h>
@@ -51,6 +54,22 @@ static const struct gpio_led_platform_da
 	.num_leds	= ARRAY_SIZE(koelsch_leds),
 };
 
+/* GPIO KEY */
+#define GPIO_KEY(c, g, d, ...) \
+	{ .code = c, .gpio = g, .desc = d, .active_low = 1 }
+
+static struct gpio_keys_button gpio_buttons[] = {
+	GPIO_KEY(KEY_4,		RCAR_GP_PIN(5, 3),	"SW2-pin4"),
+	GPIO_KEY(KEY_3,		RCAR_GP_PIN(5, 2),	"SW2-pin3"),
+	GPIO_KEY(KEY_2,		RCAR_GP_PIN(5, 1),	"SW2-pin2"),
+	GPIO_KEY(KEY_1,		RCAR_GP_PIN(5, 0),	"SW2-pin1"),
+};
+
+static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
@@ -59,6 +78,9 @@ static void __init koelsch_add_standard_
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &koelsch_leds_pdata,
 				      sizeof(koelsch_leds_pdata));
+	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+				      &koelsch_keys_pdata,
+				      sizeof(koelsch_keys_pdata));
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
