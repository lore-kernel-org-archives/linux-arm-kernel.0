From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 14:41:11 +0200
Subject: [PATCH 1/4] pinctrl: sunxi: Use common functions to change irq_chip
 and handler
In-Reply-To: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437396074-15791-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code uses some custom variable affectations, while we have
common functions to do exactly that. Move to the common functions.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f09573e13203..777669d0a955 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -588,7 +588,6 @@ static void sunxi_pinctrl_irq_release_resources(struct irq_data *d)
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
 	unsigned long flags;
@@ -615,16 +614,17 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	if (type & IRQ_TYPE_LEVEL_MASK) {
-		d->chip = &sunxi_pinctrl_level_irq_chip;
-		desc->handle_irq = handle_fasteoi_irq;
-	} else {
-		d->chip = &sunxi_pinctrl_edge_irq_chip;
-		desc->handle_irq = handle_edge_irq;
-	}
-
 	spin_lock_irqsave(&pctl->lock, flags);
 
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		__irq_set_chip_handler_name_locked(d->irq,
+						   &sunxi_pinctrl_level_irq_chip,
+						   handle_fasteoi_irq, NULL);
+	else
+		__irq_set_chip_handler_name_locked(d->irq,
+						   &sunxi_pinctrl_edge_irq_chip,
+						   handle_edge_irq, NULL);
+
 	regval = readl(pctl->membase + reg);
 	regval &= ~(IRQ_CFG_IRQ_MASK << index);
 	writel(regval | (mode << index), pctl->membase + reg);
-- 
2.4.5
