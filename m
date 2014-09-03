From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 3 Sep 2014 13:25:02 +0530
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <53FDC155.1070506@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <53FDC155.1070506@samsung.com>
Message-ID: <CAHfPSqB1_ovDYSBU4trPaEZ7PYGuqFkeOw07mQLkgTU+iv_Ymw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 27 August 2014 17:00, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Naveen,
>
> Please see my comments inline.
>
> On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
>> Add initial device tree nodes for EXYNOS7 SoC.
>> Also, includes the dt-binding definitions for clock ids.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/boot/dts/exynos7.dtsi |  553 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 553 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos7.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/exynos7.dtsi b/arch/arm64/boot/dts/exynos7.dtsi
>> new file mode 100644
>> index 0000000..6b9eaf4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos7.dtsi
>> @@ -0,0 +1,553 @@
>> +/*
>> + * SAMSUNG EXYNOS7 SoC device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *           http://www.samsung.com
>> + *
>> + * SAMSUNG EXYNOS7 SoC device nodes are listed in this file.
>> + * EXYNOS7 based board files can include this file and provide
>> + * values for board specfic bindings.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <dt-bindings/clock/exynos7-clk.h>
>> +
>> +/ {
>> +     compatible = "samsung,exynos7";
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <1>;
>> +     #size-cells = <1>;
>> +
>> +     aliases {
>> +             pinctrl0 = &pinctrl_0;
>> +             pinctrl1 = &pinctrl_1;
>> +             pinctrl2 = &pinctrl_2;
>> +             pinctrl3 = &pinctrl_3;
>> +             pinctrl4 = &pinctrl_4;
>> +             pinctrl5 = &pinctrl_5;
>> +             pinctrl6 = &pinctrl_6;
>> +             pinctrl7 = &pinctrl_7;
>> +             pinctrl8 = &pinctrl_8;
>> +             pinctrl9 = &pinctrl_9;
>> +             mshc0 = &mmc_0;
>> +             mshc2 = &mmc_2;
>
> Please add aliases for serial controllers. Refer to relevant DT binding
> documentation for more information.

Ok.

>
>> +     };
>> +
>> +     chipid at 10000000 {
>> +             compatible = "samsung,exynos4210-chipid";
>> +             reg = <0x10000000 0x100>;
>> +     };
>
> Please put SoC components (except cpus node) under a simple-bus node
> called "soc". Please see exynos5260.dtsi as an example.

Ok.

>
>> +
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a57", "arm,armv8";
>> +                     reg = <0x0 0x0>;
>> +             };
>
> Does this SoC really has only one CPU or this is a workaround for things
> like missing CPU bring-up code?
>
>> +     };
>
> [snip]
>
>> +     mct at 101C0000 {
>> +             compatible = "samsung,exynos4210-mct";
>> +             reg = <0x101C0000 0x800>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <1>;
>
> MCT is not an interrupt controller.
>
>> +             interrupt-parent = <&mct_map>;
>> +             interrupts =    <0>, <1>, <2>, <3>,
>> +                             <4>, <5>, <6>, <7>,
>> +                             <8>, <9>, <10>, <11>;
>> +             clocks = <&fin_pll>, <&clock_peris PCLK_MCT>;
>> +             clock-names = "fin_pll", "mct";
>> +
>> +             mct_map: mct-map {
>> +                     #interrupt-cells = <1>;
>> +                     #address-cells = <0>;
>> +                     #size-cells = <0>;
>> +                     interrupt-map = <0 &gic 0 112 0>,
>> +                                     <1 &gic 0 113 0>,
>> +                                     <2 &gic 0 114 0>,
>> +                                     <3 &gic 0 115 0>,
>> +                                     <4 &gic 0 116 0>,
>> +                                     <5 &gic 0 117 0>,
>> +                                     <6 &gic 0 118 0>,
>> +                                     <7 &gic 0 119 0>,
>> +                                     <8 &gic 0 120 0>,
>> +                                     <9 &gic 0 121 0>,
>> +                                     <10 &gic 0 122 0>,
>> +                                     <11 &gic 0 123 0>;
>
> All inputs of this interrupt map come from the same interrupt
> controller. What's the point of this map then?
>
>> +             };
>> +     };
>> +
>> +     mmc_0: mmc at 15740000 {
>> +             compatible = "samsung,exynos7-dw-mshc-smu";
>> +             interrupts = <0 201 0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             reg = <0x15740000 0x2000>;
>> +             clocks = <&clock_fsys1 ACLK_MMC0>,
>> +                     <&clock_top1 CLK_SCLK_MMC0>;
>> +             clock-names = "biu", "ciu";
>> +             fifo-depth = <0x40>;
>> +             status = "disabled";
>> +     };
>> +
>> +     mmc_2: mmc at 15560000 {
>> +             compatible = "samsung,exynos7-dw-mshc-smu";
>> +             interrupts = <0 216 0>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             reg = <0x15560000 0x2000>;
>> +             clocks = <&clock_fsys0 ACLK_MMC2>,
>> +                     <&clock_top1 CLK_SCLK_MMC2>;
>> +             clock-names = "biu", "ciu";
>> +             fifo-depth = <0x40>;
>> +             status = "disabled";
>> +     };
>> +
>> +     pinctrl_0: pinctrl at 10580000 {
>> +             compatible = "samsung,exynos7-pinctrl";
>> +             reg = <0x10580000 0x1000>;
>> +             interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
>> +                             <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
>> +                             <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
>> +                             <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
>
> According to patch 5/14, this bank supports only wake-up interrupts.
> Their interrupt specifiers should be specified either in the wake-up
> interrupt controller node (for muxed wake-up interrupts) or in nodes of
> respective banks (for direct wake-up interrupts).

Ok, will fix.

>
>> +             wakeup-interrupt-controller {
>> +                     compatible = "samsung,exynos4210-wakeup-eint";
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0 16 0>;
>> +             };
>> +     };
>
> [snip]
>
>> +     serial at 13630000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x13630000 0x100>;
>> +             interrupts = <0 440 0>;
>> +             clocks = <&clock_peric0 PCLK_UART0>, <&clock_peric0 SCLK_UART0>;
>> +             clock-names = "uart", "clk_uart_baud0";
>> +             status = "okay";
>
> No need to explicitly specify the status as "okay" in top level dtsi file.

Ok. Fixed.

>
>> +     };
>> +
>> +     serial at 14C20000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x14C20000 0x100>;
>> +             interrupts = <0 456 0>;
>> +             clocks = <&clock_peric1 PCLK_UART1>, <&clock_peric1 SCLK_UART1>;
>> +             clock-names = "uart", "clk_uart_baud1";
>
> The "clk_uart_baud1" clock doesn't seem right. The N in "clk_uart_baudN"
> stands for the input of internal clock source mux, not index of the IP
> block in the SoC. Please make sure this is defined correctly.

Right. That was a mistake. This is fixed.

>
>> +             status = "okay";
>
> Ditto.
>
>> +     };
>> +
>> +     serial at 14C30000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x14C30000 0x100>;
>> +             interrupts = <0 457 0>;
>> +             clocks = <&clock_peric1 PCLK_UART2>, <&clock_peric1 SCLK_UART2>;
>> +             clock-names = "uart", "clk_uart_baud2";
>
> Ditto.
>
>> +             status = "okay";
>
> Ditto.
>
>> +     };
>> +
>> +     serial at 14C40000 {
>> +             compatible = "samsung,exynos4210-uart";
>> +             reg = <0x14C40000 0x100>;
>> +             interrupts = <0 458 0>;
>> +             clocks = <&clock_peric1 PCLK_UART3>, <&clock_peric1 SCLK_UART3>;
>> +             clock-names = "uart", "clk_uart_baud3";
>
> Ditto.
>
>> +             status = "okay";
>
> Ditto.
>
> Best regards,
> Tomasz

Thanks for your comments.

-- 
Shine bright,
(: Nav :)
