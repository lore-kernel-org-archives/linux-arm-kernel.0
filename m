From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon,  2 Mar 2015 12:32:25 +0530
Subject: [PATCH 2/6] clk: qcom: gdsc: Prepare common clk probe to register
 gdscs
In-Reply-To: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
References: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1425279749-16625-3-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clk probe registers a clk provider and a reset controller.
Update it to register a genpd provider using the gdsc data provided
by each platform.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c | 27 ++++++++++++++++++++++++++-
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index e20d947..d5b65fa 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -21,10 +21,12 @@
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
+#include "gdsc.h"
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_onecell_data data;
+	struct genpd_onecell_data pd_data;
 	struct clk *clks[];
 };
 
@@ -66,10 +68,12 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	struct clk_onecell_data *data;
+	struct genpd_onecell_data *pd;
 	struct clk **clks;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
 	size_t num_clks = desc->num_clks;
+	size_t num_gdscs = desc->num_gdscs;
 	struct clk_regmap **rclks = desc->clks;
 
 	cc = devm_kzalloc(dev, sizeof(*cc) + sizeof(*clks) * num_clks,
@@ -79,8 +83,11 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	clks = cc->clks;
 	data = &cc->data;
+	pd = &cc->pd_data;
 	data->clks = clks;
 	data->clk_num = num_clks;
+	pd->domains = desc->gdscs;
+	pd->num_domains = num_gdscs;
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rclks[i]) {
@@ -108,8 +115,25 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	ret = reset_controller_register(&reset->rcdev);
 	if (ret)
-		of_clk_del_provider(dev->of_node);
+		goto err_reset;
 
+	if (num_gdscs) {
+		for (i = 0; i < num_gdscs; i++) {
+			if (!desc->gdscs[i])
+				continue;
+			gdsc_init(desc->gdscs[i], regmap);
+		}
+
+		ret = of_genpd_add_provider_onecell(dev->of_node, pd);
+		if (ret)
+			goto err_pd;
+	}
+
+	return 0;
+err_pd:
+	reset_controller_unregister(&reset->rcdev);
+err_reset:
+	of_clk_del_provider(dev->of_node);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
@@ -128,6 +152,7 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
 void qcom_cc_remove(struct platform_device *pdev)
 {
+	of_genpd_del_provider(pdev->dev.of_node);
 	of_clk_del_provider(pdev->dev.of_node);
 	reset_controller_unregister(platform_get_drvdata(pdev));
 }
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index f519322..55e69c5 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -26,6 +26,8 @@ struct qcom_cc_desc {
 	size_t num_clks;
 	const struct qcom_reset_map *resets;
 	size_t num_resets;
+	struct generic_pm_domain **gdscs;
+	size_t num_gdscs;
 };
 
 extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
