From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:49 +0200
Subject: [PATCH v5 26/46] pwm: sun4i: implement hardware readout
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-27-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement ->get_state() instead of only initializing the polarity in
the probe function.

This implementation also takes care of keeping the PWM clk enabled if at
least one of the PWM exported by the PWM chip is already enabled, which
should prevent glitches.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-sun4i.c | 74 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 03a99a5..34cb296 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -252,11 +252,65 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(sun4i_pwm->clk);
 }
 
+static void sun4i_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *pstate)
+{
+	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	unsigned int clk_rate = clk_get_rate(sun4i_pwm->clk);
+	int prescaler, prescalerid;
+	int ret;
+	u32 val;
+
+	ret = clk_prepare_enable(sun4i_pwm->clk);
+	if (ret) {
+		dev_err(chip->dev, "Failed to enable PWM clock");
+		return;
+	}
+
+	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
+		pstate->polarity = PWM_POLARITY_INVERSED;
+	else
+		pstate->polarity = PWM_POLARITY_NORMAL;
+
+	if ((val & BIT_CH(PWM_EN, pwm->hwpwm)) &&
+	    (val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm)))
+		pstate->enabled = true;
+	else
+		pstate->enabled = false;
+
+	pstate->period = 0;
+	pstate->duty_cycle = 0;
+	prescalerid = (val >> (PWMCH_OFFSET * pwm->hwpwm)) & PWM_PRESCAL_MASK;
+	prescaler = prescaler_table[prescalerid];
+	if (prescaler) {
+		u64 timens;
+
+		clk_rate /= prescaler;
+
+		val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
+
+		timens = ((val >> 16) & PWM_PRD_MASK) + 1;
+		timens *= NSEC_PER_SEC;
+		do_div(timens, clk_rate);
+		pstate->period = timens;
+
+		timens = val & PWM_DTY_MASK;
+		timens *= NSEC_PER_SEC;
+		do_div(timens, clk_rate);
+		pstate->duty_cycle = timens;
+	}
+
+	clk_disable_unprepare(sun4i_pwm->clk);
+}
+
 static const struct pwm_ops sun4i_pwm_ops = {
 	.config = sun4i_pwm_config,
 	.set_polarity = sun4i_pwm_set_polarity,
 	.enable = sun4i_pwm_enable,
 	.disable = sun4i_pwm_disable,
+	.get_state = sun4i_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
@@ -307,8 +361,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
 	struct resource *res;
-	u32 val;
-	int i, ret;
+	int ret;
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
@@ -345,24 +398,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pwm);
 
-	ret = clk_prepare_enable(pwm->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable PWM clock\n");
-		goto clk_error;
-	}
-
-	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
-		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
-			pwm_set_polarity(&pwm->chip.pwms[i],
-					 PWM_POLARITY_INVERSED);
-	clk_disable_unprepare(pwm->clk);
-
 	return 0;
-
-clk_error:
-	pwmchip_remove(&pwm->chip);
-	return ret;
 }
 
 static int sun4i_pwm_remove(struct platform_device *pdev)
-- 
2.5.0
