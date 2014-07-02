From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Jul 2014 12:14:35 +0100
Subject: [PATCH 1/5] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <1404291772-2644-2-git-send-email-jingchang.lu@freescale.com>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
 <1404291772-2644-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140702111435.GD14665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a general note, there seem to be many nodes for which bindings and
drivers do not yet exist.

For those nodes which are unusable for reasons other than their status
being "disabled", I would prefer that they were removed. They're useless
now, and might not match the bindings that are eventually decided upon,
which will result in annoying churn and possible breakage.

On Wed, Jul 02, 2014 at 10:02:48AM +0100, Jingchang Lu wrote:
> From: Jingchang Lu <b35083@freescale.com>
>
> Add Freescale LS1021A SoC device tree support
>
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Adrian Sendroiu <adrian.sendroiu@freescale.com>
> Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Chao Fu <b44548@freescale.com>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 852 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 852 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ls1021a.dtsi
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> new file mode 100644
> index 0000000..b06b320
> --- /dev/null
> +++ b/arch/arm/boot/dts/ls1021a.dtsi

[...]

> +       memory {
> +               reg = <0x0 0x80000000 0x0 0x20000000>;
> +       };

Missing device_type = "memory";

For unit-address and reg consistency, this should be memory at 0,80000000.

> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <0xf00>;
> +               };

That reg doesn't match the unit-address, which should be cpu at f00.

Why is MPIDR.Aff1 == 0xf?

> +
> +               cpu at 1 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <0xf01>;
> +               };

Likewise.

[...]

