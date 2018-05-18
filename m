From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 18 May 2018 16:48:48 +0200
Subject: [PATCH 14/17] dt-bindings/interrupt-controller: add description
 for Marvell SEI node
In-Reply-To: <CAL_JsqJ51riH+9Any7Bc6DN0Dx+WJdDAvOQ1gJCXTTUW0EUWsQ@mail.gmail.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-15-miquel.raynal@bootlin.com>
 <20180427205032.6u5zzf7265wpgppg@rob-hp-laptop>
 <20180428124827.3992b1ee@xps13>
 <CAL_JsqJ51riH+9Any7Bc6DN0Dx+WJdDAvOQ1gJCXTTUW0EUWsQ@mail.gmail.com>
Message-ID: <20180518164848.475b80ad@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, 30 Apr 2018 09:09:10 -0500, Rob Herring <robh@kernel.org> wrote:

> On Sat, Apr 28, 2018 at 5:48 AM, Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > Hi Rob,
> >
> > On Fri, 27 Apr 2018 15:50:32 -0500, Rob Herring <robh@kernel.org> wrote:
> >  
> >> On Sat, Apr 21, 2018 at 03:55:34PM +0200, Miquel Raynal wrote:  
> >> > Describe the SEI (System Error Interrupt) controller driver. The
> >> > controller is part of the GIC. It aggregates two types of interrupts,
> >> > wired and MSIs from respectively the AP and the CPs, into a single SPI
> >> > interrupt.
> >> >
> >> > Suggested-by: Haim Boot <hayim@marvell.com>
> >> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> > ---
> >> >  .../bindings/interrupt-controller/marvell,sei.txt  | 54 ++++++++++++++++++++++
> >> >  1 file changed, 54 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> >> > new file mode 100644
> >> > index 000000000000..a246d59552b1
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> >> > @@ -0,0 +1,54 @@
> >> > +Marvell SEI (System Error Interrupt) Controller
> >> > +-----------------------------------------------
> >> > +
> >> > +Marvell SEI (System Error Interrupt) controller is an interrupt aggregator.
> >> > +It receives interrupts from several sources and aggregates them to a single
> >> > +interrupt line (an SPI) on the primary interrupt controller.
> >> > +
> >> > +The IRQ chip can handle up to 64 SEIs, a set comes from the AP and is
> >> > +wired while a second set comes from the CPs by the mean of MSIs. Each
> >> > +'domain' is represented as a subnode.
> >> > +
> >> > +Required properties:
> >> > +
> >> > +- compatible: should be "marvell,armada-8k-sei".
> >> > +- reg: SEI registers location and length.
> >> > +- interrupts: identifies the parent IRQ that will be triggered.
> >> > +- #address-cells: should be '1', represents the position of the first
> >> > +                  IRQ of a given type in the SEI range.
> >> > +- #size-cells: should be '1', represents the number of a given type of
> >> > +               IRQs.
> >> > +
> >> > +Child node 'sei-wired-controller' required properties:
> >> > +
> >> > +- reg: the range of wired interrupts.
> >> > +- #interrupt-cells: number of cells to define an SEI wired interrupt
> >> > +                    coming from the AP, should be 1. The cell is the IRQ
> >> > +                    number.
> >> > +- interrupt-controller: identifies the node as an interrupt controller.
> >> > +
> >> > +Child node 'sei-msi-controller' required properties:
> >> > +
> >> > +- reg: the range of non-wired interrupts triggered by way of MSIs.
> >> > +- msi-controller: identifies the node as an MSI controller.
> >> > +
> >> > +Example:
> >> > +
> >> > +        sei: sei at 3f0200 {
> >> > +               compatible = "marvell,armada-8k-sei";
> >> > +               reg = <0x3f0200 0x40>;
> >> > +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> >> > +               #address-cells = <1>;
> >> > +               #size-cells = <1>;
> >> > +
> >> > +               sei_wired_controller: sei-wired-controller at 0 {
> >> > +                       reg = <0 21>;  
> >>
> >> Using interrupt numbers in reg is strange.  
> >
> > I thought the reg property was the one to choose here, I can of course
> > change it, what would you suggest?
> >  
> >>  
> >> > +                       #interrupt-cells = <1>;
> >> > +                       interrupt-controller;
> >> > +               };
> >> > +
> >> > +               sei_msi_controller: sei-msi-controller at 21 {
> >> > +                       reg = <21 43>;
> >> > +                       msi-controller;  
> >>
> >> Can't the parent be both an interrupt-controller and msi-controller?  

I would prefer to describe how the hardware is split in two
sub-controllers. And to answer the question: no, the parent cannot be
both and interrupt-controller and an msi-controller.

> >
> > We need to know which one aggregates interrupts, which one receives
> > MSIs and most importantly which interrupt is what (within the 64
> > that are handled by the SEI).  
> 
> You mean that 0-20 are wired and 21-63 are msi? "marvell,msi-base =
> <21>;" in the parent would be sufficient for that though you may want
> something more flexible to have multiple ranges.

Absolutely, I would like something more flexible.

> 
> It looks like there may already be similar bindings. See
> 'msi-available-ranges" and "{al,arm},msi-base-spi".

If you are ok, I will use a new property named 'marvell,sei-ranges'
instead of the reg property which is indeed more explicit.

Thanks,
Miqu?l
