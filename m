From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 12 Dec 2013 22:10:50 +0100
Subject: [PATCH 2/3] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <20131211153050.GE31617@ulmo.nvidia.com>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385412225-29740-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131202123318.GC12793@ulmo.nvidia.com>
 <20131202131807.GC29721@pengutronix.de>
 <20131205212641.GC4707@pengutronix.de>
 <20131211153050.GE31617@ulmo.nvidia.com>
Message-ID: <20131212211050.GC12238@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

first of all thanks for your reply.

On Wed, Dec 11, 2013 at 04:30:51PM +0100, Thierry Reding wrote:
> On Thu, Dec 05, 2013 at 10:26:41PM +0100, Uwe Kleine-K?nig wrote:
> > Hello Thierry,
> > 
> > On Mon, Dec 02, 2013 at 02:18:07PM +0100, Uwe Kleine-K?nig wrote:
> > > On Mon, Dec 02, 2013 at 01:33:19PM +0100, Thierry Reding wrote:
> > > > On Mon, Nov 25, 2013 at 09:43:44PM +0100, Uwe Kleine-K?nig wrote:
> > > > > This fixes disabling the LED on i.MX28. The PWM hardware delays using
> > > > > the newly set pwm-config until the beginning of a new period. It's very
> > > > > likely that pwm_disable is called before the current period ends. In
> > > > > case the LED was on brightness=max before the LED stays on because in
> > > > > the disabled PWM block the period never ends.
> > > > > 
> > > > > Also only call pwm_enable only once in the probe call back and the
> > > > > matching pwm_disable in .remove(). Moreover the pwm is explicitly
> > > > > initialized to off.
> > > > 
> > > > While I do understand the reasoning behind this, if this is really the
> > > > behaviour that we need then there's no use in having pwm_enable() and
> > > > pwm_disable() at all. They can just be folded into pwm_get() and
> > > > pwm_put(), respectively.
> > > So after the first pwm_get the pwm starts with an unspecified duty
> > > cycle? That's not that nice, is it?
> > How can we come forward here? After all it's a real bug being fixed.
> 
> I've thought about this some more, and this isn't actually fixing a bug.
> Rather it's working around some quirk of the hardware in your setup. So
<pedantic>
Yes, it does fix a bug. Without my patch setting the brightness of the
LED in question to zero doesn't work most of the time, with my patch it
works. Also I wouldn't call it quirk as that has a negative connotation
(at least for me). I'd call it a nice feature, that is missing from the
other pwms I know, but I don't care much how you call it.
</pedantic>

> in the long run I think the best option would have to be to define the
> behaviour of the PWM subsystem, and then make sure in drivers that they
> behave accordingly. So if we define, or rather keep with the existing
> implied behaviour, that the configuration is active when pwm_config()
> returns, we can easily write generic client drivers because it means
> they can rely on said behaviour. If a driver doesn't behave accordingly
> it needs to be fixed.
This definition doesn't fix the problem at hand. (It would fix it for
i.MX28, but not in general.) leds-pwm is doing:

	pwm_config(led_dat->pwm, new_duty, led_dat->period);
	if (new_duty == 0)
		pwm_disable(led_dat->pwm);
	else
		pwm_enable(led_dat->pwm);

. The problem is not that i.MX28 takes some time until it works with the
new config, but that it does something on pwm_disable that the author of
leds-pwm didn't take into account.
The only thing special on i.MX28 is that currently pwm_config might
return before the new config is active and that is the reason why the
state after pwm_disable is undefined for a different reason than on
other platforms (probably).

There are several things I can imagine that happen with the pin on
pwm_disable:

 - constant 0
 - constant 1
 - constant what it currently is
 - high-z

leds-pwm seems to assume the first option, the i.MX28 hardware behaves
according to the third option. I don't think either of them is an
assumption you should put in the API. I still think my suggestion is
sane.

> If that means that a particular PWM controller applies the configuration
> only after the current period has expired, then that's something only
> the driver can now and therefore the driver should handle this by only
> returning from pwm_config() when that's actually happened.
> 
> That seems to me the only reasonable approach. Otherwise we'll have to
> keep changing API whenever some new controller comes around that behaves
> slightly differently.
Currently even in the presence of the mentioned problems I'd say the
i.MX28 pwm driver "conforms" to the current pwm API/documentation. The
problem is that there are some things not formalized yet. And if there
are different implementations behaving differently obviously you must
specify more details if the users of the API need more
control/information (and then fix the implementations that became wrong
by the new details and fix the users that assumed wrong).

The two changes in question here are:

 - After pwm_config returns the new setting must already be active.
   This would result in the need to add a delay to the mxs-pwm driver
   (and maybe others). There is probably no need to fix users.
   I'm not yet convinced that this specification is necessary, at least
   it didn't bite yet and I cannot imagine a use case where it would
   matter.
 - Explicitly make the state of the pwm pin after pwm_disable
   implementation defined.
   There is probably no need to fix implementers, but at least leds-pwm
   as suggested in my patches.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
