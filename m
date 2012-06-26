From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:58:10 +0800
Subject: [PATCH 3/4] pwm: pwm-mxs: use devm_* managed functions
In-Reply-To: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
References: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340701091-8488-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_* managed functions to have a clean fail-out.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/pwm-mxs.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 7a97997..bbda509 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -129,21 +129,21 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_pwm_chip *mxs;
+	struct resource *res;
 	int ret;
 
 	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
 	if (!mxs)
 		return -ENOMEM;
 
-	mxs->base = of_iomap(np, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mxs->base = devm_request_and_ioremap(&pdev->dev, res);
 	if (!mxs->base)
 		return -EADDRNOTAVAIL;
 
-	mxs->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(mxs->clk)) {
-		ret = PTR_ERR(mxs->clk);
-		goto iounmap;
-	}
+	mxs->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mxs->clk))
+		return PTR_ERR(mxs->clk);
 
 	mxs->chip.dev = &pdev->dev;
 	mxs->chip.ops = &mxs_pwm_ops;
@@ -151,13 +151,13 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
-		goto clk_put;
+		return ret;
 	}
 
 	ret = pwmchip_add(&mxs->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
-		goto clk_put;
+		return ret;
 	}
 
 	mxs->dev = &pdev->dev;
@@ -166,12 +166,6 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	stmp_reset_block(mxs->base);
 
 	return 0;
-
-clk_put:
-	clk_put(mxs->clk);
-iounmap:
-	iounmap(mxs->base);
-	return ret;
 }
 
 static int __devexit mxs_pwm_remove(struct platform_device *pdev)
@@ -179,8 +173,6 @@ static int __devexit mxs_pwm_remove(struct platform_device *pdev)
 	struct mxs_pwm_chip *mxs = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&mxs->chip);
-	clk_put(mxs->clk);
-	iounmap(mxs->base);
 
 	return 0;
 }
-- 
1.7.5.4
