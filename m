From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:24 -0700
Subject: [PATCH 25/34] clk: s2mps11: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-26-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Andi Shyti <andi.shyti@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-s2mps11.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index f8c83977c7fa..fbaa84a33c46 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -137,7 +137,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct s2mps11_clk *s2mps11_clks;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	unsigned int s2mps11_reg;
 	int i, ret = 0;
 	enum sec_device_type hwid = platform_get_device_id(pdev)->driver_data;
@@ -147,15 +147,12 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	if (!s2mps11_clks)
 		return -ENOMEM;
 
-	clk_data = devm_kzalloc(&pdev->dev, sizeof(*clk_data), GFP_KERNEL);
+	clk_data = devm_kzalloc(&pdev->dev, sizeof(*clk_data) +
+				sizeof(*clk_data->hws) * S2MPS11_CLKS_NUM,
+				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
-	clk_data->clks = devm_kcalloc(&pdev->dev, S2MPS11_CLKS_NUM,
-				sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks)
-		return -ENOMEM;
-
 	switch (hwid) {
 	case S2MPS11X:
 		s2mps11_reg = S2MPS11_REG_RTC_CTRL;
@@ -196,18 +193,18 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 			goto err_reg;
 		}
 
-		s2mps11_clks[i].lookup = clkdev_create(s2mps11_clks[i].clk,
+		s2mps11_clks[i].lookup = clkdev_hw_create(&s2mps11_clks[i].hw,
 					s2mps11_clks_init[i].name, NULL);
 		if (!s2mps11_clks[i].lookup) {
 			ret = -ENOMEM;
 			goto err_reg;
 		}
-		clk_data->clks[i] = s2mps11_clks[i].clk;
+		clk_data->hws[i] = &s2mps11_clks[i].hw;
 	}
 
-	clk_data->clk_num = S2MPS11_CLKS_NUM;
-	of_clk_add_provider(s2mps11_clks->clk_np, of_clk_src_onecell_get,
-			clk_data);
+	clk_data->num = S2MPS11_CLKS_NUM;
+	of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
+			       clk_data);
 
 	platform_set_drvdata(pdev, s2mps11_clks);
 
-- 
2.7.4
