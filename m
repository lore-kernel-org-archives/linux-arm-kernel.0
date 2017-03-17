From: john@metanate.com (John Keeping)
Date: Fri, 17 Mar 2017 18:24:28 +0000
Subject: [PATCH v3 2/4] pinctrl: rockchip: convert to raw spinlock
In-Reply-To: <20170317182430.27400-1-john@metanate.com>
References: <20170317182430.27400-1-john@metanate.com>
Message-ID: <20170317182430.27400-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lock is used from rockchip_irq_set_type() which is part of the
irq_chip implementation and thus must use raw_spinlock_t as documented
in Documentation/gpio/driver.txt.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
v3: unchanged
v2: unchanged
---
 drivers/pinctrl/pinctrl-rockchip.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 1d835370c2c7..63c868ebb94b 100644
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
 
@@ -1498,7 +1498,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 		return ret;
 
 	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
 	/* set bit to 1 for output, 0 for input */
@@ -1508,7 +1508,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 		data &= ~BIT(pin);
 	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 
 	return 0;
@@ -1958,7 +1958,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	u32 data;
 
 	clk_enable(bank->clk);
-	spin_lock_irqsave(&bank->slock, flags);
+	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg);
 	data &= ~BIT(offset);
@@ -1966,7 +1966,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 		data |= BIT(offset);
 	writel(data, reg);
 
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 }
 
@@ -2078,7 +2078,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 
 			data = readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
 			do {
-				spin_lock_irqsave(&bank->slock, flags);
+				raw_spin_lock_irqsave(&bank->slock, flags);
 
 				polarity = readl_relaxed(bank->reg_base +
 							 GPIO_INT_POLARITY);
@@ -2089,7 +2089,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 				writel(polarity,
 				       bank->reg_base + GPIO_INT_POLARITY);
 
-				spin_unlock_irqrestore(&bank->slock, flags);
+				raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 				data_old = data;
 				data = readl_relaxed(bank->reg_base +
@@ -2120,20 +2120,20 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
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
@@ -2176,7 +2176,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		break;
 	default:
 		irq_gc_unlock(gc);
-		spin_unlock_irqrestore(&bank->slock, flags);
+		raw_spin_unlock_irqrestore(&bank->slock, flags);
 		clk_disable(bank->clk);
 		return -EINVAL;
 	}
@@ -2185,7 +2185,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
 
 	irq_gc_unlock(gc);
-	spin_unlock_irqrestore(&bank->slock, flags);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 
 	return 0;
@@ -2467,7 +2467,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		int bank_pins = 0;
 
-		spin_lock_init(&bank->slock);
+		raw_spin_lock_init(&bank->slock);
 		bank->drvdata = d;
 		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
-- 
2.12.0.377.gf910686b23.dirty
