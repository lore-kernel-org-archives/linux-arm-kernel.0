From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 11 Oct 2011 13:46:14 +0530
Subject: [PATCH] gpio: exynos4: Add device tree support
Message-ID: <1318320974-9879-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As gpio chips get registered, a device tree node which represents the
gpio chip is searched and attached to it. A translate function is also
provided to convert the gpio specifier into actual platform settings
for pin function selection, pull up/down and driver strength settings.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This patch is based on the latest consolidated Samsung GPIO driver available
in the following tree:
  https://github.com/kgene/linux-samsung.git  branch: for-next

 .../devicetree/bindings/gpio/gpio-samsung.txt      |   30 +++++++++++
 drivers/gpio/gpio-samsung.c                        |   53 ++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
new file mode 100644
index 0000000..883faeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
@@ -0,0 +1,30 @@
+Samsung Exynos4 GPIO Controller
+
+Required properties:
+- compatible: Format of compatible property value should be
+  "samsung,exynos4-gpio-<controller_name>". Example: For GPA0 controller, the
+  compatible property value should be "samsung,exynos4-gpio-gpa0".
+
+- reg: Physical base address of the controller and length of memory mapped region.
+
+- #gpio-cells: Should be 4. The syntax of the gpio specifier used by client nodes
+  should be the following with values derived from the SoC user manual.
+     <[phandle of the gpio controller node] <pin number within the gpio controller]
+      [mux function] [pull up/down] [drive strength]>
+
+- gpio-controller: Specifies that the node is a gpio controller.
+
+- #address-cells: should be 1.
+
+- #size-cells: should be 1. 
+
+Example:
+
+	gpa0: gpio-controller at 11400000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "samsung,exynos4-gpio-gpa0";
+		reg = <0x11400000 0x20>;
+		#gpio-cells = <4>;
+		gpio-controller;
+	};
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index b6be77a..037d3bb 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -24,6 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
 #include <linux/ioport.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/slab.h>
+#endif
 
 #include <asm/irq.h>
 
@@ -2353,6 +2357,52 @@ static struct samsung_gpio_chip exynos4_gpios_3[] = {
 #endif
 };
 
+#if defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF)
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
+#endif /* defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF) */
+
 /* TODO: cleanup soc_is_* */
 static __init int samsung_gpiolib_init(void)
 {
@@ -2434,6 +2484,7 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(&chip->chip);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_1, nr_chips, S5P_VA_GPIO1);
 
@@ -2446,6 +2497,7 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(&chip->chip);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_2, nr_chips, S5P_VA_GPIO2);
 
@@ -2458,6 +2510,7 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(&chip->chip);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_3, nr_chips, S5P_VA_GPIO3);
 
-- 
1.6.6.rc2
