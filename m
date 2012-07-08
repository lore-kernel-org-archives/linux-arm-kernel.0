From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:16 +0200
Subject: [PATCH 02/10] PLAT/Samsung/PWM: avoid division by zero
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-3-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-beeper driver crashes the PWM driver by calling with a period time of
zero nanoseconds.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/plat-samsung/pwm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index c559d84..751a0bf 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -188,7 +188,10 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	tcmp = __raw_readl(S3C2410_TCMPB(pwm->pwm_id));
 	tcnt = __raw_readl(S3C2410_TCNTB(pwm->pwm_id));
 
-	period = NS_IN_HZ / period_ns;
+	if (period_ns)
+		period = NS_IN_HZ / period_ns;
+	else
+		period = 0;
 
 	pwm_dbg(pwm, "duty_ns=%d, period_ns=%d (%lu)\n",
 		duty_ns, period_ns, period);
-- 
1.7.10
