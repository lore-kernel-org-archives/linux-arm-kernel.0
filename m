From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:35:12 +0100
Subject: [PATCH] arm64: dts: hikey960: Clean up MMC properties and move to
 proper file
In-Reply-To: <20180618181008.21831-1-ryan@edited.us>
References: <20180618181008.21831-1-ryan@edited.us>
Message-ID: <5B4F5E30.1080208@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/6/18 19:10, Ryan Grachek wrote:
> Certain properties should be moved to the board file to reflect
> the specific properties of the board, and not the SoC. Move these
> properties to proper location and organize properties in both files.
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 27 ++++++++++++++++++-----
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 27 +++++------------------
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index abc991619c75..1c2a9a5d0477 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -602,20 +602,37 @@
>  };
>  
>  &dwmmc1 {
> +	bus-width = <0x4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	disable-wp;
> +	cd-inverted;
> +	cd-gpios = <&gpio25 3 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd_pmx_func
> +		&sd_clk_cfg_func
> +		&sd_cfg_func>;
>  	vmmc-supply = <&ldo16>;
>  	vqmmc-supply = <&ldo9>;
>  	status = "okay";
>  };
>  
>  &dwmmc2 { /* WIFI */
> -	broken-cd;
> -	/* WL_EN */
> -	vmmc-supply = <&wlan_en>;
> +	bus-width = <0x4>;
>  	non-removable;
> +	broken-cd;
> +	cap-sd-highspeed;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
> -	#address-cells = <0x1>;
> -	#size-cells = <0x0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio_pmx_func
> +		&sdio_clk_cfg_func
> +		&sdio_cfg_func>;
> +	/* WL_EN */
> +	vmmc-supply = <&wlan_en>;
>  	status = "ok";
>  
>  	wlcore: wlcore at 2 {
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 74c0509f99e9..fe4c9f321b70 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1114,15 +1114,10 @@
>  
>  		/* SD */
>  		dwmmc1: dwmmc1 at ff37f000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			cd-inverted;
>  			compatible = "hisilicon,hi3660-dw-mshc";
> -			bus-width = <0x4>;
> -			disable-wp;
> -			cap-sd-highspeed;
> -			card-detect-delay = <200>;
>  			reg = <0x0 0xff37f000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_SD>,
>  				<&crg_ctrl HI3660_HCLK_GATE_SD>;
> @@ -1130,16 +1125,8 @@
>  			clock-frequency = <3200000>;
>  			resets = <&crg_rst 0x94 18>;
>  			reset-names = "reset";
> -			cd-gpios = <&gpio25 3 0>;
>  			hisilicon,peripheral-syscon = <&sctrl>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sd_pmx_func
> -				     &sd_clk_cfg_func
> -				     &sd_cfg_func>;
> -			sd-uhs-sdr12;
> -			sd-uhs-sdr25;
> -			sd-uhs-sdr50;
> -			sd-uhs-sdr104;
> +			card-detect-delay = <200>;
>  			status = "disabled";
>  		};
>  
> @@ -1147,6 +1134,8 @@
>  		dwmmc2: dwmmc2 at ff3ff000 {
>  			compatible = "hisilicon,hi3660-dw-mshc";
>  			reg = <0x0 0xff3ff000 0x0 0x1000>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
>  			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&crg_ctrl HI3660_CLK_GATE_SDIO0>,
>  				 <&crg_ctrl HI3660_HCLK_GATE_SDIO0>;
> @@ -1154,12 +1143,6 @@
>  			resets = <&crg_rst 0x94 20>;
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
> -			cap-sd-highspeed;
> -			keep-power-in-suspend;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sdio_pmx_func
> -				     &sdio_clk_cfg_func
> -				     &sdio_cfg_func>;
>  			status = "disabled";
>  		};
>  
> 
