From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 08 Mar 2013 01:40:53 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <20130307072203.GC3451@avionic-0098.mockup.avionic-design.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303070302.46593.arnd@arndb.de>
 <20130307072203.GC3451@avionic-0098.mockup.avionic-design.de>
Message-ID: <3271021.WsP8f9ZEBl@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 of March 2013 08:22:03 Thierry Reding wrote:
> On Thu, Mar 07, 2013 at 03:02:46AM +0000, Arnd Bergmann wrote:
> > On Wednesday 06 March 2013, Thierry Reding wrote:
> > > > Option 2 would probably come down to having a trivial MFD driver
> > > > exposing a regmap. You can probably reuse drivers/mfd/syscon.c
> > > > for this and make the node compatible with "syscon" to designate
> > > > the clock registers as a system-wide resource, making the other
> > > > device nodes register-less.> > 
> > > I think option 2 is the standard method if one hardware block
> > > provides
> > > several logical devices. I find it to be a pretty nice solution to
> > > this
> > > problem. We also have precedent in the PWM subsystem. The TWL chips
> > > for
> > > instance use it to create a platform device which is later driven by
> > > a
> > > PWM driver.
> > 
> > One difference though is that the TWL chip is a heterogenous MFD that
> > has a lot of different sub-devices, where in case of Exynos the timer
> > device has a set of identical units, each of which can be used either
> > as a PWM or as a clocksource or other timer.
> 
> I didn't know that. However I still making this an MFD driver is a good
> fit because it'll move the logic of defining the mode of each unit is
> kept in a parent driver which can instantiate the proper child devices
> for the corresponding subsystems.
> 
> One big disadvantage of this approach is that if this is continued there
> is a risk that MFD will turn into a dump for all kinds of devices that
> provide more than a single service.
> 
> So if people prefer option 3 I'm fine with it as well.

I have a question regarding making this an MFD driver.

As you know, the main clocksource driver must be initialized early, from 
init_time callback of machine_desc. How does using the MFD subsystem fit 
into this scheme?

P.S. I'm still not convinced about any benefits of options 2 and 3 over 
option 1, which has the obvious advantage of requiring least amount of 
changes to existing code and not binding the PWM and clocksource drivers 
together (on Exynos SoCs only the PWM driver is used, clocksource is 
handled by different hardware block - MCT).

Best regards,
Tomasz
