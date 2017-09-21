From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 20:08:39 -0500
Subject: [RFC RESEND 3/3] arm: dts: add Hi3521A dts
In-Reply-To: <20170920230405.tz3vzoys2vn72rgv@proprietary-killer.fossland>
References: <20170917082327.10058-1-hanetzer@startmail.com>
 <20170917082327.10058-4-hanetzer@startmail.com>
 <20170920205303.lcycfuai75a7namk@rob-hp-laptop>
 <20170920230405.tz3vzoys2vn72rgv@proprietary-killer.fossland>
Message-ID: <CAL_JsqLfRN=CjcDbwANE7gwCQS-_s99f6UANPLAooiaWB1mvfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 6:04 PM, Marty E. Plummer
<hanetzer@startmail.com> wrote:
> On Wed, Sep 20, 2017 at 08:53:03PM +0000, Rob Herring wrote:
>> On Sun, Sep 17, 2017 at 03:23:27AM -0500, Marty E. Plummer wrote:
>> > Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
>> > marketed under the name Samsung SDR-B74301N
>> >
>> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
>> > ---
>> >  arch/arm/boot/dts/Makefile              |   2 +
>> >  arch/arm/boot/dts/hi3521a-rs-dm290e.dts |  52 ++++++
>> >  arch/arm/boot/dts/hi3521a.dtsi          | 310 ++++++++++++++++++++++++++++++++
>> >  3 files changed, 364 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
>> >  create mode 100644 arch/arm/boot/dts/hi3521a.dtsi
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index faf46abaa4a2..e7b9b5dde20f 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -189,6 +189,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
>> >     gemini-sq201.dtb \
>> >     gemini-wbd111.dtb \
>> >     gemini-wbd222.dtb
>> > +dtb-$(CONFIG_ARCH_HI3521A) += \
>> > +   hi3521a-rs-dm290e.dtb
>> >  dtb-$(CONFIG_ARCH_HI3xxx) += \
>> >     hi3620-hi4511.dtb
>> >  dtb-$(CONFIG_ARCH_HIGHBANK) += \
>> > diff --git a/arch/arm/boot/dts/hi3521a-rs-dm290e.dts b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
>> > new file mode 100644
>> > index 000000000000..b32c8392c93f
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
>> > @@ -0,0 +1,52 @@
>> > +/*
>> > + * Copyright (C) 2017 Marty Plummer <hanetzer@startmail.com>
>> > + *
>> > + * This program is free software: you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License as published by
>> > + * the Free Software Foundation, either version 3 of the License, or
>> > + * (at your option) any later version.
>>
>> Should be version 2 or later? Doesn't really matter to me from a DT
>> perspective, but it is in the kernel tree.
>>
>> You can use SPDX tags if you want.
>>
> Oh, that's a good idea. I hadn't seen any SPDX tags in the tree that I
> noticed before. I ended up just using the :Gpl command from neovim.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> > + */
>> > +
>> > +/dts-v1/;
>> > +#include "hi3521a.dtsi"
>> > +
>> > +/ {
>> > +   model = "RaySharp RS-DM-290E DVR Board";
>> > +   compatible = "hisilicon,hi3521a";
>>
>> Needs a board compatible too.
>>
> Something like `compatible = "hisilicon,hi3521a", "raysharp,rs-dm-290e";` ?

Yes, but flip the order. Most specific compatible first.

>> > +
>> > +   aliases {
>> > +           serial0 = &uart0;
>> > +           serial1 = &uart1;
>> > +           serial2 = &uart2;
>> > +   };
>> > +
>> > +   memory {
>>
>> Needs a unit-address.
>>
> Could you explain what you mean here? As in, memory at someaddr? What would
> I use here?

"memory at 80000000". Building with W=2 will tell you.

>> > +           device_type = "memory";
>> > +           reg = <0x80000000 0xf00000>;
>> > +   };
>> > +};
>> > +
>> > +&hi_sfc {
>> > +   status = "okay";
>> > +   spi-nor at 0 {
>> > +           compatible = "jedec,spi-nor";
>>
>> I don't remember offhand, but I think this should have a device specific
>> compatible too.
>>
> Instead of "jedec,spi-nor" ? Specific to the SPI chip?

No, both with jedec,spi-nor 2nd.

>> > +           reg = <0>;
>> > +           spi-max-frequency = <104000000>;
>> > +   };
>> > +};
>> > +
>> > +&uart0 {
>> > +   status = "okay";
>> > +};
>> > +
>> > +&dual_timer0 {
>> > +   status = "okay";
>> > +};
>> > diff --git a/arch/arm/boot/dts/hi3521a.dtsi b/arch/arm/boot/dts/hi3521a.dtsi
>> > new file mode 100644
>> > index 000000000000..2af746fdec46
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/hi3521a.dtsi
>> > @@ -0,0 +1,310 @@
>> > +/*
>> > + * Copyright (C) 2017 Marty Plummer <hanetzer@startmail.com>
>> > + *
>> > + * This program is free software: you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License as published by
>> > + * the Free Software Foundation, either version 3 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> > + */
>> > +
>> > +#include <dt-bindings/clock/hi3521a-clock.h>
>> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +/ {
>> > +   #address-cells = <1>;
>> > +   #size-cells = <1>;
>> > +   chosen { };
>> > +
>> > +   cpus {
>> > +           #address-cells = <1>;
>> > +           #size-cells = <0>;
>> > +
>> > +           cpu0: cpu at 0 {
>> > +                   device_type = "cpu";
>> > +                   compatible = "arm,cortex-a7";
>> > +                   reg = <0>;
>> > +           };
>> > +   };
>> > +
>> > +   hi_sfc: spi-nor-controller at 10000000 {
>> > +           compatible = "hisilicon,hi3521a-spi-nor", "hisilicon,fmc-spi-nor";
>> > +           #address-cells = <1>;
>> > +           #size-cells = <0>;
>> > +           reg = <0x10000000 0x10000>, <0x14000000 0x1000000>;
>> > +           reg-names = "control", "memory";
>> > +           clocks = <&crg HI3521A_FMC_CLK>;
>> > +           status = "disabled";
>> > +   };
>> > +
>> > +   gic: interrupt-controller at 10300000 {
>> > +           compatible = "arm,pl390";
>> > +           #interrupt-cells = <3>;
>> > +           interrupt-controller;
>> > +           reg = <0x10301000 0x1000>, <0x10302000 0x1000>;
>> > +   };
>> > +
>> > +   clk_3m: clk_3m {
>> > +           compatible = "fixed-clock";
>> > +           #clock-cells = <0>;
>> > +           clock-frequency = <3000000>;
>> > +   };
>> > +
>> > +   crg: clock-reset-controller at 12040000 {
>> > +           compatible = "hisilicon,hi3521a-crg";
>> > +           #clock-cells = <1>;
>> > +           #reset-cells = <2>;
>> > +           reg = <0x12040000 0x10000>;
>> > +   };
>>
>> These memory mapped peripherals should be under a bus node.
>>
> Crap, will fix.
>> > +
>> > +   soc {
>> > +           #address-cells = <1>;
>> > +           #size-cells = <1>;
>> > +           compatible = "simple-bus";
>> > +           interrupt-parent = <&gic>;
>> > +           ranges;
>>
>> It is preferred to have a value here and limit the range of the bus
>> addresses.
>>
> Yeah, I think I've seen that before, I don't quite grok how that works.
>> > +
>> > +           dmac: dma at 10060000 {
>>
>> dma-controller at ...
>>
> Will fix.
>> > +                   compatible = "arm,pl080", "arm,primecell";
>> > +                   reg = <0x10060000 0x1000>;
>> > +                   interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> > +                   status = "disabled";
>>
>> I wouldn't think enabling dma would be a per board decision.
>>
> I've just noticed that in general dtsi files just lay it all out and are
> mostly "disabled", though if you think this should be explicitly enabled
> thats fine by me.
>> > +           };
>> > +
>> > +           dual_timer0: timer at 12000000 {
>> > +                   compatible = "arm,sp804", "arm,primecell";
>> > +                   interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
>> > +                                <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> > +                   reg = <0x12000000 0x1000>;
>> > +                   clocks = <&clk_3m>;
>> > +                   clock-names = "apb_pclk";
>>
>> IIRC, it is deprecated to have a single clock here. The h/w has 2 clock
>> inputs.
>>
> Are you meaning for the 0x0 index and 0x20 index clocks?

Yes. Maybe it's 3 clocks. Anyway, should all be in the sp804 binding doc.

>> Where's the ARM architected timer?
>>
> Unsure tbqf, just doing my best to translate a datasheet into code. Do
> all ARM soc's have one?

All A7's should I think.

Rob
