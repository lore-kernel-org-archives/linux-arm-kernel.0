From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  5 Sep 2012 15:35:21 +0200
Subject: [PATCH 2/8] pwm i.MX: remove unnecessary if in pwm_[en|dis]able
In-Reply-To: <1346852127-25226-1-git-send-email-s.hauer@pengutronix.de>
References: <1346852127-25226-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346852127-25226-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm core makes sure that pwm_enable/disable are called only
once. Still keep the enabled state since we will need it in
pwm_config.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pwm/pwm-imx.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 38270f4..0f244e6 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -42,7 +42,7 @@
 struct imx_chip {
 	struct clk	*clk;
 
-	int		clk_enabled;
+	int		enabled;
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
@@ -138,14 +138,15 @@ static int imx_pwm_config(struct pwm_chip *chip,
 static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
-	int rc = 0;
+	int rc;
 
-	if (!imx->clk_enabled) {
-		rc = clk_prepare_enable(imx->clk);
-		if (!rc)
-			imx->clk_enabled = 1;
-	}
-	return rc;
+	rc = clk_prepare_enable(imx->clk);
+	if (rc)
+		return rc;
+
+	imx->enabled = 1;
+
+	return 0;
 }
 
 static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -154,10 +155,8 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	writel(0, imx->mmio_base + MX3_PWMCR);
 
-	if (imx->clk_enabled) {
-		clk_disable_unprepare(imx->clk);
-		imx->clk_enabled = 0;
-	}
+	clk_disable_unprepare(imx->clk);
+	imx->enabled = 0;
 }
 
 static struct pwm_ops imx_pwm_ops = {
@@ -189,8 +188,6 @@ static int __devinit imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-	imx->clk_enabled = 0;
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no memory resource defined\n");
-- 
1.7.10.4
