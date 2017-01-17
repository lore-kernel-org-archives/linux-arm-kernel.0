From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:46:36 +0100
Subject: [PATCH v2 03/10] dt-bindings: sound: Add new reset compatible
 for sun4i-i2s
In-Reply-To: <20170117140230.23142-4-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-4-mylene.josserand@free-electrons.com>
Message-ID: <20170117164636.qhkxvqcs7l732wxk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:02:23PM +0100, Myl?ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
> 
> This new compatible, "allwinner,sun6i-a31-i2s", requires two
> properties:
> 	- resets: phandle to the reset line
> 	- reset-names: the name of the reset line ("rst").
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 7a2c0945fd22..f673206e309b 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -7,6 +7,7 @@ Required properties:
>  
>  - compatible: should be one of the following:
>     - "allwinner,sun4i-a10-i2s"
> +   - "allwinner,sun6i-a31-i2s" for controller with reset lines

That's not only for controllers with reset lines, but for the
controllers found in the A31 (and later). I'd simply drop the last
part of that line.

>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -19,7 +20,13 @@ Required properties:
>     - "mod" : module clock for the I2S controller
>  - #sound-dai-cells : Must be equal to 0
>  
> +Required properties for the following compatibles:
> +		- "allwinner,sun6i-a31-i2s"
> +- resets: phandle to the reset line for this codec
> +- reset-names: Contains the reset signal name "rst"

You don't need reset-names if there's a single reset line.

> +
>  Example:
> +For "allwinner,sun4i-a10-i2s":
>  
>  i2s0: i2s at 01c22400 {
>  	#sound-dai-cells = <0>;
> @@ -32,3 +39,19 @@ i2s0: i2s at 01c22400 {
>  	       <&dma SUN4I_DMA_NORMAL 3>;
>  	dma-names = "rx", "tx";
>  };
> +
> +For "allwinner,sun6i-a31-i2s":
> +
> +dai: dai at 01c22c00 {
> +	#sound-dai-cells = <0>;
> +	compatible = "allwinner,sun6i-a31-i2s";
> +	reg = <0x01c22c00 0x200>;
> +	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +	clock-names = "apb", "mod";
> +	resets = <&ccu RST_BUS_CODEC>;
> +	reset-names = "rst";
> +	dmas = <&dma 15>, /* AUDIO_CODEC port */
> +		<&dma 15>; /* AUDIO_CODEC port */
> +	dma-names = "rx", "tx";
> +};

And we already have an example, so there's no need to add a new one
either.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/798afa34/attachment.sig>
