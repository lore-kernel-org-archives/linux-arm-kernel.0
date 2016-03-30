From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:36 +0200
Subject: [PATCH v5 13/46] backlight: pwm_bl: use pwm_get_args() where
 appropriate
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM framework has clarified the concept of reference PWM config
(the platform dependent config retrieved from the DT or the PWM
lookup table) and real PWM state.

Use pwm_get_args() when the PWM user wants to retrieve this reference
config and not the current state.

This is part of the rework allowing the PWM framework to support
hardware readout and expose real PWM state even when the PWM has
just been requested (before the user calls pwm_config/enable/disable()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index a33a290..2479c11 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -201,6 +201,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
 	int initial_blank = FB_BLANK_UNBLANK;
+	struct pwm_args pargs = { };
 	int ret;
 
 	if (!data) {
@@ -312,7 +313,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	 * set the period from platform data if it has not already been set
 	 * via the PWM lookup table.
 	 */
-	pb->period = pwm_get_period(pb->pwm);
+	pwm_get_args(pb->pwm, &pargs);
+	pb->period = pargs.period;
 	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
 
-- 
2.5.0
