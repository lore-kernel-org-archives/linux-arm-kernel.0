From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 09:57:17 +0100
Subject: [v2 2/3] ARM: dts: STM32 Add USB FS host mode support
In-Reply-To: <20170116020958.62767-2-bruherrera@gmail.com>
References: <20170116020958.62767-1-bruherrera@gmail.com>
 <20170116020958.62767-2-bruherrera@gmail.com>
Message-ID: <f1fac058-6c03-595a-0d67-a89fcf70d7cc@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bruno,

On 01/16/2017 03:09 AM, Bruno Herrera wrote:
> This patch adds the USB pins and nodes for USB HS/FS cores working at FS speed,
> using embedded PHY.
>
> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>

Sorry, but what is patch 1 & pacth 3 status ?

For this one, can split it in 3 patches (one patch for SOC and one for 
each board) please.


> ---
>  arch/arm/boot/dts/stm32f429-disco.dts | 30 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stm32f429.dtsi      | 35 ++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/stm32f469-disco.dts | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 7d0415e..374c5ed 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -88,6 +88,16 @@
>  			gpios = <&gpioa 0 0>;
>  		};
>  	};
> +
> +	/* This turns on vbus for otg for host mode (dwc2) */
> +	vcc5v_otg: vcc5v-otg-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpioc 4 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbotg_pwren_h>;
> +		regulator-name = "vcc5_host1";
> +		regulator-always-on;
> +	};
>  };
>
>  &clk_hse {
> @@ -99,3 +109,23 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&usbotg_hs {
> +	compatible = "st,stm32-fsotg", "snps,dwc2";
> +	dr_mode = "host";
> +	pinctrl-0 = <&usbotg_fs_pins_b>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	usb-host {
> +		usbotg_pwren_h: usbotg-pwren-h {
> +			pins {
> +				pinmux = <STM32F429_PC4_FUNC_GPIO>;
> +				bias-disable;
> +				drive-push-pull;
> +			};
> +		};
> +	};
> +};

Pinctrl muxing has to be defined/declared in stm32f429.dtsi


> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index e4dae0e..bc07aa8 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -206,7 +206,7 @@
>  			reg = <0x40007000 0x400>;
>  		};
>
> -		pin-controller {
> +		pinctrl: pin-controller {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			compatible = "st,stm32f429-pinctrl";
> @@ -316,6 +316,30 @@
>  				};
>  			};
>
> +			usbotg_fs_pins_a: usbotg_fs at 0 {
> +				pins {
> +					pinmux = <STM32F429_PA10_FUNC_OTG_FS_ID>,
> +						 <STM32F429_PA11_FUNC_OTG_FS_DM>,
> +						 <STM32F429_PA12_FUNC_OTG_FS_DP>;
> +					bias-disable;
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +			};
> +
> +			usbotg_fs_pins_b: usbotg_fs at 1 {
> +				pins {
> +					pinmux = <STM32F429_PB12_FUNC_OTG_HS_ID>,
> +						 <STM32F429_PB14_FUNC_OTG_HS_DM>,
> +						 <STM32F429_PB15_FUNC_OTG_HS_DP>;
> +					bias-disable;
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +			};
> +
> +
> +
>  			usbotg_hs_pins_a: usbotg_hs at 0 {
>  				pins {
>  					pinmux = <STM32F429_PH4_FUNC_OTG_HS_ULPI_NXT>,
> @@ -420,6 +444,15 @@
>  			status = "disabled";
>  		};
>
> +		usbotg_fs: usb at 50000000 {
> +			compatible = "st,stm32f4xx-fsotg", "snps,dwc2";
> +			reg = <0x50000000 0x40000>;
> +			interrupts = <67>;
> +			clocks = <&rcc 0 39>;
> +			clock-names = "otg";
> +			status = "disabled";
> +		};
> +
>  		rng: rng at 50060800 {
>  			compatible = "st,stm32-rng";
>  			reg = <0x50060800 0x400>;
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 8877c00..8ae6763 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -68,6 +68,17 @@
>  	soc {
>  		dma-ranges = <0xc0000000 0x0 0x10000000>;
>  	};
> +
> +	/* This turns on vbus for otg for host mode (dwc2) */
> +	vcc5v_otg: vcc5v-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpiob 2 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbotg_pwren_h>;
> +		regulator-name = "vcc5_host1";
> +		regulator-always-on;
> +	};
>  };
>
>  &rcc {
> @@ -81,3 +92,22 @@
>  &usart3 {
>  	status = "okay";
>  };
> +
> +&usbotg_fs {
> +	dr_mode = "host";
> +	pinctrl-0 = <&usbotg_fs_pins_a>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	usb-host {
> +		usbotg_pwren_h: usbotg-pwren-h {
> +			pins {
> +				pinmux = <STM32F429_PB2_FUNC_GPIO>;
> +				bias-disable;
> +				drive-push-pull;
> +			};
> +		};
> +	};
> +};
Same. Note that if you have 2 configuration for one feature (like it is 
here for "usbotg_pwren_h"), you could index it. Not that I'm adding a 
dedidacted pinctroller for stm32f469.

Br
Alex
>
