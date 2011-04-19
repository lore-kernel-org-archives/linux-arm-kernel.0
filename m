From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2011 16:16:01 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110415062643.GB12272@atomide.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
	<20110415062643.GB12272@atomide.com>
Message-ID: <201104191616.01647.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2011, Tony Lindgren wrote:
> > drivers/platform/arm/ux500/*
> > include/linux/platform/arm/ux500/*
> > 
> > Are any of these generally speaking good ideas?
> 
> Or maybe drivers/arm?
> 
> Anyways, whatever can be done as loadable modules should be done
> that way. That makes the life for distros much easier ;)

drivers/arm would just become the next pile of crap if we start that,
like drivers/misc is starting to look now.

There are more things that I think should become subsystems
for themselves, with a proper maintainer, rather than bits
that simply get copied across all platforms.

Besides gpio and regulators (which is already in drivers/gpio),
it would probably be good to have drivers/irq, drivers/iommu
and others.

For the prcmu, even after staring at the code for half an hour,
I still have no idea what it actually is. I just see function
names like prcmu_config_hotdog and prcmu_request_ape_opp_100_voltage
that tell me that it's both extremely generic and extremely
detailed, and that it deals with simians and food.

If I'm not mistaken, it's some sort of systems management, right?
My feeling is that grouping the bits together in prcmu files
is somewhat suboptimal, and it could be better to spread the
prcmu functions into multiple places, e.g. an IRQ driver,
an I2C driver, etc, and exporting just the common interfaces
from a file that handles the prcmu.

> > Either place outside arch/arm/* is fine with me, creating something like
> > drivers/prcmu/* would be a bit thick since the hardware basically does
> > not look like anything else.
> > 
> > The basic problem it's reflecting is that ARM does not have something
> > like ACPI, that's basically what the driver is doing, and since every
> > vendor does their own HW thingy it's not like it's easily consolidated.
> 
> Yeah and that's going to take time.

ACPI does a lot of things (unfortunately), and I did not get the impression
that prcmu does the one part we really need, which is complete enumeration
of all devices. If it did that, it should become a bus_type and replace
the hardcoded sets of platform devices.

> > In the meantime I'm working on migrating GPIO drivers from mach-u300
> > and plat-nomadik into drivers/gpio so I will hopefully provide some negative
> > stats.
> 
> We too can move the omap gpio code there too..

That sounds like a good idea. Same for the regulator drivers that are
currently in arch/arm instead of drivers/regulator.

	Arnd
