From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Tue, 19 Dec 2017 10:40:25 +0100
Subject: [RFC PATCH v2] draft for gpio pinconf
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171219094025.6151-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Hi,

After discussing with Maxime Ripard, I realize that the first approach
may not be a good one.

For instance, the drive-strength is a digital value so it will take
ake several bits. Having a whole pin configuration in 32 bits may not
be the right solution.

My aim is to use the existing pinconf bindings.

This patch is a draft to test the feasibility. Sorry to provide it in
this state (several ugly hacks) but I didn't want to spend time on a clean
solution if it will be rejected.

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  6 +-----
 arch/arm/boot/dts/sama5d2.dtsi              |  2 +-
 drivers/gpio/gpiolib-of.c                   | 10 +++++++++-
 drivers/gpio/gpiolib.c                      | 24 +++++++++++++++++++-----
 drivers/gpio/gpiolib.h                      |  2 ++
 drivers/pinctrl/core.c                      |  5 ++---
 drivers/pinctrl/pinctrl-at91-pio4.c         | 19 +++++++++++++++++++
 include/linux/gpio/driver.h                 |  5 +++--
 include/linux/pinctrl/consumer.h            |  4 ++--
 9 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 56de21de2779..709c9c3ae622 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -413,7 +413,6 @@
 				};
 
 				pinctrl_key_gpio_default: key_gpio_default {
-					pinmux = <PIN_PB9__GPIO>;
 					bias-pull-up;
 				};
 
@@ -545,12 +544,9 @@
 	gpio_keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_key_gpio_default>;
-
 		bp1 {
 			label = "PB_USER";
-			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB9 GPIO_ACTIVE_LOW &pinctrl_key_gpio_default>;
 			linux,code = <0x104>;
 			wakeup-source;
 		};
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index b44e63995583..cccd404192cc 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1444,7 +1444,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-controller;
-				#gpio-cells = <2>;
+				#gpio-cells = <3>;
 				clocks = <&pioA_clk>;
 			};
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4a2b8d3397c7..605017a4d2d8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -46,7 +46,7 @@ static struct gpio_desc *of_xlate_and_get_gpiod_flags(struct gpio_chip *chip,
 {
 	int ret;
 
-	if (chip->of_gpio_n_cells != gpiospec->args_count)
+	if (chip->of_gpio_n_cells > gpiospec->args_count)
 		return ERR_PTR(-EINVAL);
 
 	ret = chip->of_xlate(chip, gpiospec, flags);
@@ -93,6 +93,14 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 	if (IS_ERR(desc))
 		goto out;
 
+	if (gpiospec.args_count > chip->of_gpio_n_cells) {
+		desc->np_pincfg = of_parse_phandle(np, propname, gpiospec.args_count);
+		if (!desc->np_pincfg) {
+			printk("ERROR\n");
+			goto out;
+		}
+	}
+
 	pr_debug("%s: parsed '%s' property of node '%pOF[%d]' - status (%d)\n",
 		 __func__, propname, np, index,
 		 PTR_ERR_OR_ZERO(desc));
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0621baddfddc..543a120a0f84 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -29,6 +29,8 @@
 #include <uapi/linux/gpio.h>
 
 #include "gpiolib.h"
+#include "../pinctrl/core.h"
+#include "../pinctrl/pinconf.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/gpio.h>
@@ -1997,9 +1999,9 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_free);
  * @config: the configuration to be applied
  */
 int gpiochip_generic_config(struct gpio_chip *chip, unsigned offset,
-			    unsigned long config)
+			    unsigned long *configs, unsigned num_configs)
 {
-	return pinctrl_gpio_set_config(chip->gpiodev->base + offset, config);
+	return pinctrl_gpio_set_config(chip->gpiodev->base + offset, configs, num_configs);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_config);
 
@@ -2161,6 +2163,18 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 			goto done;
 		}
 	}
