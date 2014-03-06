From: robherring2@gmail.com (Rob Herring)
Date: Wed, 5 Mar 2014 20:38:31 -0600
Subject: [PATCH v2 1/1] arm64: Add initial dts for Cavium Thunder SoC
In-Reply-To: <CAC8NTUWpU4vq7=Jotmb1+-c7xNBct+0vdb8496yx03iDso-V7w@mail.gmail.com>
References: <1393831142-27952-1-git-send-email-mohun106@gmail.com>
 <1393831142-27952-2-git-send-email-mohun106@gmail.com>
 <CAL_JsqLn2uJCcjB9D_xw8Y7om0F0JPp87niwjCjYxVUEfYwAtw@mail.gmail.com>
 <CAC8NTUWpU4vq7=Jotmb1+-c7xNBct+0vdb8496yx03iDso-V7w@mail.gmail.com>
Message-ID: <CAL_JsqJgJJ7TFyO4=o_MPsC4tYSXcAe1g-dG+=iQtgUq6RaCyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 2:46 AM, Radha Mohan <mohun106@gmail.com> wrote:
> On Tue, Mar 4, 2014 at 4:26 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On Mon, Mar 3, 2014 at 1:19 AM,  <mohun106@gmail.com> wrote:
>>> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>>
>>> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>> ---
>>>  arch/arm64/boot/dts/Makefile    |    1 +
>>>  arch/arm64/boot/dts/thunder.dts |  158 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 159 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>>> index c52bdb0..d339343 100644
>>> --- a/arch/arm64/boot/dts/Makefile
>>> +++ b/arch/arm64/boot/dts/Makefile
>>> @@ -1,5 +1,6 @@
>>>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>>> +dtb-$(CONFIG_ARCH_THUNDER) += thunder.dtb
>>>
>>>  targets += dtbs
>>>  targets += $(dtb-y)
>>> diff --git a/arch/arm64/boot/dts/thunder.dts b/arch/arm64/boot/dts/thunder.dts
>>> new file mode 100644
>>> index 0000000..7e8c7d5
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/thunder.dts
>>> @@ -0,0 +1,158 @@
>>> +/*
>>> + * Cavium Thunder 8xxx DTS file
>>> + *
>>> + * Copyright (C) 2013, Cavium Inc.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 of
>>> + * the License, or (at your option) any later version.
>>
>> DTS files should really be BSD licensed for use on other OSs.
>>
>
> Is this a new requirement? I haven't seen any DTS (atleast in
> ARM/ARM64) that uses BSD license.

I'm not saying you have to. Considering the DTB should come from the
firmware and you could want to boot other OS's, BSD license makes more
sense. Also at some point, we plan to move dts files out of the kernel
to better support other projects like u-boot or FreeBSD. It may become
more of an issue then and dts files could need to be re-licensed. I'd
rather avoid the whole issue of trying to re-license things.


>>> + */
>>> +/dts-v1/;
>>> +/ {
>>> +       model="Thunder";
>>
>> whitespace around the =.
>>
>>> +       compatible = "cavium, thunder";
>>
>> Please document compatible strings. There should not be a space in the
>> string. This should be more specific. The comments refer to 8xxx so I
>> assume there is a part number.
>
> OK will do.
>
>>
>>> +       interrupt-parent = <&gic0>;
>>> +       #address-cells = <2>;
>>> +       #size-cells = <2>;
>>> +
>>> +       aliases {
>>> +               serial0 = &uaa0;
>>> +               serial1 = &uaa1;
>>> +       };
>>> +
>>> +       cpus {
>>> +               #address-cells = <2>;
>>> +               #size-cells = <0>;
>>> +               cpu at 0 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>
>> Custom core right? Add a compatible string for the core name.
>
> OK, I guess that should be also documented, right?
> But I didn't find other ARM64 platforms doing it.

arm,potenza for APM. Everything else is models, so they don't really count.

>
>>
>>> +                       reg = <0x0 0x0>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 1 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x1>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>
>> Same address for all cores? I don't see how that will work for hotplug.
>
> Hotplug will work if we use PSCI boot-method. For spin-table there is
> no hotplug support. And we don't enable it too.
>
>>
>>> +               };
>>> +               cpu at 2 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x2>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 3 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x3>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 4 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x4>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 5 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x5>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 6 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x6>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +               cpu at 7 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,armv8";
>>> +                       reg = <0x0 0x7>;
>>> +                       enable-method = "spin-table";
>>> +                       cpu-release-addr = <0x0 0xfff8>;
>>> +               };
>>> +
>>> +       };
>>> +       memory at 0x0 {
>>
>> Drop the '0x'
>>> +               device_type = "memory";
>>> +               reg = <0x0 0x0 0x0 0x80000000>;
>>> +       };
>>> +
>>> +       gic0: interrupt-controller at 0x801000000000 {
>>
>> Ditto
>>
>>> +               compatible = "arm,gic-v3";
>>> +               #interrupt-cells = <3>;
>>> +               #address-cells = <0>;
>>> +               interrupt-controller;
>>> +               reg = <0x8010 0x0 0x0 0x10000>,         // GICD
>>> +                     <0x8010 0x80000000 0x0 0x100000>; // GICR
>>
>> Umm, so no virtualization support?
>
> Why do you think there is no virtualization support? Our platform is
> not backward compatible with GICv2

Okay.

>
>>
>> This should be under a bus node.
>
> Why GIC should be under a bus node?

Because it is on some bus.

>
>>
>>> +               interrupts = <1 9 0xf04>;
>>> +       };
>>> +
>>> +       timer {
>>> +               compatible = "arm,armv8-timer";
>>> +               interrupts = <1 13 0xff01>,
>>> +                            <1 14 0xff01>,
>>> +                            <1 11 0xff01>,
>>> +                            <1 10 0xff01>;
>>> +       };
>>> +
>>> +       on-chip-devices {
>>> +               compatible = "simple-bus";
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               ranges;
>>> +
>>> +               ahci0: host-bus-adapter at 810000000000 {
>>> +                       compatible = "snps,spear-ahci";
>>> +                       reg-io-width = <4>;
>>
>> This property is not used for this binding.
>>
>>> +                       reg = <0x8100 0x0 0x0 0x1100>;
>>> +                       interrupts = <1 32 4>;
>>> +               };
>>> +
>>> +               nic0: ethernet at 843000000000 {
>>> +                       compatible = "smsc,lan9115";
>>> +                       reg-io-width = <4>;
>>> +                       reg = <0x8430 0x0 0x0 0x1000>;
>>> +                       interrupts = <1 31 4>;
>>> +               };
>>> +       };
>>> +
>>> +       amba {
>>> +               compatible = "arm,amba-bus";
>>
>> should be "simple-bus"
>
> PL011 will not get probed if not "amba-bus"

Yes, it will. It is "arm,primecell" on the devices that is used for
probing. There is really no such thing as an AMBA bus from a software
view. There are no registers to program the bus (typically) or
discovery mechanism. The ID registers within devices give you device
type, but nothing describes where devices are.

>
>>
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               ranges;
>>> +
>>> +               refclk24mhz: refclk24mhz {
>>
>> move to top level or a clocks node.
>
> OK.
>
>>
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +                       clock-frequency = <24000000>;
>>> +                       clock-output-names = "refclk24mhz";
>>> +               };
>>> +
>>> +               uaa0: uart at 87e024000000 {
>>
>> use ranges so the bus address is 0x87e0_00000000.
>>
>
> OK, I need to look at this.
>
>>> +                       compatible = "arm,pl011", "arm,primecell";
>>> +                       reg = <0x87e0 0x24000000 0x0 0x1000>;
>>> +                       interrupts = <1 21 4>;
>>> +                       clocks = <&refclk24mhz>;
>>> +                       clock-names = "apb_pclk";
>>
>> Your APB bus frequency is really only 24MHz? There should 2 clocks defined here.
>>
>
> This clock is a dummy one as this DTS is based on a simulator.
> Is 2 clocks really a necessity? Then don't the drivers needs to do
> something if we don't define 2 clocks?

Accurately describing the h/w is a necessity.

Rob
