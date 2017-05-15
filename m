From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:12 +0200
Subject: [PATCH v2 11/18] arm64: dts: meson-gxbb-odroidc2: Fix node order
In-Reply-To: <20170513143337.14278-12-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-12-afaerber@suse.de>
Message-ID: <995e63a7-f429-a335-7e9b-4994ae849505@baylibre.com>
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
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 108 ++++++++++-----------
>  1 file changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 54a9c6a6b392..d147c853ab05 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -137,16 +137,6 @@
>  	};
>  };
>  
> -&scpi_clocks {
> -	status = "disabled";
> -};
> -
> -&uart_AO {
> -	status = "okay";
> -	pinctrl-0 = <&uart_ao_a_pins>;
> -	pinctrl-names = "default";
> -};
> -
>  &ethmac {
>  	status = "okay";
>  	pinctrl-0 = <&eth_rgmii_pins>;
> @@ -172,6 +162,33 @@
>  	};
>  };
>  
> +&gpio_ao {
> +	/*
> +	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
> +	 * to be turned high in order to be detected by the USB Controller
> +	 * This signal should be handled by a USB specific power sequence
> +	 * in order to reset the Hub when USB bus is powered down.
> +	 */
> +	usb-hub {
> +		gpio-hog;
> +		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "usb-hub-reset";
> +	};
> +};
> +
> +&i2c_A {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  &pinctrl_aobus {
>  	gpio-line-names = "UART TX", "UART RX", "VCCK En", "TF 3V3/1V8 En",
>  			  "USB HUB nRESET", "USB OTG Power En",
> @@ -223,55 +240,15 @@
>  			  "";
>  };
>  
> -&ir {
> -	status = "okay";
> -	pinctrl-0 = <&remote_input_ao_pins>;
> -	pinctrl-names = "default";
> -};
> -
> -&i2c_A {
> -	status = "okay";
> -	pinctrl-0 = <&i2c_a_pins>;
> -	pinctrl-names = "default";
> -};
> -
> -&gpio_ao {
> -	/*
> -	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
> -	 * to be turned high in order to be detected by the USB Controller
> -	 * This signal should be handled by a USB specific power sequence
> -	 * in order to reset the Hub when USB bus is powered down.
> -	 */
> -	usb-hub {
> -		gpio-hog;
> -		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
> -		output-high;
> -		line-name = "usb-hub-reset";
> -	};
> -};
> -
> -&usb0_phy {
> -	status = "okay";
> -	phy-supply = <&usb_otg_pwr>;
> -};
> -
> -&usb1_phy {
> -	status = "okay";
> -};
> -
> -&usb0 {
> -	status = "okay";
> -};
> -
> -&usb1 {
> -	status = "okay";
> -};
> -
>  &saradc {
>  	status = "okay";
>  	vref-supply = <&vcc1v8>;
>  };
>  
> +&scpi_clocks {
> +	status = "disabled";
> +};
> +
>  /* SD */
>  &sd_emmc_b {
>  	status = "okay";
> @@ -309,3 +286,26 @@
>  	vmmc-supply = <&vcc3v3>;
>  	vqmmc-supply = <&vcc1v8>;
>  };
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +	phy-supply = <&usb_otg_pwr>;
> +};
> +
> +&usb1_phy {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> 

Hi Andreas,

Like a previous attempt, I'm not OK with such rework since it will break bisect and add complexity for new patches handling.

The order is not alphabetically ordered, live with it.

Neil
