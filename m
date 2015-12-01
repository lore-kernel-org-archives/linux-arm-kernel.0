From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue,  1 Dec 2015 22:55:39 +0000
Subject: [PATCH 1/3] pwm: bcm2835: calculate scaler in pwm_config
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1449010541-3767-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pwm-bcm2835 assumes a fixed clock rate and stores the
resulting scaler in the driver structure. But with the upcoming
PWM clock support for clk-bcm2835 the rate could change.
So calculate the scaler in pwm_config.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index b4c7f95..174cca9 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -29,7 +29,6 @@
 struct bcm2835_pwm {
 	struct pwm_chip chip;
 	struct device *dev;
-	unsigned long scaler;
 	void __iomem *base;
 	struct clk *clk;
 };
@@ -66,6 +65,7 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
+	unsigned long scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
 
 	if (period_ns <= MIN_PERIOD) {
 		dev_err(pc->dev, "period %d not supported, minimum %d\n",
@@ -73,8 +73,8 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	writel(duty_ns / pc->scaler, pc->base + DUTY(pwm->hwpwm));
-	writel(period_ns / pc->scaler, pc->base + PERIOD(pwm->hwpwm));
+	writel(duty_ns / scaler, pc->base + DUTY(pwm->hwpwm));
+	writel(period_ns / scaler, pc->base + PERIOD(pwm->hwpwm));
 
 	return 0;
 }
@@ -156,8 +156,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pc->scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
-- 
1.7.9.5
