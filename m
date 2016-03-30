From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:05 +0200
Subject: [PATCH v5 42/46] backlight: lp8788: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-43-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/lp8788_bl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index 5d583d7..521c730 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -124,16 +124,13 @@ static int lp8788_backlight_configure(struct lp8788_bl *bl)
 
 static void lp8788_pwm_ctrl(struct lp8788_bl *bl, int br, int max_br)
 {
-	unsigned int period;
-	unsigned int duty;
 	struct device *dev;
+	struct pwm_state pstate;
 	struct pwm_device *pwm;
 
 	if (!bl->pdata)
 		return;
 
-	period = bl->pdata->period_ns;
-	duty = br * period / max_br;
 	dev = bl->lp->dev;
 
 	/* request PWM device with the consumer name */
@@ -147,11 +144,15 @@ static void lp8788_pwm_ctrl(struct lp8788_bl *bl, int br, int max_br)
 		bl->pwm = pwm;
 	}
 
-	pwm_config(bl->pwm, duty, period);
-	if (duty)
-		pwm_enable(bl->pwm);
+	pwm_get_state(bl->pwm, &pstate);
+	pstate.period = bl->pdata->period_ns;
+	pstate.duty_cycle = br * pstate.period / max_br;
+	if (pstate.duty_cycle)
+		pstate.enabled = true;
 	else
-		pwm_disable(bl->pwm);
+		pstate.enabled = false;
+
+	pwm_apply_state(bl->pwm, &pstate);
 }
 
 static int lp8788_bl_update_status(struct backlight_device *bl_dev)
-- 
2.5.0
