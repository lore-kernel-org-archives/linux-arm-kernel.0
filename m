From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 10:16:08 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <CALAqxLV=5ZCu8=rDUFHS9148DxzrqeTipsueA7F4i3t-mcWr=A@mail.gmail.com>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <CALAqxLV=5ZCu8=rDUFHS9148DxzrqeTipsueA7F4i3t-mcWr=A@mail.gmail.com>
Message-ID: <20170120091608.ijdhpeq2t5no75rc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Thu, Jan 19, 2017 at 11:24:38AM -0800, John Stultz wrote:
> On Mon, Jan 16, 2017 at 5:24 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> > Allwinner, Amlogic, Mediatek or Rockchip.
> >
> > Add a binding for the GPU of that family.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > new file mode 100644
> > index 000000000000..df05ba0ec357
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > @@ -0,0 +1,76 @@
> > +ARM Mali Utgard GPU
> > +===================
> > +
> > +Required properties:
> > +  - compatible:
> > +    * "arm,mali-utgard" and one of the following:
> > +      + "arm,mali-300"
> > +      + "arm,mali-400"
> > +      + "arm,mali-450"
> > +
> > +  - reg: Physical base address and length of the GPU registers
> > +
> > +  - interrupts: an entry for each entry in interrupt-names.
> > +    See ../interrupt-controller/interrupts.txt for details.
> > +
> > +  - interrupt-names:
> > +    * ppX: Pixel Processor X interrupt (X from 0 to 7)
> > +    * ppmmuX: Pixel Processor X MMU interrupt (X from 0 to 7)
> > +    * pp: Pixel Processor broadcast interrupt (mali-450 only)
> > +    * gp: Geometry Processor interrupt
> > +    * gpmmu: Geometry Processor MMU interrupt
> > +
> > +
> > +Optional properties:
> > +  - interrupt-names:
> > +    * pmu: Power Management Unit interrupt, if implemented in hardware
> > +
> > +Vendor-specific bindings
> > +------------------------
> > +
> > +The Mali GPU is integrated very differently from one SoC to
> > +another. In order to accommodate those differences, you have the option
> > +to specify one more vendor-specific compatible, among:
> > +
> > +  - allwinner,sun4i-a10-mali
> > +    Required properties:
> > +      * clocks: an entry for each entry in clock-names
> > +      * clock-names:
> > +        + bus: bus clock for the GPU
> > +        + core: clock driving the GPU itself
> > +      * resets: phandle to the reset line for the GPU
> > +
> > +  - allwinner,sun7i-a20-mali
> > +    Required properties:
> > +      * clocks: an entry for each entry in clock-names
> > +      * clock-names:
> > +        + bus: bus clock for the GPU
> > +        + core: clock driving the GPU itself
> > +      * resets: phandle to the reset line for the GPU
> > +
> > +Example:
> > +
> > +mali: gpu at 01c40000 {
> > +       compatible = "allwinner,sun7i-a20-mali", "arm,mali-400",
> > +                    "arm,mali-utgard";
> > +       reg = <0x01c40000 0x10000>;
> > +       interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > +                    <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> > +       interrupt-names = "gp",
> > +                         "gpmmu",
> > +                         "pp0",
> > +                         "ppmmu0",
> > +                         "pp1",
> > +                         "ppmmu1",
> > +                         "pmu";
> > +       clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
> > +       clock-names = "bus", "core";
> > +       resets = <&ccu RST_BUS_GPU>;
> > +};
> 
> Having a mali utgard binding upstream would be great. However I'm a
> little worried that the mali driver I've used sort of only half way
> uses DT, and still requires a custom built in platform driver to setup
> numerous other things.  Curious if you have a pointer to the kernel
> driver you've been using with the vendor specific bindings above?  I'd
> like to try to adapt what we have to your method to validate the above
> as generic.

I've created a custom platform driver, so just like you it seems,
because I've not managed to make ARM's DT support work.

https://github.com/mripard/sunxi-mali/blob/master/driver/src/devicedrv/mali/platform/sunxi/sunxi.c

I haven't updated it yet with the bindings suggested above, but only
the interrupt and clock names have changed. The rest very much
applies.

The only thing that might be vendor specific would be the (optional)
declaration of the mali_gpu_device_data structure. As far as I know,
there's two things of importance there:
  - the list of the valid OPPs in order to do DVFS, but that could be
    made generic too using the operating-points binding

  - And the valid area for the buffers for the fbdev blobs (fb_start,
    fb_size and shared_mem_size). I'm not entirely happy with this one
    so far (which is also why I've not pushed it). We'd need to come
    up with a way to get the base address and size of the CMA region
    backing the framebuffer allocation, but I haven't find any trivial
    way to do so, so for now I just hardcoded it. Worst case scenario,
    we can hardcode values based on the compatible.

> And, just for context, here's the node we've been using with hikey:
> 
>                 mali:mali at f4080000 {
>                         compatible = "arm,mali-450", "arm,mali-utgard";
>                         reg = <0x0 0x3f100000 0x0 0x00708000>;

This is because the hikey is using a 64 bits CPU, right?

>                         clocks = <&media_ctrl HI6220_G3D_CLK>,
>                                  <&media_ctrl HI6220_G3D_PCLK>;
>                         clock-names = "clk_g3d", "pclk_g3d";
>                         mali_def_freq = <500>;
>                         pclk_freq = <144>;
>                         dfs_steps = <2>;
>                         dfs_lockprf = <1>;
>                         dfs_limit_max_prf = <1>;
>                         dfs_profile_num = <2>;
>                         dfs_profiles = <250 3 0>, <500 1 0>;
>                         mali_type = <2>;
> 
>                         interrupt-parent = <&gic>;
>                         interrupts =    <1 126 4>, /*gp*/
>                                         <1 126 4>, /*gp mmu*/
>                                         <1 126 4>, /*pp bc*/
>                                         <1 126 4>, /*pmu*/
>                                         <1 126 4>, /*pp0*/
>                                         <1 126 4>,
>                                         <1 126 4>, /*pp1*/
>                                         <1 126 4>,
>                                         <1 126 4>, /*pp2*/
>                                         <1 126 4>,
>                                         <1 126 4>, /*pp4*/
>                                         <1 126 4>,
>                                         <1 126 4>, /*pp5*/
>                                         <1 126 4>,
>                                         <1 126 4>, /*pp6*/
>                                         <1 126 4>;
>                         interrupt-names = "IRQGP", "IRQGPMMU",
> "IRQPP", "IRQPMU",
>                                         "IRQPP0", "IRQPPMMU0",
> "IRQPP1", "IRQPPMMU1",
>                                         "IRQPP2",
> "IRQPPMMU2","IRQPP4", "IRQPPMMU4",
>                                         "IRQPP5", "IRQPPMMU5",
> "IRQPP6", "IRQPPMMU6";
>                 };

So all your interrupts are shared?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/22b35a87/attachment.sig>
