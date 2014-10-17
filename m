From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 17 Oct 2014 10:43:48 +0900
Subject: [PATCH 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <1413493413-8041-3-git-send-email-dinguyen@opensource.altera.com>
References: <1413493413-8041-1-git-send-email-dinguyen@opensource.altera.com>
 <1413493413-8041-3-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <54407454.50903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Dinh.

On 10/17/2014 06:03 AM, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Without the 3.3V regulator node, the SDMMC driver will give these warnings:
> 
> dw_mmc ff704000.dwmmc0: No vmmc regulator found
> dw_mmc ff704000.dwmmc0: No vqmmc regulator found
> 
> This patch adds the regulator node, and points the SD/MMC to the regulator.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria5.dtsi         | 11 ++++++++++-
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts    |  5 +++++
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi       |  9 +++++++++
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  |  2 ++
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |  5 +++++
>  5 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 03e8268..8093781 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -29,7 +29,7 @@
>  			};
>  		};
>  
> -		dwmmc0 at ff704000 {
> +		mmc0: dwmmc0 at ff704000 {
>  			num-slots = <1>;
>  			broken-cd;
>  			bus-width = <4>;
> @@ -41,4 +41,13 @@
>  			cpu1-start-addr = <0xffd080c4>;
>  		};
>  	};
> +
> +	regulator_3_3v_hps: fixed_3_3v_hps_regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "HPS 3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;

Always-on is right?

> +	};
>  };
> diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> index 27d551c..b7e4023 100644
> --- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> @@ -68,6 +68,11 @@
>  	};
>  };
>  
> +&mmc0 {
> +	vmmc-supply = <&regulator_3_3v_hps>;
> +	vqmmc-supply = <&regulator_3_3v_hps>;
> +};
> +
>  &usb1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> index 28c05e7..743bc3b 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
> @@ -48,4 +48,13 @@
>  			cpu1-start-addr = <0xffd080c4>;
>  		};
>  	};
> +
> +	regulator_3_3v_hps: fixed_3_3v_hps_regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "HPS 3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index 739c3b7..e1f56ba 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -70,6 +70,8 @@
>  
>  &mmc0 {
>  	cd = <&gpio1 18 0>;
> +	vmmc-supply = <&regulator_3_3v_hps>;
> +	vqmmc-supply = <&regulator_3_3v_hps>;

Is vmmc and vqmmc  used the common supply?

Best Regards,
Jaehoon Chung

>  };
>  
>  &usb1 {
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> index d26f155..ea0c454 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> @@ -53,6 +53,11 @@
>  	rxc-skew-ps = <2000>;
>  };
>  
> +&mmc0 {
> +	vmmc-supply = <&regulator_3_3v_hps>;
> +	vqmmc-supply = <&regulator_3_3v_hps>;
> +};
> +
>  &usb1 {
>  	status = "okay";
>  };
> 
