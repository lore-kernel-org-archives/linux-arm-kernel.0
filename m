From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 10 Aug 2018 15:21:05 +0530
Subject: [PATCH v3 1/9] clk: actions: Cache regmap info in private clock
 descriptor
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180810095113.25292-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the reset controller, regmap info needs to
be cached in the private clock descriptor, owl_clk_desc. Hence,
save that and also make the clock descriptor struct non const.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-common.c | 3 ++-
 drivers/clk/actions/owl-common.h | 3 ++-
 drivers/clk/actions/owl-s700.c   | 4 ++--
 drivers/clk/actions/owl-s900.c   | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 61c1071b5180..32dd29e0a37e 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -39,7 +39,7 @@ static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 }
 
 int owl_clk_regmap_init(struct platform_device *pdev,
-			 const struct owl_clk_desc *desc)
+			struct owl_clk_desc *desc)
 {
 	void __iomem *base;
 	struct regmap *regmap;
@@ -57,6 +57,7 @@ int owl_clk_regmap_init(struct platform_device *pdev,
 	}
 
 	owl_clk_set_regmap(desc, regmap);
+	desc->regmap = regmap;
 
 	return 0;
 }
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 4fd726ec54a6..56f01f7774aa 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -26,6 +26,7 @@ struct owl_clk_desc {
 	struct owl_clk_common		**clks;
 	unsigned long			num_clks;
 	struct clk_hw_onecell_data	*hw_clks;
+	struct regmap			*regmap;
 };
 
 static inline struct owl_clk_common *
@@ -35,7 +36,7 @@ static inline struct owl_clk_common *
 }
 
 int owl_clk_regmap_init(struct platform_device *pdev,
-			 const struct owl_clk_desc *desc);
+			struct owl_clk_desc *desc);
 int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks);
 
 #endif /* _OWL_COMMON_H_ */
diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index 5e9531392ee5..e7cacd677275 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -569,7 +569,7 @@ static struct clk_hw_onecell_data s700_hw_clks = {
 		.num    = CLK_NR_CLKS,
 };
 
-static const struct owl_clk_desc s700_clk_desc = {
+static struct owl_clk_desc s700_clk_desc = {
 	.clks       = s700_clks,
 	.num_clks   = ARRAY_SIZE(s700_clks),
 
@@ -578,7 +578,7 @@ static const struct owl_clk_desc s700_clk_desc = {
 
 static int s700_clk_probe(struct platform_device *pdev)
 {
-	const struct owl_clk_desc *desc;
+	struct owl_clk_desc *desc;
 
 	desc = &s700_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
index 7f60ed6afe63..bb7ee872d316 100644
--- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -684,7 +684,7 @@ static struct clk_hw_onecell_data s900_hw_clks = {
 	.num	= CLK_NR_CLKS,
 };
 
-static const struct owl_clk_desc s900_clk_desc = {
+static struct owl_clk_desc s900_clk_desc = {
 	.clks	    = s900_clks,
 	.num_clks   = ARRAY_SIZE(s900_clks),
 
@@ -693,7 +693,7 @@ static const struct owl_clk_desc s900_clk_desc = {
 
 static int s900_clk_probe(struct platform_device *pdev)
 {
-	const struct owl_clk_desc *desc;
+	struct owl_clk_desc *desc;
 
 	desc = &s900_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
-- 
2.17.1
