From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 22 Feb 2018 14:01:13 +0200
Subject: [PATCH v3 02/10] pwm: clps711x: populate PWM mode in of_xlate function
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1519300881-8136-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-clps711x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b1..2a4d31ab3af0 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -109,10 +109,20 @@ static const struct pwm_ops clps711x_pwm_ops = {
 static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 					     const struct of_phandle_args *args)
 {
+	struct pwm_device *pwm;
+	struct pwm_caps caps;
+
 	if (args->args[0] >= chip->npwm)
 		return ERR_PTR(-EINVAL);
 
-	return pwm_request_from_chip(chip, args->args[0], NULL);
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm_get_caps(chip, pwm, &caps);
+	pwm->args.mode = BIT(ffs(caps.modes) - 1);
+
+	return pwm;
 }
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
-- 
2.7.4
