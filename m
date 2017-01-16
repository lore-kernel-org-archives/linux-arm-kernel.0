From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Jan 2017 20:49:06 +0200
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
Message-ID: <20170116184906.r62di7xiil5lae33@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 02:24:23PM +0100, Maxime Ripard wrote:
> The ARM Mali Utgard GPU family is embedded into a number of SoCs from
> Allwinner, Amlogic, Mediatek or Rockchip.
> 
> Add a binding for the GPU of that family.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> 

Hi,

Do you have a driver in kernel which will implement these bindings?

Defining them for out-of-tree driver does not bring any benefits (3rd
party driver will not respect them anyway).

Best regards,
Krzysztof

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> new file mode 100644
> index 000000000000..df05ba0ec357
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -0,0 +1,76 @@
> +ARM Mali Utgard GPU
> +===================
> +
> +Required properties:
> +  - compatible:
> +    * "arm,mali-utgard" and one of the following:
> +      + "arm,mali-300"
> +      + "arm,mali-400"
> +      + "arm,mali-450"
> +
> +  - reg: Physical base address and length of the GPU registers
> +
> +  - interrupts: an entry for each entry in interrupt-names.
> +    See ../interrupt-controller/interrupts.txt for details.
> +
> +  - interrupt-names:
> +    * ppX: Pixel Processor X interrupt (X from 0 to 7)
> +    * ppmmuX: Pixel Processor X MMU interrupt (X from 0 to 7)
> +    * pp: Pixel Processor broadcast interrupt (mali-450 only)
> +    * gp: Geometry Processor interrupt
> +    * gpmmu: Geometry Processor MMU interrupt
> +
> +
> +Optional properties:
> +  - interrupt-names:
> +    * pmu: Power Management Unit interrupt, if implemented in hardware
> +
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accommodate those differences, you have the option
> +to specify one more vendor-specific compatible, among:
> +
> +  - allwinner,sun4i-a10-mali
> +    Required properties:
> +      * clocks: an entry for each entry in clock-names
> +      * clock-names:
> +        + bus: bus clock for the GPU
> +        + core: clock driving the GPU itself
> +      * resets: phandle to the reset line for the GPU
> +
> +  - allwinner,sun7i-a20-mali
> +    Required properties:
> +      * clocks: an entry for each entry in clock-names
> +      * clock-names:
> +        + bus: bus clock for the GPU
> +        + core: clock driving the GPU itself
> +      * resets: phandle to the reset line for the GPU
> +
> +Example:
> +
> +mali: gpu at 01c40000 {
> +	compatible = "allwinner,sun7i-a20-mali", "arm,mali-400",
> +		     "arm,mali-utgard";
> +	reg = <0x01c40000 0x10000>;
> +	interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "gp",
> +			  "gpmmu",
> +			  "pp0",
> +			  "ppmmu0",
> +			  "pp1",
> +			  "ppmmu1",
> +			  "pmu";
> +	clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
> +	clock-names = "bus", "core";
> +	resets = <&ccu RST_BUS_GPU>;
> +};
> +
> +
> -- 
> 2.11.0
> 
