From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 21 Mar 2014 13:40:03 +0100
Subject: [PATCH-next 2/2] clk: s2mps11: Remove useless check for clk_table
In-Reply-To: <1395405603-11772-1-git-send-email-k.kozlowski@samsung.com>
References: <1395405603-11772-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1395405603-11772-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for checking if 'clk_table' is not NULL twice (first
after allocation and second at the end of probe()). Also move allocation
of this 'clk_table' to probe from s2mps11_clk_parse_dt as this is
logical place for it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-s2mps11.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 843ec3646501..23ffd89c4023 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -141,11 +141,6 @@ static struct device_node *s2mps11_clk_parse_dt(struct platform_device *pdev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	clk_table = devm_kzalloc(&pdev->dev, sizeof(struct clk *) *
-				 S2MPS11_CLKS_NUM, GFP_KERNEL);
-	if (!clk_table)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < S2MPS11_CLKS_NUM; i++)
 		of_property_read_string_index(clk_np, "clock-output-names", i,
 				&s2mps11_clks_init[i].name);
@@ -168,6 +163,11 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 
 	s2mps11_clk = s2mps11_clks;
 
+	clk_table = devm_kzalloc(&pdev->dev, sizeof(struct clk *) *
+				 S2MPS11_CLKS_NUM, GFP_KERNEL);
+	if (!clk_table)
+		return -ENOMEM;
+
 	/* Store clocks of_node in first element of s2mps11_clks array */
 	s2mps11_clks->clk_np = s2mps11_clk_parse_dt(pdev);
 	if (IS_ERR(s2mps11_clks->clk_np))
@@ -220,15 +220,13 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		clkdev_add(s2mps11_clk->lookup);
 	}
 
-	if (clk_table) {
-		for (i = 0; i < S2MPS11_CLKS_NUM; i++)
-			clk_table[i] = s2mps11_clks[i].clk;
+	for (i = 0; i < S2MPS11_CLKS_NUM; i++)
+		clk_table[i] = s2mps11_clks[i].clk;
 
-		clk_data.clks = clk_table;
-		clk_data.clk_num = S2MPS11_CLKS_NUM;
-		of_clk_add_provider(s2mps11_clks->clk_np,
-				of_clk_src_onecell_get, &clk_data);
-	}
+	clk_data.clks = clk_table;
+	clk_data.clk_num = S2MPS11_CLKS_NUM;
+	of_clk_add_provider(s2mps11_clks->clk_np, of_clk_src_onecell_get,
+			&clk_data);
 
 	platform_set_drvdata(pdev, s2mps11_clks);
 
-- 
1.7.9.5
