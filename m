From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 6 Jan 2014 15:10:32 +0530
Subject: [PATCH 3/7] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <7621494.TmiSisv7PW@amdc1227>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-4-git-send-email-rahul.sharma@samsung.com>
 <7621494.TmiSisv7PW@amdc1227>
Message-ID: <CAPdUM4PO0pq9wGE0ZXF7CtMcsKFheU2HZ4XTrpOmE-cG5WosQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 10 December 2013 22:40, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Pankaj, Rahul, Arun,
>
> Please split generic SoC dtsi files and board dts files into separate
> patches. Also please see my comments inline.

I will split them to SoC and Board DT patches.

>
> On Friday 06 of December 2013 21:26:27 Rahul Sharma wrote:
>> From: Arun Kumar K <arun.kk@samsung.com>
>>
>> The patch adds the dts files for exynos5260 and for xyref
>> evt0 board.
> [snip]
>> +             gpx0: gpx0 {
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +
>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>
> Just to make sure, all your GPX banks are muxed type, with wake-up
> interrupts muxed to a single GIC interrupt line, right?

There is no combiner in 5260. Each GPX bank is connected one GIC interrupt
line.

>
>> +             };
> [snip]
>> +             cam_gpio_a: cam-gpio-a {
>> +                     samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
>> +                             "gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
>> +                             "gpe1-0", "gpe1-1";
>> +                             samsung,pin-function = <2>;
>
> Incorrect indentation.
>

Done.

>> +                     samsung,pin-pud = <0>;
>> +                     samsung,pin-drv = <0>;
>> +             };
> [snip]
>> +             hdmi_hpd_irq: hdmi-hpd-irq {
>> +                     samsung,pins = "gpx3-7";
>> +                     samsung,pin-function = <0>;
>
> Function 0 is input, not a special function. It shouldn't be handled
> this way. If a board needs to set up pull-up/down and driver strength
> for GPIO pins then it should add its own board-specific pinconf nodes
> with just pin-pud and/or pin-drv properties and without pin-function.

I moved this node to Board file. I hope that is correct.

>
>> +                     samsung,pin-pud = <1>;
>> +                     samsung,pin-drv = <0>;
>> +             };
>> +     };
> [snip]
>> +             sd0_bus1: sd0-bus-width1 {
>> +                     samsung,pins = "gpc0-3";
>> +                     samsung,pin-function = <2>;
>> +                     samsung,pin-pud = <3>;
>> +                     samsung,pin-drv = <3>;
>> +             };
>> +
>> +             sd0_bus4: sd0-bus-width4 {
>> +                     samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5", "gpc0-6";
>> +                     samsung,pin-function = <2>;
>> +                     samsung,pin-pud = <3>;
>> +                     samsung,pin-drv = <3>;
>> +             };
>> +
>> +             sd0_bus8: sd0-bus-width8 {
>> +                     samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
>> +                     samsung,pin-function = <2>;
>> +                     samsung,pin-pud = <3>;
>> +                     samsung,pin-drv = <3>;
>> +             };
>
> This is inconsistent. To specify 1- and 4-bit SD busses you need to
> include reference to just one pinconf node (sd0_bus1 or sd0_bus4), but
> for 8-bit bus you need to specify both sd0_bus4 and sd0_bus8.
>
> Please make the nodes exclusive, so you always need to specify all
> possible configurations with given wiring (e.g. with 4 wires, you can
> run in 1-bit and 4-bit modes, not just 4-bit).
>

Ok. I will remove "gpc0-3" from sdX_bus4.

