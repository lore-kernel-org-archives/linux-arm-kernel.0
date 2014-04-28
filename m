From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:40 -0700
Subject: [PATCH 14/15] pinctrl: sunxi: Move the reset handling functions out
 of the core
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way that reset is handled right now is that it is made optional for every
pinctrl driver, while actually, it isn't used at all for the older Allwinner
SoCs, and it's mandatory for the A31 and the upcoming A23.

Move the reset functions out of the core and in the drivers, where they can be
made mandatory.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 23 +++++++++++++++++++++--
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 23 +++++++++++++++++++++--
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 16 ++--------------
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index b896f7ba606e..8fcba48e0a42 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
@@ -96,8 +97,26 @@ static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
 
 static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
 {
-	return sunxi_pinctrl_init(pdev,
-				  &sun6i_a31_r_pinctrl_data);
+	struct reset_control *rstc;
+	int ret;
+
+	rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(rstc)) {
+		dev_err(&pdev->dev, "Reset controller missing\n");
+		return PTR_ERR(rstc);
+	}
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pinctrl_init(pdev,
+				 &sun6i_a31_r_pinctrl_data);
+
+	if (ret)
+		reset_control_assert(rstc);
+
+	return ret;
 }
 
 static struct of_device_id sun6i_a31_r_pinctrl_match[] = {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 8dea5856458b..6683007b2251 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
 
 #include "pinctrl-sunxi.h"
 
@@ -840,8 +841,26 @@ static const struct sunxi_pinctrl_desc sun6i_a31_pinctrl_data = {
 
 static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
 {
-	return sunxi_pinctrl_init(pdev,
-				  &sun6i_a31_pinctrl_data);
+	struct reset_control *rstc;
+	int ret;
+
+	rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(rstc)) {
+		dev_err(&pdev->dev, "Reset controller missing\n");
+		return PTR_ERR(rstc);
+	}
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pinctrl_init(pdev,
+				 &sun6i_a31_pinctrl_data);
+
+	if (ret)
+		reset_control_assert(rstc);
+
+	return ret;
 }
 
 static struct of_device_id sun6i_a31_pinctrl_match[] = {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 2c3fb92b8972..f6522b54ece9 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -26,7 +26,6 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include "../core.h"
@@ -781,7 +780,6 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	struct device_node *node = pdev->dev.of_node;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
-	struct reset_control *rstc;
 	struct resource *res;
 	int i, ret, last_pin;
 	struct clk *clk;
@@ -875,17 +873,10 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	if (ret)
 		goto gpiochip_error;
 
-	rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
-	if (!IS_ERR(rstc)) {
-		ret = reset_control_deassert(rstc);
-		if (ret)
-			goto clk_error;
-	}
-
 	pctl->irq = irq_of_parse_and_map(node, 0);
 	if (!pctl->irq) {
 		ret = -EINVAL;
-		goto rstc_error;
+		goto clk_error;
 	}
 
 	pctl->domain = irq_domain_add_linear(node, SUNXI_IRQ_NUMBER,
@@ -893,7 +884,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto rstc_error;
+		goto clk_error;
 	}
 
 	for (i = 0; i < SUNXI_IRQ_NUMBER; i++) {
@@ -911,9 +902,6 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 
 	return 0;
 
-rstc_error:
-	if (!IS_ERR(rstc))
-		reset_control_assert(rstc);
 clk_error:
 	clk_disable_unprepare(clk);
 gpiochip_error:
-- 
1.9.1
