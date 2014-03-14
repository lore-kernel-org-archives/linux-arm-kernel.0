From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 12:54:17 +0100
Subject: [PATCH v6 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <20140307010950.GE21483@n2100.arm.linux.org.uk>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <201403070137.38621.arnd@arndb.de>
 <20140307010950.GE21483@n2100.arm.linux.org.uk>
Message-ID: <201403141254.17572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 March 2014, Russell King - ARM Linux wrote:
> On Fri, Mar 07, 2014 at 01:37:38AM +0100, Arnd Bergmann wrote:
> > On Thursday 06 March 2014, Russell King - ARM Linux wrote:

> > > arch/microblaze/include/asm/io.h:/* from asm-generic/io.h */
> > 
> > PCI_IOBASE=0, IO_SPACE_LIMIT=0xffffffff, so no change.
> 
> Seems to define _IO_BASE not PCI_IOBASE.

It gets the implicit PCI_IOBASE from asm-generic/io.h at the moment.

> > 
> > PCI_IOBASE=0, IO_SPACE_LIMIT=0xffffffff, so no change.
> 
> Doesn't appear to define PCI_IOBASE.

Same here.

> > For most of these, I assume we actually want to remove support
> > for inb/outb as they don't support I/O space accesses. The other
> > ones look correct to me.
> 
> Right, so:
> 
> #ifdef CONFIG_HAS_IOPORT
> #ifndef CONFIG_GENERIC_IOMAP
> static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
> {
>         return (void __iomem *) port;
> }
> 
> changing that to include PCI_IOBASE in there will result in a build
> failure if the C compiler sees that.  In other words, when HAS_IOPORT=y
> and GENERIC_IOMAP=n.
> 
> HAS_IOPORT is set when HAS_IOMEM is also set and NO_IOPORT unset.
> 
> It looks to me like blackfin doesn't set NO_IOPORT nor NO_IOMEM, so
> this would have HAS_IOPORT set, and from what I can see doesn't set
> GENERIC_IOMAP.  So, this change probably breaks blackfin.

I also see the same thing that Liviu mentioned, that PCI_IOBASE=0
is always provided by asm-generic/io.h if not set otherwise.

On a related topic, Uwe Kleine-K?nig has submitted a patch to
rename CONFIG_HAS_IOPORT to CONFIG_HAS_IOPORT_MAP to clarify what
it does, and to allow us to add a new CONFIG_HAS_IOPORT option
that will let us remove all the I/O port handling code for
architectures that don't have any I/O access method.

	Arnd
