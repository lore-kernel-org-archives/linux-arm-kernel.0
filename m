From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:29 +0200
Subject: [PATCH v5 09/24] backlight: pwm_bl: use pwm_get_args() where
 appropriate
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-10-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/video/backlight/pwm_bl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index a33a290..b2b366b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -201,6 +201,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
 	int initial_blank = FB_BLANK_UNBLANK;
+	struct pwm_args pargs;
 	int ret;
 
 	if (!data) {
@@ -307,12 +308,19 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
 	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(pb->pwm);
+
+	/*
 	 * The DT case will set the pwm_period_ns field to 0 and store the
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,
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
