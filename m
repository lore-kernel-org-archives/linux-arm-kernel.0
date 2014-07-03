From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Jul 2014 11:10:36 +0100
Subject: [PATCH 1/5] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <c0f6813bc62a41b19790158d761d6652@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
 <1404291772-2644-2-git-send-email-jingchang.lu@freescale.com>
 <20140702111435.GD14665@leverpostej>
 <c0f6813bc62a41b19790158d761d6652@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140703101036.GE29837@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 08:58:04AM +0100, Jingchang Lu wrote:
> >-----Original Message-----
> >From: Mark Rutland [mailto:mark.rutland at arm.com]
> >Sent: Wednesday, July 02, 2014 7:15 PM
> >To: Lu Jingchang-B35083
> >Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
> >devicetree at vger.kernel.org; Lu Jingchang-B35083; Badola Nikhil-B46172;
> >Zhao Chenhui-B35336; Gupta Suresh-B42813; Leekha Shaveta-B20052; Sendroiu
> >Adrian-B46904; Gupta Ruchika-R66431; Sharma Bhupesh-B45370; Fu Chao-B44548;
> >Xiubo Li-B47053
> >Subject: Re: [PATCH 1/5] ARM: dts: Add SoC level device tree support for
> >LS1021A
> >
> >Hi,
> >
> >As a general note, there seem to be many nodes for which bindings and
> >drivers do not yet exist.
> >
> >For those nodes which are unusable for reasons other than their status
> >being "disabled", I would prefer that they were removed. They're useless
> >now, and might not match the bindings that are eventually decided upon,
> >which will result in annoying churn and possible breakage.
> >
> Thanks for help review these patches, I will revise the node as your comment.
> The LS1021A shares IP and driver with i.MX, Vybrid and PowerPC, some driver's
> behavior minor different between them, so patches is needed to make them work
> well between different platform and architecture. Thus some compatible include
> undocumented string, could it be added along with the driver support after the
> platform support is accepted? Thanks.

Those nodes in the DT which are useless at the moment should be dropped.
There's no point having them there.

We can add them when driver support is added, along with documentation.

[...]

