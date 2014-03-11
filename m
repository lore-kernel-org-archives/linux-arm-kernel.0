From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Mar 2014 14:34:38 +0100
Subject: [PATCH 7/7] PCI: designware: split samsung and fsl bindings
In-Reply-To: <1393947259.9405.18.camel@weser.hi.pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <201403041553.40202.arnd@arndb.de>
 <1393947259.9405.18.camel@weser.hi.pengutronix.de>
Message-ID: <201403111434.38834.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Lucas Stach wrote:
> > > On i.MX6 the clock names (which I have to agree are pretty bad) map as
> > > follows:
> > > pcie_axi: host controller main register/bus access clock
> > > pcie_ref_125m: pcie phy reference clock
> > > 
> > > sata_ref_100m: pcie bus 100MHz reference clock
> > 
> > That doesn't explain why it's called "sata_ref_100m".
> > 
> I agree this is bad naming. It's called this way because someone decided
> to name it like the internal clock it is sourced from on most boards.
> This really should be pcie_ref, or something. I suspect this corresponds
> to the pcie_bus clock in the Exynos binding in which case we should just
> name it this way.

Ok, so Exynos is missing one of the other clocks then? Or is the 
pcie_ref_125m clock something that should actually be listed under
the node of the PHY?

> > > lvds_gate: bad abstraction. Decides if the reference clock is sourced
> > > internal (i.e. the 100MHz ref clock above) or from an SoC external
> > > source. We should really find a better way of representing this in the
> > > clock tree.
> > 
> > I don't understand this description at all. Can you try to explain that
> > with different words?
> > 
> On i.MX6 the PCIe reference clock is routed through a generic clock pad,
> which can be configured either as input or output. When the i.MX is the
> PCI master we source the clock from sata_ref_100m and configure this pad
> as clock output.
> Somebody decided to abstract the input/output switch as a gate, which is
> arguably wrong, this should be a mux deciding between internal or
> external clock source.
> 
> The PCIe host driver should really only need the clk pad clock,
> activation of the sata_ref_100m clock should be handled through
> parent<->child relationship of those clocks in the clock tree, which
> isn't properly handled right now. I'll try to fix this up, but it won't
> be backward compatible in any way.

Is it possible to treat this clock as a "global" clock rather than a device
specific one, and pass NULL as the device for clk_get?

That's not nice, but at least it gives you a way to keep it out of the
binding, and "just" creates a dependency between the specific PCI host
controller and the way that clock is wired up on a particular SoC.

	Arnd
