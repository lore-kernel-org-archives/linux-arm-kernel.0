From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Jul 2014 01:24:36 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: use gpiolib API to mark a GPIO used as an
 IRQ
In-Reply-To: <1405358677-23657-1-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
Message-ID: <1405358677-23657-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
the gpiolib so we can keep track of the usage centrally.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 47f5e1b..23c1b9f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -541,18 +541,33 @@ static int sunxi_pinctrl_irq_request_resources(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	struct sunxi_desc_function *func;
+	int ret;
 
 	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
 					pctl->irq_array[d->hwirq], "irq");
 	if (!func)
 		return -EINVAL;
 
+	ret = gpio_lock_as_irq(pctl->chip, pctl->irq_array[d->hwirq]);
+	if (ret) {
+		dev_err(pctl->dev, "unable to lock HW IRQ %lu for IRQ\n",
+			irqd_to_hwirq(d));
+		return ret;
+	}
+
 	/* Change muxing to INT mode */
 	sunxi_pmx_set(pctl->pctl_dev, pctl->irq_array[d->hwirq], func->muxval);
 
 	return 0;
 }
 
+static void sunxi_pinctrl_irq_release_resources(struct irq_data *d)
+{
+	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+
+	gpio_unlock_as_irq(pctl->chip, pctl->irq_array[d->hwirq]);
+}
+
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
@@ -657,6 +672,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
 	.irq_mask	= sunxi_pinctrl_irq_mask,
 	.irq_unmask	= sunxi_pinctrl_irq_unmask,
 	.irq_request_resources = sunxi_pinctrl_irq_request_resources,
+	.irq_release_resources = sunxi_pinctrl_irq_release_resources,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -670,6 +686,7 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 	.irq_enable	= sunxi_pinctrl_irq_ack_unmask,
 	.irq_disable	= sunxi_pinctrl_irq_mask,
 	.irq_request_resources = sunxi_pinctrl_irq_request_resources,
+	.irq_release_resources = sunxi_pinctrl_irq_release_resources,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED |
 			  IRQCHIP_EOI_IF_HANDLED,
-- 
2.0.1