> >> +
> >> +       cpus {
> >> +               #address-cells = <1>;
> >> +               #size-cells = <0>;
> >> +
> >> +               cpu at 0 {
> >> +                       compatible = "arm,cortex-a7";
> >> +                       device_type = "cpu";
> >> +                       reg = <0xf00>;
> >> +               };
> >
> >That reg doesn't match the unit-address, which should be cpu at f00.
> >
> >Why is MPIDR.Aff1 == 0xf?
> The MPIDR value got from the SoC is 80000f00, so to match this the reg is set to x0f00.
> Thanks.

Ok. Please update the unit-address on the nodes to match.

> >[...]
> >> +
> >> +               tzasc: tzasc at 1500000 {
> >> +                       reg = <0x0 0x1500000 0x0 0x10000>;
> >> +                       interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       status = "disabled";
> >> +               };
> >
> >There's no compatible string and "tzasc" doesn't appear to be handled
> >magically anywhere, so this can't be probed even without the status
> >property being "disabled".
> I will remove this and all other unused node, it is not used currently. Thanks.

Thanks.

> >
> >
> >> +
> >> +               ifc: ifc at 1530000 {
> >> +                       compatible = "fsl,ls1021a-ifc", "fsl,ifc",
> >> + "simple-bus";
> >
> >This doesn't seem to have any children, ranges, #address-cells, or #size-
> >cells. So why is "simple-bus" in the compatible list?
> >
> >As far as I can see this is a flash controller, so "simple-bus" doesn't
> >make any sense whatsoever (and existing uses, including that in the
> >binding are a bug).
> Yes, it is a flash controller, the child nodes, ranges are in the <ls1021a-board>.dts.
> Here only describe the SoC level device and resource.
> I will remove the "simple-bus" string, Thanks.

Ok.

> >
> >> +                       reg = <0x0 0x1530000 0x0 0x10000>;
> >> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> >> +               };
> >> +
> >> +               dcfg: dcfg at 1ee0000 {
> >> +                       compatible = "fsl,ls1021a-dcfg";
> >> +                       reg = <0x0 0x1ee0000 0x0 0x10000>;
> >> +               };
> >
> >Undocumented/unsupported binding.
> >
> >What is this?
> It is the device configuration unit that provides general purpose configuration and status
> for the device, there isn't a dedicate driver for it, device that has configuration and status
> register located in this space could operate on it. Currently it is used to set the secondary
> core start address and release the secondary core from holdoff and startup. Thanks.

Then we should document it.

[...]

> >
> >> +                       big-endian;
> >
> >The binding doesn't mention this. Does the driver support it?
> >
> >> +                       amba-base = <0x40000000>;
> >
> >The string "amba-base" shows up nowhere in mainline. What is this, and why
> >is it here?
> >
> >[...]
> >
> >> +               scfg: scfg at 1570000 {
> >> +                       compatible = "fsl,ls1021a-scfg";
> >> +                       reg = <0x0 0x1570000 0x0 0x10000>;
> >> +               };
> >
> >Undocumented/unsupported binding.
> >
> >What is this?
> It is the supplemental configuration unit, provides SoC specific configuration and status
> registers for the device. Some device driver need this space to configure or get status.
> If this is need document, which location is suitable for its document?
> Thanks.

Documentation/devicetree/bindings/soc/ ?

> >
> >[...]
> >
> >> +               rcpm: rcpm at 1ee2000 {
> >> +                       compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-
> >rcpm-2.1";
> >> +                       reg = <0x0 0x1ee2000 0x0 0x10000>;
> >> +               };
> >
> >Undocumented/unsupported binding (both compatible strings).
> >
> >What is this?
> The Run Control and Power Management (RCPM) module performs all device-level tasks associated with
> device run control and power management. It will be used by the PM driver currently. Thanks.

As far as I can see this is _not_ used currently; both strings appear
nowhere in mainline.

Drop the node for now. It can be added alongside the driver and binding.

> >
> >[...]
> >
> >> +               gpio1: gpio at 2300000 {
> >> +                       compatible = "fsl,ls1021a-gpio";
> >> +                       reg = <0x0 0x2300000 0x0 0x10000>;
> >> +                       interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       gpio-controller;
> >> +                       #gpio-cells = <2>;
> >> +                       interrupt-controller;
> >> +                       #interrupt-cells = <2>;
> >> +               };
> >
> >Undocumented/unsupported binding.
> The bind document will be add along with the SoC platform support patch for it. Thanks.

Drop the node for now.

> >
> >[...]
> >
> >> +               lpuart1: serial at 2960000 {
> >> +                       compatible = "fsl,ls1021a-lpuart";
> >> +                       reg = <0x0 0x2960000 0x0 0x1000>;
> >> +                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "ipg";
> >> +                       status = "disabled";
> >> +               };
> >
> >Undocumented/unsupported binding.
> I will add the bind document for this. Thanks.

Ok.

> >
> >[...]
> >
> >[...]
> >
> >> +               wdog0: wdog at 2ad0000 {
> >> +                       compatible = "fsl,ls1021a-wdt", "fsl,imx21-wdt";
> >> +                       reg = <0x0 0x2ad0000 0x0 0x10000>;
> >> +                       interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "wdog";
> >> +                       big-endian;
> >> +               };
> >
> >That clock name looks aribitrary, and "fsl,imx21-wdt" isn't documented as
> >taking a clock.
> >
> >What is going on here?
> The imx2_wdt driver need the clock, the clock name is not used, should it be removed?
> and maybe the document is omitted, we'll check and add it subsequently. Thanks.

Either document the clock name and make sure it's used consistently, or
drop it. The latter seems like the easiest approach.

> >
> >[...]
> >
> >> +               can0: can at 2a70000 {
> >> +                       compatible = "fsl,ls1021a-flexcan";
> >> +                       reg = <0x0 0x2a70000 0x0 0x1000>;
> >> +                       interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "per";
> >> +                       status = "disabled";
> >> +               };
> >
> >Undocumented/unsupported binding.
> >
> >Was this mean to have an existing compatible string in the list?
> There will be fsl,ls1021a-flexcan support after the platform support is accepted,
> It is list here just for the SoC level device resource.

Add the node when you add support. Drop it for now.

> >
> >> +
> >> +               can1: can at 2a80000 {
> >> +                       compatible = "fsl,ls1021a-flexcan";
> >> +                       reg = <0x0 0x2a80000 0x0 0x1000>;
> >> +                       interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "per";
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               can2: can at 2a90000 {
> >> +                       compatible = "fsl,ls1021a-flexcan";
> >> +                       reg = <0x0 0x2a90000 0x0 0x1000>;
> >> +                       interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "per";
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               can3: can at 2aa0000 {
> >> +                       compatible = "fsl,ls1021a-flexcan";
> >> +                       reg = <0x0 0x2aa0000 0x0 0x1000>;
> >> +                       interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&platform_clk 1>;
> >> +                       clock-names = "per";
> >> +                       status = "disabled";
> >> +               };
> >> +       };
> >> +
> >> +       dcsr at 20000000 {
> >> +               #address-cells = <1>;
> >> +               #size-cells = <1>;
> >> +               compatible = "fsl,ls1021a-dcsr", "simple-bus";
> >
> >Missing a reg entry? Or is the unit-address arbitrary?
> >
> >The "fsl,ls1021a-dcsr" string is undocumented/unsupported, as with the
> >compatible strings of all the child nodes below.
> >
> >Thanks,
> >Mark.
> It share the drive with PowerPC SoCs, the reg here is not used, only the child node's will
> be used. Thanks.

Ok. So drop the unit-address.

Thanks,
Mark.
