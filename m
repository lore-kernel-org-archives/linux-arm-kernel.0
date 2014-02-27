From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Feb 2014 14:58:19 +0100
Subject: [PATCH 2/3] ARM/leds: move ARM Versatile LED driver to leds subsystem
In-Reply-To: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
References: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1393509500-26002-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have converted this driver to a real platform device
module-based thing, we move the driver down into the LEDs
subsystem and rename the config option to LEDS_VERSATILE.

Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Bryan: can you provide an ACK for this patch so I can funnel
this through the ARM SoC tree?
---
 arch/arm/plat-versatile/Kconfig  |   6 ---
 arch/arm/plat-versatile/Makefile |   1 -
 arch/arm/plat-versatile/leds.c   | 110 ---------------------------------------
 drivers/leds/Kconfig             |   8 +++
 drivers/leds/Makefile            |   1 +
 drivers/leds/leds-versatile.c    | 110 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+), 117 deletions(-)
 delete mode 100644 arch/arm/plat-versatile/leds.c
 create mode 100644 drivers/leds/leds-versatile.c

diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 2c4332b9f948..fce41e93b6a4 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -6,12 +6,6 @@ config PLAT_VERSATILE_CLOCK
 config PLAT_VERSATILE_CLCD
 	bool
 
-config PLAT_VERSATILE_LEDS
-	def_bool y if NEW_LEDS
-	depends on ARCH_REALVIEW || ARCH_VERSATILE
-	select LEDS_CLASS
-	select LEDS_TRIGGERS
-
 config PLAT_VERSATILE_SCHED_CLOCK
 	def_bool y
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index f88d448b629c..2e0c472958ae 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -2,6 +2,5 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
-obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/leds.c b/arch/arm/plat-versatile/leds.c
deleted file mode 100644
index 80553022d661..000000000000
--- a/arch/arm/plat-versatile/leds.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Driver for the 8 user LEDs found on the RealViews and Versatiles
- * Based on DaVinci's DM365 board code
- *
- * License terms: GNU General Public License (GPL) version 2
- * Author: Linus Walleij <triad@df.lth.se>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-
-struct versatile_led {
-	void __iomem		*base;
-	struct led_classdev	cdev;
-	u8			mask;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} versatile_leds[] = {
-	{ "versatile:0", "heartbeat", },
-	{ "versatile:1", "mmc0", },
-	{ "versatile:2", "cpu0" },
-	{ "versatile:3", "cpu1" },
-	{ "versatile:4", "cpu2" },
-	{ "versatile:5", "cpu3" },
-	{ "versatile:6", },
-	{ "versatile:7", },
-};
-
-static void versatile_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
-{
-	struct versatile_led *led = container_of(cdev,
-						 struct versatile_led, cdev);
-	u32 reg = readl(led->base);
-
-	if (b != LED_OFF)
-		reg |= led->mask;
-	else
-		reg &= ~led->mask;
-	writel(reg, led->base);
-}
-
-static enum led_brightness versatile_led_get(struct led_classdev *cdev)
-{
-	struct versatile_led *led = container_of(cdev,
-						 struct versatile_led, cdev);
-	u32 reg = readl(led->base);
-
-	return (reg & led->mask) ? LED_FULL : LED_OFF;
-}
-
-static int versatile_leds_probe(struct platform_device *dev)
-{
-	int i;
-	struct resource *res;
-	void __iomem *base;
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&dev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	/* All off */
-	writel(0, base);
-	for (i = 0; i < ARRAY_SIZE(versatile_leds); i++) {
-		struct versatile_led *led;
-
-		led = kzalloc(sizeof(*led), GFP_KERNEL);
-		if (!led)
-			break;
-
-		led->base = base;
-		led->cdev.name = versatile_leds[i].name;
-		led->cdev.brightness_set = versatile_led_set;
-		led->cdev.brightness_get = versatile_led_get;
-		led->cdev.default_trigger = versatile_leds[i].trigger;
-		led->mask = BIT(i);
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static struct platform_driver versatile_leds_driver = {
-	.driver = {
-		.name   = "versatile-leds",
-	},
-	.probe = versatile_leds_probe,
-};
-
-module_platform_driver(versatile_leds_driver);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("ARM Versatile LED driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 72156c123033..93235f7378ba 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -487,6 +487,14 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_VERSATILE
+	bool "LED support for the ARM Versatile and RealView"
+	depends on ARCH_REALVIEW || ARCH_VERSATILE
+	depends on LEDS_CLASS
+	help
+	  This option enabled support for the LEDs on the ARM Versatile
+	  and RealView boards. Say Y to enabled these.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 3cd76dbd9be2..8b4c956e11ba 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
+obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-versatile.c b/drivers/leds/leds-versatile.c
new file mode 100644
index 000000000000..80553022d661
--- /dev/null
+++ b/drivers/leds/leds-versatile.c
@@ -0,0 +1,110 @@
+/*
+ * Driver for the 8 user LEDs found on the RealViews and Versatiles
+ * Based on DaVinci's DM365 board code
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <triad@df.lth.se>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+
+struct versatile_led {
+	void __iomem		*base;
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
+	{ "versatile:2", "cpu0" },
+	{ "versatile:3", "cpu1" },
+	{ "versatile:4", "cpu2" },
+	{ "versatile:5", "cpu3" },
+	{ "versatile:6", },
+	{ "versatile:7", },
+};
+
+static void versatile_led_set(struct led_classdev *cdev,
+			      enum led_brightness b)
+{
+	struct versatile_led *led = container_of(cdev,
+						 struct versatile_led, cdev);
+	u32 reg = readl(led->base);
+
+	if (b != LED_OFF)
+		reg |= led->mask;
+	else
+		reg &= ~led->mask;
+	writel(reg, led->base);
+}
+
+static enum led_brightness versatile_led_get(struct led_classdev *cdev)
+{
+	struct versatile_led *led = container_of(cdev,
+						 struct versatile_led, cdev);
+	u32 reg = readl(led->base);
+
+	return (reg & led->mask) ? LED_FULL : LED_OFF;
+}
+
+static int versatile_leds_probe(struct platform_device *dev)
+{
+	int i;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* All off */
+	writel(0, base);
+	for (i = 0; i < ARRAY_SIZE(versatile_leds); i++) {
+		struct versatile_led *led;
+
+		led = kzalloc(sizeof(*led), GFP_KERNEL);
+		if (!led)
+			break;
+
+		led->base = base;
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
+static struct platform_driver versatile_leds_driver = {
+	.driver = {
+		.name   = "versatile-leds",
+	},
+	.probe = versatile_leds_probe,
+};
+
+module_platform_driver(versatile_leds_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("ARM Versatile LED driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.5.3
