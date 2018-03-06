From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 20:37:47 -0600
Subject: [PATCH v2 4/6] ARM: dts: stm32: Enable sdio1 for stm32f769-disco
In-Reply-To: <1519901623-23216-5-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <1519901623-23216-5-git-send-email-patrice.chotard@st.com>
Message-ID: <20180306023747.lzh5yxfyugtlu62t@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 11:53:41AM +0100, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Adds SDIO related DT nodes for stm32f769-disco board.
> 
> broken-cd property is needed as it misses a pullup on board
> (resistor R76 is missing).
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/boot/dts/stm32f769-disco.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 9dba286c6d2f..2d922b5d4766 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -44,6 +44,7 @@
>  #include "stm32f746.dtsi"
>  #include "stm32f769-pinctrl.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "STMicroelectronics STM32F769-DISCO board";
> @@ -62,6 +63,12 @@
>  		serial0 = &usart1;
>  	};
>  
> +	mmc_vcard: mmc_vcard {

mmc-vcard {

> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc_vcard";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>  };
>  
>  &cec {
> @@ -74,6 +81,18 @@
>  	clock-frequency = <25000000>;
>  };
>  
> +&sdio2 {
> +	status = "okay";
> +	vmmc-supply = <&mmc_vcard>;
> +	cd-gpios = <&gpioi 15 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	broken-cd;
> +	pinctrl-names = "default", "opendrain";
> +	pinctrl-0 = <&sdio_pins_b>;
> +	pinctrl-1 = <&sdio_pins_od_b>;
> +	bus-width = <4>;
> +};
> +
>  &usart1 {
>  	pinctrl-0 = <&usart1_pins_a>;
>  	pinctrl-names = "default";
> -- 
> 1.9.1
> 
