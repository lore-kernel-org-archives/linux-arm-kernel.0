From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 29 Apr 2016 16:25:43 +0200
Subject: [PATCH] pinctrl: stm32: Implement .pin_config_dbg_show()
Message-ID: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 174 ++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 8a7fe97..1527740 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -477,6 +477,29 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 	clk_disable(bank->clk);
 }
 
+static void stm32_pmx_get_mode(struct stm32_gpio_bank *bank,
+		int pin, u32 *mode, u32 *alt)
+{
+	u32 val;
+	int alt_shift = (pin % 8) * 4;
+	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
+	unsigned long flags;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + alt_offset);
+	val &= GENMASK(alt_shift + 3, alt_shift);
+	*alt = val >> alt_shift;
+
+	val = readl_relaxed(bank->base + STM32_GPIO_MODER);
+	val &= GENMASK(pin * 2 + 1, pin * 2);
+	*mode = val >> (pin * 2);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+}
+
 static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 			    unsigned function,
 			    unsigned group)
@@ -548,6 +571,24 @@ static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 	clk_disable(bank->clk);
 }
 
+static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
+	unsigned int offset)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
+	val &= BIT(offset);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+
+	return (val >> offset);
+}
+
 static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 speed)
 {
@@ -566,6 +607,24 @@ static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 	clk_disable(bank->clk);
 }
 
+static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
+	unsigned int offset)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
+	val &= GENMASK(offset * 2 + 1, offset * 2);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+
+	return (val >> (offset * 2));
+}
+
 static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 bias)
 {
@@ -584,6 +643,57 @@ static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 	clk_disable(bank->clk);
 }
 
+static u32 stm32_pconf_get_bias(struct stm32_gpio_bank *bank,
+	unsigned int offset)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
+	val &= GENMASK(offset * 2 + 1, offset * 2);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+
+	return (val >> (offset * 2));
+}
+
+static bool stm32_pconf_input_get(struct stm32_gpio_bank *bank,
+	unsigned int offset)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+
+	return val;
+}
+
+static bool stm32_pconf_output_get(struct stm32_gpio_bank *bank,
+	unsigned int offset)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+	val = !!(readl_relaxed(bank->base + STM32_GPIO_ODR) & BIT(offset));
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+
+	return val;
+}
+
 static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		unsigned int pin, enum pin_config_param param,
 		enum pin_config_param arg)
@@ -657,9 +767,73 @@ static int stm32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	return 0;
 }
 
+static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
+				 struct seq_file *s,
+				 unsigned int pin)
+{
+	struct pinctrl_gpio_range *range;
+	struct stm32_gpio_bank *bank;
+	int offset;
+	u32 mode, alt, drive, speed, bias;
+	static const char * const modes[] = {
+			"input", "output", "alternate", "analog" };
+	static const char * const speeds[] = {
+			"low", "medium", "high", "very high" };
+	static const char * const biasing[] = {
+			"floating", "pull up", "pull down", "" };
+	bool val;
+
+	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, pin);
+	bank = gpio_range_to_bank(range);
+	offset = stm32_gpio_pin(pin);
+
+	stm32_pmx_get_mode(bank, offset, &mode, &alt);
+	bias = stm32_pconf_get_bias(bank, offset);
+
+	seq_printf(s, "%s ", modes[mode]);
+
+	switch (mode) {
+	/* input */
+	case 0:
+		val = stm32_pconf_input_get(bank, offset);
+		seq_printf(s, "- %s - %s",
+			   val ? "high" : "low",
+			   biasing[bias]);
+		break;
+
+	/* output */
+	case 1:
+		drive = stm32_pconf_get_driving(bank, offset);
+		speed = stm32_pconf_get_speed(bank, offset);
+		val = stm32_pconf_output_get(bank, offset);
+		seq_printf(s, "- %s - %s - %s - %s %s",
+			   val ? "high" : "low",
+			   drive ? "open drain" : "push pull",
+			   biasing[bias],
+			   speeds[speed], "speed");
+		break;
+
+	/* alternate */
+	case 2:
+		drive = stm32_pconf_get_driving(bank, offset);
+		speed = stm32_pconf_get_speed(bank, offset);
+		seq_printf(s, "%d - %s -%s", alt,
+			   drive ? "open drain" : "push pull",
+			   biasing[bias],
+			   speeds[speed], "speed");
+		break;
+
+	/* analog */
+	case 3:
+		break;
+	}
+}
+
+
 static const struct pinconf_ops stm32_pconf_ops = {
 	.pin_config_group_get	= stm32_pconf_group_get,
 	.pin_config_group_set	= stm32_pconf_group_set,
+	.pin_config_dbg_show	= stm32_pconf_dbg_show,
 };
 
 static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
-- 
1.9.1
