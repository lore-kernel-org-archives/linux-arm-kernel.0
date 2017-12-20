From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 10:58:06 +0100
Subject: [PATCH 5/5] ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio
 codec
In-Reply-To: <1513103111-45830-6-git-send-email-biju.das@bp.renesas.com>
References: <1513103111-45830-1-git-send-email-biju.das@bp.renesas.com>
 <1513103111-45830-6-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20171220095806.jqtkmximxybsq6tr@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 06:25:11PM +0000, Biju Das wrote:
> This patch enables SGTL5000 audio codec on the carrier board.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Somehow I missed applying this one.
I have now done so with the minor update noted below.

> ---
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> index 54470c6..2070b14 100644
> --- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> @@ -20,6 +20,20 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	audio_clock: audio_clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +	};
> +
> +	reg_1p5v: 1p5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P5V";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-always-on;
> +	};
> +
>  	vcc_sdhi1: regulator-vcc-sdhi1 {
>  		compatible = "regulator-fixed";
>  
> @@ -83,6 +97,16 @@
>  		compatible = "ti,bq32000";
>  		reg = <0x68>;
>  	};
> +
> +	sgtl5000: codec at 0a {

s/@0a/@a/

Base addresses should not have a leading 0.

# make dtbs W=1
DTC     arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb: Warning (unit_address_format): Node /soc/i2c at e6530000/codec at 0a unit name should not have leading 0s

> +		compatible = "fsl,sgtl5000";
> +		#sound-dai-cells = <0>;
> +		reg = <0x0a>;
> +		clocks = <&audio_clock>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +		VDDD-supply = <&reg_1p5v>;
> +	};
>  };
>  
>  &pci0 {
> -- 
> 1.9.1
> 
