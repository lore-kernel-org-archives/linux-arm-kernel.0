From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 06 Jul 2013 01:36:57 +0200
Subject: [PATCH 1/3] ARM: dts: Put Arndale fixed voltage regulators on a
 simple-bus
In-Reply-To: <1372714599-17588-1-git-send-email-broonie@kernel.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
Message-ID: <2269980.iUpB0kJaI3@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Monday 01 of July 2013 22:36:37 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Fixed voltage regulators (and other similar free standing things) are
> supposed to go on a simple-bus for DT correctness reasons.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts | 28
> +++++++++++++++++----------- 1 file changed, 17 insertions(+), 11
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts
> b/arch/arm/boot/dts/exynos5250-arndale.dts index abc7272..68a13a6
> 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -429,18 +429,24 @@
>  		vdd-supply = <&ldo8_reg>;
>  	};
> 
> -	mmc_reg: voltage-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VDD_33ON_2.8V";
> -		regulator-min-microvolt = <2800000>;
> -		regulator-max-microvolt = <2800000>;
> -		gpio = <&gpx1 1 1>;
> -		enable-active-high;
> -	};
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Are the two #properties above really necessary? The regulators that will 
be placed here probably don't need any kind of addressing, so it should be 
possible to omit them.

> +
> +		mmc_reg: voltage-regulator {

I'd suggest suffixing name of this node with an index, like voltage-
regulator-0 to be more future proof, in case of further fixed regulators 
being added.

> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD_33ON_2.8V";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			gpio = <&gpx1 1 1>;
> +			enable-active-high;
> +		};
> 
> -	reg_hdmi_en: fixedregulator at 0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "hdmi-en";
> +		reg_hdmi_en: fixedregulator at 0 {

And here I'd use the same convention of suffixes, renaming the node to 
voltage-regulator-1 for the sake of consistency.

Best regards,
Tomasz

> +			compatible = "regulator-fixed";
> +			regulator-name = "hdmi-en";
> +		};
>  	};
> 
>  	fixed-rate-clocks {
