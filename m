From: l.majewski@majess.pl (Lukasz Majewski)
Date: Sun, 11 Sep 2016 10:55:09 +0200
Subject: [PATCH] pwm: imx: Port "pwm: imx: support output polarity inversion"
 to Linux v4.7
Message-ID: <1473584109-10710-1-git-send-email-l.majewski@majess.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ports "pwm: imx: support output polarity inversion" patch set
written by Lothar Wassmann (v6 from 10.2014).

It is used to control backlight of panels via inverted PWM signal.

The "inversion" of PWM output is not an issue at such devices, since
separate GPIO pin is responsible for enabling and disabling the panel's
backlight.

This patch should be put on top of:

https://patchwork.kernel.org/patch/5065841/
https://patchwork.kernel.org/patch/5065821/
https://patchwork.kernel.org/patch/5065811/


Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
 drivers/pwm/pwm-imx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 471a99e..c37d223 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -181,7 +181,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	if (enable)
 		cr |= MX3_PWMCR_EN;
 
-	if (pwm->polarity == PWM_POLARITY_INVERSED)
+	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
 		cr |= MX3_PWMCR_POUTC;
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
@@ -201,11 +201,6 @@ static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
 	else
 		val &= ~MX3_PWMCR_EN;
 
-	if (chip->pwms[0].polarity == PWM_POLARITY_INVERSED)
-		val |= MX3_PWMCR_POUTC;
-	else
-		val &= ~MX3_PWMCR_POUTC;
-
 	writel(val, imx->mmio_base + MX3_PWMCR);
 }
 
@@ -253,6 +248,19 @@ static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				enum pwm_polarity polarity)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	if (polarity == pwm->args.polarity)
+		return 0;
+
+	val = readl(imx->mmio_base + MX3_PWMCR);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		val |= MX3_PWMCR_POUTC;
+	else
+		val &= ~MX3_PWMCR_POUTC;
+
+	writel(val, imx->mmio_base + MX3_PWMCR);
 
 	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
 		polarity == PWM_POLARITY_INVERSED ? "inverted" : "normal");
-- 
2.1.4
