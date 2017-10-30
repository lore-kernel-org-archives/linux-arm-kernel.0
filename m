From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 30 Oct 2017 16:06:58 -0700
Subject: [PATCH v3 1/5] dt-bindings: input: Add Atmel PTC subsystem
 bindings
In-Reply-To: <20171020133121.7992-2-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
 <20171020133121.7992-2-ludovic.desroches@microchip.com>
Message-ID: <20171030230658.csl2sxfrmdcdx3lj@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

On Fri, Oct 20, 2017 at 03:31:17PM +0200, Ludovic Desroches wrote:
> Add description of the Atmel PTC subsystem bindings.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/input/atmel,ptc.txt        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,ptc.txt b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> new file mode 100644
> index 000000000000..a183fd511e04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> @@ -0,0 +1,67 @@
> +Atmel PTC Subsystem
> +
> +The Atmel Peripheral Touch Controller subsystem offers built-in hardware
> +for capacitive touch measurement on sensors that function as buttons, sliders
> +and wheels.
> +
> +1) PTC Subsystem node
> +
> +Required properties:
> +- compatible: 		Must be "atmel,sama5d2-ptc"
> +- reg: 			Address, length of the shared memory and ppp registers location
> +			and length.
> +- clocks: 		Phandlers to the clocks.
> +- clock-names: 		Must be "ptc_clk", "ptc_int_osc", "slow_clk".
> +- #address-cells:	Must be one. The cell is the button or scroller id.
> +- #size-cells: 		Must be zero.
> +
> +Example:
> +	ptc at fc060000 {
> +		compatible = "atmel,sama5d2-ptc";
> +		reg = <0x00800000 0x10000
> +		       0xfc060000 0xcf>;
> +		interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
> +		clocks = <&ptc_clk>, <&main>, <&clk32k>;
> +		clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		[ child node definitions... ]
> +	};
> +
> +2) Scroller / buttons subnodes
> +
> +Subnodes describe the kind of sensors the customer want to use. They have to be
> +named according to their function: button, slider or wheel.

I wonder do we really need this? Or we can have a generic:

	slider at 0 {
		reg = <0>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_X>;
	},
	vertical-slider at 1 {
		reg = <1>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_Y>;
	},
	wheel at 2 {
		reg = <2>;
		linux,type = <EV_ABS>;
		linux,code = <ABS_WHEEL>;
	},
	button at 3 {
		reg = <3>;
		linux,type = <EV_KEY>;
		linux,code = <KEY_A>;
	},
	...

I.e. you specify type/code in a generic way.

Thanks.

-- 
Dmitry
