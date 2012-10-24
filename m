From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Oct 2012 11:56:03 +0200
Subject: pwm pin stays on 1 on mxs after pwm_config(pwm, 0, period);
 pwm_disable(pwm);
Message-ID: <20121024095603.GH639@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the leds-pwm driver does the following in its led_pwm_set routine:

	if (brightness == 0) {
		pwm_config(led_dat->pwm, 0, period);
		pwm_disable(led_dat->pwm);
	} else {
		pwm_config(led_dat->pwm, brightness * period / max, period);
		pwm_enable(led_dat->pwm);
	}

The effect on setting brightness = 0 on an i.MX28 based machine after
having brightness = max = 255 before is:

pwm_config(..., 0, period) doesn't disable the output at once because of
some logic (in hardware) to prevent glitches. According to the Hardware
manual the new values take effect after the current period (which has the
output on 1). Now pwm_disable stopps the counter, the current period
doesn't run out and the output keeps the 1. So the LED stays on.

Where do I fix that? In the pwm driver (somehow block in pwm_config
until the current period is over, don't know how yet), remove the
pwm_disable in the brightness == 0 case (and then probably making the
whole if block a simple pwm_config(led_dat->pwm, brightness * period /
max, period)) or do we need a new API for that introducing a wait flag
or something different I didn't think of?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
