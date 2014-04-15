From: anders.berg@lsi.com (Anders Berg)
Date: Tue, 15 Apr 2014 17:20:47 +0200
Subject: [PATCH 2/5] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <8344066.GP0Bf5lvlE@wuerfel>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <02c006a6fc64131df82981abbc1c71c7af52254e.1397552154.git.anders.berg@lsi.com>
 <8344066.GP0Bf5lvlE@wuerfel>
Message-ID: <20140415152047.GB32285@swsaberg01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:45:48PM +0200, Arnd Bergmann wrote:
> On Tuesday 15 April 2014 14:06:11 Anders Berg wrote:
> > diff --git a/arch/arm/boot/dts/axm5516-amarillo.dts b/arch/arm/boot/dts/axm5516-amarillo.dts
> > new file mode 100644
> > index 0000000..1760d6c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/axm5516-amarillo.dts
> > @@ -0,0 +1,51 @@
> > +/*
> > + * arch/arm/boot/dts/axm5516-amarillo.dts
> > + *
> > + * Copyright (C) 2013 LSI
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> 
> It's better to use a permissive license such as the BSD license for dts files,
> so they can be shared with other OSs.

Ok.

> 
> The situation with the clocks is still very strange: either the bindings
> are all in need of update, or you got all devices wrong:
> 
> > +			serial0: uart at 2010080000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0x20 0x10080000 0 0x1000>;
> > +				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk_per>, <&clk_per>;
> > +				clock-names = "uartclk", "apb_pclk";
> > +				status = "disabled";
> > +			};
> 
> "uartclk" is not a valid string for pl011, as per binding:
> 
> | - clocks:  When present, must refer to exactly one clock named
> |           "apb_pclk"
> 
> I do see that a lot of platforms do the same thing you have here, not
> sure who is wrong.

The docs are probably correct. I used some vexpress dtsi as a reference, hence
the uartclk reference. It's gone now.

> 
> > +			timer0: timer at 2010091000 {
> > +				compatible = "arm,sp804", "arm,primecell";
> > +				reg = <0x20 0x10091000 0 0x1000>;
> > +				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk_per>, <&clk_per>;
> > +				clock-names = "timclken1", "apb_pclk";
> 
> Citing the binding:
> 
> | - clocks: clocks driving the dual timer hardware. This list should be 1 or 3
> |        clocks. With 3 clocks, the order is timer0 clock, timer1 clock,
> |        apb_pclk. A single clock can also be specified if the same clock is
> |        used for all clock inputs.
> 
> I think you only want to have one clock here and make that the "apb_pclk".

Yepp, will be fixed.

> 
> > +			gpio0: gpio at 2010092000 {
> > +				#gpio-cells = <2>;
> > +				compatible = "arm,pl061", "arm,primecell";
> > +				gpio-controller;
> > +				reg = <0x20 0x10092000 0x00 0x1000>;
> > +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> > +					     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk_per>;
> > +				clock-names = "apb_pclk";
> > +				status = "disabled";
> 
> The pl061 binding does not specify any clocks at all. Do we need to update
> that?

Doesn't all AMBA devices need at least one apb_pclk since the bus driver does
clk_get(...,"apb_pclk") before calling probe()?

/Anders
