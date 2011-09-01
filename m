From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 01 Sep 2011 21:31:37 +0530
Subject: [PATCH] gpio: exynos4: Add device tree support
Message-ID: <1314892897-18803-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As gpio chips get registered, a device tree node which represents the
gpio chip is searched and attached to it. A translate function is also
provided to convert the gpio specifier into actual platform settings
for pin function selection, pull up/down and drive strength settings.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This patch addes device tree support for exynos4 with minimal changes to
existing code. All the gpio chips that are registered find a corresponding
gpio-controller in the device tree. An example of such a node is:

	gpd1: gpio-controller at 114000C0 {
		compatible = "samsung,exynos4-gpio-gpd1", "samsung,exynos4-gpio";
		#gpio-cells = <4>;
		gpio-controller;
	};

Four cells are required to describe a gpio and all its properties. The pin
function selection, pull up/down and drive strength settings are considered
the properties of the gpio pin. This fits well with the hardware organization
of gpio, pinmux, pull up/down and drive strength for exynos4.

The format of the gpio specifier is
<[phandle] [gpio_pin] [function] [pull] [drive_strength]>;

- gpio_pin: Pin number within a gpio-controller.
- function: Pinmux function number (as per the SoC spec).
- pull: Pull up/down setting value (as per the SoC spec).
- drive_strength: Pin Driver strength setting (as per the SoC spec).

Example: A i2c device node which uses two gpio lines is listed below.

	i2c at 13860000 {
		compatible = "samsung,s3c2440-i2c";
		reg = <0x13860000 0x100>;
		interrupts = <122>;
		gpios = <&gpd1 0 2 3 0
			 &gpd1 1 2 3 0>;
	};

A driver or any other portion of the code that is looking up a gpio number
from a device tree node would first get the gpio number using the of_get_gpio()
function. And then use the gpio_request() function on that gpio number.

This approach has been tested with i2c driver for exynos4.

 drivers/gpio/gpio-exynos4.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-exynos4.c b/drivers/gpio/gpio-exynos4.c
index d24b337..aa2d9fb 100644
--- a/drivers/gpio/gpio-exynos4.c
+++ b/drivers/gpio/gpio-exynos4.c
@@ -13,6 +13,10 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/slab.h>
+#endif
 
 #include <mach/map.h>
 
@@ -320,6 +324,52 @@ static struct s3c_gpio_chip exynos4_gpio_part3_4bit[] = {
 	},
 };
 
+#ifdef CONFIG_OF
+int exynos4_gpio_xlate(struct gpio_chip *gc, struct device_node *np,
+			 const void *gpio_spec, u32 *flags)
+{
+	const __be32 *gpio = gpio_spec;
+	const u32 n = be32_to_cpup(gpio);
+	unsigned int pin = gc->base + be32_to_cpu(gpio[0]);
+
+	if (gc->of_gpio_n_cells < 4) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (n > gc->ngpio)
+		return -EINVAL;
+
+	s3c_gpio_cfgpin(pin, S3C_GPIO_SFN(be32_to_cpu(gpio[1])));
+	s3c_gpio_setpull(pin, be32_to_cpu(gpio[2]));
+	s5p_gpio_set_drvstr(pin, be32_to_cpu(gpio[3]));
+	return n;
+}
+
+static __init void exynos4_gpiolib_attach_ofnode(struct gpio_chip *gc)
+{
+	const char exynos4_gpio_compat_base[] = "samsung,exynos4-gpio-";
+	char *exynos4_gpio_compat;
+
+	exynos4_gpio_compat = kzalloc(strlen(exynos4_gpio_compat_base) +
+				strlen(gc->label), GFP_KERNEL);
+	if (!exynos4_gpio_compat)
+		return;
+
+	strcpy(exynos4_gpio_compat, exynos4_gpio_compat_base);
+	strcat(exynos4_gpio_compat, gc->label);
+	gc->of_node = of_find_compatible_node(NULL, NULL, exynos4_gpio_compat);
+	gc->of_gpio_n_cells = 4;
+	gc->of_xlate = exynos4_gpio_xlate;
+	kfree(exynos4_gpio_compat);
+}
+#else
+static __init void exynos4_gpiolib_attach_ofnode(struct gpio_chip *chip)
+{
+	return;
+}
+#endif
+
 static __init int exynos4_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip;
@@ -340,6 +390,7 @@ static __init int exynos4_gpiolib_init(void)
 		}
 		if (chip->base == NULL)
 			chip->base = S5P_VA_GPIO1 + (i) * 0x20;
+		exynos4_gpiolib_attach_ofnode(&chip->chip);
 	}
 
 	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part1_4bit, nr_chips);
@@ -357,6 +408,7 @@ static __init int exynos4_gpiolib_init(void)
 		}
 		if (chip->base == NULL)
 			chip->base = S5P_VA_GPIO2 + (i) * 0x20;
+		exynos4_gpiolib_attach_ofnode(&chip->chip);
 	}
 
 	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part2_4bit, nr_chips);
@@ -374,6 +426,7 @@ static __init int exynos4_gpiolib_init(void)
 		}
 		if (chip->base == NULL)
 			chip->base = S5P_VA_GPIO3 + (i) * 0x20;
+		exynos4_gpiolib_attach_ofnode(&chip->chip);
 	}
 
 	samsung_gpiolib_add_4bit_chips(exynos4_gpio_part3_4bit, nr_chips);
-- 
1.6.6.rc2