> +       soc {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               compatible = "simple-bus";

Please put the compatible first out of all properties, it makes it far
easier to read the DTS.

Please do that for other nodes too.

> +               interrupt-parent = <&gic>;
> +               ranges;
> +
> +               gic: interrupt-controller at 1400000 {
> +                       compatible = "arm,cortex-a15-gic";
> +                       #interrupt-cells = <3>;
> +                       interrupt-controller;
> +                       reg = <0x0 0x1401000 0x0 0x1000>,
> +                               <0x0 0x1402000 0x0 0x1000>,
> +                               <0x0 0x1404000 0x0 0x2000>,
> +                               <0x0 0x1406000 0x0 0x2000>;
> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +
> +               };
> +
> +               tzasc: tzasc at 1500000 {
> +                       reg = <0x0 0x1500000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };

There's no compatible string and "tzasc" doesn't appear to be handled
magically anywhere, so this can't be probed even without the status
property being "disabled".

Why is this here?

> +
> +               ifc: ifc at 1530000 {
> +                       compatible = "fsl,ls1021a-ifc", "fsl,ifc", "simple-bus";

This doesn't seem to have any children, ranges, #address-cells, or
#size-cells. So why is "simple-bus" in the compatible list?

As far as I can see this is a flash controller, so "simple-bus" doesn't
make any sense whatsoever (and existing uses, including that in the
binding are a bug).

> +                       reg = <0x0 0x1530000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               dcfg: dcfg at 1ee0000 {
> +                       compatible = "fsl,ls1021a-dcfg";
> +                       reg = <0x0 0x1ee0000 0x0 0x10000>;
> +               };

Undocumented/unsupported binding.

What is this?

> +               qspi: quadspi at 1550000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "fsl,vf610-qspi";

Please put the compatible string first. It makes it easier to find.

> +                       reg = <0x0 0x1550000 0x0 0x10000>;

Missing the second reg entry? The binding didn't state it was optional.

> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "qspi_en", "qspi";
> +                       clocks = <&platform_clk 1>, <&platform_clk 1>;

Normally we put $X before $X-names properties.

I note that these clock-names are poorly documented. It would be nice to
see that fixed up.

> +                       big-endian;

The binding doesn't mention this. Does the driver support it?

> +                       amba-base = <0x40000000>;

The string "amba-base" shows up nowhere in mainline. What is this, and
why is it here?

[...]

> +               scfg: scfg at 1570000 {
> +                       compatible = "fsl,ls1021a-scfg";
> +                       reg = <0x0 0x1570000 0x0 0x10000>;
> +               };

Undocumented/unsupported binding.

What is this?

[...]

> +               rcpm: rcpm at 1ee2000 {
> +                       compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1";
> +                       reg = <0x0 0x1ee2000 0x0 0x10000>;
> +               };

Undocumented/unsupported binding (both compatible strings).

What is this?

[...]

> +               gpio1: gpio at 2300000 {
> +                       compatible = "fsl,ls1021a-gpio";
> +                       reg = <0x0 0x2300000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };

Undocumented/unsupported binding.

[...]

> +               lpuart1: serial at 2960000 {
> +                       compatible = "fsl,ls1021a-lpuart";
> +                       reg = <0x0 0x2960000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "ipg";
> +                       status = "disabled";
> +               };

Undocumented/unsupported binding.

[...]

> +               ftm2: ftm at 29f0000 {
> +                       reg = <0x0 0x29f0000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };

Missing compatible strings.

[...]

> +               ftm5: ftm at 2a20000 {
> +                       reg = <0x0 0x2a20000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +                       status = "disabled";
> +               };

Missing compatible strings.

[...]

> +               wdog0: wdog at 2ad0000 {
> +                       compatible = "fsl,ls1021a-wdt", "fsl,imx21-wdt";
> +                       reg = <0x0 0x2ad0000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "wdog";
> +                       big-endian;
> +               };

That clock name looks aribitrary, and "fsl,imx21-wdt" isn't documented
as taking a clock.

What is going on here?

[...]

> +               can0: can at 2a70000 {
> +                       compatible = "fsl,ls1021a-flexcan";
> +                       reg = <0x0 0x2a70000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "per";
> +                       status = "disabled";
> +               };

Undocumented/unsupported binding.

Was this mean to have an existing compatible string in the list?

> +
> +               can1: can at 2a80000 {
> +                       compatible = "fsl,ls1021a-flexcan";
> +                       reg = <0x0 0x2a80000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "per";
> +                       status = "disabled";
> +               };
> +
> +               can2: can at 2a90000 {
> +                       compatible = "fsl,ls1021a-flexcan";
> +                       reg = <0x0 0x2a90000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "per";
> +                       status = "disabled";
> +               };
> +
> +               can3: can at 2aa0000 {
> +                       compatible = "fsl,ls1021a-flexcan";
> +                       reg = <0x0 0x2aa0000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&platform_clk 1>;
> +                       clock-names = "per";
> +                       status = "disabled";
> +               };
> +       };
> +
> +       dcsr at 20000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "fsl,ls1021a-dcsr", "simple-bus";

Missing a reg entry? Or is the unit-address arbitrary?

The "fsl,ls1021a-dcsr" string is undocumented/unsupported, as with the
compatible strings of all the child nodes below.

Thanks,
Mark.

> +
> +               ranges = <0x0 0x0 0x20000000 0x1000000>;
> +
> +               dcsr-epu at 0 {
> +                       compatible = "fsl,ls1021a-dcsr-epu";
> +                       reg = <0x0 0x10000>;
> +               };
> +
> +               dcsr-gdi at 100000 {
> +                       compatible = "fsl,ls1021a-dcsr-gdi";
> +                       reg = <0x100000 0x10000>;
> +               };
> +
> +               dcsr-dddi at 120000 {
> +                       compatible = "fsl,ls1021a-dcsr-dddi";
> +                       reg = <0x120000 0x10000>;
> +               };
> +
> +               dcsr-dcfg at 220000 {
> +                       compatible = "fsl,ls1021a-dcsr-dcfg";
> +                       reg = <0x220000 0x1000>;
> +               };
> +
> +               dcsr-clock at 221000 {
> +                       compatible = "fsl,ls1021a-dcsr-clock";
> +                       reg = <0x221000 0x1000>;
> +               };
> +
> +               dcsr-rcpm at 222000 {
> +                       compatible = "fsl,ls1021a-dcsr-rcpm";
> +                       reg = <0x222000 0x1000 0x223000 0x1000>;
> +               };
> +
> +               dcsr-ccp at 225000 {
> +                       compatible = "fsl,ls1021a-dcsr-ccp";
> +                       reg = <0x225000 0x1000>;
> +               };
> +
> +               dcsr-fusectrl at 226000 {
> +                       compatible = "fsl,ls1021a-dcsr-fusectrl";
> +                       reg = <0x226000 0x1000>;
> +               };
> +
> +               dcsr-dap at 300000 {
> +                       compatible = "fsl,ls1021a-dcsr-dap";
> +                       reg = <0x300000 0x10000>;
> +               };
> +
> +               dcsr-cstf at 350000 {
> +                       compatible = "fsl,ls1021a-dcsr-cstf";
> +                       reg = <0x350000 0x1000 0x3a7000 0x1000>;
> +               };
> +
> +               dcsr-a7rom at 360000 {
> +                       compatible = "fsl,ls1021a-dcsr-a7rom";
> +                       reg = <0x360000 0x10000>;
> +               };
> +
> +               dcsr-a7cpu at 370000 {
> +                       compatible = "fsl,ls1021a-dcsr-a7cpu";
> +                       reg = <0x370000 0x8000>;
> +               };
> +
> +               dcsr-a7cti at 378000 {
> +                       compatible = "fsl,ls1021a-dcsr-a7cti";
> +                       reg = <0x378000 0x4000>;
> +               };
> +
> +               dcsr-etm at 37c000 {
> +                       compatible = "fsl,ls1021a-dcsr-etm";
> +                       reg = <0x37c000 0x1000 0x37d000 0x3000>;
> +               };
> +
> +               dcsr-hugorom at 3a0000 {
> +                       compatible = "fsl,ls1021a-dcsr-hugorom";
> +                       reg = <0x3a0000 0x1000>;
> +               };
> +
> +               dcsr-etf at 3a1000 {
> +                       compatible = "fsl,ls1021a-dcsr-etf";
> +                       reg = <0x3a1000 0x1000 0x3a2000 0x1000>;
> +               };
> +
> +               dcsr-etr at 3a3000 {
> +                       compatible = "fsl,ls1021a-dcsr-etr";
> +                       reg = <0x3a3000 0x1000>;
> +               };
> +
> +               dcsr-cti at 3a4000 {
> +                       compatible = "fsl,ls1021a-dcsr-cti";
> +                       reg = <0x3a4000 0x1000 0x3a5000 0x1000 0x3a6000 0x1000>;
> +               };
> +
> +               dcsr-atbrepl at 3a8000 {
> +                       compatible = "fsl,ls1021a-dcsr-atbrepl";
> +                       reg = <0x3a8000 0x1000>;
> +               };
> +
> +               dcsr-tsgen-ctrl at 3a9000 {
> +                       compatible = "fsl,ls1021a-dcsr-tsgen-ctrl";
> +                       reg = <0x3a9000 0x1000>;
> +               };
> +
> +               dcsr-tsgen-read at 3aa000 {
> +                       compatible = "fsl,ls1021a-dcsr-tsgen-read";
> +                       reg = <0x3aa000 0x1000>;
> +               };
> +       };
> +};
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
