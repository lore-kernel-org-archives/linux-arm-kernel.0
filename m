From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 00:28:32 +0530
Subject: [PATCH V2] gpiolib: provide provision for gpiolib to register pin
 range
Message-ID: <4f6fa7ab699bb2fe1cd789feb457551922975579.1351277538.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

pinctrl subsystem needs gpio chip base to prepare set of gpio pin ranges, which
a given pinctrl driver can handle. This is important to handle pinctrl gpio
request calls in order to program a given pin properly for gpio operation.

As gpio base is allocated dynamically during gpiochip registration, presently
there exists no clean way to pass this information to the pinctrl subsystem.

After few discussions from [1], it was concluded that may be gpio controller
reporting the pin range it supports, is a better way than pinctrl subsystem
directly registering it.

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/184816

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
Hi Linus,

Its been almost two months when this stuff was last discussed. Here is another
attempt to fix open issues in it.

V1->V2:
------
- Add non-DT routines to register gpio ranges
- Update Documentation/gpio.txt
- of_gpiochip_add_pin_range() rearranged a bit
- use devm_kzalloc() instead of kzalloc()
- few other minor fixes

Bad part is, this code doesn't compile currently :(
It depends on a routine: pinctrl_remove_gpio_range() which was recently removed
by another patch, thinking that there might not be any more users of that
routine. It was removed as the removal of ranges was done in unregister of
pinctrl.

But because we are registering stuff from gpiolib now, we may remove and insert
a gpio module multiple times. So, we need that again. I will add that patch to
this series once you are okay with this one.

I know you might be attending connect now, please review it if you have some
spare time.

 Documentation/devicetree/bindings/gpio/gpio.txt | 36 ++++++++++++++++
 Documentation/gpio.txt                          | 26 ++++++++++++
 drivers/gpio/gpiolib-of.c                       | 56 +++++++++++++++++++++++++
 drivers/gpio/gpiolib.c                          | 43 +++++++++++++++++++
 drivers/pinctrl/core.c                          | 13 ++++++
 drivers/pinctrl/devicetree.c                    | 13 ++++++
 include/asm-generic/gpio.h                      | 23 ++++++++++
 include/linux/gpio.h                            |  3 ++
 include/linux/pinctrl/pinctrl.h                 | 16 +++++++
 9 files changed, 229 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index 4e16ba4..a336287 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -75,4 +75,40 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		gpio-controller;
 	};
 
+2.1) gpio-controller and pinctrl subsystem
+------------------------------------------
 
+gpio-controller on a SOC might be tightly coupled with the pinctrl
+subsystem, in the sense that the pins can be used by other functions
+together with optional gpio feature.
+
+While the pin allocation is totally managed by the pin ctrl subsystem,
+gpio (under gpiolib) is still maintained by gpio drivers. It may happen
+that different pin ranges in a SoC is managed by different gpio drivers.
+
+This makes it logical to let gpio drivers announce their pin ranges to
+the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
+request the corresponding pin before any gpio usage.
+
+For this, the gpio controller can use a pinctrl phandle and pins to
+announce the pinrange to the pin ctrl subsystem. For example,
+
+	qe_pio_e: gpio-controller at 1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl1 20 10>, <&pinctrl2 50 20>;
+
+    }
+
+where,
+   &pinctrl1 and &pinctrl2 is the phandle to the pinctrl DT node.
+
+   Next values specify the base pin and number of pins for the range
+   handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
+   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
+   by this gpio controller.
+
+The pinctrl node must have "#gpio-range-cells" property to show number of
+arguments to pass with phandle from gpio controllers node.
diff --git a/Documentation/gpio.txt b/Documentation/gpio.txt
index e08a883..77f233c 100644
--- a/Documentation/gpio.txt
+++ b/Documentation/gpio.txt
@@ -439,6 +439,32 @@ slower clock delays the rising edge of SCK, and the I2C master adjusts its
 signaling rate accordingly.
 
 
