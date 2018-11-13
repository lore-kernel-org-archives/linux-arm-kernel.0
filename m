From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 13 Nov 2018 10:51:41 +0100
Subject: [PATCH 2/3] pinctrl: stm32: protect configuration registers with a
 hwspinlock
In-Reply-To: <20181113095142.32015-1-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
Message-ID: <20181113095142.32015-3-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a hwspinlock if defined in device tree use it to protect
configuration registers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 71 ++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a9bec6e6fdd1..dce9dabaf4d5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -8,6 +8,7 @@
  */
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
+#include <linux/hwspinlock.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
@@ -51,6 +52,8 @@
 #define gpio_range_to_bank(chip) \
 		container_of(chip, struct stm32_gpio_bank, range)
 
+#define HWSPINLOCK_TIMEOUT	5 /* msec */
+
 static const char * const stm32_gpio_functions[] = {
 	"gpio", "af0", "af1",
 	"af2", "af3", "af4",
@@ -91,6 +94,7 @@ struct stm32_pinctrl {
 	struct irq_domain	*domain;
 	struct regmap		*regmap;
 	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
+	struct hwspinlock *hwlock;
 };
 
 static inline int stm32_gpio_pin(int gpio)
@@ -576,14 +580,24 @@ static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 		int pin, u32 mode, u32 alt)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	u32 val;
 	int alt_shift = (pin % 8) * 4;
 	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
 	unsigned long flags;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + alt_offset);
 	val &= ~GENMASK(alt_shift + 3, alt_shift);
 	val |= (alt << alt_shift);
@@ -594,6 +608,10 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 	val |= mode << (pin * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_MODER);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -683,17 +701,31 @@ static const struct pinmux_ops stm32_pmx_ops = {
 static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 drive)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
 	val &= ~BIT(offset);
 	val |= drive << offset;
 	writel_relaxed(val, bank->base + STM32_GPIO_TYPER);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -719,17 +751,31 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
 static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 speed)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
 	val &= ~GENMASK(offset * 2 + 1, offset * 2);
 	val |= speed << (offset * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_SPEEDR);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -755,17 +801,31 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
 static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 	unsigned offset, u32 bias)
 {
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
 	u32 val;
+	int err = 0;
 
 	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (pctl->hwlock)
+		err = hwspin_lock_timeout(pctl->hwlock, HWSPINLOCK_TIMEOUT);
+
+	if (err) {
+		dev_err(pctl->dev, "Can't get hwspinlock\n");
+		goto unlock;
+	}
+
 	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
 	val &= ~GENMASK(offset * 2 + 1, offset * 2);
 	val |= bias << (offset * 2);
 	writel_relaxed(val, bank->base + STM32_GPIO_PUPDR);
 
+	if (pctl->hwlock)
+		hwspin_unlock(pctl->hwlock);
+
+unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
 }
@@ -1140,7 +1200,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_pinctrl *pctl;
 	struct pinctrl_pin_desc *pins;
-	int i, ret, banks = 0;
+	int i, ret, hwlock_id, banks = 0;
 
 	if (!np)
 		return -EINVAL;
@@ -1160,6 +1220,15 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pctl);
 
+	/* hwspinlock is optional */
+	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
+	if (hwlock_id < 0) {
+		if (hwlock_id == -EPROBE_DEFER)
+			return hwlock_id;
+	} else {
+		pctl->hwlock = hwspin_lock_request_specific(hwlock_id);
+	}
+
 	pctl->dev = dev;
 	pctl->match_data = match->data;
 	ret = stm32_pctrl_build_state(pdev);
-- 
2.15.0
