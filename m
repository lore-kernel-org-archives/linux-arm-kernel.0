From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 14 Dec 2012 07:48:05 +0100
Subject: clock_enable mismatches in pwm-backlight/pwm_enable
In-Reply-To: <1355428233.2159.15.camel@gitbox>
References: <1355428233.2159.15.camel@gitbox>
Message-ID: <20121214064805.GA24094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 08:50:33AM +1300, Tony Prisk wrote:
> Hi Thierry,
> 
> This works out quite well with you looking after pwm and pwm-backlight.
> 
> I noticed while troubleshooting pwm on arch-vt8500 last night that the
> clk_enable count was getting huge for no obvious reason, and I narrowed
> it down to the pwm-backlight driver.
> 
> in pwm-bl.c::pwm_backlight_update_status()
> 
> if (brightness == 0) {
> 		pwm_config(pb->pwm, 0, pb->period);
> 		pwm_disable(pb->pwm);
> 	} else {
> 		...
> 		pwm_config(pb->pwm, duty_cycle, pb->period);
> 		pwm_enable(pb->pwm);
> 	}
> 
> Which looks fine on its own, except that in pwm_enable() it's not
> uncommon to have clk_<prepare_>enable calls.
> 
> What happens is everytime the backlight level is changed to anything
> except 0, pwm_enable() is called, which calls clk_enable() and the
> counter goes up. Only when brightness=0 does pwm_disable() get called
> and the accompanying clk_disable().
> 
> If you change brightness 3-4 times, then set brightness=0, the clock is
> enable 3-4 times, but only disabled 1.
> 
> At first I thought it was my bad, but it seems Tegra and IMX suffer from
> this problem as well - they both do clk_ calls in pwm_enable - which
> doesn't seem unreasonable.
> 
> Any thoughts on how this could be rectified?

What you describe above should not happen. If you look at the core code,
you'll see that pwm_enable() and pwm_disable() keep track of the enable
status of PWM devices and only call the driver's .enable() or .disable()
if it is actually needed.

I've just checked the pwm-vt8500 driver and it looks like clk_enable()
and clk_disable() are properly balanced everywhere, so I can't explain
why this would happen.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/74808cb5/attachment.sig>
