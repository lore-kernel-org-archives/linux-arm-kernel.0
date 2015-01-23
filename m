From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Jan 2015 12:17:47 +0000
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
In-Reply-To: <20150123120355.GA15126@ulmo.nvidia.com>
References: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
 <20150121161313.GI5044@leverpostej>
 <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
 <20150123114423.GG23493@leverpostej>
 <20150123120355.GA15126@ulmo.nvidia.com>
Message-ID: <20150123121747.GI23493@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 12:03:57PM +0000, Thierry Reding wrote:
> On Fri, Jan 23, 2015 at 11:44:24AM +0000, Mark Rutland wrote:
> > On Fri, Jan 23, 2015 at 11:31:24AM +0000, Paul Walmsley wrote:
> > > On Wed, 21 Jan 2015, Mark Rutland wrote:
> > > > On Fri, Jan 16, 2015 at 11:45:29AM +0000, Paul Walmsley wrote:
> [...]
> > > > > +
> > > > > +               clocks = <&tegra_car TEGRA124_CLK_PCIE>,
> > > > > +                        <&tegra_car TEGRA124_CLK_AFI>,
> > > > > +                        <&tegra_car TEGRA124_CLK_PLL_E>,
> > > > > +                        <&tegra_car TEGRA124_CLK_CML0>;
> > > > > +               clock-names = "pex", "afi", "pll_e", "cml";
> > > > > +               resets = <&tegra_car 70>,
> > > > > +                        <&tegra_car 72>,
> > > > > +                        <&tegra_car 74>;
> > > > > +               reset-names = "pex", "afi", "pcie_x";
> > > > > +               status = "disabled";
> > > > > +
> > > > > +               phys = <&xusb_padctl TEGRA_XUSB_PADCTL_PCIE>;
> > > > > +               phy-names = "pcie";
> > > > > +
> > > > > +               pci at 1,0 {
> > > > > +                       device_type = "pci";
> > > > > +                       assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
> > > > > +                       reg = <0x000800 0 0 0 0>;
> > > > > +                       status = "disabled";
> > > > > +
> > > > > +                       #address-cells = <3>;
> > > > > +                       #size-cells = <2>;
> > > > > +                       ranges;
> > > >
> > > > I'm not sure why these three properties are here. Surely this is a
> > > > separate address space (so isn't ranges invalid?), and do we define any
> > > > sub-nodes anywhere?
> > > 
> > > Hmm not sure.  This was originally copied from
> > > arch/arm/boot/dts/tegra124.dtsi.  Will plan to drop them for now, and then
> > > if the properties (or ones like them) turn out to be needed in the future,
> > > someone else can deal with it :-)
> > 
> > That sounds sane to me.
> 
> This follows the bindings defined almost two years ago. There was a lot
> of discussion back then and this is what we agreed upon. #address-cells
> and #size-cells are needed as per the PCI device tree bindings and the
> ranges property needed because the PCIe root ports translate addresses
> between the host bridge and the PCI endpoint devices.

Ok. That sounds a little surprising to me, but I am admittedly not
familiar with this binding and PCI more generally. I'll dig a bit
deeper.

> > > > > +       host1x at 0,50000000 {
> > > > > +               compatible = "nvidia,tegra132-host1x", "nvidia,tegra124-host1x", "simple-bus";
> > > >
> > > > Regarding simple-bus, are the sub-nodes usable if this didn't probe as
> > > > "nvidia,tegra124-host1x" or "nvidia,tegra132-host1x"?
> > > > Do the subnodes require anything from this node?
> > > >
> > > > It looks like we expect/require the host1x node to be probed and
> > > > initialised before we probe the children. Which would imply the
> > > > simple-bus annotation is wrong.
> > > 
> > > Haven't tried booting with just simple-bus here.  I believe these devices
> > > are accessible without the involvement of host1x.  In other words, host1x
> > > is not a bus; I believe it might be most accurately described as a type of
> > > DMA controller.  So in theory it should be possible for the CPU complex to
> > > read and write to these devices directly without the involvement of
> > > host1x, although I believe NVIDIA discourages this.
> > > 
> > > Under the theory that DT data should be hardware-specific, not
> > > software-specific, in an ideal world I think we would list these devices
> > > outside the embrace of the host1x node.  However the existing Tegra124 DT
> > > file listed them together, and I am unsure whether that is required for
> > > the host1x code to function correctly.
> > >
> > > Arto may be able to comment further.
> > 
> > Hmm, It would be good to hear from someone familar with that then. I'll
> > wait for Arto.
> 
> We actually rely on the parent-child relationship in drivers, so we
> can't just go and reorganize things at will. This is documented in the
> existing binding for host1x, which again, was agreed upon a long time
> ago.
> 
> As for the simple-bus compatible, I think that was used way back to make
> sure of_platform_populate() gets called. I suppose we could drop it and
> call of_platform_populate() from the driver if its not there. The reason
> why we never considered cases where it would probe as simple-bus is that
> it was deemed unreasonable for a driver to bind to simple-bus.

Labelling something as simple-bus just to get an implicit
of_platform_populate is an abuse of simple-bus. If you have a driver for
handling the device as something more complex than a simple-bus, it
absolutely must do that probing itself (because there could be some
ordering requirement on re-initialisation of the bus).

If the sub-nodes don't make sense on their own, the "simple-bus" string
is not appropriate regardless.

One thing I've been hoping/trying to do for a while (with little success
so far) was to split simple-bus handling into a simple MMIO bus driver,
which exposes and/or blows up in cases like this.

> > > > > +       cpus {
> > > > > +               #address-cells = <2>;
> > > > > +               #size-cells = <0>;
> > > > > +
> > > > > +               cpu at 0 {
> > > > > +                       device_type = "cpu";
> > > > > +                       compatible = "nvidia,denver", "arm,armv8";
> > > > > +                       reg = <0x0 0x0>;
> > > > > +                       enable-method = "spin-table";
> > > > > +                       cpu-release-addr = <0x0 0x80000008>;
> > > > > +               };
> > > > > +
> > > > > +               cpu at 1 {
> > > > > +                       device_type = "cpu";
> > > > > +                       compatible = "nvidia,denver", "arm,armv8";
> > > > > +                       reg = <0x0 0x1>;
> > > > > +                       enable-method = "spin-table";
> > > > > +                       cpu-release-addr = <0x0 0x80000008>;
> > > > > +               };
> > > > > +       };
> > > >
> > > > It would be nice if this were near the top, as in other dts files.
> > > 
> > > OK will move.
> 
> Actually this follows the rules that we've been following with every DTS
> so far. Nodes with a unit address go first, sorted by unit address. They
> are followed by nodes without a unit address, sorted alphabetically.
> 
> I'd prefer keeping it this way for consistency across Tegra DTS files.

Ok.

I guess the ordering of this w.r.t. other nodes isn't too important.
While I find it surprising, at least it shouldn't cause issues in the
DTB itself.

However, it would be nice if we aligned all dts a bit better long-term.

Thanks,
Mark.
