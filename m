From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Nov 2014 09:50:04 +0100
Subject: Again about leds-pwm and pwm-mxs
In-Reply-To: <20141126171242.GO4431@pengutronix.de>
References: <20141126171242.GO4431@pengutronix.de>
Message-ID: <20141127085004.GO30369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 06:12:42PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> two years ago I addressed the issue that on i.MX28 a led connected to a
> pwm-mxs device doesn't go off when brightness is set to 0. I tried again
> later to find an acceptable solution.
> (Links to respective threads:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=282596)
> http://thread.gmane.org/gmane.linux.kernel/1381289
> )
> 
> The technical side is well understood: The problem is that leds-pwm does
> the following:
> 
> 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
> 
> 	if (new_duty == 0)
> 		pwm_disable(led_dat->pwm);
> 	else
> 		pwm_enable(led_dat->pwm);
> 
> On i.MX28 reconfiguring the duty cycle only takes effect after the
> current period is over. That means that if the previous configuration
> was duty=period (i.e. "on") the likely outcome of the above sequence
> with new_duty=0 is that setting the duty cycle to 0 is scheduled but the
> current period never ends because the clock is stopped. So the led keeps
> being on.
> 
> Now we need a settlement in which way this should be fixed.
> There are several possibilities, roughly in order of my preference:
>  a) Declare the pin state after pwm_disable as undefined
>     In this case the leds-pwm driver must not call pwm_disable when
>     expecting a certain brightness (here: off).
>     A nice follow-up is then to patch the drivers that work the way the
>     leds-pwm author expected to call their equivalent of pwm_disable
>     themselves on new_duty=0.
>  b) Let pwm_config return at once, implement the waiting in a new call
>     pwm_sync() that either busy-loops or sleeps until the configuration
>     is 
>  c) Make the call to pwm_config for pwm-mxs block until the new period
>     started.
>  d) Make the call to pwm_config for pwm-mxs sleep until the new period
>     started.
>     (Not sure this works nicely because IIRC there is no irq available
>     that triggers accordingly.)
>  e) In pwm_disable detect that there is a reconfiguration pending and
>     block accordingly.
>  f) Extend the PWM-API to differentiate the two variants of pwm_config
>     E.g. make pwm_config sleep/busy-looping until the requested config is
>     active plus a new function pwm_config_schedule.
> 
> Back then Sascha and Matt also prefered a). The obvious downside of a)
> is that most people expect pwm_disable implying a constant 0. The
> obvious advantage of a) is that it's the simplest alternative and also
> works best when there are board specific inverters involved or the pwm
> supports built-in inversion.

I'm still in favor for a). IMO it's the only sane way to solve problems
with inverted PWMs. A PWM in disabled state has an undefined output on
some hardwares and we don't even axactly know which value a disabled
PWM should have. Using a duty cycle of 0% or 100% makes the desired
output very clear.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
