From: julia@ni.com (Julia Cartwright)
Date: Thu, 9 Mar 2017 10:22:06 -0600
Subject: [PATCH 19/19] pinctrl: sunxi: make use of raw_spinlock variants
In-Reply-To: <cover.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
Message-ID: <6b509f22ec93562892e787507e62137cee7c9114.1489015238.git.julia@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi pinctrl driver currently implement an irq_chip for handling
interrupts; due to how irq_chip handling is done, it's necessary for the
irq_chip methods to be invoked from hardirq context, even on a a
real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 26 +++++++++++++-------------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 60e6e36c4a7e..58774acfc814 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -581,11 +581,11 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 			return -ENOTSUPP;
 		}
 
-		spin_lock_irqsave(&pctl->lock, flags);
+		raw_spin_lock_irqsave(&pctl->lock, flags);
 		reg = readl(pctl->membase + offset);
 		reg &= ~(mask << shift);
 		writel(reg | val << shift, pctl->membase + offset);
-		spin_unlock_irqrestore(&pctl->lock, flags);
+		raw_spin_unlock_irqrestore(&pctl->lock, flags);
 	} /* for each config */
 
 	return 0;
@@ -634,7 +634,7 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 	unsigned long flags;
 	u32 val, mask;
 
-	spin_lock_irqsave(&pctl->lock, flags);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
 	pin -= pctl->desc->pin_base;
 	val = readl(pctl->membase + sunxi_mux_reg(pin));
@@ -642,7 +642,7 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 	writel((val & ~mask) | config << sunxi_mux_offset(pin),
 		pctl->membase + sunxi_mux_reg(pin));
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static int sunxi_pmx_set_mux(struct pinctrl_dev *pctldev,
@@ -733,7 +733,7 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	unsigned long flags;
 	u32 regval;
 
-	spin_lock_irqsave(&pctl->lock, flags);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
 	regval = readl(pctl->membase + reg);
 
@@ -744,7 +744,7 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 
 	writel(regval, pctl->membase + reg);
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
@@ -856,7 +856,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&pctl->lock, flags);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_chip_handler_name_locked(d, &sunxi_pinctrl_level_irq_chip,
@@ -869,7 +869,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 	regval &= ~(IRQ_CFG_IRQ_MASK << index);
 	writel(regval | (mode << index), pctl->membase + reg);
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 
 	return 0;
 }
@@ -893,13 +893,13 @@ static void sunxi_pinctrl_irq_mask(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&pctl->lock, flags);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
 	/* Mask the IRQ */
 	val = readl(pctl->membase + reg);
 	writel(val & ~(1 << idx), pctl->membase + reg);
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
@@ -910,13 +910,13 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&pctl->lock, flags);
+	raw_spin_lock_irqsave(&pctl->lock, flags);
 
 	/* Unmask the IRQ */
 	val = readl(pctl->membase + reg);
 	writel(val | (1 << idx), pctl->membase + reg);
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d)
@@ -1253,7 +1253,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 		return -ENOMEM;
 	platform_set_drvdata(pdev, pctl);
 
-	spin_lock_init(&pctl->lock);
+	raw_spin_lock_init(&pctl->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pctl->membase = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index e1aedd260b2e..a9d315a1256c 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -134,7 +134,7 @@ struct sunxi_pinctrl {
 	unsigned			ngroups;
 	int				*irq;
 	unsigned			*irq_array;
-	spinlock_t			lock;
+	raw_spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
 	unsigned long			variant;
 };
-- 
2.11.1
