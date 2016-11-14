From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2016 16:36:20 +0100
Subject: [PATCH v2] ARM: at91/dt: add dts file for sama5d36ek CMP board
In-Reply-To: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
References: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <8288c669-aef5-fb8d-8671-b35307203226@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/11/2016 ? 04:05, Wenyou Yang a ?crit :
> The sama5d36ek CMP board is the variant of sama5d3xek board.
> It is equipped with the low-power DDR2 SDRAM, PMIC ACT8865 and
> some power rail. Its main purpose is used to measure the power
> consumption.
> The difference of the sama5d36ek CMP dts from sama5d36ek dts
> is listed as below.
>  1. The USB host nodes are removed, that is, the USB host is disabled.
>  2. The gpio_keys node is added to wake up from the sleep.
>  3. The LCD isn't supported due to the pins for LCD are conflicted
>     with gpio_keys.
>  4. The adc0 node support the pinctrl sleep state to fix the over
>     consumption on VDDANA.
> 
> As said in errata, "When the USB host ports are used in high speed
> mode (EHCI), it is not possible to suspend the ports if no device is
> attached on each port. This leads to increased power consumption even
> if the system is in a low power mode." That is why the the USB host
> is disabled.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - Add the pinctrl sleep state for adc0 node to fix the over
>    consumption on VDDANA.
>  - Improve the commit log.
> 
>  arch/arm/boot/dts/sama5d36ek_cmp.dts  |  51 +++++++
>  arch/arm/boot/dts/sama5d3xcm_cmp.dtsi | 166 +++++++++++++++++++++
>  arch/arm/boot/dts/sama5d3xmb_cmp.dtsi | 265 ++++++++++++++++++++++++++++++++++
>  3 files changed, 482 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sama5d36ek_cmp.dts
>  create mode 100644 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
>  create mode 100644 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
> 
> diff --git a/arch/arm/boot/dts/sama5d36ek_cmp.dts b/arch/arm/boot/dts/sama5d36ek_cmp.dts
> new file mode 100644
> index 0000000..fd6bcd6
> --- /dev/null
> +++ b/arch/arm/boot/dts/sama5d36ek_cmp.dts
> @@ -0,0 +1,51 @@
> +/*
> + * sama5d36ek_cmp.dts - Device Tree file for SAMA5D36-EK CMP board
> + *
> + *  Copyright (C) 2016 Atmel,
> + *
> + * Licensed under GPLv2 or later.

No, in fact we now use a dual license scheme for DT files. Please have a
look at the recent board that we posted to take the header from them.


> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +#include "sama5d3xmb_cmp.dtsi"
> +
> +/ {
> +	model = "Atmel SAMA5D36-EK";
> +	compatible = "atmel,sama5d36ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";

I don't think the model name nor the compatible string reflect the
nature of this new "CMP" board.


> +
> +	ahb {
> +		apb {
> +			spi0: spi at f0004000 {
> +				status = "okay";
> +			};
> +
> +			ssc0: ssc at f0008000 {
> +				status = "okay";
> +			};
> +
> +			can0: can at f000c000 {
> +				status = "okay";
> +			};
> +
> +			i2c0: i2c at f0014000 {
> +				status = "okay";
> +			};
> +
> +			i2c1: i2c at f0018000 {
> +				status = "okay";
> +			};
> +
> +			macb0: ethernet at f0028000 {
> +				status = "okay";
> +			};
> +
> +			macb1: ethernet at f802c000 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	sound {
> +		status = "okay";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
> new file mode 100644
> index 0000000..77638c3
> --- /dev/null
> +++ b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
> @@ -0,0 +1,166 @@
> +/*
> + * sama5d3xcm_cmp.dtsi - Device Tree Include file for SAMA5D36 CMP CPU Module
> + *
> + *  Copyright (C) 2016 Atmel,
> + *
> + * Licensed under GPLv2 or later.

Ditto.

> + */
> +
> +/ {
> +	compatible = "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";

Ditto.

> +
> +	chosen {
> +		bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs";

Remove bootargs.

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x20000000>;
> +	};
> +
> +	clocks {
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			spi0: spi at f0004000 {
> +				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
> +			};
> +
> +			macb0: ethernet at f0028000 {
> +				phy-mode = "rgmii";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ethernet-phy at 1 {
> +					reg = <0x1>;
> +					interrupt-parent = <&pioB>;
> +					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +					txen-skew-ps = <800>;
> +					txc-skew-ps = <3000>;
> +					rxdv-skew-ps = <400>;
> +					rxc-skew-ps = <3000>;
> +					rxd0-skew-ps = <400>;
> +					rxd1-skew-ps = <400>;
> +					rxd2-skew-ps = <400>;
> +					rxd3-skew-ps = <400>;
> +				};
> +
> +				ethernet-phy at 7 {
> +					reg = <0x7>;
> +					interrupt-parent = <&pioB>;
> +					interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +					txen-skew-ps = <800>;
> +					txc-skew-ps = <3000>;
> +					rxdv-skew-ps = <400>;
> +					rxc-skew-ps = <3000>;
> +					rxd0-skew-ps = <400>;
> +					rxd1-skew-ps = <400>;
> +					rxd2-skew-ps = <400>;
> +					rxd3-skew-ps = <400>;
> +				};
> +			};
> +
> +			i2c1: i2c at f0018000 {
> +				pmic: act8865 at 5b {
> +					compatible = "active-semi,act8865";
> +					reg = <0x5b>;
> +					status = "disabled";
> +
> +					regulators {
> +						vcc_1v8_reg: DCDC_REG1 {
> +							regulator-name = "VCC_1V8";
> +							regulator-min-microvolt = <1800000>;
> +							regulator-max-microvolt = <1800000>;
> +							regulator-always-on;
> +						};
> +
> +						vcc_1v2_reg: DCDC_REG2 {
> +							regulator-name = "VCC_1V2";
> +							regulator-min-microvolt = <1100000>;
> +							regulator-max-microvolt = <1300000>;
> +							regulator-always-on;
> +						};
> +
> +						vcc_3v3_reg: DCDC_REG3 {
> +							regulator-name = "VCC_3V3";
> +							regulator-min-microvolt = <3300000>;
> +							regulator-max-microvolt = <3300000>;
> +							regulator-always-on;
> +						};
> +
> +						vddana_reg: LDO_REG1 {
> +							regulator-name = "VDDANA";
> +							regulator-min-microvolt = <3300000>;
> +							regulator-max-microvolt = <3300000>;
> +							regulator-always-on;
> +						};
> +
> +						vddfuse_reg: LDO_REG2 {
> +							regulator-name = "FUSE_2V5";
> +							regulator-min-microvolt = <2500000>;
> +							regulator-max-microvolt = <2500000>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		nand0: nand at 60000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			atmel,has-pmecc;
> +			atmel,pmecc-cap = <4>;
> +			atmel,pmecc-sector-size = <512>;
> +			nand-on-flash-bbt;
> +			status = "okay";
> +
> +			at91bootstrap at 0 {
> +				label = "at91bootstrap";
> +				reg = <0x0 0x40000>;
> +			};
> +
> +			bootloader at 40000 {
> +				label = "bootloader";
> +				reg = <0x40000 0x80000>;
> +			};
> +
> +			bootloaderenv at c0000 {
> +				label = "bootloader env";
> +				reg = <0xc0000 0xc0000>;
> +			};
> +
> +			dtb at 180000 {
> +				label = "device tree";
> +				reg = <0x180000 0x80000>;
> +			};
> +
> +			kernel at 200000 {
> +				label = "kernel";
> +				reg = <0x200000 0x600000>;
> +			};
> +
> +			rootfs at 800000 {
> +				label = "rootfs";
> +				reg = <0x800000 0x0f800000>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		d2 {
> +			label = "d2";
> +			gpios = <&pioE 25 GPIO_ACTIVE_LOW>;	/* PE25, conflicts with A25, RXD2 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
> new file mode 100644
> index 0000000..62c6230
> --- /dev/null
> +++ b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
> @@ -0,0 +1,265 @@
> +/*
> + * sama5d3xmb_cmp.dts - Device Tree file for SAMA5D3x CMP mother board
> + *
> + *  Copyright (C) 2016 Atmel,
> + *
> + * Licensed under GPLv2 or later.

Ditto.

> + */
> +#include "sama5d3xcm_cmp.dtsi"
> +
> +/ {
> +	compatible = "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d3", "atmel,sama5";

Ditto.

> +
> +	ahb {
> +		apb {
> +			mmc0: mmc at f0000000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_cd>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
> +			spi0: spi at f0004000 {
> +				dmas = <0>, <0>;	/*  Do not use DMA for spi0 */
> +
> +				m25p80 at 0 {
> +					compatible = "atmel,at25df321a";
> +					spi-max-frequency = <50000000>;
> +					reg = <0>;
> +				};
> +			};
> +
> +			ssc0: ssc at f0008000 {
> +				atmel,clk-from-rk-pin;
> +			};
> +
> +			/*
> +			 * i2c0 conflicts with ISI:
> +			 * disable it to allow the use of ISI
> +			 * can not enable audio when i2c0 disabled
> +			 */
> +			i2c0: i2c at f0014000 {
> +				wm8904: wm8904 at 1a {
> +					compatible = "wlf,wm8904";
> +					reg = <0x1a>;
> +					clocks = <&pck0>;
> +					clock-names = "mclk";
> +				};
> +			};
> +
> +			i2c1: i2c at f0018000 {
> +				ov2640: camera at 0x30 {
> +					compatible = "ovti,ov2640";
> +					reg = <0x30>;
> +					pinctrl-names = "default";
> +					pinctrl-0 = <&pinctrl_pck1_as_isi_mck &pinctrl_sensor_power &pinctrl_sensor_reset>;
> +					resetb-gpios = <&pioE 24 GPIO_ACTIVE_LOW>;
> +					pwdn-gpios = <&pioE 29 GPIO_ACTIVE_HIGH>;
> +					/* use pck1 for the master clock of ov2640 */
> +					clocks = <&pck1>;
> +					clock-names = "xvclk";
> +					assigned-clocks = <&pck1>;
> +					assigned-clock-rates = <25000000>;
> +
> +					port {
> +						ov2640_0: endpoint {
> +							remote-endpoint = <&isi_0>;
> +							bus-width = <8>;
> +						};
> +					};
> +				};
> +			};
> +
> +			usart1: serial at f0020000 {
> +				dmas = <0>, <0>;	/*  Do not use DMA for usart1 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts_cts>;
> +				status = "okay";
> +			};
> +
> +			isi: isi at f0034000 {
> +				port {
> +					isi_0: endpoint {
> +						remote-endpoint = <&ov2640_0>;
> +						bus-width = <8>;
> +						vsync-active = <1>;
> +						hsync-active = <1>;
> +					};
> +				};
> +			};
> +
> +			mmc1: mmc at f8000000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3 &pinctrl_mmc1_cd>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 18 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
> +			adc0: adc at f8018000 {
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <
> +					&pinctrl_adc0_adtrg
> +					&pinctrl_adc0_ad0
> +					&pinctrl_adc0_ad1
> +					&pinctrl_adc0_ad2
> +					&pinctrl_adc0_ad3
> +					&pinctrl_adc0_ad4
> +					>;
> +				pinctrl-1 = <
> +					&pinctrl_adc0_adtrg_sleep
> +					&pinctrl_adc0_ad0_sleep
> +					&pinctrl_adc0_ad1_sleep
> +					&pinctrl_adc0_ad2_sleep
> +					&pinctrl_adc0_ad3_sleep
> +					&pinctrl_adc0_ad4_sleep
> +					>;
> +				status = "okay";
> +			};
> +
> +			macb1: ethernet at f802c000 {
> +				phy-mode = "rmii";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				phy0: ethernet-phy at 1 {
> +					/*interrupt-parent = <&pioE>;*/
> +					/*interrupts = <30 IRQ_TYPE_EDGE_FALLING>;*/
> +					reg = <1>;
> +				};
> +			};
> +
> +			pinctrl at fffff200 {
> +				adc0 {
> +					pinctrl_adc0_adtrg_sleep: adc0_adtrg_1 {
> +						atmel,pins =
> +							<AT91_PIOD 19 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD19 GPIO output 0 */
> +					};
> +					pinctrl_adc0_ad0_sleep: adc0_ad0_1 {
> +						atmel,pins =
> +							<AT91_PIOD 20 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD20 GPIO output 0 */
> +					};
> +					pinctrl_adc0_ad1_sleep: adc0_ad1_1 {
> +						atmel,pins =
> +							<AT91_PIOD 21 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD21 GPIO output 0 */
> +					};
> +					pinctrl_adc0_ad2_sleep: adc0_ad2_1 {
> +						atmel,pins =
> +							<AT91_PIOD 22 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD22 GPIO output 0 */
> +					};
> +					pinctrl_adc0_ad3_sleep: adc0_ad3_1 {
> +						atmel,pins =
> +							<AT91_PIOD 23 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD23 GPIO output 0 */
> +					};
> +					pinctrl_adc0_ad4_sleep: adc0_ad4_1 {
> +						atmel,pins =
> +							<AT91_PIOD 24 AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(0))>;	/* PD24 GPIO output 0 */

Please remove all these comments. The binding is good enough to
understand easily.

> +					};
> +				};
> +
> +				board {
> +					pinctrl_gpio_keys: gpio_keys {
> +						atmel,pins =
> +							<AT91_PIOE 27 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +					};
> +
> +					pinctrl_mmc0_cd: mmc0_cd {
> +						atmel,pins =
> +							<AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PD17 GPIO with pullup deglitch */
> +					};
> +
> +					pinctrl_mmc1_cd: mmc1_cd {
> +						atmel,pins =
> +							<AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PD18 GPIO with pullup deglitch */
> +					};
> +
> +					pinctrl_pck0_as_audio_mck: pck0_as_audio_mck {
> +						atmel,pins =
> +							<AT91_PIOD 30 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD30 periph B */
> +					};
> +
> +					pinctrl_pck1_as_isi_mck: pck1_as_isi_mck-0 {
> +						atmel,pins =
> +							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
> +					};
> +
> +					pinctrl_sensor_reset: sensor_reset-0 {
> +						atmel,pins =
> +							<AT91_PIOE 24 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;   /* PE24 gpio */
> +					};
> +
> +					pinctrl_sensor_power: sensor_power-0 {
> +						atmel,pins =
> +							<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>; /* PE29 gpio */
> +					};
> +
> +					pinctrl_usba_vbus: usba_vbus {
> +						atmel,pins =
> +							<AT91_PIOD 29 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>; /* PD29 GPIO with deglitch */

Here again, all comments are not or great use: remove them.

> +					};
> +				};
> +			};
> +
> +			dbgu: serial at ffffee00 {
> +				dmas = <0>, <0>;	/*  Do not use DMA for dbgu */
> +				status = "okay";
> +			};
> +
> +			watchdog at fffffe40 {
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: gadget at 00500000 {
> +			atmel,vbus-gpio = <&pioD 29 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usba_vbus>;
> +			status = "okay";
> +		};
> +	};
> +
> +	sound {
> +		compatible = "atmel,asoc-wm8904";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pck0_as_audio_mck>;
> +
> +		atmel,model = "wm8904 @ SAMA5D3EK";
> +		atmel,audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN2L", "Line In Jack",
> +			"IN2R", "Line In Jack",
> +			"Mic", "MICBIAS",
> +			"IN1L", "Mic";
> +
> +		atmel,ssc-controller = <&ssc0>;
> +		atmel,audio-codec = <&wm8904>;
> +
> +		status = "disabled";
> +	};
> +
> +	/* Conflict with LCD pins */
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		pb_user1 {
> +			label = "pb_user1";
> +			gpios = <&pioE 27 GPIO_ACTIVE_HIGH>;
> +			linux,code = <0x100>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +};
> 


-- 
Nicolas Ferre
