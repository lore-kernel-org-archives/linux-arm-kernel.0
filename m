From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 20 Mar 2015 11:51:19 +0530
Subject: [PATCH v3 2/6] clk: qcom: gdsc: Prepare common clk probe to register
 gdscs
In-Reply-To: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
References: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1426832483-27026-3-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clk probe registers a clk provider and a reset controller.
Update it to register a genpd provider using the gdsc data provided
by each platform.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c | 14 +++++++++++++-
 drivers/clk/qcom/common.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index a946b48..0c9fbc7 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -21,6 +21,7 @@
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
+#include "gdsc.h"
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
@@ -125,8 +126,18 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 
 	ret = reset_controller_register(&reset->rcdev);
 	if (ret)
-		of_clk_del_provider(dev->of_node);
+		goto err_reset;
 
+	ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs, regmap);
+	if (ret)
+		goto err_pd;
+
+	return 0;
+err_pd:
+	dev_err(dev, "Failed to register power domains\n");
+	reset_controller_unregister(&reset->rcdev);
+err_reset:
+	of_clk_del_provider(dev->of_node);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
@@ -145,6 +156,7 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
 void qcom_cc_remove(struct platform_device *pdev)
 {
+	gdsc_unregister(&pdev->dev);
 	of_clk_del_provider(pdev->dev.of_node);
 	reset_controller_unregister(platform_get_drvdata(pdev));
 }
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index b3d7e57..480fdbe 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -27,6 +27,8 @@ struct qcom_cc_desc {
 	size_t num_clks;
 	const struct qcom_reset_map *resets;
 	size_t num_resets;
+	struct gdsc **gdscs;
+	size_t num_gdscs;
 };
 
 extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
