From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 18:34:55 -0300
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <201306181814.33941.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181814.33941.arnd@arndb.de>
Message-ID: <20130618213454.GD2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Tue, Jun 18, 2013 at 06:14:33PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > +Required properties:
> > +
> > +- compatible:	 Should be set to one of the following:
> > +		 marvell,armada370-mbus
> > +		 marvell,armadaxp-mbus
> > +
> > +- reg:		 Device's register space.
> > +		 Two entries are expected, see the examples below.
> > +		 The first one controls the devices decoding window and
> > +		 the second one controls the SDRAM decoding window.
> > +
> > +- address-cells: Must be '2'. The first cell for the MBus ID encoding,
> > +                 the second cell for the address offset within the window.
> > +
> > +- size-cells:    Must be '1'.
> > +
> > +- ranges:        Must be set up to provide a proper translation for each child.
> > +	         See the examples below.
> 
> You should explain here what the policy is regarding windows set up by the
> boot loader. Are the ranges in here required to be the ones that the boot
> loader has preconfigured, or are they the ones that the mbus driver is supposed
> to set up?
> 

Actually, I might be confused but the kernel MBus driver is completely
independent from the bootloader's -except in the internal register case,
(because we don't touch that from where the bootloader left it).

What happens is that any decoding window that was setup by the bootloader,
is wiped and completely new windows are allocated using the translations
in the DT, as described by this binding.

This was the case from the start with the old MBus driver. FWIW, I think
it's actually the best choice that can be made: it makes the kernel
independent of the previous setting.

I know you've suggested differently in the past, but I'm not sure I
understand what's the benefit in keeping the bootloaders configuration.

> > +Each child device needs at least a 'ranges' property. If the child is avaiable
> > +(i.e. status not 'disabled'), then the MBus driver creates a decoding window
> > +for it. For instance, in the example below the BootROM child is specified:
> > +
> > +	soc {
> > +		compatible = "marvell,armada370-mbus", "simple-bus";
> > +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +
> > +		ranges = < ... /* other entries */
> > +			   0x011d0000 0 0 0xfff00000 0x100000>;
> > +
> > +		bootrom {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 0x011d0000 0 0x100000>;
> > +		};
> > +
> > +		/* other children */
> > +		...
> > +	};
> 
> Do you really want to require the child to provide a "ranges" property?
> I think this makes it more complicated to specify devices that belong
> into the "internal-regs" category.
> 

No, this text is actually a left-over from the previous patchset, in
current v3 patchset MBus children are *not* required to have any ranges.
On the otherside, although you will need one except in the most trivial
cases like for the BootROM.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
