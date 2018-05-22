From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 22 May 2018 15:07:06 +0300
Subject: [PATCH v5 2/9] pwm: clps711x: populate PWM mode in of_xlate function
In-Reply-To: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
References: <1526990833-30707-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1526990833-30707-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-clps711x.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b1..d742e8e375c7 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -109,10 +109,18 @@ static const struct pwm_ops clps711x_pwm_ops = {
 static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 					     const struct of_phandle_args *args)
 {
+	struct pwm_device *pwm;
+
 	if (args->args[0] >= chip->npwm)
 		return ERR_PTR(-EINVAL);
 
-	return pwm_request_from_chip(chip, args->args[0], NULL);
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.mode = pwm_mode_get_valid(chip, pwm);
+
+	return pwm;
 }
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
-- 
2.7.4
