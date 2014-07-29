From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 29 Jul 2014 10:44:40 +0800
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <20140728180609.GE2576@leverpostej>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
Message-ID: <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 02:06, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 28, 2014 at 02:57:51PM +0100, Haojian Zhuang wrote:
>> Add hip04-d01.dts & hip04.dtsi for hip04 SoC platform.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/boot/dts/Makefile      |   1 +
>>  arch/arm/boot/dts/hip04-d01.dts |  39 ++++++
>>  arch/arm/boot/dts/hip04.dtsi    | 267 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 307 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/hip04-d01.dts
>>  create mode 100644 arch/arm/boot/dts/hip04.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 721525e..6587bbf 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
>>  dtb-$(CONFIG_ARCH_HIX5HD2) += hix5hd2-dkb.dtb
>>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>>         ecx-2000.dtb
>> +dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
>>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>>         integratorcp.dtb
>>  dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
>> diff --git a/arch/arm/boot/dts/hip04-d01.dts b/arch/arm/boot/dts/hip04-d01.dts
>> new file mode 100644
>> index 0000000..661c8e5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/hip04-d01.dts
>> @@ -0,0 +1,39 @@
>> +/*
>> + *  Copyright (C) 2013-2014 Linaro Ltd.
>> + *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  publishhed by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/* For bootwrapper */
>> +/memreserve/ 0x10c00000 0x00010000;
>
> How exactly is this bootwrapper used? Is the kernel compiled into it?
>
> It might make more sense for the wrapper build system to inject
> bootwrapper-related properties. Then the DTB is less likely to
> amalgamate hacks to workaround differences between versions, and can be
> used on systems without a wrapper without throwing away some memory.
>

In this platform, we relied on the bootwrapper. If I discard this,
I'll fail to bring up all secondary cores.

>> +
>> +#include "hip04.dtsi"
>> +
>> +/ {
>> +       /* memory bus is 64-bit */
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +       model = "Hisilicon D01 Development Board";
>> +       compatible = "hisilicon,hip04-d01";
>> +
>> +       memory at 00000000,10000000 {
>> +               device_type = "memory";
>> +               reg = <0x00000000 0x10000000 0x00000000 0xc0000000>;
>> +       };
>> +
>> +       memory at 00000004,c0000000 {
>> +               device_type = "memory";
>> +               reg = <0x00000004 0xc0000000 0x00000003 0x40000000>;
>> +       };
>
> You can fold these into a single node.
>

The address spaces of these two memory node are different.
I can't fold them into a single node.

>> +
>> +       soc {
>> +               uart0: uart at 4007000 {
>> +                       status = "ok";
>> +               };
>> +       };
>> +};
>> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
>> new file mode 100644
>> index 0000000..30942be
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/hip04.dtsi
>> @@ -0,0 +1,267 @@
>> +/*
>> + * Hisilicon Ltd. HiP04 SoC
>> + *
>> + * Copyright (C) 2013-2014 Hisilicon Ltd.
>> + * Copyright (C) 2013-2014 Linaro Ltd.
>> + *
>> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * publishhed by the Free Software Foundation.
>
> s/hh/h/
>

Thanks. I'll fix it.

> [...]
>
>> +       clock: clock {
>> +               compatible = "hisilicon,hip04-clock";
>> +               /* dummy register.
>> +                * Don't need to access clock registers since they're
>> +                * configured in firmware already.
>> +                */
>> +               reg = <0 0 0 0x1000>;
>
> Huh? Whether or not you need to access the registers should be up to the
> kernel, not the DT.
>
> Why can the kernel not access these? This sounds like a hack.
>

Because I didn't get these materials yet. All clocks are enabled in bootloader.

>> +               #clock-cells = <1>;
>> +       };
>> +
>> +       timer {
>> +               compatible = "arm,armv7-timer";
>> +               interrupt-parent = <&gic>;
>> +               interrupts = <1 13 0xf08>,
>> +                            <1 14 0xf08>,
>> +                            <1 11 0xf08>,
>> +                            <1 10 0xf08>;
>> +       };
>> +
>> +       soc {
>> +               /* It's a 32-bit SoC. */
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               compatible = "simple-bus";
>> +               interrupt-parent = <&gic>;
>> +               ranges = <0 0 0xe0000000 0x10000000>;
>> +
>> +               gic: interrupt-controller at c01000 {
>> +                       compatible = "hisilicon,hip04-gic";
>> +                       #interrupt-cells = <3>;
>> +                       #address-cells = <0>;
>> +                       interrupt-controller;
>> +                       interrupts = <1 9 0xf04>;
>> +
>> +                       reg = <0xc01000 0x1000>, <0xc02000 0x1000>,
>> +                             <0xc04000 0x2000>, <0xc06000 0x2000>;
>
> Please place these on separate lines. It's easier to read and will match
> what you've done for every other node.
>

OK

>> +               };
>> +
>> +               sysctrl: sysctrl {
>> +                       compatible = "hisilicon,sysctrl";
>> +                       reg = <0x3e00000 0x00100000>;
>> +                       relocation-entry = <0xe0000100>;
>> +                       relocation-size = <0x1000>;
>> +                       bootwrapper-phys = <0x10c00000>;
>> +                       bootwrapper-size = <0x10000>;
>> +                       bootwrapper-magic = <0xa5a5a5a5>;
>
> Are these absolute addresses, or translated per ranges above?
>
> Why are they related to the system controller?
>

I need these parameters. But I can't find a better place.

>> +               };
>> +
>> +               fabric: fabric {
>> +                       compatible = "hisilicon,hip04-fabric";
>> +                       reg = <0x302a000 0x1000>;
>
> How is this going to be used?
>

Fabric could configure snoop filter of multiple cluster. I don't have
the manual. I only know this.

>> +               };
>> +
>> +               dual_timer0: dual_timer at 3000000 {
>> +                       compatible = "arm,sp804", "arm,primecell";
>> +                       reg = <0x3000000 0x1000>;
>> +                       interrupts = <0 224 4>;
>> +                       clocks = <&clock HIP04_CLK_50M>;
>> +                       clock-names = "apb_pclk";
>> +               };
>
> I thought sp804 had two clocks (one for AMBA and one for the actual
> timer). What's going on here?
>

If only one clock is configured at here, sp804 driver believes that
clk2 is same as clk1.

Regards
Haojian
