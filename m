From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:10:58 +0200
Subject: [PATCH v3 1/9] gpiolib-of: Rename gpio_hog functions to be generic
In-Reply-To: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439561466-14350-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio hogging functions are currently only used for gpio-hogging. But
these functions are widely generic ones which parse gpio device nodes in
the DT.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-of.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9a0ec48a4737..fea80bbccf12 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -119,20 +119,20 @@ int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
 EXPORT_SYMBOL(of_get_named_gpio_flags);
 
 /**
- * of_get_gpio_hog() - Get a GPIO hog descriptor, names and flags for GPIO API
+ * of_parse_own_gpio() - Get a GPIO hog descriptor, names and flags for GPIO API
  * @np:		device node to get GPIO from
  * @name:	GPIO line name
  * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
- *		of_get_gpio_hog()
+ *		of_parse_own_gpio()
  * @dflags:	gpiod_flags - optional GPIO initialization flags
  *
  * Returns GPIO descriptor to use with Linux GPIO API, or one of the errno
  * value on the error condition.
  */
-static struct gpio_desc *of_get_gpio_hog(struct device_node *np,
-				  const char **name,
-				  enum gpio_lookup_flags *lflags,
-				  enum gpiod_flags *dflags)
+static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
+					   const char **name,
+					   enum gpio_lookup_flags *lflags,
+					   enum gpiod_flags *dflags)
 {
 	struct device_node *chip_np;
 	enum of_gpio_flags xlate_flags;
@@ -199,13 +199,13 @@ static struct gpio_desc *of_get_gpio_hog(struct device_node *np,
 }
 
 /**
- * of_gpiochip_scan_hogs - Scan gpio-controller and apply GPIO hog as requested
+ * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
  * @chip:	gpio chip to act on
  *
  * This is only used by of_gpiochip_add to request/set GPIO initial
  * configuration.
  */
-static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
+static void of_gpiochip_scan_gpios(struct gpio_chip *chip)
 {
 	struct gpio_desc *desc = NULL;
 	struct device_node *np;
@@ -217,7 +217,7 @@ static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
-		desc = of_get_gpio_hog(np, &name, &lflags, &dflags);
+		desc = of_parse_own_gpio(np, &name, &lflags, &dflags);
 		if (IS_ERR(desc))
 			continue;
 
@@ -436,7 +436,7 @@ void of_gpiochip_add(struct gpio_chip *chip)
 	of_gpiochip_add_pin_range(chip);
 	of_node_get(chip->of_node);
 
-	of_gpiochip_scan_hogs(chip);
+	of_gpiochip_scan_gpios(chip);
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
-- 
2.4.6
