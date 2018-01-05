From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:11 -0600
Subject: [PATCH 6/7] clk: st: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-7-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function clk_alloc_onecell_data() to allocate struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/st/clk-flexgen.c | 17 +++++------------
 drivers/clk/st/clkgen-fsyn.c | 11 +----------
 drivers/clk/st/clkgen-pll.c  | 12 ++----------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 918ba31..29ff00d 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -310,7 +310,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 {
 	struct device_node *pnode;
 	void __iomem *reg;
-	struct clk_onecell_data *clk_data;
+	struct clk_onecell_data *clk_data = NULL;
 	const char **parents;
 	int num_parents, i;
 	spinlock_t *rlock = NULL;
@@ -341,21 +341,15 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 		clk_mode = data->mode;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err;
-
 	ret = of_property_count_strings(np, "clock-output-names");
 	if (ret <= 0) {
 		pr_err("%s: Failed to get number of output clocks (%d)",
-				__func__, clk_data->clk_num);
+				__func__, ret);
 		goto err;
 	}
-	clk_data->clk_num = ret;
 
-	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
-			GFP_KERNEL);
-	if (!clk_data->clks)
+	clk_data = clk_alloc_onecell_data(ret);
+	if (!clk_data)
 		goto err;
 
 	rlock = kzalloc(sizeof(spinlock_t), GFP_KERNEL);
@@ -397,8 +391,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 
 err:
 	iounmap(reg);
-	if (clk_data)
-		kfree(clk_data->clks);
+	clk_free_onecell_data(clk_data);
 	kfree(clk_data);
 	kfree(parents);
 	kfree(rlock);
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 14819d9..48e6bff 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -869,19 +869,10 @@ static void __init st_of_create_quadfs_fsynths(
 	struct clk_onecell_data *clk_data;
 	int fschan;
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(QUADFS_MAX_CHAN);
 	if (!clk_data)
 		return;
 
-	clk_data->clk_num = QUADFS_MAX_CHAN;
-	clk_data->clks = kzalloc(QUADFS_MAX_CHAN * sizeof(struct clk *),
-				 GFP_KERNEL);
-
-	if (!clk_data->clks) {
-		kfree(clk_data);
-		return;
-	}
-
 	for (fschan = 0; fschan < QUADFS_MAX_CHAN; fschan++) {
 		struct clk *clk;
 		const char *clk_name;
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 25bda48..07795ee 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -733,17 +733,10 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 
 	num_odfs = data->num_odfs;
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(num_odfs);
 	if (!clk_data)
 		return;
 
-	clk_data->clk_num = num_odfs;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
-				 GFP_KERNEL);
-
-	if (!clk_data->clks)
-		goto err;
-
 	for (odf = 0; odf < num_odfs; odf++) {
 		struct clk *clk;
 		const char *clk_name;
@@ -768,8 +761,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 
 err:
 	kfree(pll_name);
-	kfree(clk_data->clks);
-	kfree(clk_data);
+	clk_free_onecell_data(clk_data);
 }
 static void __init clkgen_c32_pll0_setup(struct device_node *np)
 {
-- 
2.7.4
