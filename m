From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Dec 2013 14:18:07 +0100
Subject: [PATCH 2/3] leds/pwm: Don't disable pwm when setting brightness
 to 0
In-Reply-To: <20131202123318.GC12793@ulmo.nvidia.com>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385412225-29740-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131202123318.GC12793@ulmo.nvidia.com>
Message-ID: <20131202131807.GC29721@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 01:33:19PM +0100, Thierry Reding wrote:
> On Mon, Nov 25, 2013 at 09:43:44PM +0100, Uwe Kleine-K?nig wrote:
> > This fixes disabling the LED on i.MX28. The PWM hardware delays using
> > the newly set pwm-config until the beginning of a new period. It's very
> > likely that pwm_disable is called before the current period ends. In
> > case the LED was on brightness=max before the LED stays on because in
> > the disabled PWM block the period never ends.
> > 
> > Also only call pwm_enable only once in the probe call back and the
> > matching pwm_disable in .remove(). Moreover the pwm is explicitly
> > initialized to off.
> 
> While I do understand the reasoning behind this, if this is really the
> behaviour that we need then there's no use in having pwm_enable() and
> pwm_disable() at all. They can just be folded into pwm_get() and
> pwm_put(), respectively.
So after the first pwm_get the pwm starts with an unspecified duty
cycle? That's not that nice, is it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
