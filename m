From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 12:38:48 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add spinlocks
In-Reply-To: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code use no locking at all, which is obviously not that
great and can lead to concurrency issues, especially with the newer SMP
SoCs from Allwinner.

Add some locking where it's needed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 55 ++++++++++++++++++++++++++++++++++++++---
 drivers/pinctrl/pinctrl-sunxi.h |  2 ++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 8ed4b4a..94716c7 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -278,6 +278,7 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct sunxi_pinctrl_group *g = &pctl->groups[group];
+	unsigned long flags;
 	u32 val, mask;
 	u16 strength;
 	u8 dlevel;
@@ -295,22 +296,35 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 		 *   3: 40mA
 		 */
 		dlevel = strength / 10 - 1;
+
+		spin_lock_irqsave(&pctl->lock, flags);
+
 		val = readl(pctl->membase + sunxi_dlevel_reg(g->pin));
 	        mask = DLEVEL_PINS_MASK << sunxi_dlevel_offset(g->pin);
 		writel((val & ~mask) | dlevel << sunxi_dlevel_offset(g->pin),
 			pctl->membase + sunxi_dlevel_reg(g->pin));
+
+		spin_unlock_irqrestore(&pctl->lock, flags);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
+		spin_lock_irqsave(&pctl->lock, flags);
+
 		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
 		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
 		writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin),
 			pctl->membase + sunxi_pull_reg(g->pin));
+
+		spin_unlock_irqrestore(&pctl->lock, flags);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
+		spin_lock_irqsave(&pctl->lock, flags);
+
 		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
 		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
 		writel((val & ~mask) | 2 << sunxi_pull_offset(g->pin),
 			pctl->membase + sunxi_pull_reg(g->pin));
+
+		spin_unlock_irqrestore(&pctl->lock, flags);
 		break;
 	default:
 		break;
@@ -360,11 +374,17 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 				 u8 config)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned long flags;
+	u32 val, mask;
+
+	spin_lock_irqsave(&pctl->lock, flags);
 
-	u32 val = readl(pctl->membase + sunxi_mux_reg(pin));
-	u32 mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
+	val = readl(pctl->membase + sunxi_mux_reg(pin));
+	mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
 	writel((val & ~mask) | config << sunxi_mux_offset(pin),
 		pctl->membase + sunxi_mux_reg(pin));
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static int sunxi_pmx_enable(struct pinctrl_dev *pctldev,
@@ -464,7 +484,12 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	struct sunxi_pinctrl *pctl = dev_get_drvdata(chip->dev);
 	u32 reg = sunxi_data_reg(offset);
 	u8 index = sunxi_data_offset(offset);
-	u32 regval = readl(pctl->membase + reg);
+	unsigned long flags;
+	u32 regval;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+
+	regval = readl(pctl->membase + reg);
 
 	if (value)
 		regval |= BIT(index);
@@ -472,6 +497,8 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 		regval &= ~(BIT(index));
 
 	writel(regval, pctl->membase + reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
@@ -532,6 +559,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
+	unsigned long flags;
 	u32 regval;
 	u8 mode;
 
@@ -555,10 +583,14 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 		return -EINVAL;
 	}
 
+	spin_lock_irqsave(&pctl->lock, flags);
+
 	regval = readl(pctl->membase + reg);
 	regval &= ~IRQ_CFG_IRQ_MASK;
 	writel(regval | (mode << index), pctl->membase + reg);
 
+	spin_unlock_irqrestore(&pctl->lock, flags);
+
 	return 0;
 }
 
@@ -569,14 +601,19 @@ static void sunxi_pinctrl_irq_mask_ack(struct irq_data *d)
 	u8 ctrl_idx = sunxi_irq_ctrl_offset(d->hwirq);
 	u32 status_reg = sunxi_irq_status_reg(d->hwirq);
 	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
+	unsigned long flags;
 	u32 val;
 
+	spin_lock_irqsave(&pctl->lock, flags);
+
 	/* Mask the IRQ */
 	val = readl(pctl->membase + ctrl_reg);
 	writel(val & ~(1 << ctrl_idx), pctl->membase + ctrl_reg);
 
 	/* Clear the IRQ */
 	writel(1 << status_idx, pctl->membase + status_reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static void sunxi_pinctrl_irq_mask(struct irq_data *d)
@@ -584,11 +621,16 @@ static void sunxi_pinctrl_irq_mask(struct irq_data *d)
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	u32 reg = sunxi_irq_ctrl_reg(d->hwirq);
 	u8 idx = sunxi_irq_ctrl_offset(d->hwirq);
+	unsigned long flags;
 	u32 val;
 
+	spin_lock_irqsave(&pctl->lock, flags);
+
 	/* Mask the IRQ */
 	val = readl(pctl->membase + reg);
 	writel(val & ~(1 << idx), pctl->membase + reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
@@ -597,6 +639,7 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	struct sunxi_desc_function *func;
 	u32 reg = sunxi_irq_ctrl_reg(d->hwirq);
 	u8 idx = sunxi_irq_ctrl_offset(d->hwirq);
+	unsigned long flags;
 	u32 val;
 
 	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
@@ -606,9 +649,13 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	/* Change muxing to INT mode */
 	sunxi_pmx_set(pctl->pctl_dev, pctl->irq_array[d->hwirq], func->muxval);
 
+	spin_lock_irqsave(&pctl->lock, flags);
+
 	/* Unmask the IRQ */
 	val = readl(pctl->membase + reg);
 	writel(val | (1 << idx), pctl->membase + reg);
+
+	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static struct irq_chip sunxi_pinctrl_irq_chip = {
@@ -761,6 +808,8 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, pctl);
 
+	spin_lock_init(&pctl->lock);
+
 	pctl->membase = of_iomap(node, 0);
 	if (!pctl->membase)
 		return -ENOMEM;
diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index d68047d..01c494f 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -14,6 +14,7 @@
 #define __PINCTRL_SUNXI_H
 
 #include <linux/kernel.h>
+#include <linux/spinlock.h>
 
 #define PA_BASE	0
 #define PB_BASE	32
@@ -407,6 +408,7 @@ struct sunxi_pinctrl {
 	unsigned			ngroups;
 	int				irq;
 	int				irq_array[SUNXI_IRQ_NUMBER];
+	spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
 };
 
-- 
1.8.3.4
