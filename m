From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:20 +0200
Subject: [PATCH v2 10/18] arm64: dts: meson-gxbb: Fix node order
In-Reply-To: <20170513143337.14278-11-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-11-afaerber@suse.de>
Message-ID: <9c51a1dd-8d70-31f8-6fd7-f33861763e2d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Rebased (new nodes added)
>  
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 171 +++++++++++++++-------------
>  1 file changed, 91 insertions(+), 80 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 4afe1c46ec11..92dd5d1d73c8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -97,13 +97,6 @@
>  	};
>  };
>  
> -&ethmac {
> -	clocks = <&clkc CLKID_ETH>,
> -		 <&clkc CLKID_FCLK_DIV2>,
> -		 <&clkc CLKID_MPLL2>;
> -	clock-names = "stmmaceth", "clkin0", "clkin1";
> -};
> -
>  &aobus {
>  	pinctrl_aobus: pinctrl at 14 {
>  		compatible = "amlogic,meson-gxbb-aobus-pinctrl";
> @@ -252,6 +245,97 @@
>  	};
>  };
>  
> +&apb {
> +	mali: gpu at c0000 {
> +		compatible = "amlogic,meson-gxbb-mali", "arm,mali-450";
> +		reg = <0x0 0xc0000 0x0 0x40000>;
> +		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "gp", "gpmmu", "pp", "pmu",
> +			"pp0", "ppmmu0", "pp1", "ppmmu1",
> +			"pp2", "ppmmu2";
> +		clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
> +		clock-names = "bus", "core";
> +
> +		/*
> +		 * Mali clocking is provided by two identical clock paths
> +		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
> +		 * free mux to safely change frequency while running.
> +		 */
> +		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
> +				  <&clkc CLKID_MALI_0>,
> +				  <&clkc CLKID_MALI>; /* Glitch free mux */
> +		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
> +					 <0>, /* Do Nothing */
> +					 <&clkc CLKID_MALI_0>;
> +		assigned-clock-rates = <0>, /* Do Nothing */
> +				       <666666666>,
> +				       <0>; /* Do Nothing */
> +	};
> +};
> +
> +&cbus {
> +	spifc: spi at 8c80 {
> +		compatible = "amlogic,meson-gxbb-spifc";
> +		reg = <0x0 0x08c80 0x0 0x80>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clkc CLKID_SPI>;
> +		status = "disabled";
> +	};
> +};
> +
> +&ethmac {
> +	clocks = <&clkc CLKID_ETH>,
> +		 <&clkc CLKID_FCLK_DIV2>,
> +		 <&clkc CLKID_MPLL2>;
> +	clock-names = "stmmaceth", "clkin0", "clkin1";
> +};
> +
> +&hdmi_tx {
> +	compatible = "amlogic,meson-gxbb-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
> +	resets = <&reset RESET_HDMITX_CAPB3>,
> +		 <&reset RESET_HDMI_SYSTEM_RESET>,
> +		 <&reset RESET_HDMI_TX>;
> +	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
> +	clocks = <&clkc CLKID_HDMI_PCLK>,
> +		 <&clkc CLKID_CLK81>,
> +		 <&clkc CLKID_GCLK_VENCI_INT0>;
> +	clock-names = "isfr", "iahb", "venci";
> +};
> +
> +&hiubus {
> +	clkc: clock-controller at 0 {
> +		compatible = "amlogic,gxbb-clkc";
> +		#clock-cells = <1>;
> +		reg = <0x0 0x0 0x0 0x3db>;
> +	};
> +};
> +
> +&i2c_A {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
> +&i2c_AO {
> +	clocks = <&clkc CLKID_AO_I2C>;
> +};
> +
> +&i2c_B {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
> +&i2c_C {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
>  &periphs {
>  	pinctrl_periphs: pinctrl at 4b0 {
>  		compatible = "amlogic,meson-gxbb-periphs-pinctrl";
> @@ -521,67 +605,6 @@
>  	};
>  };
>  
> -&hiubus {
> -	clkc: clock-controller at 0 {
> -		compatible = "amlogic,gxbb-clkc";
> -		#clock-cells = <1>;
> -		reg = <0x0 0x0 0x0 0x3db>;
> -	};
> -};
> -
> -&apb {
> -	mali: gpu at c0000 {
> -		compatible = "amlogic,meson-gxbb-mali", "arm,mali-450";
> -		reg = <0x0 0xc0000 0x0 0x40000>;
> -		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "gp", "gpmmu", "pp", "pmu",
> -			"pp0", "ppmmu0", "pp1", "ppmmu1",
> -			"pp2", "ppmmu2";
> -		clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
> -		clock-names = "bus", "core";
> -
> -		/*
> -		 * Mali clocking is provided by two identical clock paths
> -		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
> -		 * free mux to safely change frequency while running.
> -		 */
> -		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
> -				  <&clkc CLKID_MALI_0>,
> -				  <&clkc CLKID_MALI>; /* Glitch free mux */
> -		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
> -					 <0>, /* Do Nothing */
> -					 <&clkc CLKID_MALI_0>;
> -		assigned-clock-rates = <0>, /* Do Nothing */
> -				       <666666666>,
> -				       <0>; /* Do Nothing */
> -	};
> -};
> -
> -&i2c_A {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
> -&i2c_AO {
> -	clocks = <&clkc CLKID_AO_I2C>;
> -};
> -
> -&i2c_B {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
> -&i2c_C {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
>  &saradc {
>  	compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
>  	clocks = <&xtal>,
> @@ -620,15 +643,3 @@
>  &vpu {
>  	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
>  };
> -
> -&hdmi_tx {
> -	compatible = "amlogic,meson-gxbb-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
> -	resets = <&reset RESET_HDMITX_CAPB3>,
> -		 <&reset RESET_HDMI_SYSTEM_RESET>,
> -		 <&reset RESET_HDMI_TX>;
> -	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
> -	clocks = <&clkc CLKID_HDMI_PCLK>,
> -		 <&clkc CLKID_CLK81>,
> -		 <&clkc CLKID_GCLK_VENCI_INT0>;
> -	clock-names = "isfr", "iahb", "venci";
> -};
> 
Hi Andreas,

Like a previous attempt, I'm not OK with such rework since it will break bisect and add complexity for new patches handling.

The order is not alphabetically ordered, live with it.

Neil
