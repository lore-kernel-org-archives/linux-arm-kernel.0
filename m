From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:30 -0700
Subject: [PATCH 31/34] clk: twl6040: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-32-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-twl6040.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 697c66757400..8f4c1af5fb92 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -30,7 +30,6 @@ struct twl6040_clk {
 	struct twl6040 *twl6040;
 	struct device *dev;
 	struct clk_hw mcpdm_fclk;
-	struct clk *clk;
 	int enabled;
 };
 
@@ -80,6 +79,7 @@ static int twl6040_clk_probe(struct platform_device *pdev)
 {
 	struct twl6040 *twl6040 = dev_get_drvdata(pdev->dev.parent);
 	struct twl6040_clk *clkdata;
+	int ret;
 
 	clkdata = devm_kzalloc(&pdev->dev, sizeof(*clkdata), GFP_KERNEL);
 	if (!clkdata)
@@ -89,9 +89,9 @@ static int twl6040_clk_probe(struct platform_device *pdev)
 	clkdata->twl6040 = twl6040;
 
 	clkdata->mcpdm_fclk.init = &wm831x_clkout_init;
-	clkdata->clk = devm_clk_register(&pdev->dev, &clkdata->mcpdm_fclk);
-	if (IS_ERR(clkdata->clk))
-		return PTR_ERR(clkdata->clk);
+	ret = devm_clk_hw_register(&pdev->dev, &clkdata->mcpdm_fclk);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, clkdata);
 
-- 
2.7.4
