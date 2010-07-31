From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 Jul 2010 21:21:40 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <20100731110802.GL23886@n2100.arm.linux.org.uk>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<20100731110802.GL23886@n2100.arm.linux.org.uk>
Message-ID: <201007312121.40995.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 July 2010 13:08:02 Russell King - ARM Linux wrote:
> On Thu, Jul 29, 2010 at 01:45:35PM +0800, Eric Miao wrote:
> > diff --git a/arch/arm/mach-dove/include/mach/io.h
> > b/arch/arm/mach-dove/include/mach/io.h
> > index 3b3e472..067435e 100644
> > --- a/arch/arm/mach-dove/include/mach/io.h
> > +++ b/arch/arm/mach-dove/include/mach/io.h
> > @@ -11,10 +11,9 @@
> > 
> >  #include "dove.h"
> > 
> > -#define IO_SPACE_LIMIT               0xffffffff
> > -
> > -#define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
> > -                                DOVE_PCIE0_IO_VIRT_BASE))
> > -#define __mem_pci(a)         (a)
> > +#define IO_SPACE_LIMIT       0xffffffff
> > +#define __io(a)              __typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
> > +                                         DOVE_PCIE0_IO_VIRT_BASE)
> 
> I recommend against this use of __typesafe_io():
> 
> http://lists.arm.linux.org.uk/lurker/message/20090214.154245.6325bc9d.en.html
> 

On a related note, is there a particular reason why most of the
*_*_VIRT_BASE macros are just numbers instead of void __iomem
pointers?

My feeling is that we could save a lot of these typecasts and conversion
macros if the base addresses were already pointers in the right address
space.

I could do some cleanup and try to get the pointers right in the arm
architecture tree if you think that's a good idea.

	Arnd
