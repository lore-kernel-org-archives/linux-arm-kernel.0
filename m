From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Mar 2014 16:34:19 +0100
Subject: [PATCH 7/7] PCI: designware: split samsung and fsl bindings
In-Reply-To: <201403041553.40202.arnd@arndb.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <201402282103.01897.arnd@arndb.de>
 <1393942383.9405.8.camel@weser.hi.pengutronix.de>
 <201403041553.40202.arnd@arndb.de>
Message-ID: <1393947259.9405.18.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 04.03.2014, 15:53 +0100 schrieb Arnd Bergmann:
> On Tuesday 04 March 2014, Lucas Stach wrote:
> > Right, we should be able to reuse the clock names. Though I'm not really
> > sure how the Samsung clocks maps to those used on i.MX, as the names are
> > a bit generic. Maybe someone from Samsung could shed a bit of light on
> > this.
> > 
> > On i.MX6 the clock names (which I have to agree are pretty bad) map as
> > follows:
> > pcie_axi: host controller main register/bus access clock
> > pcie_ref_125m: pcie phy reference clock
> > 
> > sata_ref_100m: pcie bus 100MHz reference clock
> 
> That doesn't explain why it's called "sata_ref_100m".
> 
I agree this is bad naming. It's called this way because someone decided
to name it like the internal clock it is sourced from on most boards.
This really should be pcie_ref, or something. I suspect this corresponds
to the pcie_bus clock in the Exynos binding in which case we should just
name it this way.

> > lvds_gate: bad abstraction. Decides if the reference clock is sourced
> > internal (i.e. the 100MHz ref clock above) or from an SoC external
> > source. We should really find a better way of representing this in the
> > clock tree.
> 
> I don't understand this description at all. Can you try to explain that
> with different words?
> 
On i.MX6 the PCIe reference clock is routed through a generic clock pad,
which can be configured either as input or output. When the i.MX is the
PCI master we source the clock from sata_ref_100m and configure this pad
as clock output.
Somebody decided to abstract the input/output switch as a gate, which is
arguably wrong, this should be a mux deciding between internal or
external clock source.

The PCIe host driver should really only need the clk pad clock,
activation of the sata_ref_100m clock should be handled through
parent<->child relationship of those clocks in the clock tree, which
isn't properly handled right now. I'll try to fix this up, but it won't
be backward compatible in any way.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