+gpio-controller and pinctrl subsystem
+------------------------------------------
+
+gpio-controller on a SOC might be tightly coupled with the pinctrl
+subsystem, in the sense that the pins can be used by other functions
+together with optional gpio feature.
+
+While the pin allocation is totally managed by the pin ctrl subsystem,
+gpio (under gpiolib) is still maintained by gpio drivers. It may happen
+that different pin ranges in a SoC is managed by different gpio drivers.
+
+This makes it logical to let gpio drivers announce their pin ranges to
+the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
+request the corresponding pin before any gpio usage.
+
+For this, the gpio controller can register its pin range with pinctrl subsystem.
+There are two ways of doing it currently with or without DT.
+
+For with DT support refer to Documentation/devicetree/bindings/gpio/gpio.txt.
+
+For non-DT support, user can call gpiochip_add_pin_range() with appropriate
+parameters to register a range of gpio pins with a pinctrl driver. For this
+exact name string of pinctrl device has to be passed as one of the argument to
+this routine.
+
+
 What do these conventions omit?
 ===============================
 One of the biggest things these conventions omit is pin multiplexing, since
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index f1a4599..a5b90c8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
 
 /* Private data structure for of_gpiochip_find_and_xlate */
@@ -216,6 +217,58 @@ err0:
 }
 EXPORT_SYMBOL(of_mm_gpiochip_add);
 
+#ifdef CONFIG_PINCTRL
+void of_gpiochip_add_pin_range(struct gpio_chip *chip)
+{
+	struct device_node *np = chip->of_node;
+	struct gpio_pin_range *pin_range;
+	struct of_phandle_args pinspec;
+	int index = 0, ret;
+
+	if (!np)
+		return;
+
+	do {
+		ret = of_parse_phandle_with_args(np, "gpio-ranges",
+				"#gpio-range-cells", index, &pinspec);
+		if (ret)
+			break;
+
+		pin_range = devm_kzalloc(chip->dev, sizeof(*pin_range),
+				GFP_KERNEL);
+		if (!pin_range) {
+			pr_err("%s: GPIO chip: failed to allocate pin ranges\n",
+					chip->label);
+			break;
+		}
+
+		pin_range->range.name = chip->label;
+		pin_range->range.base = chip->base;
+		pin_range->range.pin_base = pinspec.args[0];
+		pin_range->range.npins = pinspec.args[1];
+		pin_range->pctldev = of_pinctrl_add_gpio_range(pinspec.np,
+				&pin_range->range);
+
+		list_add_tail(&pin_range->node, &chip->pin_ranges);
+
+	} while (index++);
+}
+
+void of_gpiochip_remove_pin_range(struct gpio_chip *chip)
+{
+	struct gpio_pin_range *pin_range, *tmp;
+
+	list_for_each_entry_safe(pin_range, tmp, &chip->pin_ranges, node) {
+		list_del(&pin_range->node);
+		pinctrl_remove_gpio_range(pin_range->pctldev,
+				&pin_range->range);
+	}
+}
+#else
+void of_gpiochip_add_pin_range(struct gpio_chip *chip) {}
+void of_gpiochip_remove_pin_range(struct gpio_chip *chip) {}
+#endif
+
 void of_gpiochip_add(struct gpio_chip *chip)
 {
 	if ((!chip->of_node) && (chip->dev))
@@ -229,11 +282,14 @@ void of_gpiochip_add(struct gpio_chip *chip)
 		chip->of_xlate = of_gpio_simple_xlate;
 	}
 
+	of_gpiochip_add_pin_range(chip);
 	of_node_get(chip->of_node);
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
+	of_gpiochip_remove_pin_range(chip);
+
 	if (chip->of_node)
 		of_node_put(chip->of_node);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d5f9742..6456bc0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1088,6 +1088,10 @@ int gpiochip_add(struct gpio_chip *chip)
 		}
 	}
 
+#ifdef CONFIG_PINCTRL
+	INIT_LIST_HEAD(&chip->pin_ranges);
+#endif
+
 	of_gpiochip_add(chip);
 
 unlock:
@@ -1185,6 +1189,45 @@ struct gpio_chip *gpiochip_find(void *data,
 }
 EXPORT_SYMBOL_GPL(gpiochip_find);
 
