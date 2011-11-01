From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 Nov 2011 06:13:47 +0530
Subject: [PATCH v2] gpio/samsung: Add device tree support for Exynos4
Message-ID: <1320108227-2693-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As gpio chips get registered, a device tree node which represents the
gpio chip is searched and attached to it. A translate function is also
provided to convert the gpio specifier into actual platform settings
for pin function selection, pull up/down and driver strength settings.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
Changes since v1:
- As suggested by Rob and Grant, the gpio controller node lookup is based
  on the base address of the gpio controller instead of the unique
  per-controller compatible property value.

This patch is based on the following tree and branch.
git://git.linaro.org/git/people/arnd/arm-soc.git  branch: for-next

 .../devicetree/bindings/gpio/gpio-samsung.txt      |   40 ++++++++++++
 drivers/gpio/gpio-samsung.c                        |   66 ++++++++++++++++++++
 2 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
new file mode 100644
index 0000000..c143058
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
@@ -0,0 +1,40 @@
+Samsung Exynos4 GPIO Controller
+
+Required properties:
+- compatible: Compatible property value should be "samsung,exynos4-gpio>".
+
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+
+- #gpio-cells: Should be 4. The syntax of the gpio specifier used by client nodes
+  should be the following with values derived from the SoC user manual.
+     <[phandle of the gpio controller node]
+      [pin number within the gpio controller]
+      [mux function]
+      [pull up/down]
+      [drive strength]>
+
+  Values for gpio specifier:
+  - Pin number: is a value between 0 to 7.
+  - Pull Up/Down: 0 - Pull Up/Down Disabled.
+                  1 - Pull Down Enabled.
+                  3 - Pull Up Enabled.
+  - Drive Strength: 0 - 1x,
+                    1 - 3x,
+                    2 - 2x,
+                    3 - 4x
+
+- gpio-controller: Specifies that the node is a gpio controller.
+- #address-cells: should be 1.
+- #size-cells: should be 1. 
+
+Example:
+
+	gpa0: gpio-controller at 11400000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "samsung,exynos4-gpio";
+		reg = <0x11400000 0x20>;
+		#gpio-cells = <4>;
+		gpio-controller;
+	};
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 8662518..0140756 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -24,6 +24,9 @@
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
 
 #include <asm/irq.h>
 
@@ -2374,6 +2377,63 @@ static struct samsung_gpio_chip exynos4_gpios_3[] = {
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
+static const struct of_device_id exynos4_gpio_dt_match[] __initdata = {
+	{ .compatible = "samsung,exynos4-gpio", },
+	{}
+};
+
+static __init void exynos4_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
+						u64 base, u64 offset)
+{
+	struct gpio_chip *gc =  &chip->chip;
+	u64 address;
+
+	if (!of_have_populated_dt())
+		return;
+
+	address = (chip->base) ? (base + ((u32)chip->base & 0xfff)) :
+			(base + offset);
+
+	gc->of_node = of_find_matching_node_by_address(NULL,
+			exynos4_gpio_dt_match, address);
+	if (!gc->of_node) {
+		pr_info("gpio: device tree node not found for gpio controller"
+			" with base address %08llx\n", address);
+		return;
+	}
+	gc->of_gpio_n_cells = 4;
+	gc->of_xlate = exynos4_gpio_xlate;
+}
+#else
+static __init void exynos4_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
+						u64 base, u64 offset)
+{
+	return;
+}
+#endif /* defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF) */
+
 /* TODO: cleanup soc_is_* */
 static __init int samsung_gpiolib_init(void)
 {
@@ -2455,6 +2515,8 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(chip,
+					EXYNOS4_PA_GPIO1, i * 0x20);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_1, nr_chips, S5P_VA_GPIO1);
 
@@ -2467,6 +2529,8 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(chip,
+					EXYNOS4_PA_GPIO2, i * 0x20);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_2, nr_chips, S5P_VA_GPIO2);
 
@@ -2479,6 +2543,8 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos4_gpio_cfg;
 				chip->group = group++;
 			}
+			exynos4_gpiolib_attach_ofnode(chip,
+					EXYNOS4_PA_GPIO3, i * 0x20);
 		}
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_3, nr_chips, S5P_VA_GPIO3);
 
-- 
1.7.4.4
