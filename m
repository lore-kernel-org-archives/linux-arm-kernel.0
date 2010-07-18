From: triad@df.lth.se (Linus Walleij)
Date: Mon, 19 Jul 2010 01:17:53 +0200
Subject: [PATCH] ARM: driver for the LEDs found in the later ARM refdesigns
Message-ID: <1279495073-29576-1-git-send-email-triad@df.lth.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple driver supporting the new LED framework with
triggers and all for the RealView and Versatile platforms. The
RealView and Versatile platform drivers were arranged to compile
for all-but-integrator as a side effect since the Integrator has
a different LED driver.

Signed-off-by: Linus Walleij <triad@df.lth.se>
---
 arch/arm/plat-versatile/Makefile |    7 ++-
 arch/arm/plat-versatile/leds.c   |  103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-versatile/leds.c

diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 9b1a668..505a8f8 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,7 @@
 obj-y	:= clock.o
 obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
-obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
-obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
+# For all but the Integrator, compile these
+ifeq ($(CONFIG_ARCH_INTEGRATOR),)
+obj-y += sched-clock.o
+obj-$(CONFIG_LEDS_CLASS) += leds.o
+endif
diff --git a/arch/arm/plat-versatile/leds.c b/arch/arm/plat-versatile/leds.c
new file mode 100644
index 0000000..3169fa5
--- /dev/null
+++ b/arch/arm/plat-versatile/leds.c
@@ -0,0 +1,103 @@
+/*
+ * Driver for the 8 user LEDs found on the RealViews and Versatiles
+ * Based on DaVinci's DM365 board code
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <triad@df.lth.se>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+#ifdef VERSATILE_SYS_BASE
+#define LEDREG	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
+#endif
+
+#ifdef REALVIEW_SYS_BASE
+#define LEDREG	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LED_OFFSET)
+#endif
+
+struct versatile_led {
+	struct led_classdev	cdev;
+	u8			mask;
+};
+
+/*
+ * The triggers lines up below will only be used if the
+ * LED triggers are compiled in.
+ */
+static const struct {
+	const char *name;
+	const char *trigger;
+} versatile_leds[] = {
+	{ "versatile:0", "heartbeat", },
+	{ "versatile:1", "mmc0", },
+	{ "versatile:2", },
+	{ "versatile:3", },
+	{ "versatile:4", },
+	{ "versatile:5", },
+	{ "versatile:6", },
+	{ "versatile:7", },
+};
+
+static void versatile_led_set(struct led_classdev *cdev,
+			      enum led_brightness b)
+{
+	struct versatile_led *led = container_of(cdev,
+						 struct versatile_led, cdev);
+	u32 reg = readl(LEDREG);
+
+	if (b != LED_OFF)
+		reg |= led->mask;
+	else
+		reg &= ~led->mask;
+	writel(reg, LEDREG);
+}
+
+static enum led_brightness versatile_led_get(struct led_classdev *cdev)
+{
+	struct versatile_led *led = container_of(cdev,
+						 struct versatile_led, cdev);
+	u32 reg = readl(LEDREG);
+
+	return (reg & led->mask) ? LED_FULL : LED_OFF;
+}
+
+static int __init versatile_leds_init(void)
+{
+	int i;
+
+	/* All ON */
+	writel(0xff, LEDREG);
+	for (i = 0; i < ARRAY_SIZE(versatile_leds); i++) {
+		struct versatile_led *led;
+
+		led = kzalloc(sizeof(*led), GFP_KERNEL);
+		if (!led)
+			break;
+
+		led->cdev.name = versatile_leds[i].name;
+		led->cdev.brightness_set = versatile_led_set;
+		led->cdev.brightness_get = versatile_led_get;
+		led->cdev.default_trigger = versatile_leds[i].trigger;
+		led->mask = BIT(i);
+
+		if (led_classdev_register(NULL, &led->cdev) < 0) {
+			kfree(led);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Since we may have triggers on any subsystem, defer registration
+ * until after subsystem_init.
+ */
+fs_initcall(versatile_leds_init);
-- 
1.7.1
