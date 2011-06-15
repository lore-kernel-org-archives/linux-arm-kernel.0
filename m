From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2011 11:46:13 +0200
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <4DF83577.6040903@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<201106142333.16203.arnd@arndb.de> <4DF83577.6040903@zytor.com>
Message-ID: <201106151146.13320.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 June 2011, H. Peter Anvin wrote:
> On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
> >>
> >> Why on earth restrict it like that?  It's just a device driver, like
> >> more or less any other device driver...
> > 
> > I'd say any other classic ISA/PC driver, including floppy, gameport or
> > serial-8250. One problem with these is that we never fully worked out
> > the dependencies for these, which we probably should. CONFIG_ISA
> > generally means ISA add-on cards, but that might not be enabled for
> > platforms that have a pc-parport but no ISA slots.
> > 
> 
> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> are ubiquitous across just about every platform.

Obviously you want to support 8250 uarts with MMIO on most architectures,
but the driver can only be built if you define both MMIO and PIO 
accessors (readb and outb). I would like to make the PIO part of 8250
conditional on having PIO support so that an architecture that doesn't
support this no longer has to provide fake accessor functions.

> Parallel port is an intermediate case... Centronics parallel ports
> predate the PC ecosystem by quite a bit, and the particular arrangement
> of ports became popular with the PC and spread to other platforms, but
> the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
> specific.

The driver looks like it can easily be built without support for the ISA DMA
API.

> > On the other hand, you have embedded platforms that currently build support
> > for parport-pc but define the inb/outb macros to plain pointer dereferences
> > (otherwise you can't build the 8250 driver). Loading parport-pc on those
> > machines typically results in derefencing user memory in the best case.
> >
> > What I'd love to see is a configuration option for "arch has working
> > PC-style inb/outb instructions", so we can build a kernel without them but
> > still get MMIO based drivers for PCI-less platforms.
> 
> Now, isn't that was iowrite/ioread was designed for?

Yes, it just isn't used consistently. As far as I can tell, this is for multiple
number of reasons:

* In case of 8250, the driver abstracts the difference between PIO and MMIO itself,
  because it uses the same method to do indirect accesses and different strides.
  Using ioread wouldn't really make the driver much simpler.

* For parport-pc, the driver really only needs PIO, we don't even
  try to support the same device on random MMIO addresses, and that might not
  be necessary.

* In case of floppies, the "solution" was to write a driver for every platform that
  doesn't have PIO, since they tend to have other differences. The amiflop and
  ataflop drivers are not even use readb(), they just derefence volatile pointers
  to do MMIO. I doubt we can find volunteers to clean that up.

	Arnd
