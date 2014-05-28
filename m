From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 12:27:27 +0200
Subject: [PATCH 1/5] pinctrl: sunxi: Remove irq_mask_ack and use irq_ack
 instead
In-Reply-To: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401272851-15873-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If irq_mask_ack is not defined, mask_ack_irq will call irq_mask and then
irq_ack. In order to avoid code duplication, between irq_mask_ack and irq_mask,
just declare irq_ack.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index d69a440e728d..71d6cd10d56f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -571,26 +571,15 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 	return 0;
 }
 
-static void sunxi_pinctrl_irq_mask_ack(struct irq_data *d)
+static void sunxi_pinctrl_irq_ack(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	u32 ctrl_reg = sunxi_irq_ctrl_reg(d->hwirq);
-	u8 ctrl_idx = sunxi_irq_ctrl_offset(d->hwirq);
 	u32 status_reg = sunxi_irq_status_reg(d->hwirq);
 	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
 	unsigned long flags;
-	u32 val;
-
-	spin_lock_irqsave(&pctl->lock, flags);
-
-	/* Mask the IRQ */
-	val = readl(pctl->membase + ctrl_reg);
-	writel(val & ~(1 << ctrl_idx), pctl->membase + ctrl_reg);
 
 	/* Clear the IRQ */
 	writel(1 << status_idx, pctl->membase + status_reg);
-
-	spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
 static void sunxi_pinctrl_irq_mask(struct irq_data *d)
@@ -636,8 +625,8 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 }
 
 static struct irq_chip sunxi_pinctrl_irq_chip = {
+	.irq_ack	= sunxi_pinctrl_irq_ack,
 	.irq_mask	= sunxi_pinctrl_irq_mask,
-	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 };
-- 
1.9.3
