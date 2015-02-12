From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 10:44:49 +0100
Subject: [PATCH 1/2] pwm/doc: Clearify that the pin state after pwm_disable is
 undefined
In-Reply-To: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423734290-19750-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes assumptions on the behaviour of the pwm API explicit.

Note that there are drivers that assume that pwm_disable does result in
a stable output matching the last pwm_config; leds-pwm is an example
that is fixed in a followup patch.

On arm/i.MX28 it can really happen that after

	pwm_config(led_dat->pwm, 0, 100);
	pwm_disable(led_dat->pwm);

the output is stuck at 1. That's because the pwm only works with the
newly configured config when a period is over for the previously
configured setting to prevent spikes.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/pwm.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index ca895fd211e4..abdd21d047ca 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -46,6 +46,11 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
 
 To start/stop toggling the PWM output use pwm_enable()/pwm_disable().
 
+Note that after calling pwm_disable() it's undefined if the output stops in a
+high or low state, even if the duty cycle is set to 0% or 100%. So don't call
+pwm_disable() if there is a need for a specific level. The same applies when
+pwm_enable() was called, but pwm_config() was not.
+
 Using PWMs with the sysfs interface
 -----------------------------------
 
-- 
2.1.4
