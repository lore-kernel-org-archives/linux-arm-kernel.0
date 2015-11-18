From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Nov 2015 11:33:17 -0800
Subject: [PATCH] pinctrl: qcom: pmic-gpio/mpp: of_irq_count() == npins
In-Reply-To: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447875197-21645-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of interrupts is always equal to the number of pins
provided by the PMIC gpio and MPP hardware blocks. Count the
number of irqs to figure out the number of pins instead of adding
more compatible strings or doing math on the reg property. This
should make the code more generic and ease the number of changes
we have to make to the driver for each new pmic revision.

Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Stephen Boyd wrote:
> We can also figure out the number of the pins from the number
> of interrupts, so we really don't need to even look at the size of the
> reg property or model number for the spmi and ssbi modules. I'll propose
> that change as well tomorrow.

And here's that change. It can be squashed together if desired.

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 12 ++++++------
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 11 ++++++-----
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 16 ++++++++++------
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 16 ++++++++++------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 9f9979903fcb..cceda6afe280 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -14,6 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinmux.h>
@@ -693,16 +694,15 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	struct pmic_gpio_pad *pad, *pads;
 	struct pmic_gpio_state *state;
 	int ret, npins, i;
-	u32 res[2];
+	u32 reg;
 
-	ret = of_property_read_u32_array(dev->of_node, "reg", res, 2);
+	ret = of_property_read_u32(dev->of_node, "reg", &reg);
 	if (ret < 0) {
-		dev_err(dev, "missing base address and/or range");
+		dev_err(dev, "missing base address");
 		return ret;
 	}
 
-	npins = res[1] / PMIC_GPIO_ADDRESS_RANGE;
-
+	npins = of_irq_count(dev->of_node);
 	if (!npins)
 		return -EINVAL;
 
@@ -752,7 +752,7 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		if (pad->irq < 0)
 			return pad->irq;
 
-		pad->base = res[0] + i * PMIC_GPIO_ADDRESS_RANGE;
+		pad->base = reg + i * PMIC_GPIO_ADDRESS_RANGE;
 
 		ret = pmic_gpio_populate(state, pad);
 		if (ret < 0)
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 5a4373dd9c61..b45123066669 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -14,6 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinmux.h>
@@ -795,15 +796,15 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 	struct pmic_mpp_pad *pad, *pads;
 	struct pmic_mpp_state *state;
 	int ret, npins, i;
-	u32 res[2];
+	u32 reg;
 
-	ret = of_property_read_u32_array(dev->of_node, "reg", res, 2);
+	ret = of_property_read_u32(dev->of_node, "reg", &reg);
 	if (ret < 0) {
-		dev_err(dev, "missing base address and/or range");
+		dev_err(dev, "missing base address");
 		return ret;
 	}
 
-	npins = res[1] / PMIC_MPP_ADDRESS_RANGE;
+	npins = of_irq_count(dev->of_node);
 	if (!npins)
 		return -EINVAL;
 
@@ -854,7 +855,7 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 		if (pad->irq < 0)
 			return pad->irq;
 
-		pad->base = res[0] + i * PMIC_MPP_ADDRESS_RANGE;
+		pad->base = reg + i * PMIC_MPP_ADDRESS_RANGE;
 
 		ret = pmic_mpp_populate(state, pad);
 		if (ret < 0)
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index d809c9eaa323..78fa2281116d 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
@@ -650,11 +651,12 @@ static int pm8xxx_pin_populate(struct pm8xxx_gpio *pctrl,
 }
 
 static const struct of_device_id pm8xxx_gpio_of_match[] = {
-	{ .compatible = "qcom,pm8018-gpio", .data = (void *)6 },
-	{ .compatible = "qcom,pm8038-gpio", .data = (void *)12 },
-	{ .compatible = "qcom,pm8058-gpio", .data = (void *)40 },
-	{ .compatible = "qcom,pm8917-gpio", .data = (void *)38 },
-	{ .compatible = "qcom,pm8921-gpio", .data = (void *)44 },
+	{ .compatible = "qcom,pm8018-gpio" },
+	{ .compatible = "qcom,pm8038-gpio" },
+	{ .compatible = "qcom,pm8058-gpio" },
+	{ .compatible = "qcom,pm8917-gpio" },
+	{ .compatible = "qcom,pm8921-gpio" },
+	{ .compatible = "qcom,ssbi-gpio" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_gpio_of_match);
@@ -672,7 +674,9 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pctrl->dev = &pdev->dev;
-	pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
+	pctrl->npins = of_irq_count(pdev->dev.of_node);
+	if (!pctrl->npins)
+		return -EINVAL;
 
 	pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pctrl->regmap) {
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 8982027de8e8..0831063da54c 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 
@@ -741,11 +742,12 @@ static int pm8xxx_pin_populate(struct pm8xxx_mpp *pctrl,
 }
 
 static const struct of_device_id pm8xxx_mpp_of_match[] = {
-	{ .compatible = "qcom,pm8018-mpp", .data = (void *)6 },
-	{ .compatible = "qcom,pm8038-mpp", .data = (void *)6 },
-	{ .compatible = "qcom,pm8917-mpp", .data = (void *)10 },
-	{ .compatible = "qcom,pm8821-mpp", .data = (void *)4 },
-	{ .compatible = "qcom,pm8921-mpp", .data = (void *)12 },
+	{ .compatible = "qcom,pm8018-mpp" },
+	{ .compatible = "qcom,pm8038-mpp" },
+	{ .compatible = "qcom,pm8917-mpp" },
+	{ .compatible = "qcom,pm8821-mpp" },
+	{ .compatible = "qcom,pm8921-mpp" },
+	{ .compatible = "qcom,ssbi-mpp" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_mpp_of_match);
@@ -763,7 +765,9 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pctrl->dev = &pdev->dev;
-	pctrl->npins = (unsigned)of_device_get_match_data(&pdev->dev);
+	pctrl->npins = of_irq_count(pdev->dev.of_node);
+	if (!pctrl->npins)
+		return -EINVAL;
 
 	pctrl->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pctrl->regmap) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
