From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 26 May 2017 12:31:53 +0100
Subject: [PATCH V2] ARM: dts: rockchip:add sd card support for firefly
 reload board
In-Reply-To: <1495782439-27142-1-git-send-email-eddie.cai.linux@gmail.com>
References: <1495782439-27142-1-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <951b3bad-eae7-f870-2bc1-8e230bfa4904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/17 08:07, Eddie Cai wrote:
> firefly reload board not support sd card yet. so support it.

I'm confused... According to pictures and the schematic the microSD
socket and vcc_sd supply are on the baseboard, not the core module, and
these nodes already exist in rk3288-firefly-reload.dts :/

Robin.

> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> index 413b61f..2f41209 100644
> --- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> @@ -57,6 +57,17 @@
>  		clock-output-names = "ext_gmac";
>  	};
>  
> +	vcc_sd: sdmmc-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_pwr>;
> +		regulator-name = "vcc_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100000>;
> +		vin-supply = <&vcc_io>;
> +	};
>  
>  	vcc_flash: flash-regulator {
>  		compatible = "regulator-fixed";
> @@ -281,6 +292,26 @@
>  			rockchip,pins = <4 8 RK_FUNC_GPIO &pcfg_output_high>;
>  		};
>  	};
> +
> +	sdmmc {
> +		sdmmc_pwr: sdmmc-pwr {
> +			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	card-detect-delay = <200>;
> +	disable-wp;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
> +	vmmc-supply = <&vcc_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
>  };
>  
>  &tsadc {
> 
