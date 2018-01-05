From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:08 -0600
Subject: [PATCH 3/7] clk: qoriq: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function clk_alloc_onecell_data() to allocate struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/clk-qoriq.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..5278cc7 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1175,13 +1175,11 @@ static void __init legacy_pll_init(struct device_node *np, int idx)
 	count = of_property_count_strings(np, "clock-output-names");
 
 	BUILD_BUG_ON(ARRAY_SIZE(pll->div) < 4);
-	subclks = kcalloc(4, sizeof(struct clk *), GFP_KERNEL);
-	if (!subclks)
+	onecell_data = clk_alloc_onecell_data(4);
+	if (!onecell_data)
 		return;
 
-	onecell_data = kmalloc(sizeof(*onecell_data), GFP_KERNEL);
-	if (!onecell_data)
-		goto err_clks;
+	subclks = onecell_data->clks;
 
 	if (count <= 3) {
 		subclks[0] = pll->div[0].clk;
@@ -1194,7 +1192,6 @@ static void __init legacy_pll_init(struct device_node *np, int idx)
 		subclks[3] = pll->div[3].clk;
 	}
 
-	onecell_data->clks = subclks;
 	onecell_data->clk_num = count;
 
 	rc = of_clk_add_provider(np, of_clk_src_onecell_get, onecell_data);
@@ -1206,9 +1203,7 @@ static void __init legacy_pll_init(struct device_node *np, int idx)
 
 	return;
 err_cell:
-	kfree(onecell_data);
-err_clks:
-	kfree(subclks);
+	clk_free_onecell_data(onecell_data);
 }
 
 /* Legacy node */
-- 
2.7.4