+#ifdef CONFIG_PINCTRL
+void gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
+		unsigned int pin_base, unsigned int npins)
+{
+	struct gpio_pin_range *pin_range;
+
+	pin_range = devm_kzalloc(chip->dev, sizeof(*pin_range), GFP_KERNEL);
+	if (!pin_range) {
+		pr_err("%s: GPIO chip: failed to allocate pin ranges\n",
+				chip->label);
+		return;
+	}
+
+	pin_range->range.name = chip->label;
+	pin_range->range.base = chip->base;
+	pin_range->range.pin_base = pin_base;
+	pin_range->range.npins = npins;
+	pin_range->pctldev = find_pinctrl_and_add_gpio_range(pinctl_name,
+			&pin_range->range);
+
+	list_add_tail(&pin_range->node, &chip->pin_ranges);
+}
+
+void gpiochip_remove_pin_ranges(struct gpio_chip *chip)
+{
+	struct gpio_pin_range *pin_range, *tmp;
+
+	list_for_each_entry_safe(pin_range, tmp, &chip->pin_ranges, node) {
+		list_del(&pin_range->node);
+		pinctrl_remove_gpio_range(pin_range->pctldev,
+				&pin_range->range);
+	}
+}
+#else
+void gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
+		unsigned int pin_base, unsigned int npins) {}
+void gpiochip_remove_pin_ranges(struct gpio_chip *chip) {}
+#endif
+
 /* These "optional" allocation calls help prevent drivers from stomping
  * on each other, and help provide better diagnostics in debugfs.
  * They're called even less than the "set direction" calls.
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index cec6072..620259e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -345,6 +345,19 @@ void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_add_gpio_ranges);
 
+struct pinctrl_dev *find_pinctrl_and_add_gpio_range(const char *devname,
+		struct pinctrl_gpio_range *range)
+{
+	struct pinctrl_dev *pctldev = get_pinctrl_dev_from_devname(devname);
+
+	if (!pctldev)
+		return NULL;
+
+	pinctrl_add_gpio_range(pctldev, range);
+	return pctldev;
+}
+EXPORT_SYMBOL_GPL(find_pinctrl_and_add_gpio_range);
+
 /**
  * pinctrl_get_group_selector() - returns the group selector for a group
  * @pctldev: the pin controller handling the group
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fcb1de4..6728ec7 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -106,6 +106,19 @@ static struct pinctrl_dev *find_pinctrl_by_of_node(struct device_node *np)
 	return NULL;
 }
 
+struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
+		struct pinctrl_gpio_range *range)
+{
+	struct pinctrl_dev *pctldev;
+
+	pctldev = find_pinctrl_by_of_node(np);
+	if (!pctldev)
+		return NULL;
+
+	pinctrl_add_gpio_range(pctldev, range);
+	return pctldev;
+}
+
 static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 				struct device_node *np_config)
 {
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index a9432fc..77eb1c1 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/of.h>
+#include <linux/pinctrl/pinctrl.h>
 
 #ifdef CONFIG_GPIOLIB
 
@@ -48,6 +49,19 @@ struct module;
 struct device_node;
 
 /**
+ * struct gpio_pin_range - pin range controlled by a gpio chip
+ * @head: list for maintaining set of pin ranges, used internally
+ * @pctldev: pinctrl device which handles corresponding pins
+ * @range: actual range of pins controlled by a gpio controller
+ */
+
+struct gpio_pin_range {
+	struct list_head node;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_gpio_range range;
+};
+
+/**
  * struct gpio_chip - abstract a GPIO controller
  * @label: for diagnostics
  * @dev: optional device providing the GPIOs
@@ -134,6 +148,15 @@ struct gpio_chip {
 	int (*of_xlate)(struct gpio_chip *gc,
 		        const struct of_phandle_args *gpiospec, u32 *flags);
 #endif
+#ifdef CONFIG_PINCTRL
+	/*
+	 * If CONFIG_PINCTRL is enabled, then gpio controllers can optionally
+	 * describe the actual pin range which they serve in an SoC. This
+	 * information would be used by pinctrl subsystem to configure
+	 * corresponding pins for gpio usage.
+	 */
+	struct list_head pin_ranges;
+#endif
 };
 
 extern const char *gpiochip_is_requested(struct gpio_chip *chip,
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 2e31e8b..a284459 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -231,6 +231,9 @@ static inline int irq_to_gpio(unsigned irq)
 	return -EINVAL;
 }
 
+void gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
+		unsigned int pin_base, unsigned int npins);
+void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
 #endif
 
 #endif /* __LINUX_GPIO_H */
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 7d087f0..273df69 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -134,6 +134,22 @@ extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
 extern void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *ranges,
 				unsigned nranges);
+extern struct pinctrl_dev *find_pinctrl_and_add_gpio_range(const char *devname,
+		struct pinctrl_gpio_range *range);
+
+#ifdef CONFIG_OF
+extern struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
+		struct pinctrl_gpio_range *range);
+#else
+static inline
+struct pinctrl_dev *of_pinctrl_add_gpio_range(struct device_node *np,
+		struct pinctrl_gpio_range *range)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_OF */
+
 extern const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev);
 extern void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev);
 #else
-- 
1.7.12.rc2.18.g61b472e
