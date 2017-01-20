From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 20 Jan 2017 08:10:42 -0600
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <CALAqxLV=5ZCu8=rDUFHS9148DxzrqeTipsueA7F4i3t-mcWr=A@mail.gmail.com>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <CALAqxLV=5ZCu8=rDUFHS9148DxzrqeTipsueA7F4i3t-mcWr=A@mail.gmail.com>
Message-ID: <CAL_Jsq+w9Md4GNZX1nZJS3aVT=gBmrraQVhGnc7wT2avW7w47w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 1:24 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Jan 16, 2017 at 5:24 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> The ARM Mali Utgard GPU family is embedded into a number of SoCs from
>> Allwinner, Amlogic, Mediatek or Rockchip.
>>
>> Add a binding for the GPU of that family.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>> new file mode 100644
>> index 000000000000..df05ba0ec357
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>> @@ -0,0 +1,76 @@
>> +ARM Mali Utgard GPU
>> +===================
>> +
>> +Required properties:
>> +  - compatible:
>> +    * "arm,mali-utgard" and one of the following:
>> +      + "arm,mali-300"
>> +      + "arm,mali-400"
>> +      + "arm,mali-450"
>> +
>> +  - reg: Physical base address and length of the GPU registers
>> +
>> +  - interrupts: an entry for each entry in interrupt-names.
>> +    See ../interrupt-controller/interrupts.txt for details.
>> +
>> +  - interrupt-names:
>> +    * ppX: Pixel Processor X interrupt (X from 0 to 7)
>> +    * ppmmuX: Pixel Processor X MMU interrupt (X from 0 to 7)
>> +    * pp: Pixel Processor broadcast interrupt (mali-450 only)
>> +    * gp: Geometry Processor interrupt
>> +    * gpmmu: Geometry Processor MMU interrupt
>> +
>> +
>> +Optional properties:
>> +  - interrupt-names:
>> +    * pmu: Power Management Unit interrupt, if implemented in hardware
>> +
>> +Vendor-specific bindings
>> +------------------------
>> +
>> +The Mali GPU is integrated very differently from one SoC to
>> +another. In order to accommodate those differences, you have the option
>> +to specify one more vendor-specific compatible, among:
>> +
>> +  - allwinner,sun4i-a10-mali
>> +    Required properties:
>> +      * clocks: an entry for each entry in clock-names
>> +      * clock-names:
>> +        + bus: bus clock for the GPU
>> +        + core: clock driving the GPU itself
>> +      * resets: phandle to the reset line for the GPU
>> +
>> +  - allwinner,sun7i-a20-mali
>> +    Required properties:
>> +      * clocks: an entry for each entry in clock-names
>> +      * clock-names:
>> +        + bus: bus clock for the GPU
>> +        + core: clock driving the GPU itself
>> +      * resets: phandle to the reset line for the GPU
>> +
>> +Example:
>> +
>> +mali: gpu at 01c40000 {
>> +       compatible = "allwinner,sun7i-a20-mali", "arm,mali-400",
>> +                    "arm,mali-utgard";
>> +       reg = <0x01c40000 0x10000>;
>> +       interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +                    <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>> +       interrupt-names = "gp",
>> +                         "gpmmu",
>> +                         "pp0",
>> +                         "ppmmu0",
>> +                         "pp1",
>> +                         "ppmmu1",
>> +                         "pmu";
>> +       clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
>> +       clock-names = "bus", "core";
>> +       resets = <&ccu RST_BUS_GPU>;
>> +};
>> +
>> +
>
>
> Having a mali utgard binding upstream would be great. However I'm a
> little worried that the mali driver I've used sort of only half way
> uses DT, and still requires a custom built in platform driver to setup
> numerous other things.  Curious if you have a pointer to the kernel
> driver you've been using with the vendor specific bindings above?  I'd
> like to try to adapt what we have to your method to validate the above
> as generic.
>
> And, just for context, here's the node we've been using with hikey:
>
>                 mali:mali at f4080000 {
>                         compatible = "arm,mali-450", "arm,mali-utgard";
>                         reg = <0x0 0x3f100000 0x0 0x00708000>;

Why's the size 7MB?

>                         clocks = <&media_ctrl HI6220_G3D_CLK>,
>                                  <&media_ctrl HI6220_G3D_PCLK>;
>                         clock-names = "clk_g3d", "pclk_g3d";

Seems like these are swapped from Maxime's order. Based on the pclk
frequency, that's the bus clock.

>                         mali_def_freq = <500>;
>                         pclk_freq = <144>;

There's a standard property for these with assigned-clocks.

>                         dfs_steps = <2>;
>                         dfs_lockprf = <1>;
>                         dfs_limit_max_prf = <1>;
>                         dfs_profile_num = <2>;
>                         dfs_profiles = <250 3 0>, <500 1 0>;

This looks like a OPP table. It can all be driver data associated with
the compatible string for now.

>                         mali_type = <2>;

Not sure about this one.

Rob
