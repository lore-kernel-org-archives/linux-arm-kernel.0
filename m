From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:33 -0700
Subject: [PATCH 34/34] clk: wm831x: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-35-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-wm831x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 88def4b2761c..f4fdac55727c 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -24,9 +24,6 @@ struct wm831x_clk {
 	struct clk_hw xtal_hw;
 	struct clk_hw fll_hw;
 	struct clk_hw clkout_hw;
-	struct clk *xtal;
-	struct clk *fll;
-	struct clk *clkout;
 	bool xtal_ena;
 };
 
@@ -370,19 +367,19 @@ static int wm831x_clk_probe(struct platform_device *pdev)
 	clkdata->xtal_ena = ret & WM831X_XTAL_ENA;
 
 	clkdata->xtal_hw.init = &wm831x_xtal_init;
-	clkdata->xtal = devm_clk_register(&pdev->dev, &clkdata->xtal_hw);
-	if (IS_ERR(clkdata->xtal))
-		return PTR_ERR(clkdata->xtal);
+	ret = devm_clk_hw_register(&pdev->dev, &clkdata->xtal_hw);
+	if (ret)
+		return ret;
 
 	clkdata->fll_hw.init = &wm831x_fll_init;
-	clkdata->fll = devm_clk_register(&pdev->dev, &clkdata->fll_hw);
-	if (IS_ERR(clkdata->fll))
-		return PTR_ERR(clkdata->fll);
+	ret = devm_clk_hw_register(&pdev->dev, &clkdata->fll_hw);
+	if (ret)
+		return ret;
 
 	clkdata->clkout_hw.init = &wm831x_clkout_init;
-	clkdata->clkout = devm_clk_register(&pdev->dev, &clkdata->clkout_hw);
-	if (IS_ERR(clkdata->clkout))
-		return PTR_ERR(clkdata->clkout);
+	ret = devm_clk_hw_register(&pdev->dev, &clkdata->clkout_hw);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, clkdata);
 
-- 
2.7.4
