From: hc.yen@mediatek.com (HC Yen)
Date: Tue, 4 Nov 2014 14:36:45 +0800
Subject: [PATCH v4 1/8] ARM: mediatek: Add basic support for mt8127
In-Reply-To: <CABuKBeLYMbD-dV_25FJd_NE1RgfVkgF+SoCiAx9O9jKUUAcexA@mail.gmail.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
 <1413973797-17619-2-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeLYMbD-dV_25FJd_NE1RgfVkgF+SoCiAx9O9jKUUAcexA@mail.gmail.com>
Message-ID: <1415083006.10186.85.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-11-03 at 18:53 +0100, Matthias Brugger wrote:
> 2014-10-22 12:29 GMT+02:00 Joe.C <yingjoe.chen@mediatek.com>:
> > From: "Joe.C" <yingjoe.chen@mediatek.com>
> >
> > This adds a basic dtsi for MT8127 SoC.
> >
> > Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt8127.dtsi     | 93 +++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mediatek/mediatek.c |  1 +
> >  2 files changed, 94 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/mt8127.dtsi
> >
> > diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
> > new file mode 100644
> > index 0000000..25c9f69
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mt8127.dtsi
> > @@ -0,0 +1,93 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: Joe.C <yingjoe.chen@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include "skeleton64.dtsi"
> 
> Cortex a7 is 32 bits, right? So why do you use skeleton64.dtsi?

Cortex-A7 is 32-bit, but that doesn't mean it can only have 32-bit
physical address.  With LPAE enabled, we can have physical address more
than 32 bits.

The main difference between "skeleton64.dtsi" and "skeleton.dtsi" is
"#address-cells" property set to 2.  Although there are few sources
using "skeleton64.dtsi", some of them write "#address-cells = <2>"
directly in order to have 64-bit address space.  ARM's TC2 reference
platform (vexpress-v2p-ca15_a7.dts) is an example.

Some of MediaTek ARMv7 SoCs support address space larger than 4GB. It
will be convenient to share the sources if we all use 64-bit device
tree.

> 
> > +
> > +/ {
> > +       compatible = "mediatek,mt8127";
> > +       interrupt-parent = <&gic>;
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu at 0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a7";
> > +                       reg = <0x0>;
> > +               };
> > +               cpu at 1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a7";
> > +                       reg = <0x1>;
> > +               };
> > +               cpu at 2 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a7";
> > +                       reg = <0x2>;
> > +               };
> > +               cpu at 3 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a7";
> > +                       reg = <0x3>;
> > +               };
> > +
> > +       };
> > +
> > +       clocks {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               compatible = "simple-bus";
> > +               ranges;
> > +
> > +               system_clk: dummy13m {
> > +                       compatible = "fixed-clock";
> > +                       clock-frequency = <13000000>;
> > +                       #clock-cells = <0>;
> > +               };
> > +
> > +               rtc_clk: dummy32k {
> > +                       compatible = "fixed-clock";
> > +                       clock-frequency = <32000>;
> > +                       #clock-cells = <0>;
> > +               };
> > +       };
> > +
> > +       soc {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               compatible = "simple-bus";
> > +               ranges;
> > +
> > +               timer: timer at 10008000 {
> > +                       compatible = "mediatek,mt8127-timer", "mediatek,mt6577-timer";
> > +                       reg = <0 0x10008000 0 0x80>;
> 
> This should be "reg = <0x10008000 0x80>;" right?
> Same in mt8135.dtsi
> 
> > +                       interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&system_clk>, <&rtc_clk>;
> > +                       clock-names = "system-clk", "rtc-clk";
> > +               };
> > +
> > +               gic: interrupt-controller at 10211000 {
> > +                       compatible = "arm,cortex-a7-gic";
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <3>;
> > +                       reg = <0 0x10211000 0 0x1000>,
> > +                             <0 0x10212000 0 0x1000>,
> > +                             <0 0x10214000 0 0x2000>,
> > +                             <0 0x10216000 0 0x2000>;
> > +               };
> > +       };
> > +};
> > diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> > index f2acf07..7f478ce 100644
> > --- a/arch/arm/mach-mediatek/mediatek.c
> > +++ b/arch/arm/mach-mediatek/mediatek.c
> > @@ -19,6 +19,7 @@
> >
> >  static const char * const mediatek_board_dt_compat[] = {
> >         "mediatek,mt6589",
> > +       "mediatek,mt8127",
> >         NULL,
> >  };
> >
> > --
> > 1.8.1.1.dirty
> >
> 
> 
> 
