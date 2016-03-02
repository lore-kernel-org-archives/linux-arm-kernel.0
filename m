From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Mar 2016 15:32:02 +0000
Subject: [RESEND 04/11] pwm: sti: Only request clock rate when you need to
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1456932729-9667-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the original code the clock rate was only obtained during
initialisation; however, the rate may change between then and
its use.  This patch ensures the correct rate is acquired just
before use.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 4e06c4d..aa217e2 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -51,7 +51,6 @@ struct sti_pwm_compat_data {
 
 struct sti_pwm_chip {
 	struct device *dev;
-	unsigned long clk_rate;
 	struct clk *pwm_clk;
 	struct regmap *regmap;
 	struct sti_pwm_compat_data *cdata;
@@ -86,13 +85,20 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
 				unsigned int *prescale)
 {
 	struct sti_pwm_compat_data *cdata = pc->cdata;
+	unsigned long clk_rate;
 	unsigned long val;
 	unsigned int ps;
 
+	clk_rate = clk_get_rate(pc->pwm_clk);
+	if (!clk_rate) {
+		dev_err(pc->dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * prescale = ((period_ns * clk_rate) / (10^9 * (max_pwm_count + 1)) - 1
 	 */
-	val = NSEC_PER_SEC / pc->clk_rate;
+	val = NSEC_PER_SEC / clk_rate;
 	val *= cdata->max_pwm_cnt + 1;
 
 	if (period % val) {
@@ -353,12 +359,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->pwm_clk);
 	}
 
-	pc->clk_rate = clk_get_rate(pc->pwm_clk);
-	if (!pc->clk_rate) {
-		dev_err(dev, "failed to get clock rate\n");
-		return -EINVAL;
-	}
-
 	ret = clk_prepare(pc->pwm_clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
-- 
1.9.1
