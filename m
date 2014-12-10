From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:23 +0100
Subject: [RFC 05/15] gpio: move DT parsing code to separate functions
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-6-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch moves Device Tree parsing logic to separate
function.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpio/gpiolib-of.c | 59 +++++++++++++++++++++--------------------------
 drivers/gpio/gpiolib.c    | 33 +++++++++++++++++++-------
 drivers/gpio/gpiolib.h    |  4 ++--
 3 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 604dbe6..4707727 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -28,7 +28,7 @@
 /* Private data structure for of_gpiochip_find_and_xlate */
 struct gg_data {
 	enum of_gpio_flags *flags;
-	struct of_phandle_args gpiospec;
+	struct of_phandle_args *gpiospec;
 
 	struct gpio_desc *out_gpio;
 };
@@ -39,12 +39,12 @@ static int of_gpiochip_find_and_xlate(struct gpio_chip *gc, void *data)
 	struct gg_data *gg_data = data;
 	int ret;
 
-	if ((gc->of_node != gg_data->gpiospec.np) ||
-	    (gc->of_gpio_n_cells != gg_data->gpiospec.args_count) ||
+	if ((gc->of_node != gg_data->gpiospec->np) ||
+	    (gc->of_gpio_n_cells != gg_data->gpiospec->args_count) ||
 	    (!gc->of_xlate))
 		return false;
 
-	ret = gc->of_xlate(gc, &gg_data->gpiospec, gg_data->flags);
+	ret = gc->of_xlate(gc, gg_data->gpiospec, gg_data->flags);
 	if (ret < 0)
 		return false;
 
@@ -52,61 +52,54 @@ static int of_gpiochip_find_and_xlate(struct gpio_chip *gc, void *data)
 	return true;
 }
 
-/**
- * of_get_named_gpiod_flags() - Get a GPIO descriptor and flags for GPIO API
- * @np:		device node to get GPIO from
- * @propname:	property name containing gpio specifier(s)
- * @index:	index of the GPIO
- * @flags:	a flags pointer to fill in
- *
- * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
- * value on the error condition. If @flags is not NULL the function also fills
- * in flags for the GPIO.
- */
-struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
-		     const char *propname, int index, enum of_gpio_flags *flags)
+struct gpio_desc *of_get_gpiod_by_spec(struct of_phandle_args *spec,
+				       enum of_gpio_flags *flags)
 {
 	/* Return -EPROBE_DEFER to support probe() functions to be called
 	 * later when the GPIO actually becomes available
 	 */
 	struct gg_data gg_data = {
 		.flags = flags,
-		.out_gpio = ERR_PTR(-EPROBE_DEFER)
+		.out_gpio = ERR_PTR(-EPROBE_DEFER),
+		.gpiospec = spec
 	};
-	int ret;
 
 	/* .of_xlate might decide to not fill in the flags, so clear it. */
 	if (flags)
 		*flags = 0;
 
-	ret = of_parse_phandle_with_args(np, propname, "#gpio-cells", index,
-					 &gg_data.gpiospec);
-	if (ret) {
-		pr_debug("%s: can't parse '%s' property of node '%s[%d]'\n",
-			__func__, propname, np->full_name, index);
-		return ERR_PTR(ret);
-	}
-
 	gpiochip_find(&gg_data, of_gpiochip_find_and_xlate);
 
-	of_node_put(gg_data.gpiospec.np);
-	pr_debug("%s: parsed '%s' property of node '%s[%d]' - status (%d)\n",
-		 __func__, propname, np->full_name, index,
+	pr_debug("%s: parsed property of node '%s[%d]' - status (%d)\n",
+		 __func__, spec->np->full_name, spec->args[0],
 		 PTR_ERR_OR_ZERO(gg_data.out_gpio));
+
 	return gg_data.out_gpio;
 }
 
 int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
 			    int index, enum of_gpio_flags *flags)
 {
+	struct of_phandle_args spec;
 	struct gpio_desc *desc;
+	int ret;
+
+	ret = of_parse_phandle_with_args(np, list_name, "#gpio-cells", index,
+					 &spec);
+	if (ret) {
+		pr_debug("%s: can't parse '%s' property of node '%s[%d]'\n",
+			__func__, list_name, np->full_name, index);
+		return ret;
+	}
 
-	desc = of_get_named_gpiod_flags(np, list_name, index, flags);
+	desc = of_get_gpiod_by_spec(&spec, flags);
 
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
-	else
-		return desc_to_gpio(desc);
+
+	of_node_put(spec.np);
+
+	return desc_to_gpio(desc);
 }
 EXPORT_SYMBOL(of_get_named_gpio_flags);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8e98ca..78fcec9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1470,15 +1470,13 @@ void gpiod_add_lookup_table(struct gpiod_lookup_table *table)
 	mutex_unlock(&gpio_lookup_lock);
 }
 
-static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
-				      unsigned int idx,
-				      enum gpio_lookup_flags *flags)
+static int of_get_gpiod_spec(struct device *dev, const char *con_id,
+			     unsigned int idx, struct of_phandle_args *spec)
 {
 	static const char *suffixes[] = { "gpios", "gpio" };
 	char prop_name[32]; /* 32 is max size of property name */
-	enum of_gpio_flags of_flags;
-	struct gpio_desc *desc;
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(suffixes); i++) {
 		if (con_id)
@@ -1486,12 +1484,31 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 		else
 			snprintf(prop_name, 32, "%s", suffixes[i]);
 
-		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
-						&of_flags);
-		if (!IS_ERR(desc) || (PTR_ERR(desc) == -EPROBE_DEFER))
+		ret = of_parse_phandle_with_args(dev->of_node, prop_name,
+						 "#gpio-cells", idx, spec);
+		if (!ret)
 			break;
 	}
 
+	return ret;
+}
+
+static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
+				      unsigned int idx,
+				      enum gpio_lookup_flags *flags)
+{
+	enum of_gpio_flags of_flags;
+	struct of_phandle_args spec;
+	struct gpio_desc *desc;
+	int ret;
+
+	ret = of_get_gpiod_spec(dev, con_id, idx, &spec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	desc = of_get_gpiod_by_spec(&spec, &of_flags);
+	of_node_put(spec.np);
+
 	if (IS_ERR(desc))
 		return desc;
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 9db2b6a..3c0c1ad 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -54,8 +54,8 @@ acpi_get_gpiod_by_index(struct device *dev, int index,
 }
 #endif
 
-struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
-		   const char *list_name, int index, enum of_gpio_flags *flags);
+struct gpio_desc *of_get_gpiod_by_spec(struct of_phandle_args *spec,
+				       enum of_gpio_flags *flags);
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 
-- 
1.9.1
