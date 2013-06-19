From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 15:52:25 -0300
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <201306182345.26281.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181814.33941.arnd@arndb.de>
 <20130618213454.GD2516@localhost>
 <201306182345.26281.arnd@arndb.de>
Message-ID: <20130619185224.GB5701@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jun 18, 2013 at 11:45:26PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > On Tue, Jun 18, 2013 at 06:14:33PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > > > +Required properties:
> > > > +
> > > > +- compatible:	 Should be set to one of the following:
> > > > +		 marvell,armada370-mbus
> > > > +		 marvell,armadaxp-mbus
> > > > +
> > > > +- reg:		 Device's register space.
> > > > +		 Two entries are expected, see the examples below.
> > > > +		 The first one controls the devices decoding window and
> > > > +		 the second one controls the SDRAM decoding window.
> > > > +
> > > > +- address-cells: Must be '2'. The first cell for the MBus ID encoding,
> > > > +                 the second cell for the address offset within the window.
> > > > +
> > > > +- size-cells:    Must be '1'.
> > > > +
> > > > +- ranges:        Must be set up to provide a proper translation for each child.
> > > > +	         See the examples below.
> > > 
> > > You should explain here what the policy is regarding windows set up by the
> > > boot loader. Are the ranges in here required to be the ones that the boot
> > > loader has preconfigured, or are they the ones that the mbus driver is supposed
> > > to set up?
> > > 
> > 
> > Actually, I might be confused but the kernel MBus driver is completely
> > independent from the bootloader's -except in the internal register case,
> > (because we don't touch that from where the bootloader left it).
> 
> Right, then state that clearly in the binding.
> 
> > What happens is that any decoding window that was setup by the bootloader,
> > is wiped and completely new windows are allocated using the translations
> > in the DT, as described by this binding.
> > 
> > This was the case from the start with the old MBus driver. FWIW, I think
> > it's actually the best choice that can be made: it makes the kernel
> > independent of the previous setting.
> > 
> > I know you've suggested differently in the past, but I'm not sure I
> > understand what's the benefit in keeping the bootloaders configuration.
> 
> The device tree /normally/ describes things that are either wired up
> in hardware or set up by the boot loader. Describing things that the
> boot loader may or may not have set up and that the kernel should
> set up but may ignore if it wants to is a bit fishy, but it seems
> that you have decided to do it that way. You should definitely
> document the fact that all ranges except the "internal-regs" are just
> suggestions and cannot be relied on to be present at boot time.
> 

Hold on! I've just noticed this, and I want to clarify something, just
to avoid mis-interpretations. The binding is not saying "the windows
described through this ranges are present at boot time".

Rather, it is "this binding will guarantee that the windows described 
in it will be present after the mbus allocates them".

Does it sound too fishy?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
