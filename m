From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 31 Mar 2016 17:09:36 +0200
Subject: [PATCH v2 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1459436979-17275-7-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IRQ support to STM32 gpios.

The EXTI controller has 16 lines dedicated to GPIOs.
EXTI line n can be connected to only line n of one of the GPIO ports, for
example EXTI0 can be connected to either PA0, or PB0, or PC0...
This port selection is done by specifying the port number into System
Config registers.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/pinctrl/stm32/Kconfig         |  1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c | 68 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 0f28841b2332..b5cac5bfd0cd 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -6,6 +6,7 @@ config PINCTRL_STM32
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select MFD_SYSCON
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 8deb566ed4cd..f2fa717894dc 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -20,6 +22,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -77,6 +80,9 @@ struct stm32_pinctrl {
 	struct stm32_gpio_bank *banks;
 	unsigned nbanks;
 	const struct stm32_pinctrl_match_data *match_data;
+	struct irq_domain	*domain;
+	struct regmap		*regmap;
+	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
 };
 
 static inline int stm32_gpio_pin(int gpio)
@@ -174,6 +180,22 @@ static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+
+static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct stm32_pinctrl *pctl = dev_get_drvdata(chip->parent);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
+	unsigned int irq;
+
+	regmap_field_write(pctl->irqmux[offset], bank->range.id);
+
+	irq = irq_create_mapping(pctl->domain, offset);
+	if (!irq)
+		return -ENXIO;
+
+	return irq;
+}
+
 static struct gpio_chip stm32_gpio_template = {
 	.request		= stm32_gpio_request,
 	.free			= stm32_gpio_free,
@@ -181,6 +203,7 @@ static struct gpio_chip stm32_gpio_template = {
 	.set			= stm32_gpio_set,
 	.direction_input	= stm32_gpio_direction_input,
 	.direction_output	= stm32_gpio_direction_output,
+	.to_irq			= stm32_gpio_to_irq,
 };
 
 /* Pinctrl functions */
@@ -704,6 +727,47 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	return 0;
 }
 
+static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
+			   struct stm32_pinctrl *pctl)
+{
+	struct device_node *np = pdev->dev.of_node, *parent;
+	struct device *dev = &pdev->dev;
+	struct regmap *rm;
+	int offset, ret, i;
+
+	parent = of_irq_find_parent(np);
+	if (!parent)
+		return -ENXIO;
+
+	pctl->domain = irq_find_host(parent);
+	if (!pctl->domain)
+		return -ENXIO;
+
+	pctl->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(pctl->regmap))
+		return PTR_ERR(pctl->regmap);
+
+	rm = pctl->regmap;
+
+	ret = of_property_read_u32_index(np, "st,syscfg", 1, &offset);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < STM32_GPIO_PINS_PER_BANK; i++) {
+		struct reg_field mux;
+
+		mux.reg = offset + (i / 4) * 4;
+		mux.lsb = (i % 4) * 4;
+		mux.msb = mux.lsb + 3;
+
+		pctl->irqmux[i] = devm_regmap_field_alloc(dev, rm, mux);
+		if (IS_ERR(pctl->irqmux[i]))
+			return PTR_ERR(pctl->irqmux[i]);
+	}
+
+	return 0;
+}
+
 static int stm32_pctrl_build_state(struct platform_device *pdev)
 {
 	struct stm32_pinctrl *pctl = platform_get_drvdata(pdev);
@@ -796,6 +860,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
+	if (ret)
+		return ret;
+
 	pins = devm_kcalloc(&pdev->dev, pctl->match_data->npins, sizeof(*pins),
 			    GFP_KERNEL);
 	if (!pins)
-- 
1.9.1
