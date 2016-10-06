From: l.majewski@majess.pl (Lukasz Majewski)
Date: Thu,  6 Oct 2016 08:49:54 +0200
Subject: [PATCH] pwm: core: Use pwm->args.polarity to setup
 PWM_POLARITY_INVERSED
In-Reply-To: <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
Message-ID: <1475736594-23028-1-git-send-email-l.majewski@majess.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm_set_polarity() function finally calls pwm_apply_state(), which
in turn requires state->duty_cycle and state->period properly set.

In the moment when polarity is set, the PWM is disabled and not configured.
For that reason both above variables are set to 0 and the polarity is not
set.

To be sure that polarity is setup, one needs to set pwm->args.polarity, which
controls MX3_PWMCR_POUTC bit setting at imx_pwm_config_v2().

Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
This patch should be applied on top of:

"[v2,2/6] pwm: core: make the PWM_POLARITY flag in DTB optional"

http://patchwork.ozlabs.org/patch/677330/

---
 drivers/pwm/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f62668..6cd6004 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -153,13 +153,11 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args_count > 2) {
+	if (args->args_count > 2)
 		if (args->args[2] & PWM_POLARITY_INVERTED)
-			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-		else
-			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
-	}
+			pwm->args.polarity = PWM_POLARITY_INVERSED;
 
 	return pwm;
 }
-- 
2.1.4
