From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 14:52:48 +0200
Subject: [PATCHv4 4/4] pwm: imx: support output polarity inversion
In-Reply-To: <1402577568-10037-4-git-send-email-LW@KARO-electronics.de>
References: <1402577568-10037-1-git-send-email-LW@KARO-electronics.de>
 <1402577568-10037-2-git-send-email-LW@KARO-electronics.de>
 <1402577568-10037-3-git-send-email-LW@KARO-electronics.de>
 <1402577568-10037-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <1402577568-10037-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
output polarity. This patch adds support to utilize this feature where
available.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/pwm/pwm-imx.c |   38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 582ac3a..7357bbb 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -138,6 +138,8 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 
 	if (test_bit(PWMF_ENABLED, &pwm->flags))
 		cr |= MX3_PWMCR_EN;
+	if (pwm->polarity == PWM_POLARITY_INVERSED)
+		cr |= MX3_PWMCR_POUTC;
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
@@ -156,6 +158,11 @@ static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
 	else
 		val &= ~MX3_PWMCR_EN;
 
+	if (chip->pwms[0].polarity == PWM_POLARITY_INVERSED)
+		val |= MX3_PWMCR_POUTC;
+	else
+		val &= ~MX3_PWMCR_POUTC;
+
 	writel(val, imx->mmio_base + MX3_PWMCR);
 }
 
@@ -199,27 +206,49 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
 
-static struct pwm_ops imx_pwm_ops = {
+static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				enum pwm_polarity polarity)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+
+	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
+		polarity == PWM_POLARITY_INVERSED ? "inverted" : "normal");
+
+	return 0;
+}
+
+static struct pwm_ops imx_pwm_ops_v1 = {
 	.enable = imx_pwm_enable,
 	.disable = imx_pwm_disable,
 	.config = imx_pwm_config,
 	.owner = THIS_MODULE,
 };
 
+static struct pwm_ops imx_pwm_ops_v2 = {
+	.enable = imx_pwm_enable,
+	.disable = imx_pwm_disable,
+	.set_polarity = imx_pwm_set_polarity,
+	.config = imx_pwm_config,
+	.owner = THIS_MODULE,
+};
+
 struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	struct pwm_ops *pwm_ops;
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
 	.config = imx_pwm_config_v1,
 	.set_enable = imx_pwm_set_enable_v1,
+	.pwm_ops = &imx_pwm_ops_v1,
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
 	.config = imx_pwm_config_v2,
 	.set_enable = imx_pwm_set_enable_v2,
+	.pwm_ops = &imx_pwm_ops_v2,
 };
 
 static const struct of_device_id imx_pwm_dt_ids[] = {
@@ -241,6 +270,10 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (!of_id)
 		return -ENODEV;
 
+	data = of_id->data;
+	if (data->pwm_ops->set_polarity)
+		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
+
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
@@ -259,7 +292,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imx->clk_ipg);
 	}
 
-	imx->chip.ops = &imx_pwm_ops;
+	imx->chip.ops = data->pwm_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
@@ -269,7 +302,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	data = of_id->data;
 	imx->config = data->config;
 	imx->set_enable = data->set_enable;
 
-- 
1.7.10.4
