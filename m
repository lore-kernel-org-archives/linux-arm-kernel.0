From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Jan 2015 11:44:24 +0000
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
In-Reply-To: <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
 <20150121161313.GI5044@leverpostej>
 <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
Message-ID: <20150123114423.GG23493@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 11:31:24AM +0000, Paul Walmsley wrote:
> + Arto, Terje for comments on the host1x section
> + Stephen Warren for comments on the serial DT data
> 
> Hi Mark,
> 
> thanks for the review.
> 
> On Wed, 21 Jan 2015, Mark Rutland wrote:
> 
> > As mentioned in my reply to the DT list patch [1], there are a couple of
> > bits I'd like to see cleaned up first, but in the meantime I have some
> > comments from my first pass of the dtsi below. Some of these may equally
> > apply to existing dts(i) files.
> >
> > I see a few undocumented compatible strings (at least when comparing
> > against mainline). If there are other series or trees I should be
> > looking at, any pointers would be appreciated. If not, documentation
> > updates would be nice (checkpatch should complain otherwise).
> 
> (discussed in the tegra132-pcie comments below)
> 
> >
> > On Fri, Jan 16, 2015 at 11:45:29AM +0000, Paul Walmsley wrote:
> > >
> > > Add an initial device tree file for the Tegra132 SoC.  The DT file is
> > > based on arch/arm/boot/dts/tegra124.dtsi and
> > > arch/arm/boot/dts/tegra114.dtsi, with the following significant
> > > changes:
> > >
> > > - Tegra132 uses a Denver CPU cluster rather than an ARMv7 CPU cluster
> > > - Devices are arranged by bus, rather than in a flat topology
> > > - No polling delays have been defined for the thermal zones.  I don't
> > >   believe that this is a property of the SoC hardware, but rather of a
> > >   given use-case.
> > >
> > > DT nodes representing IP blocks have generally been labeled according
> > > to the names used in Section 2.1 "System Address Map" of the _Tegra K1
> > > 64-Bit Mobile Processor Technical Reference Manual_
> > > (DP-07148-001_ALPHA), with a few exceptions for disambiguation or
> > > abbreviated naming.  Some of the known IP block aliases used by PCB
> > > designers (e.g., "GEN2_I2C" for "I2C2") have been noted in DT node
> > > comments.
> > >
> > > Known future work:
> > >
> > > - Add support for the Denver CLUSTER_clocks IP block
> > > - Add support for the CPU thermal zone; now handled by a CCPLEX IP block
> > > - The CPU spin_table enable-method may change to PSCI at some point
> >
> > That sounds nice. Any idea if/when that would be likely to happen?
> 
> The PSCI aspect?  Unfortunately not at the moment due to the secure
> firmware dependency.

Ah, ok.

[...]

