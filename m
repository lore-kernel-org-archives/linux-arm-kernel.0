From: pgsellmann@portner-elektronik.at (Peter Gsellmann)
Date: Tue, 18 Jan 2011 22:38:44 +0100
Subject: [PATCH] Board support Pcontrol_G20, hardware revision 2
In-Reply-To: <20110118185657.GV14798@game.jcrosoft.org>
References: <201101171843.07148.pgsellmann@portner-elektronik.at>
	<20110118185657.GV14798@game.jcrosoft.org>
Message-ID: <201101182238.45374.pgsellmann@portner-elektronik.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. Januar 2011, 19:56:57 schrieb Jean-Christophe PLAGNIOL-VILLARD:
> On 18:43 Mon 17 Jan     , Peter Gsellmann wrote:
> >  Backplane timings adjusted
> >  Addition of specific platform devices and resources
> >  Leds renamed
> >  Minor bugfixes
> I'd prefer to split the patch for bisect
Is this really a requirement?
Except for added resources, changes are mostly in values of static structs reflecting
the hardware changes from rev1 to rev2. There is no such thing as hardware rev1.5 so
any mixed version neither works on hardware rev1 nor on rev2.

> > +static struct resource pcontrol_resources[] = {
> > +	{
> > +		.start	= AT91_CHIPSELECT_4,
> > +		.end	= AT91_CHIPSELECT_4 + SZ_256M - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= AT91_CHIPSELECT_7,
> > +		.end	= AT91_CHIPSELECT_7 + SZ_256M - 1,
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= AT91_CHIPSELECT_4,
> > +		.end	= AT91_CHIPSELECT_4 + 0x800 - 1,
> > +		.name   = "bus51",
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= AT91_CHIPSELECT_4 + 0x800,
> > +		.end	= AT91_CHIPSELECT_4 + 0x900 - 1,
> > +		.name   = "lcd40x16bw",
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= AT91_CHIPSELECT_4 + 0x900,
> > +		.end	= AT91_CHIPSELECT_4 + 0xa00 - 1,
> > +		.name   = "kbd6x3+5",
> > +		.flags	= IORESOURCE_MEM,
> > +	}, {
> > +		.start	= AT91_CHIPSELECT_7,
> > +		.end	= AT91_CHIPSELECT_7 + SZ_512K - 1,
> > +		.name   = "ferroram",
> > +		.flags	= IORESOURCE_MEM,
> > +	}
> export the same memory twice as ressource :(
yes, this is intended:
the first two are main resources(chipselects with size 256MB),
 the others are subresources(real chips with smaller sizes)
 which divide the address space of the chipselects; otherwise
 the driver plat_ram would present the 512K ferroram as 256MB disk.

after loading some of the drivers, /proc/iomem looks like:
50000000-5fffffff : atmel_smc.4
  50000000-500007ff : bus51
  50000800-500008ff : lcd40x16bw
    50000800-500008ff : t6963c
  50000900-500009ff : kbd6x3+5
    50000900-500009ff : polledio-dev
80000000-8fffffff : atmel_smc.7
  80000000-8007ffff : ferroram
    80000000-8007ffff : mtd-ram

which is similar to:
fea00000-feafffff : PCI Bus 0000:01
  feac0000-feadffff : 0000:01:00.0
  feaec000-feaeffff : 0000:01:00.1
    feaec000-feaeffff : ICH HD audio
  feaf0000-feafffff : 0000:01:00.0

on my host-machine and shows the hierarchy slot - card - driver
