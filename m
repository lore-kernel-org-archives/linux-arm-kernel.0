From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jun 2011 23:33:15 +0200
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <4DF7C3CA.9050902@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
Message-ID: <201106142333.16203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 June 2011 22:25:46 H. Peter Anvin wrote:
> On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> > The PC parallel port Kconfig as acquired one of those messy terms to
> > describe it's architecture dependencies:
> > 
> >        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> >                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> > 
> > This isn't just ugly - it also almost certainly describes the dependencies
> > too coarse grainedly.  This is an attempt at cleaing the mess up.
> > 
> > I tried to faithfully aproximate the old behaviour but the existing
> > behaviour seems inacurate if not wrong for some architectures or platforms.
> > To improve on this I rely on comments from other arch and platforms
> > maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> > parallel port on the mainboard should probably should now do a
> > select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> > restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> > need it.
> > 
> 
> Why on earth restrict it like that?  It's just a device driver, like
> more or less any other device driver...

I'd say any other classic ISA/PC driver, including floppy, gameport or
serial-8250. One problem with these is that we never fully worked out
the dependencies for these, which we probably should. CONFIG_ISA
generally means ISA add-on cards, but that might not be enabled for
platforms that have a pc-parport but no ISA slots.

On the other hand, you have embedded platforms that currently build support
for parport-pc but define the inb/outb macros to plain pointer dereferences
(otherwise you can't build the 8250 driver). Loading parport-pc on those
machines typically results in derefencing user memory in the best case.

What I'd love to see is a configuration option for "arch has working
PC-style inb/outb instructions", so we can build a kernel without them but
still get MMIO based drivers for PCI-less platforms.

	Arnd
