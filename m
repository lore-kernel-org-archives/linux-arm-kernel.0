From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 16:22:53 +0200
Subject: [RFC PATCH 2/6] pinctrl: samsung: Hold pointer to driver data in bank
 struct
In-Reply-To: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
References: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348237377-21299-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer will be used by further extensions added to the driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 33 +++++++++++++++++----------------
 drivers/pinctrl/pinctrl-samsung.h |  2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 846b277..3f48d3f 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -844,11 +844,11 @@ static int samsung_pinctrl_parse_dt_bank(struct samsung_pin_bank *bank,
 
 /* retrieve the soc specific data */
 static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
-				struct platform_device *pdev)
+					struct samsung_pinctrl_drv_data *d)
 {
 	int id;
 	const struct of_device_id *match;
-	const struct device_node *node = pdev->dev.of_node;
+	struct device_node *node = d->dev->of_node;
 	struct device_node *bank_np;
 	struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *banks, *b;
@@ -858,9 +858,9 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	u32 val;
 	int ret;
 
-	id = of_alias_get_id(pdev->dev.of_node, "pinctrl");
+	id = of_alias_get_id(node, "pinctrl");
 	if (id < 0) {
-		dev_err(&pdev->dev, "failed to get alias id\n");
+		dev_err(d->dev, "failed to get alias id\n");
 		return NULL;
 	}
 	match = of_match_node(samsung_pinctrl_dt_match, node);
@@ -873,20 +873,20 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 	}
 
 	if (!bank_cnt) {
-		dev_err(&pdev->dev, "no pin banks specified\n");
+		dev_err(d->dev, "no pin banks specified\n");
 		return NULL;
 	}
 
-	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	ctrl = devm_kzalloc(d->dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
-		dev_err(&pdev->dev, "failed to allocate soc data\n");
+		dev_err(d->dev, "failed to allocate soc data\n");
 		return NULL;
 	}
 
-	banks = devm_kzalloc(&pdev->dev,
+	banks = devm_kzalloc(d->dev,
 			bank_cnt * sizeof(*ctrl->pin_banks), GFP_KERNEL);
 	if (!banks) {
-		dev_err(&pdev->dev, "failed to allocate pin banks\n");
+		dev_err(d->dev, "failed to allocate pin banks\n");
 		return NULL;
 	}
 
@@ -896,6 +896,7 @@ static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 			continue;
 		if (samsung_pinctrl_parse_dt_bank(b, bank_np))
 			return NULL;
+		b->drvdata = d;
 		b->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += b->nr_pins;
 		if (of_find_property(bank_np, "interrupt-controller", NULL)) {
@@ -956,21 +957,21 @@ static int __devinit samsung_pinctrl_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ctrl = samsung_pinctrl_get_soc_data(pdev);
-	if (!ctrl) {
-		dev_err(&pdev->dev, "driver data not available\n");
-		return -EINVAL;
-	}
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
 		dev_err(dev, "failed to allocate memory for driver's "
 				"private data\n");
 		return -ENOMEM;
 	}
-	drvdata->ctrl = ctrl;
 	drvdata->dev = dev;
 
+	ctrl = samsung_pinctrl_get_soc_data(drvdata);
+	if (!ctrl) {
+		dev_err(&pdev->dev, "driver data not available\n");
+		return -EINVAL;
+	}
+	drvdata->ctrl = ctrl;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "cannot find IO resource\n");
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index b7b74cc..9e30081 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -112,6 +112,7 @@ struct samsung_pinctrl_drv_data;
  * @irq_base: starting controller local irq number of the bank.
  * @name: name to be prefixed for each pin in this pin bank.
  * @of_node: node of pin bank in device tree
+ * @drvdata: link to controller driver data
  */
 struct samsung_pin_bank {
 	u32		pctl_offset;
@@ -128,6 +129,7 @@ struct samsung_pin_bank {
 	const char	*name;
 
 	struct device_node *of_node;
+	struct samsung_pinctrl_drv_data *drvdata;
 };
 
 /**
-- 
1.7.12
