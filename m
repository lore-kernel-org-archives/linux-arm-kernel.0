From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:25 +0200
Subject: [PATCH v5 02/46] backlight: pwm_bl: remove useless call to
 pwm_set_period()
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM period will be set when calling pwm_config. Remove this useless
call to pwm_set_period(), which might mess up with the internal PWM state.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 64f9e1b..a33a290 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -313,10 +313,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * via the PWM lookup table.
 	 */
 	pb->period = pwm_get_period(pb->pwm);
-	if (!pb->period && (data->pwm_period_ns > 0)) {
+	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
-		pwm_set_period(pb->pwm, data->pwm_period_ns);
-	}
 
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
-- 
2.5.0
