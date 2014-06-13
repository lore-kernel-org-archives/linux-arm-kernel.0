From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 13 Jun 2014 22:36:02 +0200
Subject: [PATCH v2 2/4] pinctrl: sunxi: Move setting of mux to irq type from
 unmask to request_resources
In-Reply-To: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
References: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1402691764-17562-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With level triggered interrupt mask / unmask will get called for each
interrupt, doing the somewhat expensive mux setting on each unmask thus is
not a good idea. Instead add a request_resources callback and do it there.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index c199337..d4d4934 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -531,6 +531,21 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 	return irq_find_mapping(pctl->domain, desc->irqnum);
 }
 
+static int sunxi_pinctrl_irq_request_resources(struct irq_data *d)
+{
+	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+	struct sunxi_desc_function *func;
+
+	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
+					pctl->irq_array[d->hwirq], "irq");
+        if (!func)
+                return -EINVAL;
+
+	/* Change muxing to INT mode */
+	sunxi_pmx_set(pctl->pctl_dev, pctl->irq_array[d->hwirq], func->muxval);
+
+	return 0;
+}
 
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d,
 				      unsigned int type)
@@ -603,19 +618,11 @@ static void sunxi_pinctrl_irq_mask(struct irq_data *d)
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
@@ -629,6 +636,7 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
 	.irq_ack	= sunxi_pinctrl_irq_ack,
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
+	.irq_request_resources = sunxi_pinctrl_irq_request_resources,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
-- 
2.0.0