+	if (chip->set_config) {
+		unsigned long *configs;
+		unsigned num_configs;
+		int ret;
+
+		ret = pinconf_generic_parse_dt_config(desc->np_pincfg, NULL, &configs, &num_configs);
+		if (ret < 0) {
+			/* TODO */
+		}
+		chip->set_config(chip, gpio_chip_hwgpio(desc), configs, num_configs);
+		kfree(configs);
+	}
 	if (chip->get_direction) {
 		/* chip->get_direction may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2404,7 +2418,7 @@ static int gpio_set_drive_single_ended(struct gpio_chip *gc, unsigned offset,
 {
 	unsigned long config = { PIN_CONF_PACKED(mode, 0) };
 
-	return gc->set_config ? gc->set_config(gc, offset, config) : -ENOTSUPP;
+	return gc->set_config ? gc->set_config(gc, offset, &config, 1) : -ENOTSUPP;
 }
 
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
@@ -2529,7 +2543,7 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 	}
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
+	return chip->set_config(chip, gpio_chip_hwgpio(desc), &config, 1);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -2565,7 +2579,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
 					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = chip->set_config(chip, gpio, packed);
+	rc = chip->set_config(chip, gpio, &packed, 1);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 5e1f7cc6eeb6..79119548cc33 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -215,6 +215,8 @@ struct gpio_desc {
 	const char		*label;
 	/* Name of the GPIO */
 	const char		*name;
+	/* Pin configuration node */
+	struct device_node	*np_pincfg;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 4c8d5b23e4d0..89976f35a6a3 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -857,9 +857,8 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
  * they need to call the underlying pin controller to change GPIO config
  * (for example set debounce time).
  */
-int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
+int pinctrl_gpio_set_config(unsigned gpio, unsigned long *configs, unsigned num_configs)
 {
-	unsigned long configs[] = { config };
 	struct pinctrl_gpio_range *range;
 	struct pinctrl_dev *pctldev;
 	int ret, pin;
@@ -870,7 +869,7 @@ int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
 
 	mutex_lock(&pctldev->mutex);
 	pin = gpio_to_pin(range, gpio);
-	ret = pinconf_set_config(pctldev, pin, configs, ARRAY_SIZE(configs));
+	ret = pinconf_set_config(pctldev, pin, configs, num_configs);
 	mutex_unlock(&pctldev->mutex);
 
 	return ret;
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index b1ca838dd80a..477a4d7ddbaf 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -358,12 +358,15 @@ static int atmel_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 
 static struct gpio_chip atmel_gpio_chip = {
+	.request		= gpiochip_generic_request,
+	.free			= gpiochip_generic_free,
 	.direction_input        = atmel_gpio_direction_input,
 	.get                    = atmel_gpio_get,
 	.direction_output       = atmel_gpio_direction_output,
 	.set                    = atmel_gpio_set,
 	.to_irq                 = atmel_gpio_to_irq,
 	.base                   = 0,
+	.set_config		= gpiochip_generic_config,
 };
 
 /* --- PINCTRL --- */
@@ -643,11 +646,26 @@ static int atmel_pmx_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int atmel_pmx_gpio_request_enable(struct pinctrl_dev *pctldev, struct pinctrl_gpio_range *range, unsigned offset)
+{
+	u32 conf;
+
+	conf = atmel_pin_config_read(pctldev, offset);
+	conf &= (~ATMEL_PIO_CFGR_FUNC_MASK);
+	atmel_pin_config_write(pctldev, offset, conf);
+
+	dev_dbg(pctldev->dev, "enable pin %u as GPIO\n", offset);
+
+	return 0;
+}
+
 static const struct pinmux_ops atmel_pmxops = {
+	.gpio_request_enable	= atmel_pmx_gpio_request_enable,
 	.get_functions_count	= atmel_pmx_get_functions_count,
 	.get_function_name	= atmel_pmx_get_function_name,
 	.get_function_groups	= atmel_pmx_get_function_groups,
 	.set_mux		= atmel_pmx_set_mux,
+	.strict			= true,
 };
 
 static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
@@ -817,6 +835,7 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinconf_ops atmel_confops = {
+	.pin_config_set		= atmel_conf_pin_config_group_set,
 	.pin_config_group_get	= atmel_conf_pin_config_group_get,
 	.pin_config_group_set	= atmel_conf_pin_config_group_set,
 	.pin_config_dbg_show	= atmel_conf_pin_config_dbg_show,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 55e672592fa9..b54968cd6dfc 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -247,7 +247,8 @@ struct gpio_chip {
 						unsigned long *bits);
 	int			(*set_config)(struct gpio_chip *chip,
 					      unsigned offset,
-					      unsigned long config);
+					      unsigned long *configs,
+					      unsigned num_configs);
 	int			(*to_irq)(struct gpio_chip *chip,
 						unsigned offset);
 
@@ -490,7 +491,7 @@ static inline int gpiochip_irqchip_add_nested(struct gpio_chip *gpiochip,
 int gpiochip_generic_request(struct gpio_chip *chip, unsigned offset);
 void gpiochip_generic_free(struct gpio_chip *chip, unsigned offset);
 int gpiochip_generic_config(struct gpio_chip *chip, unsigned offset,
-			    unsigned long config);
+			    unsigned long *configs, unsigned num_configs);
 
 #ifdef CONFIG_PINCTRL
 
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 0412cc9833e9..14be53e1e053 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -29,7 +29,7 @@ extern int pinctrl_gpio_request(unsigned gpio);
 extern void pinctrl_gpio_free(unsigned gpio);
 extern int pinctrl_gpio_direction_input(unsigned gpio);
 extern int pinctrl_gpio_direction_output(unsigned gpio);
-extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
+extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long *configs, unsigned num_configs);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
 extern void pinctrl_put(struct pinctrl *p);
@@ -81,7 +81,7 @@ static inline int pinctrl_gpio_direction_output(unsigned gpio)
 	return 0;
 }
 
-static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long config)
+static inline int pinctrl_gpio_set_config(unsigned gpio, unsigned long *configs, unsigned num_configs)
 {
 	return 0;
 }
-- 
2.12.2
