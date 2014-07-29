From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 29 Jul 2014 18:58:56 +0800
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <20140729035321.GA8430@quad.lixom.net>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
 <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
 <20140729035321.GA8430@quad.lixom.net>
Message-ID: <CAD6h2NQomwTm3a06j5FbCVP9bdFqBkfTCCL1phaZRfH3XUCgOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 11:53, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
>
> On Tue, Jul 29, 2014 at 10:44:40AM +0800, Haojian Zhuang wrote:
>> On 29 July 2014 02:06, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Mon, Jul 28, 2014 at 02:57:51PM +0100, Haojian Zhuang wrote:
>> >> +/*
>> >> + *  Copyright (C) 2013-2014 Linaro Ltd.
>> >> + *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> >> + *
>> >> + *  This program is free software; you can redistribute it and/or modify
>> >> + *  it under the terms of the GNU General Public License version 2 as
>> >> + *  publishhed by the Free Software Foundation.
>> >> + */
>> >> +
>> >> +/dts-v1/;
>> >> +
>> >> +/* For bootwrapper */
>> >> +/memreserve/ 0x10c00000 0x00010000;
>> >
>> > How exactly is this bootwrapper used? Is the kernel compiled into it?
>> >
>> > It might make more sense for the wrapper build system to inject
>> > bootwrapper-related properties. Then the DTB is less likely to
>> > amalgamate hacks to workaround differences between versions, and can be
>> > used on systems without a wrapper without throwing away some memory.
>> >
>>
>> In this platform, we relied on the bootwrapper. If I discard this,
>> I'll fail to bring up all secondary cores.
>
> What is this memory used for? Is this where the cores are parked on the spin
> table, or something else? Does your platform have runtime firmware?
>

This memory stores the instructions that secondary cores will execute initially.

They will switch cores into non-secure & hyp mode.

There's no runtime firmware in this platform. And there's no schedule
to support it.

>> >> +
>> >> +#include "hip04.dtsi"
>> >> +
>> >> +/ {
>> >> +       /* memory bus is 64-bit */
>> >> +       #address-cells = <2>;
>> >> +       #size-cells = <2>;
>> >> +       model = "Hisilicon D01 Development Board";
>> >> +       compatible = "hisilicon,hip04-d01";
>> >> +
>> >> +       memory at 00000000,10000000 {
>> >> +               device_type = "memory";
>> >> +               reg = <0x00000000 0x10000000 0x00000000 0xc0000000>;
>> >> +       };
>> >> +
>> >> +       memory at 00000004,c0000000 {
>> >> +               device_type = "memory";
>> >> +               reg = <0x00000004 0xc0000000 0x00000003 0x40000000>;
>> >> +       };
>> >
>> > You can fold these into a single node.
>> >
>>
>> The address spaces of these two memory node are different.
>> I can't fold them into a single node.
>
> There's no functional difference today between having two memory nodes or one
> node with two ranges. It would be:
>         memory at 0 {
>                 device_type = "memory";
>                 reg = <0x00000000 0x10000000 0x00000000 0xc0000000>,
>                       <0x00000004 0xc0000000 0x00000003 0x40000000>;
>

OK.

>> >> +
>> >> +       soc {
>> >> +               uart0: uart at 4007000 {
>> >> +                       status = "ok";
>> >> +               };
>> >> +       };
>> >> +};
>> >> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
>> >> new file mode 100644
>> >> index 0000000..30942be
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/hip04.dtsi
>> >> @@ -0,0 +1,267 @@
>> >> +/*
>> >> + * Hisilicon Ltd. HiP04 SoC
>> >> + *
>> >> + * Copyright (C) 2013-2014 Hisilicon Ltd.
>> >> + * Copyright (C) 2013-2014 Linaro Ltd.
>> >> + *
>> >> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License version 2 as
>> >> + * publishhed by the Free Software Foundation.
>> >
>> > s/hh/h/
>> >
>>
>> Thanks. I'll fix it.
>>
>> > [...]
>> >
>> >> +       clock: clock {
>> >> +               compatible = "hisilicon,hip04-clock";
>> >> +               /* dummy register.
>> >> +                * Don't need to access clock registers since they're
>> >> +                * configured in firmware already.
>> >> +                */
>> >> +               reg = <0 0 0 0x1000>;
>> >
>> > Huh? Whether or not you need to access the registers should be up to the
>> > kernel, not the DT.
>> >
>> > Why can the kernel not access these? This sounds like a hack.
>> >
>>
>> Because I didn't get these materials yet. All clocks are enabled in bootloader.
>
> What materials? Technical documentation for the CPU you're upstreaming?
>
> It seems like a very bad idea to upstream a DT for a CPU that you don't
> have documentation for. It seems appropriate to wait until you have
> documentation so you can make sure that the hardware you're describing
> is actually what is there, and not something made-up or misdescribed.
>
>> >> +               };
>> >> +
>> >> +               sysctrl: sysctrl {
>> >> +                       compatible = "hisilicon,sysctrl";
>> >> +                       reg = <0x3e00000 0x00100000>;
>> >> +                       relocation-entry = <0xe0000100>;
>> >> +                       relocation-size = <0x1000>;
>> >> +                       bootwrapper-phys = <0x10c00000>;
>> >> +                       bootwrapper-size = <0x10000>;
>> >> +                       bootwrapper-magic = <0xa5a5a5a5>;
>> >
>> > Are these absolute addresses, or translated per ranges above?
>> >
>> > Why are they related to the system controller?
>> >
>>
>> I need these parameters. But I can't find a better place.
>
> Again, what is the boot wrapper in this case? And what do you need them for?
>

Now UEFI didn't switch secondary cores to non-secure & hyp mode. The
bootwrapper is used to handle this job. Then bootwrapper will jump to
kernel to continue boot SMP. So the relocation area is used to store
the SMP entrance.

SMP feature will fail without bootwrapper in this platform.

>> >> +               };
>> >> +
>> >> +               fabric: fabric {
>> >> +                       compatible = "hisilicon,hip04-fabric";
>> >> +                       reg = <0x302a000 0x1000>;
>> >
>> > How is this going to be used?
>> >
>>
>> Fabric could configure snoop filter of multiple cluster. I don't have
>> the manual. I only know this.
>
> What driver is going to bind against this? It probably makes sense to leave
> this out until the consumer is also upstreamed, to have something to have as
> a base for discussion.

Only one register is configured in the fabric by kernel. Do we need a driver?

This register is only used when we power up/down the cluster. MCPM
framework could help to call the function to configure this register.

Regards
Haojian
