From: david.wu@rock-chips.com (David Wu)
Date: Tue,  8 Aug 2017 23:38:30 +0800
Subject: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value of
 pwm_config
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems the rockchip_pwm_config always returns the result 0,
so remove the judge.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index ac3cd5e..33bbb5a 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -165,7 +165,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	clk_disable(pc->pclk);
 }
 
-static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
@@ -188,8 +188,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
-
-	return 0;
 }
 
 static int rockchip_pwm_enable(struct pwm_chip *chip,
@@ -236,13 +234,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		enabled = false;
 	}
 
-	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
-	if (ret) {
-		if (enabled != curstate.enabled)
-			rockchip_pwm_enable(chip, pwm, !enabled,
-				      state->polarity);
-		goto out;
-	}
+	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
 	if (state->enabled != enabled) {
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-- 
1.9.1
