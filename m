From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 22 Apr 2016 11:18:11 +0100
Subject: [[PATCH v2] 07/11] pwm: sti: Supply PWM Capture clock handling
In-Reply-To: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461320295-20414-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's PWM IP is supplied by 2 different clocks.  One for PWM
Output and the other for Capture.  This patch provides clock
handling for the latter.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 2f61e1e..78979d0 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -74,6 +74,7 @@ struct sti_pwm_compat_data {
 struct sti_pwm_chip {
 	struct device *dev;
 	struct clk *pwm_clk;
+	struct clk *cpt_clk;
 	struct regmap *regmap;
 	struct sti_pwm_compat_data *cdata;
 	struct regmap_field *prescale_low;
@@ -183,6 +184,10 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
+		ret = clk_enable(pc->cpt_clk);
+		if (ret)
+			return ret;
+
 		if (!period_same) {
 			ret = sti_pwm_get_prescale(pc, period_ns, &prescale);
 			if (ret)
@@ -227,6 +232,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 clk_dis:
 	clk_disable(pc->pwm_clk);
+	clk_disable(pc->cpt_clk);
 	return ret;
 }
 
@@ -246,6 +252,10 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		if (ret)
 			goto out;
 
+		ret = clk_enable(pc->cpt_clk);
+		if (ret)
+			goto out;
+
 		ret = regmap_field_write(pc->pwm_out_en, 1);
 		if (ret) {
 			dev_err(dev, "failed to enable PWM device:%d\n",
@@ -271,6 +281,7 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	regmap_field_write(pc->pwm_out_en, 0);
 
 	clk_disable(pc->pwm_clk);
+	clk_disable(pc->cpt_clk);
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
@@ -390,6 +401,18 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+	if (IS_ERR(pc->cpt_clk)) {
+		dev_err(dev, "failed to get PWM capture clock\n");
+		return PTR_ERR(pc->cpt_clk);
+	}
+
+	ret = clk_prepare(pc->cpt_clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare clock\n");
+		return ret;
+	}
+
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
@@ -399,6 +422,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
+		clk_unprepare(pc->cpt_clk);
 		return ret;
 	}
 
@@ -416,6 +440,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->pwm_clk);
+	clk_unprepare(pc->cpt_clk);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
2.8.0
