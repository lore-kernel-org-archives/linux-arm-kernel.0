From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 17:10:10 +0200
Subject: [PATCH 3/4] pinctrl: stm32: Implement .get_direction gpio_chip
 callback
In-Reply-To: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491577811-26989-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add .get_direction() gpiochip callback in STM32 pinctrl driver.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index c8825e5..fdde60f 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
 
 #include "../core.h"
 #include "../pinconf.h"
@@ -197,6 +198,24 @@ static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 	return irq_create_fwspec_mapping(&fwspec);
 }
 
+static int stm32_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
+	int pin = stm32_gpio_pin(offset);
+	int ret;
+	u32 mode, alt;
+
+	stm32_pmx_get_mode(bank, pin, &mode, &alt);
+	if ((alt == 0) && (mode == 0))
+		ret = GPIOF_DIR_IN;
+	else if ((alt == 0) && (mode == 1))
+		ret = GPIOF_DIR_OUT;
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static const struct gpio_chip stm32_gpio_template = {
 	.request		= stm32_gpio_request,
 	.free			= stm32_gpio_free,
@@ -205,6 +224,7 @@ static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 	.direction_input	= stm32_gpio_direction_input,
 	.direction_output	= stm32_gpio_direction_output,
 	.to_irq			= stm32_gpio_to_irq,
+	.get_direction		= stm32_gpio_get_direction,
 };
 
 static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
@@ -569,8 +589,8 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 	clk_disable(bank->clk);
 }
 
-static void stm32_pmx_get_mode(struct stm32_gpio_bank *bank,
-		int pin, u32 *mode, u32 *alt)
+void stm32_pmx_get_mode(struct stm32_gpio_bank *bank, int pin, u32 *mode,
+			u32 *alt)
 {
 	u32 val;
 	int alt_shift = (pin % 8) * 4;
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index 35ebc94..8702a99 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -45,7 +45,10 @@ struct stm32_pinctrl_match_data {
 	const unsigned int npins;
 };
 
-int stm32_pctl_probe(struct platform_device *pdev);
+struct stm32_gpio_bank;
 
+int stm32_pctl_probe(struct platform_device *pdev);
+void stm32_pmx_get_mode(struct stm32_gpio_bank *bank,
+			int pin, u32 *mode, u32 *alt);
 #endif /* __PINCTRL_STM32_H */
 
-- 
1.9.1
