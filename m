From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 10 Oct 2014 18:50:05 +0300
Subject: =?UTF-8?q?=5BPATCH=201/3=5D=20pwm=3A=20process=20pwm=20polarity=20argument=20in=20of=5Fpwm=5Fsimple=5Fxlate=28=29?=
In-Reply-To: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1412956207-24008-2-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third optional argument of pwms is well defined as polarity and it
is already used in a number of pwm drivers, so, to minimize changes in
the remaining drivers which are to be updated accordingly set polarity
in default of_xlate() function.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d..681d154 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -174,6 +174,13 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm_set_period(pwm, args->args[1]);
 
+	if (pc->of_pwm_n_cells > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		else
+			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	}
+
 	return pwm;
 }
 
-- 
1.7.10.4
