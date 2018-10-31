From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Wed, 31 Oct 2018 10:31:48 +0200
Subject: [PATCH 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
In-Reply-To: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <f1d3f6d26c2731050b4be90c32397c62e4dc31a8.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm variant of clkdev lookup registration in order to avoid
clkdev lookup leak at device remove.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 0d92f3e5e3d9..07798debfec4 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -309,16 +309,17 @@ static int s3c24xx_dclk_probe(struct platform_device *pdev)
 			goto err_clk_register;
 		}
 
-	ret = clk_hw_register_clkdev(clk_table[MUX_DCLK0], "dclk0", NULL);
+	ret = devm_clk_hw_register_clkdev(&pdev->dev, clk_table[MUX_DCLK0],
+					  "dclk0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_DCLK1], "dclk1",
-					     NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_DCLK1], "dclk1", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT0],
-					     "clkout0", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT0], "clkout0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT1],
-					     "clkout1", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT1], "clkout1", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register aliases, %d\n", ret);
 		goto err_clk_register;
-- 
2.14.3