> > > +/ {
> > > +       compatible = "nvidia,tegra132";
> > > +       interrupt-parent = <&gic>;
> > > +       #address-cells = <2>;
> > > +       #size-cells = <2>;
> > > +
> > > +       pcie-controller at 0,01003000 {
> > > +               compatible = "nvidia,tegra132-pcie", "nvidia,tegra124-pcie";
> >
> > I couldn't spot "nvidia,tegra132-pcie" in mainline anywhere. Does it
> > differ significantly from "nvidia,tegra124-pcie"?
> 
> I'm not sure if the T132 PCIe driver will need any T132-specific
> workarounds.  I just followed what seems to be at least one DT practice
> discussed in the past of adding SoC-specific variants for the IP blocks in
> the event that a SoC-specific driver change is needed in the future.  I'm
> probably out-of-date on the current doctrine here, though.
> 
> Anyway, I have no problem with dropping the tegra132- variants, except in
> cases where changes are specifically known to be needed, although this
> seems likely to strengthen the binding between DT data and kernel
> versions.  Let me know.

I agree we should have the tegra132- variants, even if we don't know how
different the blocks happen to be from their predecessors. So please
don't drop them.

It would just be nice to dump the strings in binding docs so as to not
have checkpatch complaints.

> 
> > > +               device_type = "pci";
> > > +               reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
> > > +                      0x0 0x01003800 0x0 0x00000800   /* AFI registers */
> > > +                      0x0 0x02000000 0x0 0x10000000>; /* configuration space */
> >
> > Nit: for properties which are lists, please bracket each entry, e.g.
> >
> > reg = <0x0 0x01003000 0x0 0x00000800>,   /* PADS registers */
> >       <0x0 0x01003800 0x0 0x00000800>,
> >       <0x0 0x02000000 0x0 0x10000000>;
> >
> > I appreciate the newlines serve as an obvious delimiter here, but in
> > single-line cases it really helps, and it would be nice to be
> > consistent. It looks like most instances in this file already do this
> > anyway.
> 
> OK will do.
> 
> >
> > > +               reg-names = "pads", "afi", "cs";
> > > +               interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
> > > +                            <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> > > +               interrupt-names = "intr", "msi";
> > > +
> > > +               #interrupt-cells = <1>;
> > > +               interrupt-map-mask = <0 0 0 0>;
> > > +               interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +               bus-range = <0x00 0xff>;
> > > +               #address-cells = <3>;
> > > +               #size-cells = <2>;
> > > +
> > > +               ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
> > > +                         0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
> > > +                         0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
> > > +                         0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
> > > +                         0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
> >
> > Same here w.r.t. list bracketing.
> 
> OK
> 
> >
> > > +
> > > +               clocks = <&tegra_car TEGRA124_CLK_PCIE>,
> > > +                        <&tegra_car TEGRA124_CLK_AFI>,
> > > +                        <&tegra_car TEGRA124_CLK_PLL_E>,
> > > +                        <&tegra_car TEGRA124_CLK_CML0>;
> > > +               clock-names = "pex", "afi", "pll_e", "cml";
> > > +               resets = <&tegra_car 70>,
> > > +                        <&tegra_car 72>,
> > > +                        <&tegra_car 74>;
> > > +               reset-names = "pex", "afi", "pcie_x";
> > > +               status = "disabled";
> > > +
> > > +               phys = <&xusb_padctl TEGRA_XUSB_PADCTL_PCIE>;
> > > +               phy-names = "pcie";
> > > +
> > > +               pci at 1,0 {
> > > +                       device_type = "pci";
> > > +                       assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
> > > +                       reg = <0x000800 0 0 0 0>;
> > > +                       status = "disabled";
> > > +
> > > +                       #address-cells = <3>;
> > > +                       #size-cells = <2>;
> > > +                       ranges;
> >
> > I'm not sure why these three properties are here. Surely this is a
> > separate address space (so isn't ranges invalid?), and do we define any
> > sub-nodes anywhere?
> 
> Hmm not sure.  This was originally copied from
> arch/arm/boot/dts/tegra124.dtsi.  Will plan to drop them for now, and then
> if the properties (or ones like them) turn out to be needed in the future,
> someone else can deal with it :-)

That sounds sane to me.

> 
> >
> > > +
> > > +                       nvidia,num-lanes = <2>;
> > > +               };
> > > +
> > > +               pci at 2,0 {
> > > +                       device_type = "pci";
> > > +                       assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
> > > +                       reg = <0x001000 0 0 0 0>;
> > > +                       status = "disabled";
> > > +
> > > +                       #address-cells = <3>;
> > > +                       #size-cells = <2>;
> > > +                       ranges;
> > > +
> >
> > Likewise.
> 
> OK
> 
> >
> > > +                       nvidia,num-lanes = <1>;
> > > +               };
> > > +       };
> >
> > [...]
> >
> > > +       host1x at 0,50000000 {
> > > +               compatible = "nvidia,tegra132-host1x", "nvidia,tegra124-host1x", "simple-bus";
> >
> > Regarding simple-bus, are the sub-nodes usable if this didn't probe as
> > "nvidia,tegra124-host1x" or "nvidia,tegra132-host1x"?
> > Do the subnodes require anything from this node?
> >
> > It looks like we expect/require the host1x node to be probed and
> > initialised before we probe the children. Which would imply the
> > simple-bus annotation is wrong.
> 
> Haven't tried booting with just simple-bus here.  I believe these devices
> are accessible without the involvement of host1x.  In other words, host1x
> is not a bus; I believe it might be most accurately described as a type of
> DMA controller.  So in theory it should be possible for the CPU complex to
> read and write to these devices directly without the involvement of
> host1x, although I believe NVIDIA discourages this.
> 
> Under the theory that DT data should be hardware-specific, not
> software-specific, in an ideal world I think we would list these devices
> outside the embrace of the host1x node.  However the existing Tegra124 DT
> file listed them together, and I am unsure whether that is required for
> the host1x code to function correctly.
>
> Arto may be able to comment further.

Hmm, It would be good to hear from someone familar with that then. I'll
wait for Arto.

[...]

> > > +               ahb_gizmo: ahb-gizmo at 0,6000c004 {
> > > +                       compatible = "nvidia,tegra132-ahb", "nvidia,tegra124-ahb", "nvidia,tegra30-ahb";
> > > +                       /*
> > > +                        * This IP block actually starts at 0x6000c000,
> > > +                        * but all of the register offsets in the driver
> > > +                        * have 0x4 subtracted from them.  So handle
> > > +                        * it this way until the driver is fixed.
> > > +                        */
> > > +                       reg = <0x0 0x6000c004 0x0 0x14d>;
> > > +               };
> >
> > That doesn't sound great. Can we not fix the driver and limit that
> > mistake to existing DTBs?
> 
> We can do it that way if you think it's important to fix now.  Have been
> trying to avoid gating our initial ARM64 support on fixing all of our
> hardware misalignment problems accumulated over the years, but if you
> think it's a blocker, it can be done.

I appreciate it's a bit of a pain, but once we allow it we're stuck with
it forever, so I'd prefer that we fix these known binding issues first.

[...]

> > > +               apbmisc: apbmisc at 0,70000800 {
> > > +                       compatible = "nvidia,tegra132-apbmisc", "nvidia,tegra124-apbmisc", "nvidia,tegra20-apbmisc";
> > > +                       reg = <0x0 0x70000800 0x0 0x64>,   /* Chip revision */
> > > +                             <0x0 0x7000E864 0x0 0x04>;   /* Strapping options */
> > > +               };
> > > +
> > > +               pinmux: pinmux at 0,70000868 {
> > > +                       compatible = "nvidia,tegra132-pinmux", "nvidia,tegra124-pinmux";
> > > +                       reg = <0x0 0x70000868 0x0 0x164>,  /* Pad control registers */
> > > +                             <0x0 0x70003000 0x0 0x434>;  /* Mux registers */
> > > +               };
> > > +
> > > +               /*
> > > +                * There are two serial drivers: an 8250 based simple
> > > +                * serial driver and an APB DMA based serial driver
> > > +                * for higher baudrate and performance. To enable the
> > > +                * 8250 based driver, the compatible string is
> > > +                * "nvidia,tegra132-uart", "nvidia,tegra124-uart",
> > > +                * "nvidia,tegra20-uart" and to enable the APB DMA
> > > +                * based serial driver, the compatible string is
> > > +                * "nvidia,tegra132-hsuart", "nvidia,tegra124-hsuart",
> > > +                * "nvidia,tegra30-hsuart".
> > > +                */
> >
> > Is there any reason to continue with this split?
> >
> > Surely if the only difference is DMA, the presence of dmas and dma-names
> > should be sufficient to get the driver to do the right thing, and if you
> > need to disable DMA for debugging that could be a command-line option.
> >
> > Does the binding and/or driver support aliases so you can get consistent
> > numbering? It would be nice to have.
> >
> > Do these UARTs work with earlycon?
> >
> > It would be nice to have a /chosen/stdout-path (ideally with rate) so as
> > to get output consistently without command line options being required.
> 
> Stephen Warren might be the best person to directly respond to these
> issues.  This is all legacy DT data from previous Tegra SoCs.

Ok. I'll wait for something from Stephen.

[...]

> > > +       cpus {
> > > +               #address-cells = <2>;
> > > +               #size-cells = <0>;
> > > +
> > > +               cpu at 0 {
> > > +                       device_type = "cpu";
> > > +                       compatible = "nvidia,denver", "arm,armv8";
> > > +                       reg = <0x0 0x0>;
> > > +                       enable-method = "spin-table";
> > > +                       cpu-release-addr = <0x0 0x80000008>;
> > > +               };
> > > +
> > > +               cpu at 1 {
> > > +                       device_type = "cpu";
> > > +                       compatible = "nvidia,denver", "arm,armv8";
> > > +                       reg = <0x0 0x1>;
> > > +                       enable-method = "spin-table";
> > > +                       cpu-release-addr = <0x0 0x80000008>;
> > > +               };
> > > +       };
> >
> > It would be nice if this were near the top, as in other dts files.
> 
> OK will move.
> 
> >
> > It's a shame these share the same release address, though I guess that
> > doesn't matter too much if PSCI is forthcoming.
> >
> > I didn't spot a memory node or /memreserve/ entries. Is the memory used
> > here for the spin-table guaranteed to be protected?
> >
> > If the enable-method might change, it's probably best to leave this to
> > the bootloader to fill in, or to have it in the board files if the boot
> > loader isn't that clever (perhaps via a dtsi).
> 
> OK will drop the enable-method for the time being.

Ok.

> > > +       thermal-zones {
> > > +               /* XXX T132 CPU thermal zone - still TBD */
> > > +
> >
> > What is still TBD here?
> 
> The T132 CPU thermal zone thermal sensor data.  Specifically (and I hope
> this comes as no surprise), there's some power/thermal management data
> missing from this file that is intended to be added later.  The
> placeholder is simply to indicate that.

So the other data is correct, but just incomplete?

I'm trying to get a feel for how this is likely to change and what that
means for long-term compatibility. If what's here is sufficient but
sub-optimal, that's fine.

Thanks,
Mark.
