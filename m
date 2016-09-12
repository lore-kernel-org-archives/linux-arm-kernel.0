From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Sep 2016 16:04:01 +0200
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <20160912124553.aqgv7b4vsx4urogi@piout.net>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
 <20160912124553.aqgv7b4vsx4urogi@piout.net>
Message-ID: <20160912140401.qkezay7sqqavsf4i@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Sep 12, 2016 at 02:45:53PM +0200, Alexandre Belloni wrote:
> Isn't a properly designed PWM putting a high level on its pin when
> disabled and configured with inversed polarity ?

it's not well defined. When trying several times over the years to
properly define and document it, I didn't manage to agree with Thierry
what is the right thing to define.

IMHO it would be sensible to make it explicitly undefined what happens
when a PMW is disabled. This would simplify drivers from

	pwm_config(mypwm, value, period);
	if (!value)
		pwm_disable(mypwm)
	else
		pwm_enable(led_dat->pwm);

to

	pwm_config(mypwm, value, period);

and let the pwm driver disable it's clock (or whatever) when value is 0
and there are energy saving benefits that don't hurt the expected
behaviour of the pin. So the hardware specific stuff is handled in the
hardware specific driver and usage in pwm-consumers is simplified.
Moreover this also simplifies some pwm drivers because they don't have
to catch in software the cases where the hardware differs from the
expectation[1].
Looking at drivers/leds/leds-pwm.c it doesn't ensure that each
pwm_enable is paired by an pwm_disable (e.g. on .remove). Is this a bug?
With my purposed semantics of .config and .disable this would be much
easier to fix.

Regarding your question: Yeah, maybe all properly designed PWMs behave
like you expect. But reality isn't only about properly designed
hardware, so I wouldn't expect all hardware to behave. The inverse
property might be software emulated and so on pwm_disable the pin might
become 0.

The obvious downside of my suggestion is that this is a change in what
most people expect (because it was "safe" to call pwm_enable before),
but the resulting code is simpler and cleaner.

Today it's a (maybe small) bug, when a pwm consumer calls pwm_config with
value=0 and doesn't disable it afterwards. IMHO that's a bug in the pwm
API that pwm_config with value=0 doesn't imply (the wanted effects of)
pwm_disable.

Best regards
Uwe

[1] This might even be impossible: Consider a PWM that gets 0 (or
high-z) on hw-disable independent of configured duty or inversion. The
driver now sees for an inverted pwm: pwm_config(this, 0, 100);
pwm_disable(this); The driver cannot know if it should continue to drive
the pin at 1, or if the pwm consumer stopped caring about the pwm and
disabling the hardware is OK.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
