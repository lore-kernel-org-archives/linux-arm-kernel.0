From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 24 Jan 2016 18:37:01 +0100
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
In-Reply-To: <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20160124173701.GU3880@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 12:36:39AM +0200, Aaro Koskinen wrote:
> Fix audio on kirkwood-openrd-client:
> 
> 1) The audio-controller was left disabled.
> 
> 2) The probe fails because cs42l51 is missing #sound-dai-cells.
> 
> 	/sound/simple-audio-card,codec: could not get #sound-dai-cells for /ocp at f1000000/i2c at 11000/cs42l51 at 4a
> 	asoc-simple-card sound: parse error -22
> 	asoc-simple-card: probe of sound failed with error -22
> 
> 3) The mapping is incorrect:
> 
> 	asoc-simple-card sound: cs42l51-hifi <-> spdif mapping ok
> 
>    should be:
> 
> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
> 
> Reported-by: Rick Thomas <rbthomas@pobox.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

It would be good to have a Tested-by: from Rick.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	     Andrew

> ---
>  arch/arm/boot/dts/kirkwood-openrd-client.dts | 6 +++++-
>  arch/arm/boot/dts/kirkwood.dtsi              | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openrd-client.dts b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> index 887b9c1..96ff59d 100644
> --- a/arch/arm/boot/dts/kirkwood-openrd-client.dts
> +++ b/arch/arm/boot/dts/kirkwood-openrd-client.dts
> @@ -20,6 +20,9 @@
>  	compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>  
>  	ocp at f1000000 {
> +		audio-controller at a0000 {
> +			status = "okay";
> +		};
>  		i2c at 11000 {
>  			status = "okay";
>  			clock-frequency = <400000>;
> @@ -27,6 +30,7 @@
>  			cs42l51: cs42l51 at 4a {
>  				compatible = "cirrus,cs42l51";
>  				reg = <0x4a>;
> +				#sound-dai-cells = <0>;
>  			};
>  		};
>  	};
> @@ -37,7 +41,7 @@
>  		simple-audio-card,mclk-fs = <256>;
>  
>  		simple-audio-card,cpu {
> -			sound-dai = <&audio0>;
> +			sound-dai = <&audio0 0>;
>  		};
>  
>  		simple-audio-card,codec {
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7b5a4a1..7445a15 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -381,7 +381,7 @@
>  
>  		audio0: audio-controller at a0000 {
>  			compatible = "marvell,kirkwood-audio";
> -			#sound-dai-cells = <0>;
> +			#sound-dai-cells = <1>;
>  			reg = <0xa0000 0x2210>;
>  			interrupts = <24>;
>  			clocks = <&gate_clk 9>;
> -- 
> 2.4.0
> 
