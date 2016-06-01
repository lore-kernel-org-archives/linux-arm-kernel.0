From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:22 -0700
Subject: [PATCH 23/34] clk: pwm: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-24-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-pwm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 1630a1f085f7..8cb9d117fdbf 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -61,7 +61,6 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	struct pwm_device *pwm;
 	struct pwm_args pargs;
 	const char *clk_name;
-	struct clk *clk;
 	int ret;
 
 	clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
@@ -107,11 +106,11 @@ static int clk_pwm_probe(struct platform_device *pdev)
 
 	clk_pwm->pwm = pwm;
 	clk_pwm->hw.init = &init;
-	clk = devm_clk_register(&pdev->dev, &clk_pwm->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = devm_clk_hw_register(&pdev->dev, &clk_pwm->hw);
+	if (ret)
+		return ret;
 
-	return of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return of_clk_add_hw_provider(node, of_clk_hw_simple_get, &clk_pwm->hw);
 }
 
 static int clk_pwm_remove(struct platform_device *pdev)
-- 
2.7.4
