From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 19 Mar 2015 13:32:21 +0530
Subject: [PATCH v2 2/6] clk: qcom: gdsc: Prepare common clk probe to register
 gdscs
In-Reply-To: <1426752145-4365-1-git-send-email-rnayak@codeaurora.org>
References: <1426752145-4365-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1426752145-4365-3-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clk probe registers a clk provider and a reset controller.
Update it to register a genpd provider using the gdsc data provided
by each platform.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/common.c | 14 +++++++++++++-
 drivers/clk/qcom/common.h |  2 ++
 drivers/clk/qcom/gdsc.c   | 34 +++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/gdsc.h   |  9 ++++++++-
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index a946b48..cc9f56f 100644
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
+	of_genpd_del_provider(pdev->dev.of_node);
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
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 4c89312..7de9a00 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
@@ -100,7 +101,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return gdsc_toggle_logic(sc, false);
 }
 
-int gdsc_init(struct gdsc *sc)
+static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
 	int on, ret;
@@ -127,3 +128,34 @@ int gdsc_init(struct gdsc *sc)
 
 	return 0;
 }
+
+int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
+		  struct regmap *regmap)
+{
+	int i, ret;
+	struct genpd_onecell_data *data;
+
+	if (!num || !scs || !dev || !dev->of_node)
+		return 0;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kzalloc(dev, sizeof(*data->domains) * num,
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	data->num_domains = num;
+	for (i = 0; i < num; i++) {
+		if (!scs[i])
+			continue;
+		scs[i]->regmap = regmap;
+		ret = gdsc_init(scs[i]);
+		if (ret)
+			return ret;
+		data->domains[i] = &scs[i]->pd;
+	}
+	return of_genpd_add_provider_onecell(dev->of_node, data);
+}
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index ac6a2d5..14de304 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -32,5 +32,12 @@ struct gdsc {
 
 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
 
-int gdsc_init(struct generic_pm_domain *domain, struct regmap *regmap);
+#ifdef CONFIG_QCOM_GDSC
+int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
+#else
+int gdsc_register(struct device *d, struct gdsc **g, size_t n, struct regmap *r)
+{
+	return 0;
+}
+#endif /* CONFIG_QCOM_GDSC */
 #endif /* __QCOM_GDSC_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
