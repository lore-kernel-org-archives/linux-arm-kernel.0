From: orsonzhai@gmail.com (Orson Zhai)
Date: Fri, 16 Jan 2015 20:49:20 +0800
Subject: [PATCH v5 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20150116103558.GD21809@leverpostej>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116103558.GD21809@leverpostej>
Message-ID: <CA+H2tpGPKc8Gu=s+d4PnO=Wp_Uv=o338hxj_1opPRkZ3KZH+rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

On Fri, Jan 16, 2015 at 6:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 16, 2015 at 10:00:09AM +0000, Chunyan Zhang wrote:
>> From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
>>
>> Adds the device tree support for Spreadtrum SC9836 SoC which is based on
>> Sharkl64 platform.
>>
>> Sharkl64 platform contains the common nodes of Spreadtrum's arm64-based SoCs.
>>
>> Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
>> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  arch/arm64/boot/dts/Makefile                  |    1 +
>>  arch/arm64/boot/dts/sprd/Makefile             |    5 ++
>>  arch/arm64/boot/dts/sprd/sc9836-openphone.dts |   49 +++++++++++++++++
>>  arch/arm64/boot/dts/sprd/sc9836.dtsi          |   73 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/sprd/sharkl64.dtsi        |   67 +++++++++++++++++++++++
>>  5 files changed, 195 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/sprd/Makefile
>>  create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
>>  create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
>>  create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi
>
> [...]
>
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53", "arm,armv8";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu at 1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53", "arm,armv8";
>> +                     reg = <0x0 0x1>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu at 2 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53", "arm,armv8";
>> +                     reg = <0x0 0x2>;
>> +                     enable-method = "psci";
>> +             };
>> +
>> +             cpu at 3 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a53", "arm,armv8";
>> +                     reg = <0x0 0x3>;
>> +                     enable-method = "psci";
>> +             };
>> +     };
>
> Just to check, all CPUs may be hotplugged off and on, yes?
>

Yes, I have tested with them successfully by looking into
`/proc/interrupts` and `top` except CPU0.

> Including CPU0?
>

 It returns "status busy" after I type the command below.


> How is your implementation tested?
>
I build kernel image with 3.19-rc1 + this patchset and run into console.
I use `echo 0 > /sys/devices/system/cpu[0-3]/online`

BTW, I run these on a real phone of sc9836 not fast-model as before.

> You boot CPUs at EL2?
>

Yes, I have confirmed this when working around the BUG() in
arch_counter_get_cntpct() introduced from 3.19.

>> +
>> +     gic: interrupt-controller at 12001000 {
>> +             compatible = "arm,gic-400";
>> +             #interrupt-cells = <3>;
>> +             interrupt-controller;
>> +             reg = <0 0x12001000 0 0x1000>,
>> +                   <0 0x12002000 0 0x2000>,
>> +                   <0 0x12004000 0 0x2000>,
>> +                   <0 0x12006000 0 0x2000>;
>> +     };
>
> You're missing the maintenance interrupt here.
>

Do you mean to declare SGI like this ?

" interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)> "

> [...]
>
>> diff --git a/arch/arm64/boot/dts/sprd/sharkl64.dtsi b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
>> new file mode 100644
>> index 0000000..b08989d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
>> @@ -0,0 +1,67 @@
>> +/*
>> + * Spreadtrum Sharkl64 platform DTS file
>> + *
>> + * Copyright (C) 2014, Spreadtrum Communications Inc.
>> + *
>> + * This file is licensed under a dual GPLv2 or X11 license.
>> + */
>> +
>> +/ {
>> +     interrupt-parent = <&gic>;
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     soc {
>> +             compatible = "simple-bus";
>> +             reg = <0x0 0x0 0x0 0x80000000>;
>
> What is this reg for? It's not required by simple-bus.
>

It's added by me.
I want to tell people the register range of what the bus covers, not
for any drivers use.
for this example, It starts from address 0 to 0x80000000.
Because Spreadtrum chip is very large with a lots of registers and matrix buses.


> If you want to encode that this covers a particular portion of the
> address space, do so with the ranges proeprty.

But I look up the ePAPER who says "The ranges property provides a
means of defining a mapping or translation...".
The bus here is flat-memory for all.

>
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             ranges;
>> +
>> +             ap_apb: apb at 70000000 {
>> +                     compatible = "simple-bus";
>> +                     reg = <0x0 0x70000000 0x0 0x10000000>;
>
> Likewise here.
>

This initial patch is picked up from a very big dt file.
There are several apb buses in this chip.
So I use apb at starting-address to separate them.
But I remember another rule that the @address needs to equal  first
address in property reg array.
Do I have to delete @7000000 as well if i delete reg line?

    Orson

> Thanks,
> Mark.
