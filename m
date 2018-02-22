From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 22 Feb 2018 14:01:15 +0200
Subject: [PATCH v3 04/10] pwm: pxa: populate PWM mode in of_xlate function
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1519300881-8136-5-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 4143a46684d2..7a035716e054 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -155,12 +155,16 @@ static struct pwm_device *
 pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
+	struct pwm_caps caps;
 
 	pwm = pwm_request_from_chip(pc, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
+	pwm_get_caps(pc, pwm, &caps);
+
 	pwm->args.period = args->args[0];
+	pwm->args.mode = BIT(ffs(caps.modes) - 1);
 
 	return pwm;
 }
-- 
2.7.4
