From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 26 May 2014 09:47:58 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type from
 unmask to set_type
In-Reply-To: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With level triggered interrupt mask / unmask will get called for each
interrupt, doing the somewhat expensive mux setting on each unmask thus is
not a good idea. Instead move it to the set_type callback, which is typically
done only once for each irq.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ec60c2e..d1675c9 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -542,6 +542,7 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	u32 reg = sunxi_irq_cfg_reg(d->hwirq);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
+	struct sunxi_desc_function *func;
 	unsigned long flags;
 	u32 regval;
 	u8 mode;
@@ -574,6 +575,12 @@ static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 
 	spin_unlock_irqrestore(&pctl->lock, flags);
 
+	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
+					pctl->irq_array[d->hwirq], "irq");
+
+	/* Change muxing to INT mode */
+	sunxi_pmx_set(pctl->pctl_dev, pctl->irq_array[d->hwirq], func->muxval);
+
 	return 0;
 }
 
@@ -619,19 +626,11 @@ static void sunxi_pinctrl_irq_mask(struct irq_data *d)
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	struct sunxi_desc_function *func;
 	u32 reg = sunxi_irq_ctrl_reg(d->hwirq);
 	u8 idx = sunxi_irq_ctrl_offset(d->hwirq);
 	unsigned long flags;
 	u32 val;
 
-	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
-						       pctl->irq_array[d->hwirq],
-						       "irq");
-
-	/* Change muxing to INT mode */
-	sunxi_pmx_set(pctl->pctl_dev, pctl->irq_array[d->hwirq], func->muxval);
-
 	spin_lock_irqsave(&pctl->lock, flags);
 
 	/* Unmask the IRQ */
-- 
1.9.3
