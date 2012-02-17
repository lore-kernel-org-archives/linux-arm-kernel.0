From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Feb 2012 08:40:07 +0100
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120216162703.GB3383@opensource.wolfsonmicro.com>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120216091352.GK3852@pengutronix.de>
 <20120216162703.GB3383@opensource.wolfsonmicro.com>
Message-ID: <20120217074007.GM3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 08:27:04AM -0800, Mark Brown wrote:
> On Thu, Feb 16, 2012 at 10:13:52AM +0100, Sascha Hauer wrote:
> > On Wed, Feb 15, 2012 at 11:58:26PM -0800, Mark Brown wrote:
> 
> > > It's not per device, of course - there's an overhead from putting a
> > > fixed regulator in but then per supply it's just a line.
> 
> > You mean one supply if the voltages are the same, right? Otherwise
> > we need multiple fixed regulators (or we shouldn't claim that the
> > board-dummy-fixed-catch-all regulator has a particular voltage)
> 
> I'd expect that anyone who's bothered by all this stuff wouldn't be
> going to fill in the voltages accurately.

Ok, so then I'll drop the voltage parameter.

> 
> > > This is obviously not good for users, they'd still have to do error
> > > checking to determine if the device was created or not and then manually
> > > register the device with the driver core and ideally also care if that
> > > worked or not.
> 
> > I understand that error checking is a good idea, but what do you mean
> > with 'manually register the device with the core'? The regulator is
> > registered with the core in this function.
> 
> Oh, in that case it seems really odd that it's returning a pointer to
> the device rather than just returning success or failure.

It has to as it gives you a pointer which you can use to unregister the
device later. Also it's in line with the platform helpers like
platform_device_register_resndata, platform_device_register_simple and
others.

> 
> > > Of course with device tree this all becomes moot as this won't be
> > > happening from code anyway...
> 
> > I wonder what the devicetree guys will do with this situation anyway.
> > The devicetree won't describe regulators that are actually not present
> > in the hardware, does it?
> 
> In all these cases there is actually a physical supply of some kind; if
> there isn't one then you'd expect the driver would have explicit code to
> handle that in some way.

Yes, there is one. But I think it will only be described in the device
tree if it's software controllable.

> 
> > Don't get me wrong. All I want is just a way for people to be able to
> > add regulator support to drivers *without* breaking its users. Normally
> > we have the policy in the kernel that changes to the kernel do not break
> > its users. The smsc case violated this and it will happen again. In the
> > end it doesn't even matter if a particular board could control a supply
> > via software or not. Patches should not simply declare all users of a
> > driver as broken.
> 
> Yes, I'm quite disappointed with people who are adding regulator support
> without making an effort to go round all the uers and at least notify
> the existing users of the device that they need updates.  There's a
> limited amount we can do in the core

Are you then willing to merge my patch to make it easier to not break
boards? I would remove the voltage parameter and fix a remaining
Kconfig/ifdef issue then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
