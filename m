From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 2 May 2012 14:34:06 +0530
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
Message-ID: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a requirement in pinctrl subsystem, to bind pinctrl driver with
gpio_chip. The way i could think of to do this is:
- pass gpio-handle = <&gpiopinctrl>; via pinctrl node
- call of_get_gpio_chip_by_phandle() with of_node of pinctrl
- Use gpio_chip returned to get basic details of chip like its base, which is
  decided at runtime.

So implemented this helper here.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
Linus/Grant,

Once you give your comments on this patch, i would implement this solution for
SPEAr pinctrl drivers.

 drivers/gpio/gpiolib-of.c |   32 ++++++++++++++++++++++++++++++++
 include/linux/of_gpio.h   |    9 ++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index bf984b6..fd97d51 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -78,6 +78,38 @@ err0:
 EXPORT_SYMBOL(of_get_named_gpio_flags);
 
 /**
+ * of_get_gpio_chip_by_phandle() - Get a GPIO Chip using "gpio-phandle"
+ * @np:		device node to get GPIO chip from
+ *
+ * Returns GPIO chip pointer or NULL on error.
+ */
+struct gpio_chip *of_get_gpio_chip_by_phandle(struct device_node *np)
+{
+	struct gpio_chip *gc;
+	struct device_node *gpio_np;
+
+	gpio_np = of_parse_phandle(np, "gpio-phandle", 0);
+	if (!gpio_np) {
+		pr_debug("%s: Looking up gpio-phandle property failed",
+				np->full_name);
+		return NULL;
+	}
+
+	gc = of_node_to_gpiochip(gpio_np);
+	if (!gc) {
+		pr_debug("%s: gpio controller %s isn't registered\n",
+				np->full_name, gpio_np->full_name);
+		goto err;
+	}
+
+err:
+	of_node_put(gpio_np);
+
+	return gc;
+}
+EXPORT_SYMBOL(of_get_gpio_chip_by_phandle);
+
+/**
  * of_gpio_named_count - Count GPIOs for a device
  * @np:		device node to count GPIOs for
  * @propname:	property name containing gpio specifier(s)
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 81733d1..764c807 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -50,6 +50,8 @@ static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
 extern int of_get_named_gpio_flags(struct device_node *np,
 		const char *list_name, int index, enum of_gpio_flags *flags);
 
+extern struct gpio_chip *of_get_gpio_chip_by_phandle(struct device_node *np);
+
 extern unsigned int of_gpio_named_count(struct device_node *np,
 					const char* propname);
 
@@ -72,6 +74,12 @@ static inline int of_get_named_gpio_flags(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline struct gpio_chip *
+of_get_gpio_chip_by_phandle(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline unsigned int of_gpio_named_count(struct device_node *np,
 					const char* propname)
 {
@@ -154,5 +162,4 @@ static inline int of_get_gpio(struct device_node *np, int index)
 {
 	return of_get_gpio_flags(np, index, NULL);
 }
-
 #endif /* __LINUX_OF_GPIO_H */
-- 
1.7.9
