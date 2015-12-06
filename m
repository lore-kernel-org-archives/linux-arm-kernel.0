From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 6 Dec 2015 10:28:30 +0100
Subject: [PATCH] arm: dts: berlin2q-marvell-dmp: add sdhci1 fully
 functionality
In-Reply-To: <1448891679-7894-1-git-send-email-jszhang@marvell.com>
References: <1448891679-7894-1-git-send-email-jszhang@marvell.com>
Message-ID: <5663FFBE.1070708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.11.2015 14:54, Jisheng Zhang wrote:
> The sdhci1 on Marvell BG2Q DMP board is used as sdcard interface, we
> have gpios for card detection, write-protect, vqmmc and vmmc.
> 
> This patch adds pinmux for this sdcard interface, then adds regulators
> for vmmc and vqmmc, lastly adds cd-gpios, wp-gpios properties.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin/dt.

> ---
> since v1:

Please also increment the patch subject version next time.

Thanks!

Sebastian

>  - move sd1_pmux to soc dtsi
>  - remove cd-inverted and make cd-gpio GPIO_ACTIVE_LOW
> 
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 37 ++++++++++++++++++++++++++++--
>  arch/arm/boot/dts/berlin2q.dtsi            |  5 ++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index cdcf89b..33b2875 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -84,12 +84,45 @@
>  			gpio = <&portb 12 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
>  		};
> +
> +		reg_sdio1_vmmc: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-name = "sdio1_vmmc";
> +			enable-active-high;
> +			regulator-boot-on;
> +			gpio = <&portb 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		reg_sdio1_vqmmc: regulator at 4 {
> +			compatible = "regulator-gpio";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-name = "sdio1_vqmmc";
> +			regulator-type = "voltage";
> +			enable-active-high;
> +			gpios = <&portb 16 GPIO_ACTIVE_HIGH>;
> +			states = <3300000 0x1
> +				  1800000 0x0>;
> +		};
> +	};
> +};
> +
> +&soc_pinctrl {
> +	sd1gpio_pmux: sd1pwr-pmux {
> +		groups = "G23", "G32";
> +		function = "gpio";
>  	};
>  };
>  
>  &sdhci1 {
> -	broken-cd;
> -	sdhci,wp-inverted;
> +	vmmc-supply = <&reg_sdio1_vmmc>;
> +	vqmmc-supply = <&reg_sdio1_vqmmc>;
> +	cd-gpios = <&portc 30 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&portd 0 GPIO_ACTIVE_HIGH>;
> +	pinctrl-0 = <&sd1gpio_pmux>, <&sd1_pmux>;
> +	pinctrl-names = "default";
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 8ea177f..73a9362 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -417,6 +417,11 @@
>  			soc_pinctrl: pin-controller {
>  				compatible = "marvell,berlin2q-soc-pinctrl";
>  
> +				sd1_pmux: sd1-pmux {
> +					groups = "G31";
> +					function = "sd1";
> +				};
> +
>  				twsi0_pmux: twsi0-pmux {
>  					groups = "G6";
>  					function = "twsi0";
> 
