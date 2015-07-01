From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  1 Jul 2015 10:21:54 +0200
Subject: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM period will be set when calling pwm_config. Remove this useless
call to pwm_set_period, which might mess up with the initial PWM state
once we have added proper support for PWM init state retrieval.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index ae498c1..fe5597c 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * via the PWM lookup table.
 	 */
 	pb->period = pwm_get_default_period(pb->pwm);
-	if (!pb->period && (data->pwm_period_ns > 0)) {
+	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
-		pwm_set_period(pb->pwm, data->pwm_period_ns);
-	}
 
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
-- 
1.9.1
