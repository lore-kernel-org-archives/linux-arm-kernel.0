From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 23 Mar 2012 00:00:51 -0400 (EDT)
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203222348210.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Mar 2012, jonsmirl at gmail.com wrote:

> When iotable is used to initially map memory you can specify the
> mapping address. In this case IO_SDMMC_PHYS is 0x18000000 and it gets
> mapped to  0xf1800000
> 
> NXP has supplied this handly macro
> #define io_p2v(x) (0xf0000000 | (((x) & 0xff000000) >> 4) | ((x) & 0x000fffff))
> 
> iotable_init(lpc313x_io_desc, ARRAY_SIZE(lpc313x_io_desc));
> 
> 	{
> 		.virtual	= io_p2v(IO_SDMMC_PHYS),
> 		.pfn		= __phys_to_pfn(IO_SDMMC_PHYS),
> 		.length		= IO_SDMMC_SIZE,
> 		.type		= MT_DEVICE
> 	},
> 
> The supplied kernel is full of code that uses this type of addressing.
> It has macros for register definition that all depend on the registers
> being mapped to a well know location - io_p2v(x).
> 
> I'd like to move the map out of the core code and into the SDMMC
> device driver and then only do it if the driver loads.

Why would you do that?  Those static mappings are meant to be global and 
remain there.  The handy macro is in fact not handy at all as it forces 
virtual addresses on you.

It is OK to keep the static mappings as you can use 1MB regions and the 
mapping code will use first level mappings which are better with TLB 
usage.

But drivers should really be using:

	iobase = ioremap(IO_SDMMC_PHYS);

and the various registers should be defined as offsets from that base.  
Then you would use:

	val = readl(iobase + SDMMC_FOO_REG);

where you could have:

#define SDMMC_FOO_REG	0x10

With a recent kernel, the ioremap code will reuse any static mappings 
that matches the physical address you give it, or create a new mapping 
otherwise.  But in either cases the actual virtual address used 
shouldn't matter anymore.


Nicolas
