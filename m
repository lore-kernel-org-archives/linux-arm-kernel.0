From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  3 Jun 2016 10:23:05 +0200
Subject: [PATCH 07/14] pwm: sti: Add support for hardware readout
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464942192-25967-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement ->get_state() to provide support for initial state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-sti.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 92abbd5..6300d3e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -238,6 +238,43 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&pc->sti_pwm_lock);
 }
 
+static void sti_pwm_get_state(struct pwm_chip *chip,
+			      struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
+	unsigned int regval, prescaler;
+	int ret;
+
+	/* The clock has to be enabled to access PWM registers */
+	ret = clk_enable(pc->clk);
+	if (ret) {
+		dev_err(chip->dev, "Failed to enable PWM clk");
+		return;
+	}
+
+	regmap_field_read(pc->prescale_high, &regval);
+	prescaler = regval << 4;
+	regmap_field_read(pc->prescale_low, &regval);
+	prescaler |= regval;
+	state->period = DIV_ROUND_CLOSEST_ULL((u64)(prescaler + 1) *
+					      NSEC_PER_SEC *
+					      (pc->cdata->max_pwm_cnt + 1),
+					      pc->clk_rate);
+
+	regmap_read(pc->regmap, STI_DS_REG(pwm->hwpwm), &regval);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)(regval + 1) *
+						  state->period,
+						  pc->cdata->max_pwm_cnt + 1);
+
+	regmap_field_read(pc->pwm_en, &regval);
+	state->enabled = regval;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	clk_disable(pc->clk);
+}
+
 static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
@@ -249,6 +286,7 @@ static const struct pwm_ops sti_pwm_ops = {
 	.config = sti_pwm_config,
 	.enable = sti_pwm_enable,
 	.disable = sti_pwm_disable,
+	.get_state = sti_pwm_get_state,
 	.free = sti_pwm_free,
 	.owner = THIS_MODULE,
 };
-- 
2.7.4
