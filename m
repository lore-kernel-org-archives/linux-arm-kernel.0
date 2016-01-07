From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Jan 2016 17:12:48 -0800
Subject: [PATCH 2/3] pinctrl: qcom: Use platform_irq_count() instead of
 of_irq_count()
In-Reply-To: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1452129169-2014-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_count() is not an exported symbol (and it shouldn't be
used by platform drivers anyway) so use platform_irq_count()
instead. This allows us to make the qcom pinctrl drivers modular
again.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 4 +++-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 4 +++-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 9 ++++++---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 9 ++++++---
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 60b922274879..9ed2b4eba1f8 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -702,9 +702,11 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	npins = of_irq_count(dev->of_node);
+	npins = platform_irq_count(pdev);
 	if (!npins)
 		return -EINVAL;
+	if (npins < 0)
+		return npins;
 
 	BUG_ON(npins > ARRAY_SIZE(pmic_gpio_groups));
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 5654287c382c..3fd04a6888a4 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -804,9 +804,11 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	npins = of_irq_count(dev->of_node);
+	npins = platform_irq_count(pdev);
 	if (!npins)
 		return -EINVAL;
+	if (npins < 0)
+		return npins;
 
 	BUG_ON(npins > ARRAY_SIZE(pmic_mpp_groups));
 
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index df054e716dc0..bde2aa684dc1 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -667,16 +667,19 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct pm8xxx_gpio *pctrl;
 	int ret;
-	int i;
+	int i, npins;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
 	pctrl->dev = &pdev->dev;
-	pctrl->npins = of_irq_count(pdev->dev.of_node);
-	if (!pctrl->npins)
+	npins = platform_irq_count(pdev);
+	if (!npins)
 		return -EINVAL;
+	if (npins < 0)
+		return npins;
+	pctrl->npins = npins;
 
 	pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pctrl->regmap) {
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 3ddb4cc38f1c..37ae6b72ea35 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -758,16 +758,19 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct pm8xxx_mpp *pctrl;
 	int ret;
-	int i;
+	int i, npins;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
 	pctrl->dev = &pdev->dev;
-	pctrl->npins = of_irq_count(pdev->dev.of_node);
-	if (!pctrl->npins)
+	npins = of_irq_count(pdev->dev.of_node);
+	if (!npins)
 		return -EINVAL;
+	if (npins < 0)
+		return npins;
+	pctrl->npins = npins;
 
 	pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pctrl->regmap) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
