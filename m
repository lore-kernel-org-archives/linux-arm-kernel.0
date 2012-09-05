From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  5 Sep 2012 15:35:20 +0200
Subject: [PATCH 1/8] pwm i.MX: factor out SoC specific functions
In-Reply-To: <1346852127-25226-1-git-send-email-s.hauer@pengutronix.de>
References: <1346852127-25226-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346852127-25226-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the code more flexible.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pwm/pwm-imx.c |  145 ++++++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 63 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2a0b353..38270f4 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -46,81 +46,95 @@ struct imx_chip {
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
+
+	int (*config)(struct pwm_chip *chip,
+		struct pwm_device *pwm, int duty_ns, int period_ns);
 };
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
 
-static int imx_pwm_config(struct pwm_chip *chip,
+static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
 
-	if (!(cpu_is_mx1() || cpu_is_mx21())) {
-		unsigned long long c;
-		unsigned long period_cycles, duty_cycles, prescale;
-		u32 cr;
-
-		c = clk_get_rate(imx->clk);
-		c = c * period_ns;
-		do_div(c, 1000000000);
-		period_cycles = c;
-
-		prescale = period_cycles / 0x10000 + 1;
-
-		period_cycles /= prescale;
-		c = (unsigned long long)period_cycles * duty_ns;
-		do_div(c, period_ns);
-		duty_cycles = c;
-
-		/*
-		 * according to imx pwm RM, the real period value should be
-		 * PERIOD value in PWMPR plus 2.
-		 */
-		if (period_cycles > 2)
-			period_cycles -= 2;
-		else
-			period_cycles = 0;
-
-		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
-		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
-
-		cr = MX3_PWMCR_PRESCALER(prescale) |
-			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-			MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
-
-		if (cpu_is_mx25())
-			cr |= MX3_PWMCR_CLKSRC_IPG;
-		else
-			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
-
-		writel(cr, imx->mmio_base + MX3_PWMCR);
-	} else if (cpu_is_mx1() || cpu_is_mx21()) {
-		/* The PWM subsystem allows for exact frequencies. However,
-		 * I cannot connect a scope on my device to the PWM line and
-		 * thus cannot provide the program the PWM controller
-		 * exactly. Instead, I'm relying on the fact that the
-		 * Bootloader (u-boot or WinCE+haret) has programmed the PWM
-		 * function group already. So I'll just modify the PWM sample
-		 * register to follow the ratio of duty_ns vs. period_ns
-		 * accordingly.
-		 *
-		 * This is good enough for programming the brightness of
-		 * the LCD backlight.
-		 *
-		 * The real implementation would divide PERCLK[0] first by
-		 * both the prescaler (/1 .. /128) and then by CLKSEL
-		 * (/2 .. /16).
-		 */
-		u32 max = readl(imx->mmio_base + MX1_PWMP);
-		u32 p = max * duty_ns / period_ns;
-		writel(max - p, imx->mmio_base + MX1_PWMS);
-	} else {
-		BUG();
-	}
+	/* The PWM subsystem allows for exact frequencies. However,
+	 * I cannot connect a scope on my device to the PWM line and
+	 * thus cannot provide the program the PWM controller
+	 * exactly. Instead, I'm relying on the fact that the
+	 * Bootloader (u-boot or WinCE+haret) has programmed the PWM
+	 * function group already. So I'll just modify the PWM sample
+	 * register to follow the ratio of duty_ns vs. period_ns
+	 * accordingly.
+	 *
+	 * This is good enough for programming the brightness of
+	 * the LCD backlight.
+	 *
+	 * The real implementation would divide PERCLK[0] first by
+	 * both the prescaler (/1 .. /128) and then by CLKSEL
+	 * (/2 .. /16).
+	 */
+	u32 max = readl(imx->mmio_base + MX1_PWMP);
+	u32 p = max * duty_ns / period_ns;
+	writel(max - p, imx->mmio_base + MX1_PWMS);
+
+	return 0;
+}
+
+static int imx_pwm_config_v2(struct pwm_chip *chip,
+		struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	unsigned long long c;
+	unsigned long period_cycles, duty_cycles, prescale;
+	u32 cr;
+
+	c = clk_get_rate(imx->clk);
+	c = c * period_ns;
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	prescale = period_cycles / 0x10000 + 1;
+
+	period_cycles /= prescale;
+	c = (unsigned long long)period_cycles * duty_ns;
+	do_div(c, period_ns);
+	duty_cycles = c;
+
+	/*
+	 * according to imx pwm RM, the real period value should be
+	 * PERIOD value in PWMPR plus 2.
+	 */
+	if (period_cycles > 2)
+		period_cycles -= 2;
+	else
+		period_cycles = 0;
+
+	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
+
+	cr = MX3_PWMCR_PRESCALER(prescale) |
+		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+		MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
+
+	if (cpu_is_mx25())
+		cr |= MX3_PWMCR_CLKSRC_IPG;
+	else
+		cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
+
+	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	return 0;
 }
 
+static int imx_pwm_config(struct pwm_chip *chip,
+		struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+
+	return imx->config(chip, pwm, duty_ns, period_ns);
+}
+
 static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
@@ -187,6 +201,11 @@ static int __devinit imx_pwm_probe(struct platform_device *pdev)
 	if (imx->mmio_base == NULL)
 		return -EADDRNOTAVAIL;
 
+	if (cpu_is_mx1() || cpu_is_mx21())
+		imx->config = imx_pwm_config_v1;
+	else
+		imx->config = imx_pwm_config_v2;
+
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
1.7.10.4
