From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:43 +0200
Subject: [PATCH 5/6] pinctrl: exynos: Correct the detection of wakeup-eint node
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current way of finding the wakeup-eint node scans the whole device tree
not only children of the pinctrl node, so it might detect a wakeup-eint
node of another pinctrl device.

This patch limits the scope of looking for nodes only to subnodes of the
pinctrl node.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 49ef5a2..0d01d19 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -431,15 +431,19 @@ static const struct irq_domain_ops exynos_wkup_irqd_ops = {
 static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
-	struct device_node *wkup_np;
+	struct device_node *wkup_np = NULL;
+	struct device_node *np;
 	struct exynos_weint_data *weint_data;
 	int idx, irq;
 
-	wkup_np = of_find_matching_node(dev->of_node, exynos_wkup_irq_ids);
-	if (!wkup_np) {
-		dev_err(dev, "wakeup controller node not found\n");
-		return -ENODEV;
+	for_each_child_of_node(dev->of_node, np) {
+		if (of_match_node(exynos_wkup_irq_ids, np)) {
+			wkup_np = np;
+			break;
+		}
 	}
+	if (!wkup_np)
+		return -ENODEV;
 
 	d->wkup_irqd = irq_domain_add_linear(wkup_np, d->ctrl->nr_wint,
 				&exynos_wkup_irqd_ops, d);
-- 
1.7.12
