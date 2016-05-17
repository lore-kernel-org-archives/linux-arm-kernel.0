From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 17 May 2016 12:35:33 +0200
Subject: [PATCH] pwm: Fill pwm->args before calling pwm_request_from_chip()
In-Reply-To: <1463481333-23438-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1463481333-23438-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1463481333-23438-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e39c0df1be5a ("pwm: Introduce the pwm_args concept"), moved the
period and polarity initialization steps into pwm_request_device() (called
by pwm_request_from_chip()) based on the pwm->args information.
Make sure we fill pwm->args fields before calling pwm_request_from_chip().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Mika Penttil? <mika.penttila@nextfour.com>
Fixes: e39c0df1be5a ("pwm: Introduce the pwm_args concept")
---
Mika,

Can you test after applying this patch and let me know if it fixes your
bug.

Thanks,

Boris

 drivers/pwm/core.c    | 12 ++++++------
 drivers/pwm/pwm-pxa.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 427142d..3d2eeaa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -143,10 +143,6 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
-	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
 	pwm->args.period = args->args[1];
 
 	if (args->args[2] & PWM_POLARITY_INVERTED)
@@ -154,6 +150,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 	else
 		pwm->args.polarity = PWM_POLARITY_NORMAL;
 
+	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
@@ -169,12 +169,12 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
+	pwm->args.period = args->args[1];
+
 	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm->args.period = args->args[1];
-
 	return pwm;
 }
 
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 58b709f..c33bd42 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -156,12 +156,12 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	pwm->args.period = args->args[0];
+
 	pwm = pwm_request_from_chip(pc, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm->args.period = args->args[0];
-
 	return pwm;
 }
 
-- 
2.7.4
