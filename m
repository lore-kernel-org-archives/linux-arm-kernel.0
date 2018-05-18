From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 18 May 2018 11:56:09 +0200
Subject: [PATCH 17/27] dt-bindings: ap806: add the thermal node in the
 syscon file
In-Reply-To: <20180427210722.obyujepjvqc5hwcd@rob-hp-laptop>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-18-miquel.raynal@bootlin.com>
 <20180427210722.obyujepjvqc5hwcd@rob-hp-laptop>
Message-ID: <20180518115609.420de41d@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for reviewing, one question below.

On Fri, 27 Apr 2018 16:07:22 -0500, Rob Herring <robh@kernel.org> wrote:

> On Sat, Apr 21, 2018 at 05:12:45PM +0200, Miquel Raynal wrote:
> > Explain the thermal bindings now that the thermal IP is described being
> > inside of a system controller. Add a reference to the thermal-zone node.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../arm/marvell/ap806-system-controller.txt        | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> > index a856eb9a4e05..c95f3ac5c728 100644
> > --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> > +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> > @@ -11,6 +11,9 @@ For the top level node:
> >   - compatible: must be: "syscon", "simple-mfd";
> >   - reg: register area of the AP806 system controller
> >  
> > +SYSTEM CONTROLLER 0
> > +===================
> > +
> >  Clocks:
> >  -------
> >  
> > @@ -98,3 +101,43 @@ ap_syscon: system-controller at 6f4000 {
> >  		gpio-ranges = <&ap_pinctrl 0 0 19>;
> >  	};
> >  };
> > +
> > +SYSTEM CONTROLLER 1
> > +===================
> > +
> > +Thermal:
> > +--------
> > +
> > +For common binding part and usage, refer to
> > +Documentation/devicetree/bindings/thermal/thermal.txt
> > +
> > +The thermal IP can probe the temperature all around the processor. It
> > +may feature several channels, each of them wired to one sensor.
> > +
> > +It is possible to setup an overheat interrupt by giving at least one
> > +critical point to any subnode of the thermal-zone node.
> > +
> > +Required properties:
> > +- compatible: "marvell,armada-ap806-thermal"
> > +
> > +Optional properties:
> > +- interrupt-parent/interrupts: overheat interrupt handle. Should point to
> > +  line 18 of the SEI irqchip.
> > +  See interrupt-controller/interrupts.txt
> > +- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
> > +  to this IP and represents the channel ID. There is one sensor per
> > +  channel. O refers to the thermal IP internal channel, while positive
> > +  IDs refer to each CPU.
> > +
> > +Example:
> > +ap_syscon1: system-controller at 6f8000 {
> > +	compatible = "syscon", "simple-mfd";
> > +	reg = <0x6f8000 0x1000>;
> > +
> > +	ap_thermal: ap-thermal {
> > +		compatible = "marvell,armada-ap806-thermal";  
> 
> Is there a register range associated with the thermal functions?

Indeed there is a small one (three registers) but we also need to access
some registers out of this area (so called the 'DFX' area, in this
syscon, to route correctly the interrupt) and I fear we'll need to
access others in the future. I choose to declare a syscon because this
area mixes a lot of misc registers.

So do you think I should declare these 3 registers area in a reg
property? Or keep the way I retrieved the offsets in the syscon:
defining offsets in the code?

> 
> > +		interrupt-parent = <&sei>;
> > +		interrupts = <18>;
> > +		#thermal-sensor-cells = <1>;
> > +	};
> > +};
> > -- 
> > 2.14.1
> >   

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
