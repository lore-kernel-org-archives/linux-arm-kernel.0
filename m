From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:58:47 +0100
Subject: [PATCH v2 08/10] ARM: dts: sun8i: Add audio codec, dai and card
 for A33
In-Reply-To: <20170117140230.23142-9-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-9-mylene.josserand@free-electrons.com>
Message-ID: <20170117165847.olotkisojwgtdzrz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 17, 2017 at 03:02:28PM +0100, Myl?ne Josserand wrote:
> Add the audio codec, dai and a simple card to be able to use the
> audio stream of the builtin codec on sun8i SoC.
> 
> This commit adds also an audio-routing for the sound card node to link
> the analog DAPM widgets (Right/Left DAC) and the digital one's as they
> are created in different drivers.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 63d5181ffff8..fe8a4f4760d2 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -43,6 +43,7 @@
>   */
>  
>  #include "sun8i-a23-a33.dtsi"
> +#include <dt-bindings/dma/sun4i-a10.h>
>  
>  / {
>  	cpus {
> @@ -69,6 +70,27 @@
>  		reg = <0x40000000 0x80000000>;
>  	};
>  
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "Sun8i Audio Card";

You might have several of them if you're using an internal i2s DAI
with a codec too. What about "a33-codec" or something alike?

> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&link_codec>;
> +		simple-audio-card,bitclock-master = <&link_codec>;
> +		simple-audio-card,mclk-fs = <512>;
> +		simple-audio-card,aux-devs = <&codec_analog>;
> +		simple-audio-card,routing =
> +				"Left DAC", "Digital Left DAC",
> +				"Right DAC", "Digital Right DAC";

This will be enabled all the time (even if your DAI and codec are
not), which means that the driver will probe and.. do nothing. You
probably want to disable it here.

> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&dai>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +	};
> +
>  	soc at 01c00000 {
>  		tcon0: lcd-controller at 01c0c000 {
>  			compatible = "allwinner,sun8i-a33-tcon";
> @@ -116,6 +138,31 @@
>  			reset-names = "ahb";
>  		};
>  
> +		dai: dai at 01c22c00 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun6i-a31-i2s";
> +			reg = <0x01c22c00 0x200>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names = "apb", "mod";
> +			resets = <&ccu RST_BUS_CODEC>;
> +			reset-names = "rst";
> +			dmas = <&dma 15>, /* AUDIO_CODEC port */
> +				<&dma 15>; /* AUDIO_CODEC port */

There's no need for those comments.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/7bc16a97/attachment.sig>
