From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 28 Sep 2009 11:55:17 +0400
Subject: something wrong in drivers/power
In-Reply-To: <20090927173516.GB6710@elf.ucw.cz>
References: <20090926095555.GG1331@ucw.cz>
	<20090926145536.GA8445@doriath.ww600.siemens.net>
	<20090927173516.GB6710@elf.ucw.cz>
Message-ID: <20090928075517.GA6871@doriath.ww600.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 07:35:16PM +0200, Pavel Machek wrote:
> On Sat 2009-09-26 18:55:36, Dmitry Eremin-Solenikov wrote:
> > On Sat, Sep 26, 2009 at 11:55:55AM +0200, Pavel Machek wrote:
> > > 
> > > Tosa battery driver seems to be confused about its own identity.
> > 
> > NAK. Please see the drivers/input/touchscree/wm97xx-core.c
> 
> Could you elaborate? 
> 
> I took a look at touchscreen file, and it does not explain
> anything. Having tosa_battery calling itself wm97xx-battery is at
> least confusing, and there's no explaining comment. Given that we have
> different wm97xx_battery.c driver calling itself "wm97xx-battery"... I
> believe that's a bug.

Tosa has a battery that is hanging on the wm97xx codec (9712 if somebody
cares). The platform device for it is registered in the wm97xx-core and
then used by tosa-battery driver. If you'd like to clean up this mess
properly, you should:

1) add a clean possibility to pass platform data via ac97 bus to wm97xx
core driver (care to check that it should be passable both via regular
ac97 driver and via ASoC).

2) add a possibility to pass device names and platform data to
wm97xx-core child devices (battery, ts , etc.)

> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > diff -ur power.ofic/tosa_battery.c power/tosa_battery.c
> > > --- linux/drivers/power.ofic/tosa_battery.c	2009-09-06 08:56:36.000000000 +0200
> > > +++ linux/drivers/power/tosa_battery.c	2009-09-15 15:14:08.000000000 +0200
> > > @@ -459,7 +459,7 @@
> > >  }
> > >  
> > >  static struct platform_driver tosa_bat_driver = {
> > > -	.driver.name	= "wm97xx-battery",
> > > +	.driver.name	= "tosa-battery",
> > >  	.driver.owner	= THIS_MODULE,
> > >  	.probe		= tosa_bat_probe,
> > >  	.remove		= __devexit_p(tosa_bat_remove),
> > > @@ -483,4 +483,4 @@
> > >  MODULE_LICENSE("GPL");
> > >  MODULE_AUTHOR("Dmitry Baryshkov");
> > >  MODULE_DESCRIPTION("Tosa battery driver");
> > > -MODULE_ALIAS("platform:wm97xx-battery");
> > > +MODULE_ALIAS("platform:tosa-battery");
> > > 
> > > 
> > > -- 
> > > (english) http://www.livejournal.com/~pavelmachek
> > > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> > 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
With best wishes
Dmitry
