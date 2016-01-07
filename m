From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Jan 2016 17:37:41 -0800
Subject: [PATCH v2 2/3] pinctrl: qcom: Use platform_irq_count() instead of
 of_irq_count()
In-Reply-To: <CAJAp7OhNxTzsRSq7MHfBCbp3F+vaw6tS99eMBw8FbWLunudiKQ@mail.gmail.com>
References: <CAJAp7OhNxTzsRSq7MHfBCbp3F+vaw6tS99eMBw8FbWLunudiKQ@mail.gmail.com>
Message-ID: <1452130661-13157-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_count() is not an exported symbol (and it shouldn't be
used by platform drivers anyway) so use platform_irq_count()
instead. This allows us to make the qcom pinctrl drivers modular
again.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn@kryo.se>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * Fixed one wrong of_irq_count() noticed by Bjorn

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 4 +++-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 4 +++-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 9 ++++++---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 9 ++++++---
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index f46dbbf7ff25..4e12ded3c773 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -697,9 +697,11 @@ static int pmic_gpio_probe(struct platform_device *pdev)
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
index 5c7935012e3a..2f18323571a6 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -799,9 +799,11 @@ static int pmic_mpp_probe(struct platform_device *pdev)
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
index f75e482073b7..cd8580d9741d 100644
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
index 3e19c12a315a..54a5402a9079 100644
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
+	npins = platform_irq_count(pdev);
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
