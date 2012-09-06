From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  6 Sep 2012 14:48:09 +0200
Subject: [PATCH 3/9] pwm i.MX: add functions to enable/disable pwm.
In-Reply-To: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346935695-25179-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to enable/disable the pwm only by switching the
clock on or off. Instead, use the dedicated register bits.
These differ on different SoCs, so introduce a SoC specific
function for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 drivers/pwm/pwm-imx.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 609b540..242a30d 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -25,6 +25,7 @@
 #define MX1_PWMS    0x04   /* PWM Sample Register */
 #define MX1_PWMP    0x08   /* PWM Period Register */
 
+#define MX1_PWMC_EN		(1 << 4)
 
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
 
@@ -49,6 +50,7 @@ struct imx_chip {
 
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
+	void (*set_enable)(struct pwm_chip *chip, bool enable);
 };
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
@@ -81,6 +83,21 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
 	return 0;
 }
 
+static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	val = readl(imx->mmio_base + MX1_PWMC);
+
+	if (enable)
+		val |= MX1_PWMC_EN;
+	else
+		val &= ~MX1_PWMC_EN;
+
+	writel(val, imx->mmio_base + MX1_PWMC);
+}
+
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -115,7 +132,10 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 
 	cr = MX3_PWMCR_PRESCALER(prescale) |
 		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
+		MX3_PWMCR_DBGEN;
+
+	if (imx->enabled)
+		cr |= MX3_PWMCR_EN;
 
 	if (cpu_is_mx25())
 		cr |= MX3_PWMCR_CLKSRC_IPG;
@@ -127,6 +147,21 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	return 0;
 }
 
+static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	val = readl(imx->mmio_base + MX3_PWMCR);
+
+	if (enable)
+		val |= MX3_PWMCR_EN;
+	else
+		val &= ~MX3_PWMCR_EN;
+
+	writel(val, imx->mmio_base + MX3_PWMCR);
+}
+
 static int imx_pwm_config(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -144,6 +179,8 @@ static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret)
 		return ret;
 
+	imx->set_enable(chip, true);
+
 	imx->enabled = 1;
 
 	return 0;
@@ -153,7 +190,7 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
 
-	writel(0, imx->mmio_base + MX3_PWMCR);
+	imx->set_enable(chip, false);
 
 	clk_disable_unprepare(imx->clk);
 	imx->enabled = 0;
@@ -198,10 +235,13 @@ static int __devinit imx_pwm_probe(struct platform_device *pdev)
 	if (imx->mmio_base == NULL)
 		return -EADDRNOTAVAIL;
 
-	if (cpu_is_mx1() || cpu_is_mx21())
+	if (cpu_is_mx1() || cpu_is_mx21()) {
 		imx->config = imx_pwm_config_v1;
-	else
+		imx->set_enable = imx_pwm_set_enable_v1;
+	} else {
 		imx->config = imx_pwm_config_v2;
+		imx->set_enable = imx_pwm_set_enable_v2;
+	}
 
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
-- 
1.7.10.4
