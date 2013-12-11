From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Dec 2013 16:30:51 +0100
Subject: [PATCH 2/3] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <20131205212641.GC4707@pengutronix.de>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385412225-29740-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131202123318.GC12793@ulmo.nvidia.com>
 <20131202131807.GC29721@pengutronix.de>
 <20131205212641.GC4707@pengutronix.de>
Message-ID: <20131211153050.GE31617@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 10:26:41PM +0100, Uwe Kleine-K?nig wrote:
> Hello Thierry,
> 
> On Mon, Dec 02, 2013 at 02:18:07PM +0100, Uwe Kleine-K?nig wrote:
> > On Mon, Dec 02, 2013 at 01:33:19PM +0100, Thierry Reding wrote:
> > > On Mon, Nov 25, 2013 at 09:43:44PM +0100, Uwe Kleine-K?nig wrote:
> > > > This fixes disabling the LED on i.MX28. The PWM hardware delays using
> > > > the newly set pwm-config until the beginning of a new period. It's very
> > > > likely that pwm_disable is called before the current period ends. In
> > > > case the LED was on brightness=max before the LED stays on because in
> > > > the disabled PWM block the period never ends.
> > > > 
> > > > Also only call pwm_enable only once in the probe call back and the
> > > > matching pwm_disable in .remove(). Moreover the pwm is explicitly
> > > > initialized to off.
> > > 
> > > While I do understand the reasoning behind this, if this is really the
> > > behaviour that we need then there's no use in having pwm_enable() and
> > > pwm_disable() at all. They can just be folded into pwm_get() and
> > > pwm_put(), respectively.
> > So after the first pwm_get the pwm starts with an unspecified duty
> > cycle? That's not that nice, is it?
> How can we come forward here? After all it's a real bug being fixed.

I've thought about this some more, and this isn't actually fixing a bug.
Rather it's working around some quirk of the hardware in your setup. So
in the long run I think the best option would have to be to define the
behaviour of the PWM subsystem, and then make sure in drivers that they
behave accordingly. So if we define, or rather keep with the existing
implied behaviour, that the configuration is active when pwm_config()
returns, we can easily write generic client drivers because it means
they can rely on said behaviour. If a driver doesn't behave accordingly
it needs to be fixed.

If that means that a particular PWM controller applies the configuration
only after the current period has expired, then that's something only
the driver can now and therefore the driver should handle this by only
returning from pwm_config() when that's actually happened.

That seems to me the only reasonable approach. Otherwise we'll have to
keep changing API whenever some new controller comes around that behaves
slightly differently.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/c365de3c/attachment.sig>
