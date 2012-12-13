From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 14 Dec 2012 08:50:33 +1300
Subject: clock_enable mismatches in pwm-backlight/pwm_enable
Message-ID: <1355428233.2159.15.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

This works out quite well with you looking after pwm and pwm-backlight.

I noticed while troubleshooting pwm on arch-vt8500 last night that the
clk_enable count was getting huge for no obvious reason, and I narrowed
it down to the pwm-backlight driver.

in pwm-bl.c::pwm_backlight_update_status()

if (brightness == 0) {
		pwm_config(pb->pwm, 0, pb->period);
		pwm_disable(pb->pwm);
	} else {
		...
		pwm_config(pb->pwm, duty_cycle, pb->period);
		pwm_enable(pb->pwm);
	}

Which looks fine on its own, except that in pwm_enable() it's not
uncommon to have clk_<prepare_>enable calls.

What happens is everytime the backlight level is changed to anything
except 0, pwm_enable() is called, which calls clk_enable() and the
counter goes up. Only when brightness=0 does pwm_disable() get called
and the accompanying clk_disable().

If you change brightness 3-4 times, then set brightness=0, the clock is
enable 3-4 times, but only disabled 1.

At first I thought it was my bad, but it seems Tegra and IMX suffer from
this problem as well - they both do clk_ calls in pwm_enable - which
doesn't seem unreasonable.

Any thoughts on how this could be rectified?

Regards
Tony Prisk

PS: I have cc: Stephen for Tegra and Sascha for IMX as I don't know who
looks after pwm on those systems.
