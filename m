From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:08 -0700
Subject: [PATCH 09/34] clk: axi-clkgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-10-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-axi-clkgen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 3294db3b4e4e..5e918e7afaba 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -392,8 +392,8 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	const char *parent_names[2];
 	const char *clk_name;
 	struct resource *mem;
-	struct clk *clk;
 	unsigned int i;
+	int ret;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -433,12 +433,12 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	axi_clkgen_mmcm_enable(axi_clkgen, false);
 
 	axi_clkgen->clk_hw.init = &init;
-	clk = devm_clk_register(&pdev->dev, &axi_clkgen->clk_hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = devm_clk_hw_register(&pdev->dev, &axi_clkgen->clk_hw);
+	if (ret)
+		return ret;
 
-	return of_clk_add_provider(pdev->dev.of_node, of_clk_src_simple_get,
-				    clk);
+	return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_simple_get,
+				      &axi_clkgen->clk_hw);
 }
 
 static int axi_clkgen_remove(struct platform_device *pdev)
-- 
2.7.4
