From: zonque@gmail.com (Daniel Mack)
Date: Mon, 29 Oct 2012 23:37:08 +0100
Subject: Representation of external memory-mapped devices in DT (gpmc)
In-Reply-To: <508EF9E3.5090507@gmail.com>
References: <508E9513.7050106@gmail.com> <508E9C42.10907@gmail.com>
 <508EBB47.8070405@gmail.com> <508EF9E3.5090507@gmail.com>
Message-ID: <CACTFLAPk3sH1kKuSbjsRFBfYg_CjRG_jTxHVv6GREro3HA-=uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Oct 29, 2012 10:49 PM, "Rob Herring" <robherring2@gmail.com> wrote:
>
> On 10/29/2012 12:22 PM, Daniel Mack wrote:
> > On 29.10.2012 16:09, Rob Herring wrote:
> >> On 10/29/2012 09:39 AM, Daniel Mack wrote:
> >>> Hi,
> >>>
> >>> we're currently working on a DT binding for the GPMC bus that is found
> >>> on SoCs by TI. The implementation is based on CS lines and an 8, 16 or
> >>> 32 bit parallel interface. That IP is quite flexible, and it can for
> >>> example be used for physmap flash, external peripherals or even NAND.
> >>>
> >>> Depending on which CS is used to control the device, different memory
> >>> regions are reserved, and there's code to calculate the location and
> >>> size of them, given a CS number (see arch/arm/mach-omap2/gpmc.c).
> >>
> >> I don't know the details of the h/w, but I would think the DT core code
> >> should be able work out the addresses. This can be done using ranges
> >> property which defines the mapping of a child bus into the parent bus
> >> addresses.
> >
> > In this case, the controller is @0x50000000 while the external device is
> > mapped to address 0x0.
>
> Okay, so it's not fixed or some sub-range of the memory map.

It still haz a fixed position i  the memory map (0 - 0x1fffffff), but how
that space is divided for peripherals depends on the configuration.

>
> >>> The binding will use one top-level node to describe the GPMC
controller
> >>> itself and register the actual devices as sub-nodes to it. The NAND
type
> >>> is the only one that is currently supported. This is how it currently
looks:
> >>>
> >>>     gpmc: gpmc at 50000000 {
> >>>             compatible = "ti,gpmc";
> >>>             ti,hwmods = "gpmc";
> >>>             reg = <0x50000000 0x2000>;
> >>>             interrupt-parent = <&intc>;
> >>>             interrupts = <100>;
> >>>             #address-cells = <1>;
> >>>             #size-cells = <0>;
> >>>
> >>>             nand at 0 {
> >>
> >> You may want a CS0 node with nand as a child node of that.
> >
> > Hmm, I don't see what that would buy us. The question is which way is
> > feasible for storing both the memory region and the cs number in the
> > device tree. The CS number should certainly go to the child node, no?
>
> I was thinking of if you had per CS properties you needed to setup each
> CS. So something like this (using non-zero address to show the
> translation better):
>
> gpmc {
>         compatible = "ti,gpmc", "simple-bus";
>         ti,hwmods = "gpmc";
>         reg = <0x50000000 0x2000>;
>
>         CS0 {
>                 // map 1MB @ gpmc offset 0 to host address 0x10000000
>                 ranges = <0x10000000 0x0 <0x100000>;

The most important bit has a syntax error ;-) Was that property meant to
carry 3 values?

>                 // other gpmc specific per CS properties.
>                 nand {
>                         reg = <0x0 0x100000>;
>                 }
>         };
>

so that way, the child has the awareness about the gpmc controller config
(the offset in the memory map), and is agnostic to the cs number in use,
right? I think this is not really the most convenient approach from a
user's perspective.

> The core code will look at parents' ranges properties to translate the
> local offset of 0 into host address of 0x10000000 Then the nand node's
> reg address will get translated to 0x10000000.

That part is understood, I'm just not sure whether this is the most useful
way of describing the h/w capabilities.

Thanks,
Daniel

>
> The gpmc code can then use the ranges properties to setup the mapping of
> each chip select to the host address. You don't need a new property to
> describe the cs mapping.
>
> Rob
>
> >
> > IOW, would it be a good idea to have something like the following
layout?
> >
> >       gpmc: gpmc at 50000000 {
> >               compatible = "ti,gpmc";
> >               ti,hwmods = "gpmc";
> >               reg = <0x50000000 0x2000>;
> >
> >               /* cs-reg stores the setup of the controller's
> >                  memory map */
> >
> >                       /* offset       size */
> >               cs-reg = <0x0           0x1000000
> >                         ....          .....
> >                         ....          .....>;
> >
> >               nand: child at 0 {
> >                       /* timings */
> >                       /* peripheral specifics */
> >               };
> >       };
> >
> > I would actually much prefer that approach.
> >
> > Afzal, because because that way, we can leave the code as-is for now and
> > add the "cs-reg" property once the code is switched to dynamic handling.
> > What do you think?
> >
> >
> > Thanks,
> > Daniel
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/0729e0f3/attachment-0001.html>