> Same for remaining instances of SD bus.
>
> [snip]
>
>> diff --git a/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>> new file mode 100644
>> index 0000000..aa1fcda
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
>> @@ -0,0 +1,85 @@
>> +/*
>> + * SAMSUNG XYREF5260 EVT0 board device tree source
>> + *
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +/dts-v1/;
>> +#include "exynos5260.dtsi"
>> +
>> +/ {
>> +     model = "SAMSUNG XYREF5260 EVT0 board based on EXYNOS5260";
>> +     compatible = "samsung,xyref5260", "samsung,exynos5260";
>> +
>
> Shouldn't you have a memory node here?

I added memory node here.

>
>> +     chosen {
>> +             bootargs = "console=ttySAC2,115200";
>> +     };
>> +
>> +     fixed-rate-clocks {
>> +             oscclk {
>> +                     compatible = "samsung,exynos5260-oscclk";
>> +                     clock-frequency = <24000000>;
>> +             };
>> +     };
>
> Please use generic fixed clock bindings. You can take [1] as an example
> how to use them.
>
> [1] arch/arm/boot/dts/s3c6410-smdk6410.dtsi

Ok. I will changes this.

>
>> +
>> +     serial at 12C00000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 12C10000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 12C20000 {
>> +             status = "okay";
>> +     };
>> +
>> +     serial at 12860000 {
>
> Is it the correct UART address? It seems a bit off compared to addresses
> of other ports.
>

This is correct.

>> +             status = "okay";
>> +     };
>> +
>> +     dwmmc0 at 12140000 {
>> +             status = "okay";
>> +             num-slots = <1>;
>> +             broken-cd;
>> +             bypass-smu;
>
> This is not a valid property, according to binding documentation.
>
>> +             supports-highspeed;
>> +             supports-hs200-mode; /* 200 Mhz */
>
> Neither is this one.
>
>> +             fifo-depth = <0x40>;
>
> This is a property of the SoC, not the board.
>
>> +             card-detect-delay = <200>;
>> +             samsung,dw-mshc-ciu-div = <3>;
>> +             samsung,dw-mshc-sdr-timing = <0 4>;
>> +             samsung,dw-mshc-ddr-timing = <0 2>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> +
>> +             slot at 0 {
>> +                     reg = <0>;
>> +                     bus-width = <8>;
>> +             };
>> +     };
>> +
>> +     dwmmc2 at 12160000 {
>> +             status = "okay";
>> +             num-slots = <1>;
>> +             supports-highspeed;
>> +             fifo-depth = <0x40>;
>
> See above.

I will remove them. These are optional properties which are not being referred
in the mainline driver.

>
>> +             card-detect-delay = <200>;
>> +             samsung,dw-mshc-ciu-div = <3>;
>> +             samsung,dw-mshc-sdr-timing = <2 3>;
>> +             samsung,dw-mshc-ddr-timing = <1 2>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>> +
>> +             slot at 0 {
>> +                     reg = <0>;
>> +                     bus-width = <4>;
>> +                     disable-wp;
>> +             };
>> +     };
>> +};
>> diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
>> new file mode 100644
>> index 0000000..fcb8d4f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5260.dtsi
>> @@ -0,0 +1,315 @@
>> +/*
>> + * SAMSUNG EXYNOS5260 SoC device tree source
>> + *
>> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include "skeleton.dtsi"
>> +#include "exynos5260-pinctrl.dtsi"
>> +
>> +#include <dt-bindings/clk/exynos5260-clk.h>
>
> This won't compile, because this file hasn't been added yet by previous
> patches.
>

I will reorder the patches to ensure build doesn't break.

> Isn't it possible to reuse some of the definitions from exynos5.dtsi? How
> much different is this SoC from other SoCs from the series?

It is quite different than other Exynos5 SoCs specially the physical
address of the
IPs.

>
>> +
>> +/ {
>> +     compatible = "samsung,exynos5260";
>> +     interrupt-parent = <&gic>;
>> +
>> +     aliases {
>> +             pinctrl0 = &pinctrl_0;
>> +             pinctrl1 = &pinctrl_1;
>> +             pinctrl2 = &pinctrl_2;
>> +     };
>> +
>> +     chipid at 10000000 {
>> +             compatible = "samsung,exynos4210-chipid";
>> +             reg = <0x10000000 0x100>;
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <0>;
>> +                     cci-control-port = <&cci_control1>;
>> +             };
>> +             cpu at 1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a15";
>> +                     reg = <1>;
>> +                     cci-control-port = <&cci_control1>;
>> +             };
>> +             cpu at 2 {
>
> @unit-address suffix must match the first entry of reg property.

Ok. I will change this.

>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x100>;
>> +                     cci-control-port = <&cci_control0>;
>> +             };
>> +             cpu at 3 {
>
> Ditto.
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x101>;
>> +                     cci-control-port = <&cci_control0>;
>> +             };
>> +             cpu at 4 {
>
> Ditto.
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x102>;
>> +                     cci-control-port = <&cci_control0>;
>> +             };
>> +             cpu at 5 {
>
> Ditto.
>
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a7";
>> +                     reg = <0x103>;
>> +                     cci-control-port = <&cci_control0>;
>> +             };
>> +     };
>> +
>> +     cmus {
>
> You need compatible = "simple-bus" here if you need the nodes below
> to be instantiated.
>
> However I'm not sure if there is a point in placing them inside
> a simple-bus. This needs more thought, so please give me a bit
> more time to think over this and patches 4 and 7.

Please let me know if you have a better solution.

>
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges;
>> +
>> +             cmu_top: clock-controller at 0x10010000 {
>
> coding style: There should be no 0x prefix in @unit-address suffix.

ok. Done.

> + all the CMU instances below.
>
> [snip]
>> +
>> +     gic:interrupt-controller at 10481000 {
>
> coding style: There should be a space after the colon ending the label.
>
Done.

>> +             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>> +             #interrupt-cells = <3>;
>> +             #address-cells = <0>;
>> +             #size-cells = <0>;
>> +             interrupt-controller;
>> +             reg = <0x10481000 0x1000>,
>> +                     <0x10482000 0x1000>,
>> +                     <0x10484000 0x2000>,
>> +                     <0x10486000 0x2000>;
>> +             interrupts = <1 9 0xf04>;
>> +     };
>> +
>> +     mct at 100B0000 {
>> +             compatible = "samsung,exynos4210-mct";
>> +             reg = <0x100B0000 0xb00>;
>
> nit: Inconsistent hexadecimal character case, on Exynos in dts* files
> upper case should be used.
>
> Also the reg size looks a bit suspicious, as it's not even page aligned.
> Is it the whole area used by the MCT block, not just the used registers?
>

Done.

>> +             interrupt-controller;
>
> MCT is not an interrupt controller.
>
>> +             #interrups-cells = <2>;
>
> Ditto. This is a property specific to interrupt controllers.
>
>> +             interrupt-parent = <&mct_map>;
>> +             interrupts = <0 0>, <1 0>, <2 0>, <3 0>,
>> +                             <4 0>, <5 0>, <6 0>, <7 0>,
>> +                             <8 0>, <9 0>, <10 0>, <11 0>;
>> +             clocks = <&cmu_top FIN_PLL>, <&cmu_peri PERI_PCLK_MCT>;
>> +             clock-names = "fin_pll", "mct";
>> +
>> +             mct_map: mct-map {
>> +                     #interrupt-cells = <2>;
>
> Why two cells are needed? Using just one woudl simplify interrupt
> specifiers above and interrupt-map specifiers below.
>

Done.

>> +                     #address-cells = <0>;
>> +                     #size-cells = <0>;
>> +                     interrupt-map = <0x0 0 &gic 0 104 0>,
>> +                                     <0x1 0 &gic 0 105 0>,
>> +                                     <0x2 0 &gic 0 106 0>,
>> +                                     <0x3 0 &gic 0 107 0>,
>> +                                     <0x4 0 &gic 0 122 0>,
>> +                                     <0x5 0 &gic 0 123 0>,
>> +                                     <0x6 0 &gic 0 124 0>,
>> +                                     <0x7 0 &gic 0 125 0>,
>> +                                     <0x8 0 &gic 0 126 0>,
>> +                                     <0x9 0 &gic 0 127 0>,
>> +                                     <0xa 0 &gic 0 128 0>,
>> +                                     <0xb 0 &gic 0 129 0>;
>> +             };
>> +     };
>> +
>> +     cci at 10F00000 {
>> +             compatible = "arm,cci-400";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             reg = <0x10F00000 0x1000>;
>> +             ranges = <0x0 0x10F00000 0x6000>;
>> +
>> +             cci_control0: slave-if at 4000 {                   /* Please check again */
>
> Huh? Please check again and send correct data.
>
>> +                     compatible = "arm,cci-400-ctrl-if";
>> +                     interface-type = "ace";
>> +                     reg = <0x4000 0x1000>;                  /* Please check again */
>> +             };
>> +
>> +             cci_control1: slave-if at 5000 {                   /* Please check again */
>> +                     compatible = "arm,cci-400-ctrl-if";
>> +                     interface-type = "ace";
>> +                     reg = <0x5000 0x1000>;                  /* Please check again */
>> +             };
>> +     };
>> +
>> +     pinctrl_0: pinctrl at 11600000 {
>> +             compatible = "samsung,exynos5260-pinctrl";
>> +             reg = <0x11600000 0x1000>;
>> +             interrupts = <0 79 0>;                          /* GPIO_RT */
>
> Instead of using such comment, maybe it would be better to rename
> labels of pinctrl nodes to be more meaningful, such as pinctrl_rt,
> pinctrl_fsys and pinctrl_aud?

I removed the comments.

>
>> +
>> +             wakeup-interrupt-controller {
>> +                     compatible = "samsung,exynos4210-wakeup-eint";
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0 32 0>;
>> +             };
>> +     };
> [snip]
>> +
>> +     dwmmc_0: dwmmc0 at 12140000 {
>
> Please use generic "mmc@" names for MMC nodes and move fifo-depth property
> here to SoC-level dtsi.

Done.

Regards,
Rahul Sharma.

>
> Best regards,
> Tomasz
>
