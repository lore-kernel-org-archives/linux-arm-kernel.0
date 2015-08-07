From: maoguang.meng@mediatek.com (maoguang.meng at mediatek.com)
Date: Fri, 7 Aug 2015 18:14:39 +0800
Subject: [PATCH v2] pinctrl: mediatek: Implement wake handler and suspend
 resume
Message-ID: <1438942479-24478-1-git-send-email-maoguang.meng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maoguang Meng <maoguang.meng@mediatek.com>

This patch implement irq_set_wake and add suspend resume feature.

Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 78 +++++++++++++++++++++++++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index d0c811d..ad27184 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -385,6 +385,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt8173-pinctrl",
 		.of_match_table = mt8173_pctrl_match,
+		.pm = &mtk_eint_pm_ops,
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index a3d137e..af2d33a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -35,6 +35,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
 
 #include "../core.h"
@@ -1066,14 +1067,74 @@ static int mtk_eint_set_type(struct irq_data *d,
 
 static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
 {
+	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
+
 	if (on)
-		d->chip->flags |= IRQF_NO_SUSPEND;
+		set_bit(d->hwirq, (unsigned long *)pctl->wake_mask);
 	else
-		d->chip->flags &= ~IRQF_NO_SUSPEND;
+		clear_bit(d->hwirq, (unsigned long *)pctl->wake_mask);
+
+	return 0;
+}
+
+static void mtk_eint_chip_write_mask(const struct mtk_eint_offsets *chip,
+	void __iomem *eint_reg_base, u32 *buf)
+{
+	int port;
+	void __iomem *reg;
+
+	for (port = 0; port < chip->ports; port++) {
+		reg = eint_reg_base + (port << 2);
+		writel_relaxed(~buf[port], reg + chip->mask_set);
+		writel_relaxed(buf[port], reg + chip->mask_clr);
+	}
+}
+
+static void mtk_eint_chip_read_mask(const struct mtk_eint_offsets *chip,
+	void __iomem *eint_reg_base, u32 *buf)
+{
+	int port;
+	void __iomem *reg;
+
+	for (port = 0; port < chip->ports; port++) {
+		reg = eint_reg_base + chip->mask + (port << 2);
+		buf[port] = ~readl_relaxed(reg);
+	}
+}
+
+static int mtk_eint_suspend(struct device *device)
+{
+	void __iomem *reg;
+	struct platform_device *pdev = to_platform_device(device);
+	struct mtk_pinctrl *pctl = platform_get_drvdata(pdev);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+
+	reg = pctl->eint_reg_base;
+	mtk_eint_chip_read_mask(eint_offsets, reg, pctl->cur_mask);
+	mtk_eint_chip_write_mask(eint_offsets, reg, pctl->wake_mask);
+
+	return 0;
+}
+
+static int mtk_eint_resume(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct mtk_pinctrl *pctl = platform_get_drvdata(pdev);
+	const struct mtk_eint_offsets *eint_offsets =
+		&pctl->devdata->eint_offsets;
+
+	mtk_eint_chip_write_mask(eint_offsets,
+		pctl->eint_reg_base, pctl->cur_mask);
 
 	return 0;
 }
 
+const struct dev_pm_ops mtk_eint_pm_ops = {
+	.suspend = mtk_eint_suspend,
+	.resume = mtk_eint_resume,
+};
+
 static void mtk_eint_ack(struct irq_data *d)
 {
 	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
@@ -1231,7 +1292,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node, *node;
 	struct property *prop;
 	struct resource *res;
-	int i, ret, irq;
+	int i, ret, irq, ports_buf;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
@@ -1333,6 +1394,17 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		goto chip_error;
 	}
 
+	ports_buf = ALIGN(pctl->devdata->eint_offsets.ports,
+			sizeof(long)/sizeof(u32));
+	pctl->wake_mask = devm_kcalloc(&pdev->dev, ports_buf * 2,
+					sizeof(*pctl->wake_mask), GFP_KERNEL);
+	if (!pctl->wake_mask) {
+		ret = -ENOMEM;
+		goto chip_error;
+	}
+
+	pctl->cur_mask = pctl->wake_mask + ports_buf;
+
 	pctl->eint_dual_edges = devm_kcalloc(&pdev->dev, pctl->devdata->ap_num,
 					     sizeof(int), GFP_KERNEL);
 	if (!pctl->eint_dual_edges) {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 30213e5..f1be8e8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -266,6 +266,8 @@ struct mtk_pinctrl {
 	void __iomem		*eint_reg_base;
 	struct irq_domain	*domain;
 	int			*eint_dual_edges;
+	u32 *wake_mask;
+	u32 *cur_mask;
 };
 
 int mtk_pctrl_init(struct platform_device *pdev,
@@ -281,4 +283,6 @@ int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
 		const struct mtk_pin_ies_smt_set *ies_smt_infos, unsigned int info_num,
 		unsigned int pin, unsigned char align, int value);
 
+extern const struct dev_pm_ops mtk_eint_pm_ops;
+
 #endif /* __PINCTRL_MTK_COMMON_H */
-- 
1.8.1.1.dirty
