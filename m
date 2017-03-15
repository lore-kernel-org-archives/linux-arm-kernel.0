From: john@metanate.com (John Keeping)
Date: Wed, 15 Mar 2017 17:46:52 +0000
Subject: [PATCH v2 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <20170315174654.15128-1-john@metanate.com>
References: <20170315174654.15128-1-john@metanate.com>
Message-ID: <20170315174654.15128-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lock is used from rockchip_irq_set_type() which is part of the
irq_chip implementation and thus must use raw_spinlock_t as documented
in Documentation/gpio/driver.txt.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
v2: unchanged
---
 drivers/pinctrl/pinctrl-rockchip.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 128c383ea7ba..8c1cae6d78d7 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -163,7 +163,7 @@ struct rockchip_pin_bank {
 	struct irq_domain		*domain;
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	grange;
-	spinlock_t			slock;
+	raw_spinlock_t			slock;
 	u32				toggle_edge_mode;
 };
 
@@ -1295,14 +1295,14 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 
 	switch (ctrl->type) {
 	case RK2928:
-		spin_lock_irqsave(&bank->slock, flags);
+		raw_spin_lock_irqsave(&bank->slock, flags);
 
 		data = BIT(bit + 16);
 		if (pull == PIN_CONFIG_BIAS_DISABLE)
 			data |= BIT(bit);
 		ret = regmap_write(regmap, reg, data);
 
-		spin_unlock_irqrestore(&bank->slock, flags);
+		raw_spin_unlock_irqrestore(&bank->slock, flags);
 		break;
 	case RK1108:
 	case RK3188:
@@ -1503,7 +1503,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 		return ret;
 
 	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
 	/* set bit to 1 for output, 0 for input */
@@ -1513,7 +1513,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 		data &= ~BIT(pin);
 	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 
 	return 0;
@@ -1963,7 +1963,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	u32 data;
 
 	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg);
 	data &= ~BIT(offset);
@@ -1971,7 +1971,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 		data |= BIT(offset);
 	writel(data, reg);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 }
 
@@ -2083,7 +2083,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 
 			data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
 			do {
-				spin_lock_irqsave(&bank->slock, flags);
+				raw_spin_lock_irqsave(&bank->slock, flags);
 
 				polarity = readl_relaxed(bank->reg_base +
 							 GPIO_INT_POLARITY);
@@ -2094,7 +2094,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 				writel(polarity,
 				       bank->reg_base + GPIO_INT_POLARITY);
 
-				spin_unlock_irqrestore(&bank->slock, flags);
+				raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 				data_old = data;
 				data = readl_relaxed(bank->reg_base +
@@ -2125,20 +2125,20 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		return ret;
 
 	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
 	data &= ~mask;
 	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 	else
 		irq_set_handler_locked(d, handle_level_irq);
 
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 	irq_gc_lock(gc);
 
 	level = readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
@@ -2181,7 +2181,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		break;
 	default:
 		irq_gc_unlock(gc);
-		spin_unlock_irqrestore(&bank->slock, flags);
+		raw_spin_unlock_irqrestore(&bank->slock, flags);
 		clk_disable(bank->clk);
 		return -EINVAL;
 	}
@@ -2190,7 +2190,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
 
 	irq_gc_unlock(gc);
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 
 	return 0;
@@ -2472,7 +2472,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		int bank_pins = 0;
 
-		spin_lock_init(&bank->slock);
+		raw_spin_lock_init(&bank->slock);
 		bank->drvdata = d;
 		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
-- 
2.12.0.377.gf910686b23.dirty
