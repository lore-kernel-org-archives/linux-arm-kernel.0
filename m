From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:03 +0200
Subject: [PATCH v5 40/46] backlight: lm3630a: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-41-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/lm3630a_bl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 3d16bd6..fdad23c 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -162,14 +162,16 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
 
 static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
 {
-	unsigned int period = pchip->pdata->pwm_period;
-	unsigned int duty = br * period / br_max;
+	struct pwm_state pstate;
 
-	pwm_config(pchip->pwmd, duty, period);
-	if (duty)
-		pwm_enable(pchip->pwmd);
+	pwm_get_state(pchip->pwmd, &pstate);
+	pstate.period = pchip->pdata->pwm_period;
+	pstate.duty_cycle = br * pstate.period / br_max;
+	if (pstate.duty_cycle)
+		pstate.enabled = true;
 	else
-		pwm_disable(pchip->pwmd);
+		pstate.enabled = false;
+	pwm_apply_state(pchip->pwmd, &pstate);
 }
 
 /* update and get brightness */
-- 
2.5.0
