From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 14:39:10 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160325223922.GG5028@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <10747635.WkGeFaKqdy@wuerfel> <20160325223922.GG5028@sirena.org.uk>
Message-ID: <29105031.S6XB0bXn2i@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 22:39:22 Mark Brown wrote:
> On Fri, Mar 25, 2016 at 09:58:40PM +0100, Arnd Bergmann wrote:
> > On Friday 25 March 2016 15:50:32 Mark Brown wrote:
> 
> > > Why are we even doing that though?  Like I say it just seems pointlessly
> > > unhelpful for users.  Are we really saying that every single system has
> > > to go through and manually modify their DT so that they can use this
> > > entirely in SoC feature?  That doesn't seem like winning...
> 
> > I don't remember the exact details, but I think we had come up with
> > a generic constraint solving algorithm to pick appropriate windows for
> > each device with a (close to) minimal use of physical address space,
> 
> So there are some complicated constraints that make it hard to allocate
> from the bus space?

Yes, it's basically an optimization problem: the closer you can squeeze
everything together, the more address space you have left for RAM and/or
PCI.

>From the Armada XP data sheet, I can also see that it's possible to map
multiple SPI slaves into the MMIO space using a single MBus window, which
can be useful if  you have plenty of address space but a shortage of
mbus window registers.

> > > > way: if we just use the existing binding, the spi host driver can
> > > > simply call devm_ioremap_resource() to see if there is a map
> > > > for a given chipselect and otherwise fall back to the current
> > > > mode.
> 
> > > Why does the binding have to be in the client device to do that?
> 
> > I don't understand the question. The client device here is the SPI
> > controller, right? That doesn't need to have a special binding, it
> > just needs to list the registers relative to the mbus address space
> > like any other device, and that is independent of how we implement
> > it.
> 
> If you're saying we're doing a binding per chip select presumably that
> binding appears in the SPI device even if it's the controller driver
> that parses it.  This was what the original patch did, I pushed back
> since it's a fairly common pattern for poor quality bindings where
> people for some reason want to add per device properties for whatever
> new feature they want to support instead of doing it at the controller
> level (and ideally just doing it without requring any configuration).
>
> > It looks like Stefan's patch tricks here by creating an incompatible
> > binding for mbus that bypasses the address mapping.
> 
> I've not looked at the patch and honestly nobody has been talking about
> any generic binding, all I've seen is the per device property in the
> original patch.

I've looked up the original patch now, and I agree with your concern.
It's not at all what I suggest here though. We should not need any
properties in the spi slave node, and I think all added properties in
the spi master node should be static, and not refer to the configuration
at all.

In the DT node for the spi master, we already have a register range
for the SPI's control registers, and this is an address in the
domain of the MBus controller, which we treat as a 64-bit flat address
space in DT, specifically it is part of the 'internal-regs' bus that
has a 20-bit section out of that 64-bit bus:

        soc {
                #address-cells = <2>;
                #size-cells = <1>;
                internal-regs {
                        compatible = "simple-bus";
                        #address-cells = <1>;
                        #size-cells = <1>;
                        ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;

                        spi0: spi at 10600 {
				compatible = "marvell,armada-370-spi";
                                reg = <0x10600 0x28>;
                                #address-cells = <1>;
                                #size-cells = <0>;
                        };
		};
	};

What we really have though is additional registers that belong to
the SPI controller and that are not part of internal-regs, so
we need to move it up one level out of the internal-regs node in order
to add more registers:

        soc {
                #address-cells = <2>;
                #size-cells = <1>;
               spi0: spi at 10600 {
			compatible = "marvell,armada-370-spi";
                       reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
			       <MBUS_ID(0x01, 0x1e) 0 0x100000>; /* CS0 */
			       <MBUS_ID(0x01, 0x5e) 0 0x100000>; /* CS1 */
			       <MBUS_ID(0x01, 0x9e) 0 0x100000>; /* CS2 */
			       <MBUS_ID(0x01, 0xee) 0 0x100000>; /* CS3 */
			       <MBUS_ID(0x01, 0x1f) 0 0x100000>; /* CS4 */
			       <MBUS_ID(0x01, 0x5f) 0 0x100000>; /* CS5 */
			       <MBUS_ID(0x01, 0x9f) 0 0x100000>; /* CS6 */
			       <MBUS_ID(0x01, 0xef) 0 0x100000>; /* CS7 */
                       #address-cells = <1>;
                       #size-cells = <0>;
		};
	};

This lists all the addresses as seen from the MBus, but doesn't put them
into the CPU address space, which is then done by adding an entry in the
'ranges' property of the soc node:

	soc {
		ranges = <MBUS_ID(0x01, 0x1e) 0  0xe0000000  0x20000>; /* SPI 0 CS0 128kb */
		...
	};

I think it makes a lot of sense to define a separate window for each CS
at boot time, just so you don't have to reprogram the windows manually.
After all, the entire point of the direct mode is to avoid having to
do any of the setup work, and have the SPI master set the right CS
itself based on the MBus ID that is used for accessing the slave mmio
window. This is also required if we want to enable things like
XIP (DaX) mappings for file systems on a SPI-NOR flash.

	Arnd
