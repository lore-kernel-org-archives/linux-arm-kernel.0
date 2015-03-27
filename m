From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Mar 2015 19:49:01 +0100
Subject: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
In-Reply-To: <20150327154301.GA27626@ulmo.nvidia.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
 <20150325120039.GA16310@ulmo.nvidia.com>
 <20150327085942.GA10906@pengutronix.de>
 <20150327112607.GD5440@ulmo.nvidia.com>
 <20150327143559.GZ32677@pengutronix.de>
 <20150327154301.GA27626@ulmo.nvidia.com>
Message-ID: <20150327184901.GY9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 04:43:03PM +0100, Thierry Reding wrote:
> On Fri, Mar 27, 2015 at 03:35:59PM +0100, Uwe Kleine-K?nig wrote:
> > > Why do you think it is the worst? If we define the behaviour as b) what
> > > does that gain us? Why would users want to call these functions if their
> > The gain is that the three (or more?) pwm drivers don't need to special
> > case an artificial requirement of the framework. OK, users have to
> > adapt, but it's as simple as substituting all questionable calls to
> > pwm_disable by a call to pwm_config(duty=0).
> 
> There is no gain. If users suddenly have to care about hardware
> specifics I call that a loss. Equivalently if the PWM core framework
> needs to know about these specifics that's also a loss because it puts
> complexity in the core where device-specific properties clearly
> shouldn't be handled.

The easy way out for PWM users, the core and the driver is:

Declare the output status of a disabled PWM as undefined.

The core is not affected by this change. The users are even simplified
by this change, because at the moment they all have to special case in
some way if (duty == 0) pwm_disable(pwm);, this code could be removed.
The PWM drivers could be simplified aswell since they no longer have to
care about getting the PWM in a well defined state and don't have to
take care about the correct disabled state of inverted PWMs. If a PWM
driver wishes it can do some special casing for 0 and 100% duty cycle in
order to save some power, but that would only be a bonus. As an
additional bonus inverted PWMs could be completely software emulated in
the core, then this code could also be removed from the drivers.
PWM Users generally don't want to disable or enable the PWMs, instead
they want a duty cycle of 0 or 100%. If they really don't care about the
output status then they can call pwm_disable().

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
