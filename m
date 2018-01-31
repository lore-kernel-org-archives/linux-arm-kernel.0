From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 31 Jan 2018 18:40:59 +0100
Subject: [PATCH v2 01/16] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
In-Reply-To: <20180128232919.12639-2-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-2-embed3d@gmail.com>
Message-ID: <20180131174058.f7gog7yahcu67sqr@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:04AM +0100, Philipp Rossak wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
> 
> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> the bus clock and the reset was removed from the CCU. The THS in A83T
> has a clock that is directly connected and runs with 24 MHz.
> 
> Update the binding document to cover H3 and A83T.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 50 ++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index 86dd8191b04c..22df0c5c23d4 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,35 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
>  and sometimes as a touchscreen controller.
>  
>  Required properties:
> -  - compatible: "allwinner,sun8i-a33-ths",
> +  - compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a33-ths"
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
>    - reg: mmio address range of the chip,
> -  - #thermal-sensor-cells: shall be 0,
> +  - #thermal-sensor-cells: shall be 0 or 1,

Well, thermal-sensor-cells is either 0 or 1 :)

Better to point to the documentation describing this
thermal-sensor-cells IMHO.

>    - #io-channel-cells: shall be 0,
>  
> -Example:
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
> +  - interrupts: the sampling interrupt of the ADC,
> +
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "mod",
> +  - resets: the bus reset of the ADC,
> +
> +Optional properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> +		If unspecified default values shall be used. The size should
> +		be 0x2 * sensorcount.

"twice the number of sensors" ?

> +  - nvmem-cell-names: Should be "calibration".
> +
> +Details see: bindings/nvmem/nvmem.txt
> +
> +Example for A33:
>  	ths: ths at 1c25000 {
>  		compatible = "allwinner,sun8i-a33-ths";
>  		reg = <0x01c25000 0x100>;
> @@ -17,6 +40,27 @@ Example:
>  		#io-channel-cells = <0>;
>  	};
>  
> +Example for H3:
> +	ths: thermal-sensor at 1c25000 {
> +		compatible = "allwinner,sun8i-h3-ths";
> +		reg = <0x01c25000 0x400>;
> +		clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +		clock-names = "bus", "mod";
> +		resets = <&ccu RST_BUS_THS>;
> +		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells = <0>;
> +		#io-channel-cells = <0>;
> +	};
> +
> +Example for A83T:
> +	ths: thermal-sensor at 1f04000 {
> +		compatible = "allwinner,sun8i-a83t-ths";
> +		reg = <0x01f04000 0x100>;
> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells = <1>;
> +		#io-channel-cells = <0>;
> +	};
> +

Aside from Maxime's comment on how we would like to refactor GPADC/THS,
I'm not sure we really want an example for each an every thermal sensor
supported.

Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180131/f784ab6e/attachment.sig>
