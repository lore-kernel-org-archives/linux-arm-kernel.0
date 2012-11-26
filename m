From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 26 Nov 2012 17:04:08 +0100
Subject: [RFC 1/2] ARM: S3C24XX: add devicetree support for interrupts
In-Reply-To: <CAJuYYwSi=5rbARhmrL5J-58LwraERHRmLs9B9X+110ZGBb9iBA@mail.gmail.com>
References: <201211250145.21226.heiko@sntech.de>
 <201211261313.28307.heiko@sntech.de>
 <CAJuYYwSi=5rbARhmrL5J-58LwraERHRmLs9B9X+110ZGBb9iBA@mail.gmail.com>
Message-ID: <201211261704.09273.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Am Montag, 26. November 2012, 16:23:00 schrieb Thomas Abraham:
> On 26 November 2012 17:43, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Thomas,
> > 
> > Am Montag, 26. November 2012, 12:03:22 schrieb Thomas Abraham:
> >> Hi Heiko,
> >> 
> >> On 25 November 2012 06:17, Heiko St?bner <heiko@sntech.de> wrote:
> >> > This adds devicetree parsing of the controller-data for the
> >> > interrupt controllers on S3C24XX architectures.
> >> > 
> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> > ---
> >> > 
> >> >  .../interrupt-controller/samsung,s3c24xx-irq.txt   |   57 ++++++
> >> >  arch/arm/mach-s3c24xx/common.h                     |    1 +
> >> >  arch/arm/plat-s3c24xx/irq.c                        |  197
> >> >  ++++++++++++++++++++ 3 files changed, 255 insertions(+), 0
> >> >  deletions(-) create mode 100644
> >> >  Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24x
> >> >  x- irq.txt
> >> > 
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24
> >> > xx -irq.txt
> >> > b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24
> >> > xx -irq.txt new file mode 100644
> >> > index 0000000..c637637
> >> > --- /dev/null
> >> > +++
> >> > b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24
> >> > xx -irq.txt @@ -0,0 +1,57 @@
> >> > +Samsung S3C24XX Interrupt Controllers
> >> > +
> >> > +The S3C24XX SoCs contain custom set of interrupt controllers
> >> > providing a +varying number of interrupt sources.
> >> > +
> >> > +The set consists of a main- and a sub-controller as well as a
> >> > controller +for the external interrupts and on newer SoCs even a
> >> > second main controller. +
> >> > +The bit-to-interrupt and parent mapping of the controllers is not
> >> > fixed +over all SoCs and therefore must be defined in the controller
> >> > description. +
> >> > +Required properties:
> >> > +- compatible: Compatible property value should be
> >> > "samsung,s3c24xx-irq". +
> >> > +- reg: Physical base address of the controller and length of memory
> >> > mapped +  region.
> >> > +
> >> > +- interrupt-controller : Identifies the node as an interrupt
> >> > controller +- #interrupt-cells : Specifies the number of cells needed
> >> > to encode an +  interrupt source. The value shall be 2.
> >> > +
> >> > +- s3c24xx,irqlist : List of irqtypes found on this controller as
> >> > +  two-value pairs consisting of irqtype and parent-irq
> >> > +
> >> > +  parent-irq is always the list position of the irq in the irqlist
> >> > +  of the parent controller (0..31)
> >> > +
> >> > +  irqtypes are:
> >> > +  - 0 .. none
> >> > +  - 1 .. external interrupts in the main register (GPF0 .. GPF3)
> >> > +  - 2 .. edge irq in the main register
> >> > +  - 3 .. for parent-irqs, that have sub-irqs in child controllers
> >> > +  - 4 .. level irqs in the sub-register
> >> > +  - 5 .. edge irqs in the sub-register
> >> > +  - 6 .. external irqs in the external irq register (starting with
> >> > GPF4) +  - 7 .. irq in the second base irq controller of
> >> > S3C2416/S3C2450 SoCs
> >> 
> >> Instead of defining the type of interrupt controller as above, is it
> >> possible to create multiple device nodes, with each node representing
> >> a type of interrupt controller with a unique compatible string and
> >> corresponding properties. There will be a init function for each type
> >> of interrupt controller. There should be a irq-domain for each of
> >> these different types of interrupt controller. And then, in the device
> >> tree source file, a proper tree like hierarchy of interrupt
> >> controllers can defined (using the interrupt-parent property for each
> >> controller node). The client nodes that generate the interrupt can
> >> specify the parent node and the interrupt number within the parent to
> >> which they generate the interrupt.
> > 
> > I'm not sure I understand yet :-). The list describes the types of
> > interrupts inside the individual controllers.
> > 
> > On all the s3c24xx we have three register sets denoting the main (SRCPND,
> > INTPND, INTMSK), sub (SUBSRCPEND, INTSUBMASK) and extint (EINTPEND,
> > EINTMASK) controllers. The bits of these registers are used for quite
> > different irqs.
> 
> We could consider main, sub and extint as three separate interrupt
> controllers and thus three different nodes in device tree. So the
> interrupt nodes could be something like (referring to 2416 manual).
> 
>      main at 0x4a000000 {
>             compatible = "samsung,s3c2410-main";
>             reg = <0x4a000000 0x100>;
>             interrupt-controller;
>             #interrupt-cells = <2>;
>      };
> 
>      sub at 0x4a001000 {
>             compatible = "samsung,s3c2410-sub";
>             reg = <0x4a001000 0x100>;
>             interrupt-controller;
>             #interrupt-cells = <2>;
>             interrupt-parent = <&main>;
>             interrupts = <28 0>, <23 0>, <.....  /*uart0/uart1/..*/
>      };
> 
>      eint at 0x4a002000 {
>             compatible = "samsung,s3c2410-eint";
>             reg = <0x4a002000 0x100>;
>             interrupt-controller;
>             #interrupt-cells = <2>;
>             interrupt-parent = <&main>;
>             interrupts = <0 0>, <1 0>,
>                               <2 0>, <3 0>,
>                               <4 0>, <5 0>;
>      };
> 
> There should be a corresponding irqchip driver code to handle each of
> these types of controllers. They should have their own irq-domain
> supported.
> 
> Then the client nodes can specify the interrupt parent and interrupt
> number. For example, the uart node would be
> 
>        uart at 50000000 {
>             compatible = "samsung,s3c2410-uart";
>             reg = <0x50000000 0x100>;
>             interrupt-parent = <&sub>;
>             interrupts = <0 0>, <1 0>, <2 0>; /*tx/rx/err*/
>        };
> 
> > For example is bit 17 of the main register set used as DMA0 on earlier
> > socs while the dma interrupts moved to the subint registers for s3c2443
> > and later.
> 
> Writing the nodes with the correct interrupt parent and the interrupt
> number should take care of this.
> 
> > So the entries in the irqlist describe the needed handlers for the hwirq
> > bits of the indidual controllers. So in this scheme you set for
> > dt-devices the interrupt parent to the correct register set and the
> > interrupts field then matches the bit of the register, according to the
> > datasheet.
> > 
> > When I changed the basic interrupt handling in the previous set, the
> > changed irq.c can for exmaple be found on [0], I created these lists in
> > the code and soc specific routines to init them for the still valid
> > non-dt case.
> > 
> > But as dt is about describing the hardware, I found the current solution
> > nice, because will I only need exactly one dt-init-function for all
> > s3c24xx-socs, instead of representing all the slight variances in code.
> > 
> > I'm definitly not sure if all the different types of individual irq
> > handlers are strictly necessary yet, but they represent all the variants
> > that were in use in the original code.
> 
> I have brought up this point just for discussion. You could choose the
> implementation that you prefer. I understand that implementing with
> different interrupt controller nodes might require lot of code
> changes.

first of all, thanks for the feedback. Working on this is like moving in a fog 
where I don't really see where I'm going - so I don't claim to be right.


But somehow I have the feeling we're talking about similar things here :-)

If you look in the second patch, you'll see that there are already the three 
(or 4 in the case of the s3c2416) interrupt controllers defined [intc, 
subintc, extintc]. But as they contain the data of their individual interrupts 
inside the devicetree definitions, they don't need individual init functions 
but only one which constructs the interrupt data out of the list provided.

The real list for a platform in the second patch might also help in showing 
why this list was necessary.

The basic problem is, that each individual interrupt inside one of the 
controllers might need a different handler and access a specific parent 
interrupt. For example the uart0-rx,tx,err interrupts in the subintc must 
ack/mask the uart0 interrupt in the main intc; similar for a lot of other 
interrupts. And the s3c24xx,irqlist provides this mapping to handler and 
parent, so it does not need to be codified.

And of course the second problem this approach should solve is, that the 
interrupts in the controllers differ and also move between most of the s3c24xx 
sub-architectures.


Thanks
Heiko
