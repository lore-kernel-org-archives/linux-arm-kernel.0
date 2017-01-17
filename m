From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:51:24 +0100
Subject: [PATCH v2 07/10] dt-bindings: sound: Add sun8i audio documentation
In-Reply-To: <20170117140230.23142-8-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-8-mylene.josserand@free-electrons.com>
Message-ID: <20170117165124.h5rbx3qhvdzwbqup@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 17, 2017 at 03:02:27PM +0100, Myl?ne Josserand wrote:
> Add the documentation for dt-binding of the digital audio codec driver
> and the audio card driver for Sun8i SoCs.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

One small comment below,

> ---
>  .../devicetree/bindings/sound/sun8i-codec.txt      | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> new file mode 100644
> index 000000000000..ce3c05219e33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> @@ -0,0 +1,76 @@
> +Allwinner SUN8I audio codec
> +------------------------------------
> +
> +On Sun8i SoCs, and particularly on A33, the audio is separated in

Technically that's not true on all the SoCs of the sun8i family, but
only a few of them (A33 and H3 iirc).

This driver is only made for the A33 at the moment, so you should only
mention it (and you should rename that file as well).

Once done,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime


> +different parts:
> +	  - A DAI driver. It uses the "sun4i-i2s" driver which is
> +	  documented here:
> +	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +	  - An analog part of the codec which is handled as PRCM registers.
> +	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> +	  - An digital part of the codec which is documented in this current
> +	  binding documentation.
> +	  - And finally, an audio card which links all the above components.
> +	  The simple-audio card will be used.
> +	  See Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +This bindings documentation exposes Sun8i codec (digital part).
> +
> +Required properties:
> +- compatible: must be "allwinner,sun8i-a33-codec"
> +- reg: must contain the registers location and length
> +- interrupts: must contain the codec interrupt
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain followings:
> +   - "bus": the parent APB clock for this controller
> +   - "mod": the parent module clock
> +
> +Example:
> +codec: codec at 01c22e00 {
> +	#sound-dai-cells = <0>;
> +	compatible = "allwinner,sun8i-a33-codec";
> +	reg = <0x01c22e00 0x400>;
> +	interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +	clock-names = "bus", "mod";
> +	status = "disabled";
> +};
> +
> +Here is an example to add a sound card and the codec binding on sun8i SoCs that
> +are similar to A33 using simple-card:
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "Sun8i Audio Card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&link_codec>;
> +		simple-audio-card,bitclock-master = <&link_codec>;
> +		simple-audio-card,mclk-fs = <512>;
> +		simple-audio-card,aux-devs = <&codec_analog>;
> +		simple-audio-card,routing =
> +				"Left DAC", "Digital Left DAC",
> +				"Right DAC", "Digital Right DAC";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&dai>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +
> +	soc at 01c00000 {
> +		[...]
> +
> +		codec: codec at 01c22e00 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun8i-a33-codec";
> +			reg = <0x01c22e00 0x400>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names = "bus", "mod";
> +			status = "disabled";
> +		};
> +	};
> +
> -- 
> 2.11.0
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/dbd075eb/attachment-0001.sig>
