From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 23:08:13 +0200
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <1718887.H9vPuvORKd@amdc1227>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <201304110035.47776.arnd@arndb.de> <1718887.H9vPuvORKd@amdc1227>
Message-ID: <201304112308.14181.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013, Tomasz Figa wrote:
> On Thursday 11 of April 2013 00:35:47 Arnd Bergmann wrote:
> > On Monday 08 April 2013, Tomasz Figa wrote:
> > > On Saturday 06 of April 2013 00:24:18 Tomasz Figa wrote:
> > > > On Friday 05 of April 2013 21:54:21 Arnd Bergmann wrote:
> > > > > On Friday 05 April 2013, Tomasz Figa wrote:
> > 
> > Sorry for not replying earlier. My idea for the register level interface
> > was to create a platform_device for each PWM, e.g. using the mfd_cell
> > infrastructure. You can then pass a "struct regmap" as the platform
> > data for each child of the timer node, and all the DT handling code
> > can stay in the parent driver.
> 
> Hmm. As I said, I'm completely fine with using a regmap for sharing registers 
> between subdrivers. However the clocksource can not be registered as an MFD 
> cell, because it's needed very early.
> 
> I can imagine a solution alternative to my original one, where the MFD cells 
> would be registered from the clocksource driver. This would mean that 
> platforms that don't need (and can't use) the PWM clocksource would have to 
> enable the driver anyway.

Sounds ok to me. The main part I want to avoid is having two separate device
nodes in the DT for one physical device, but there are multiple ways to get
there.

> Another thing is that I don't see a need to create one cell per PWM channel. 
> The PWM core is designed in a way that supports multiple channels per PWM 
> controller and so is the generic PWM DT specifier (<&controller channel period 
> flags>), so I'd rather see a single cell for all PWM channels.

Sure, no problem with that.

> So, to summarize this alternative concept:
>  - two drivers:
>    1) clocksource driver - registering clocksource and PWM MFD cell
>    2) PWM driver - handling the PWM MFD cell

Ok. Don't be too tied to the MFD concept though if it causes problems.
In many cases calling platform_device_register_resndata or similar is
actually easier than MFD, especially if you only want a single child
device. Either way is fine though.

>  - both drivers would share registers using a regmap with custom lock/unlock 
>    callbacks (using spin_lock_irqsave/spin_unlock_irqrestore, because the 
>    clocksource needs to access PWM registers in IRQ context)

Ok.

>  - the clocksource/master driver would have a samsung_time_init function which 
>    would set up the driver early and initialize the clocksource

Right. If you want to use the clocksource_of_init() infratstructure for this
(which is probably a good idea), please base your series on top of the
clksrc/cleanup branch in arm-soc.

>  - a platform driver would be registered by the clocksource/master driver
>    which would register the PWM MFD cell in its probe.

This seems unnecessary, if the only purpose of the platform driver is to
export the MFD cell. In that case, I would actually suggest a simpler model
where the PWM driver registers the main platform driver directly and
calls a function exported by the clocksource driver to get the regmap
structure and anything else it may need (possibly initializing the driver
in the case where it is not used as the clocksource but only provides
the registers for PWM).

>  - MFD cell platform data would contain struct regmap * and variant data
>    (parsed from DT or received from platform code - as in my original version)

Yes, either the MFD cell, or the exported symbol, whichever ends up easier.

> This should indeed work, assuming that I find a solution to make 
> clocksource_of_init not initialize the PWM clocksource (from PWM DT node) on 
> platforms that can't use it.

Right. If anything else comes up, I'd suggest we discuss it on IRC (#armlinux
on irc.freenode.net) tomorrow for faster round-trip, or I can call you on
the phone if you like. I'm available all day tomorrow, just send me your
(landline) phone number by private email.

	Arnd.
