From: hl@rock-chips.com (Lin Huang)
Date: Fri,  7 Aug 2015 17:31:12 +0800
Subject: [PATCH v4 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <1438939872-2116-1-git-send-email-hl@rock-chips.com>
References: <1438939872-2116-1-git-send-email-hl@rock-chips.com>
Message-ID: <1438939872-2116-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio can keep state even the clock disable, for save power
consumption, only enable gpio clock when it setting

Signed-off-by: Lin Huang <hl@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changes in v4:
-delete some unrelated new blank line

 drivers/pinctrl/pinctrl-rockchip.c | 55 +++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index cc2843a..c5246c0 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -945,6 +945,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 	if (ret < 0)
 		return ret;
 
+	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
@@ -956,6 +957,7 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
+	clk_disable(bank->clk);
 
 	return 0;
 }
@@ -1389,6 +1391,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	unsigned long flags;
 	u32 data;
 
+	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg);
@@ -1398,6 +1401,7 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	writel(data, reg);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
+	clk_disable(bank->clk);
 }
 
 /*
@@ -1409,7 +1413,9 @@ static int rockchip_gpio_get(struct gpio_chip *gc, unsigned offset)
 	struct rockchip_pin_bank *bank = gc_to_pin_bank(gc);
 	u32 data;
 
+	clk_enable(bank->clk);
 	data = readl(bank->reg_base + GPIO_EXT_PORT);
+	clk_disable(bank->clk);
 	data >>= offset;
 	data &= 1;
 	return data;
@@ -1546,6 +1552,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	if (ret < 0)
 		return ret;
 
+	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
@@ -1603,6 +1610,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	default:
 		irq_gc_unlock(gc);
 		spin_unlock_irqrestore(&bank->slock, flags);
+		clk_disable(bank->clk);
 		return -EINVAL;
 	}
 
@@ -1611,6 +1619,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irq_gc_unlock(gc);
 	spin_unlock_irqrestore(&bank->slock, flags);
+	clk_disable(bank->clk);
 
 	return 0;
 }
@@ -1620,8 +1629,10 @@ static void rockchip_irq_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
+	clk_enable(bank->clk);
 	bank->saved_masks = irq_reg_readl(gc, GPIO_INTMASK);
 	irq_reg_writel(gc, ~gc->wake_active, GPIO_INTMASK);
+	clk_disable(bank->clk);
 }
 
 static void rockchip_irq_resume(struct irq_data *d)
@@ -1629,7 +1640,27 @@ static void rockchip_irq_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
+	clk_enable(bank->clk);
 	irq_reg_writel(gc, bank->saved_masks, GPIO_INTMASK);
+	clk_disable(bank->clk);
+}
+
+static void rockchip_irq_gc_mask_clr_bit(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank = gc->private;
+
+	clk_enable(bank->clk);
+	irq_gc_mask_clr_bit(d);
+}
+
+void rockchip_irq_gc_mask_set_bit(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank = gc->private;
+
+	irq_gc_mask_set_bit(d);
+	clk_disable(bank->clk);
 }
 
 static int rockchip_interrupts_register(struct platform_device *pdev,
@@ -1640,7 +1671,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct irq_chip_generic *gc;
 	int ret;
-	int i;
+	int i, j;
 
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		if (!bank->valid) {
@@ -1649,11 +1680,19 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 			continue;
 		}
 
+		ret = clk_enable(bank->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable clock for bank %s\n",
+				bank->name);
+			continue;
+		}
+
 		bank->domain = irq_domain_add_linear(bank->of_node, 32,
 						&irq_generic_chip_ops, NULL);
 		if (!bank->domain) {
 			dev_warn(&pdev->dev, "could not initialize irq domain for bank %s\n",
 				 bank->name);
+			clk_disable(bank->clk);
 			continue;
 		}
 
@@ -1664,6 +1703,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 			dev_err(&pdev->dev, "could not alloc generic chips for bank %s\n",
 				bank->name);
 			irq_domain_remove(bank->domain);
+			clk_disable(bank->clk);
 			continue;
 		}
 
@@ -1681,8 +1721,9 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 		gc->chip_types[0].regs.mask = GPIO_INTMASK;
 		gc->chip_types[0].regs.ack = GPIO_PORTS_EOI;
 		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
-		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
-		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_mask = rockchip_irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_unmask =
+						  rockchip_irq_gc_mask_clr_bit;
 		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
 		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
 		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
@@ -1691,6 +1732,12 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 
 		irq_set_chained_handler_and_data(bank->irq,
 						 rockchip_irq_demux, bank);
+
+		/* map the gpio irqs here, when the clock is still running */
+		for (j = 0 ; j < 32 ; j++)
+			irq_create_mapping(bank->domain, j);
+
+		clk_disable(bank->clk);
 	}
 
 	return 0;
@@ -1808,7 +1855,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
-	return clk_prepare_enable(bank->clk);
+	return clk_prepare(bank->clk);
 }
 
 static const struct of_device_id rockchip_pinctrl_dt_match[];
-- 
1.9.1
