From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Jun 2011 10:50:46 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <201106281903.06121.arnd@arndb.de>
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
	<201106281427.04373.arnd@arndb.de>
	<20110628161842.GK6069@pengutronix.de>
	<201106281903.06121.arnd@arndb.de>
Message-ID: <20110629085046.GM6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 07:03:05PM +0200, Arnd Bergmann wrote:
> On Tuesday 28 June 2011, Sascha Hauer wrote:
> > > How about using idr? It provides you a fast lookup and handles giving
> > > out unique numbers.
> > 
> > Sounds like a good idea, but is idr compatible with the pwmchip_reserve
> > function below? idr gives no guarantee that the first id is zero, but I
> > need exactly this to make the ids for the internal PWMs known at compile
> > time.
> 
> You can certainly use ida_get_new_above to guarantee that implicit
> number allocation doesn't interfere with the reserved numbers. Whether
> that guarantees that you get the reserved numbers when you ask for them,
> I don't know.
> 
> A possible way to deal with that would be to allocate an array of pointers
> for the reserved space but use IDR for the rest, but at that point the
> complexity is probably higher than what you have now ;-)
> 
> Another question is whether the dynamic allocation even makes sense. How
> does a driver that wants to use a PWM find out what number to ask for
> when it's not reserved for the platform to start with. Maybe the
> answer is to just use an array or tree for the lookup and refuse to
> register multiple PWMs to the same number.

I tend to remove the dynamic allocation support for now. Currently we
have two types of pwm drivers in the tree. The SoC internal PWMs can
cope with a fixed id so that platforms can pass the id to the pwm
function driver (backlight, led).
The other type is some mfd drivers which implement the pwm API themselves
right now. These are currently incompatible with the pwm framework anyway.
If a board wants to connect the mfd pwm to its backlight, the current
pwm_request based on an integer id is not suitable anymore. We need
a (struct device *dev, char *id) based pwm_request function then.
So my plan is to change the pwm API once we have all in tree drivers
in drivers/pwm.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
