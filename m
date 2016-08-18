From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Aug 2016 14:08:52 -0500
Subject: [PATCH 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <1471329328-26842-2-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160818190852.GA11943@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:35:27PM +0900, Chanwoo Choi wrote:
> This patch adds the Device Tree source for Exynos5433-based Samsung TM2 board.
> This board fully support the all things for mobile target.
> 
> This patch supports the following devices:
> 1. basic SoC
> - Initial booting for Samsung Exynos5433 SoC
> - DRAM LPDDR3 (3GB)
> - eMMC (32GB)
> - ARM architecture timer
> 
> 2. power management devices
> - Sasmung S2MPS13 PMIC for the power supply
> - CPUFREQ for big.LITTLE cores
> - TMU for big.LITTLE cores and GPU
> - ADC with thermistor to measure the temperature of AP/Battery/Charger
> - Maxim MAX77843 Interface PMIC (MUIC/Fuel-gauge/Charger/Haptic/LED/Regulator)
> 
> 3. sound devices
> - I2S for sound bus
> - LPASS for sound power control
> - Wolfson WM5110 for sound codec
> - Maxim MAX98504 for speaker amplifier
> - TM2 ASoC Machine device driver node
> 
> 3. display devices
> - DECON, DSI and MIC for the panel output
> 
> 4. usb devices
> - USB 3.0 DRD (Dual Role Device)
> - USB 3.0 Host controller
> 
> 5. storage devices
> - MSHC (obile Storae Host Controller) for eMMC device
> 
> 6. misc devices
> - gpio-keys (power, volume up/down, home key)
> - PWM (Pulse Width Modulation Timer)
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |    1 +
>  arch/arm64/boot/dts/exynos/Makefile                |    5 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1003 ++++++++++++++++++++
>  3 files changed, 1008 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 0ea7f14ef294..c704b4bf6137 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -15,6 +15,7 @@ Required root node properties:
>  	- "samsung,xyref5260"	- for Exynos5260-based Samsung board.
>  	- "samsung,smdk5410"	- for Exynos5410-based Samsung SMDK5410 eval board.
>  	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
> +	- "samsung,tm2"		- for Exynos5333-based Samsung TM2 board.
>  	- "samsung,sd5v1"	- for Exynos5440-based Samsung board.
>  	- "samsung,ssdk5440"	- for Exynos5440-based Samsung board.
>  
> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
> index 50c9b9383cfa..7ddea53769a7 100644
> --- a/arch/arm64/boot/dts/exynos/Makefile
> +++ b/arch/arm64/boot/dts/exynos/Makefile
> @@ -1,4 +1,7 @@
> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos7-espresso.dtb
> +dtb-$(CONFIG_ARCH_EXYNOS) += \
> +	exynos5433-tm2.dtb	\
> +	exynos5433-tm2e.dtb	\
> +	exynos7-espresso.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> new file mode 100644
> index 000000000000..3e497b0d0015
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -0,0 +1,1003 @@
> +/*
> + * SAMSUNG Exynos5433 TM2 board device tree source
> + *
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *
> + * Device tree source file for Samsung's TM2 board which is based on
> + * Samsung Exynos5433 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "exynos5433.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Samsung TM2 board";
> +	compatible = "samsung,exynos5433-tm2", "samsung,exynos5433";
> +
> +	aliases {
> +		i2c0 = &hsi2c_0;
> +		i2c1 = &hsi2c_1;
> +		i2c2 = &hsi2c_2;
> +		i2c3 = &hsi2c_3;
> +		i2c4 = &hsi2c_4;
> +		i2c5 = &hsi2c_5;
> +		i2c6 = &hsi2c_6;
> +		i2c7 = &hsi2c_7;
> +		i2c8 = &hsi2c_8;
> +		i2c9 = &hsi2c_9;
> +		i2c10 = &hsi2c_10;
> +		i2c11 = &hsi2c_11;
> +		mshc0 = &mshc_0;
> +		mshc1 = &mshc_1;
> +		mshc2 = &mshc_2;
> +		pinctrl0 = &pinctrl_alive;
> +		pinctrl1 = &pinctrl_aud;
> +		pinctrl2 = &pinctrl_cpif;
> +		pinctrl3 = &pinctrl_ese;
> +		pinctrl4 = &pinctrl_finger;
> +		pinctrl5 = &pinctrl_fsys;
> +		pinctrl6 = &pinctrl_imem;
> +		pinctrl7 = &pinctrl_nfc;
> +		pinctrl8 = &pinctrl_peric;
> +		pinctrl9 = &pinctrl_touch;
> +		serial0 = &serial_0;
> +		serial1 = &serial_1;
> +		serial2 = &serial_2;
> +		serial3 = &serial_3;
> +		spi0 = &spi_0;
> +		spi1 = &spi_1;
> +		spi2 = &spi_2;
> +		spi3 = &spi_3;
> +		spi4 = &spi_4;
> +		usbdrdphy0 = &usbdrd30_phy;

Please drop all these aliases except for serial.

> +	};
> +
> +	chosen {
> +		stdout-path = &serial_1;
> +	};
> +
> +	memory at 20000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x20000000 0x0 0xc0000000>;
> +	};
> +
> +	gpio_keys {

Use -, not _.
> +		compatible = "gpio-keys";
> +
> +		power_key {

ditto...

> +			gpios = <&gpa2 7 1>;
> +			linux,code = <KEY_POWER>;
> +			label = "power key";
> +			debounce-interval = <10>;
> +			gpio-key,wakeup;

This is legacy. Use the common binding.

> +		};
> +
> +		volume_up_key {
> +			gpios = <&gpa2 0 1>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			label = "volume-up key";
> +			debounce-interval = <10>;
> +		};
> +
> +		volume_down_key {
> +			gpios = <&gpa2 1 1>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			label = "volume-down key";
> +			debounce-interval = <10>;
> +		};
> +
> +		homepage_key {
> +			gpios = <&gpa0 3 1>;
> +			linux,code = <KEY_MENU>;
> +			label = "homepage key";
> +			debounce-interval = <10>;
> +		};
> +	};
> +
> +	i2c_max98504: i2c-gpio-0 {
> +		compatible = "i2c-gpio";
> +		gpios = <&gpd0 1 GPIO_ACTIVE_HIGH /* SPK_AMP_SDA */
> +			 &gpd0 0 GPIO_ACTIVE_HIGH /* SPK_AMP_SCL */ >;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		max98504: max98504 at 31 {
> +			compatible = "maxim,max98504";
> +			reg = <0x31>;
> +			maxim,rx-path = <1>;
> +			maxim,tx-path = <1>;
> +			maxim,tx-channel-mask = <3>;
> +			maxim,tx-channel-source = <2>;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "samsung,tm2-audio";
> +		audio-codec = <&wm5110>;
> +		i2s-controller = <&i2s0>;
> +		audio-amplifier = <&max98504>;
> +		mic-bias-gpios = <&gpr3 2 0>;
> +		model = "wm5110";
> +		samsung,audio-routing =
> +			/* Headphone */
> +			"HP", "HPOUT1L",
> +			"HP", "HPOUT1R",
> +
> +			/* Speaker */
> +			"SPK", "SPKOUT",
> +			"SPKOUT", "HPOUT2L",
> +			"SPKOUT", "HPOUT2R",
> +
> +			/* Receiver */
> +			"RCV", "HPOUT3L",
> +			"RCV", "HPOUT3R";
> +		status = "okay";
> +	};
> +};
> +
> +&adc {
> +	vdd-supply = <&ldo3_reg>;
> +	status = "okay";
> +
> +	thermistor-ap {
> +		compatible = "ntc,ncp03wf104";
> +		pullup-uv = <1800000>;
> +		pullup-ohm = <100000>;
> +		pulldown-ohm = <0>;
> +		io-channels = <&adc 0>;
> +	};
> +
> +	thermistor_battery: thermistor-battery {
> +		compatible = "ntc,ncp03wf104";
> +		pullup-uv = <1800000>;
> +		pullup-ohm = <100000>;
> +		pulldown-ohm = <0>;
> +		io-channels = <&adc 1>;
> +		#thermal-sensor-cells = <0>;
> +	};
> +
> +	thermistor-charger {
> +		compatible = "ntc,ncp03wf104";
> +		pullup-uv = <1800000>;
> +		pullup-ohm = <100000>;
> +		pulldown-ohm = <0>;
> +		io-channels = <&adc 2>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&buck3_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&decon {
> +	status = "okay";
> +	iommu-reserved-mapping = <0x20000000 0x20000000 0xc0000000>;
> +
> +	i80-if-timings {
> +	};
> +};
> +
> +&dsi {
> +	status = "okay";
> +	vddcore-supply = <&ldo6_reg>;
> +	vddio-supply = <&ldo7_reg>;
> +	samsung,pll-clock-frequency = <24000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&te_irq>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 1 {
> +			reg = <1>;
> +
> +			dsi_out: endpoint {
> +				samsung,burst-clock-frequency = <512000000>;
> +				samsung,esc-clock-frequency = <16000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&hsi2c_0 {
> +	status = "okay";
> +	clock-frequency = <2500000>;
> +
> +	s2mps13_pmic at 66 {

Use '-'

> +		compatible = "samsung,s2mps13-pmic";
> +		interrupt-parent = <&gpa0>;
> +		interrupts = <7 0>;
> +		reg = <0x66>;
> +		wakeup;

Use the common binding.

> +		samsung,s2mps11-wrstbi-ground;
> +
> +		s2mps13_osc: clocks {
> +			compatible = "samsung,s2mps13-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps13_ap", "s2mps13_cp",
> +				"s2mps13_bt";
> +		};
> +
> +		regulators {
> +			ldo1_reg: LDO1 {
> +				regulator-name = "VDD_ALIVE_0.9V_AP";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "VDDQ_MMC2_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "VDD1_E_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "VDD10_MIF_PLL_1.0V_AP";
> +				regulator-min-microvolt = <1300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo5_reg: LDO5 {
> +				regulator-name = "VDD10_DPLL_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo6_reg: LDO6 {
> +				regulator-name = "VDD10_MIPI2L_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo7_reg: LDO7 {
> +				regulator-name = "VDD18_MIPI2L_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo8_reg: LDO8 {
> +				regulator-name = "VDD18_LLI_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "VDD18_ABB_ETC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "VDD33_USB30_3.0V_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo11_reg: LDO11 {
> +				regulator-name = "VDD_INT_M_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "VDD_KFC_M_1.1V_AP";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo13_reg: LDO13 {
> +				regulator-name = "VDD_G3D_M_0.95V_AP";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo14_reg: LDO14 {
> +				regulator-name = "VDDQ_M1_LDO_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "VDDQ_M2_LDO_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo16_reg: LDO16 {
> +				regulator-name = "VDDQ_EFUSE";
> +				regulator-min-microvolt = <1400000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo17_reg: LDO17 {
> +				regulator-name = "V_TFLASH_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo18_reg: LDO18 {
> +				regulator-name = "V_CODEC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo19_reg: LDO19 {
> +				regulator-name = "VDDA_1.8V_COMP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo20_reg: LDO20 {
> +				regulator-name = "VCC_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo21_reg: LDO21 {
> +				regulator-name = "VT_CAM_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo22_reg: LDO22 {
> +				regulator-name = "CAM_IO_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo23_reg: LDO23 {
> +				regulator-name = "CAM_SEN_CORE_1.2V_AP";
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1200000>;
> +			};
> +
> +			ldo24_reg: LDO24 {
> +				regulator-name = "VT_CAM_1.2V";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +			};
> +
> +			ldo25_reg: LDO25 {
> +				regulator-name = "CAM_SEN_A2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo26_reg: LDO26 {
> +				regulator-name = "CAM_AF_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo27_reg: LDO27 {
> +				regulator-name = "VCC_3.0V_LCD_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo28_reg: LDO28 {
> +				regulator-name = "VCC_1.8V_LCD_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo29_reg: LDO29 {
> +				regulator-name = "VT_CAM_2.8V";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo30_reg: LDO30 {
> +				regulator-name = "TSP_AVDD_3.3V_AP";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo31_reg: LDO31 {
> +				regulator-name = "TSP_VDD_1.85V_AP";
> +				regulator-min-microvolt = <1850000>;
> +				regulator-max-microvolt = <1850000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo32_reg: LDO32 {
> +				regulator-name = "VTOUCH_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo33_reg: LDO33 {
> +				regulator-name = "VTOUCH_LED_3.3V";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +			};
> +
> +			ldo34_reg: LDO34 {
> +				regulator-name = "VCC_1.8V_MHL_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <2100000>;
> +			};
> +
> +			ldo35_reg: LDO35 {
> +				regulator-name = "OIS_VM_2.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo36_reg: LDO36 {
> +				regulator-name = "VSIL_1.0V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +			};
> +
> +			ldo37_reg: LDO37 {
> +				regulator-name = "VF_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo38_reg: LDO38 {
> +				regulator-name = "VCC_3.0V_MOTOR_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			ldo39_reg: LDO39 {
> +				regulator-name = "V_HRM_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo40_reg: LDO40 {
> +				regulator-name = "V_HRM_3.3V";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			buck1_reg: BUCK1 {
> +				regulator-name = "VDD_MIF_0.9V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "VDD_EGL_1.0V_AP";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "VDD_KFC_1.0V_AP";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				regulator-name = "VDD_INT_0.95V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				regulator-name = "VDD_DISP_CAM0_0.9V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "VDD_G3D_0.9V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck7_reg: BUCK7 {
> +				regulator-name = "VDD_MEM1_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +			};
> +
> +			buck8_reg: BUCK8 {
> +				regulator-name = "VDD_LLDO_1.35V_AP";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			buck9_reg: BUCK9 {
> +				regulator-name = "VDD_MLDO_2.0V_AP";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			buck10_reg: BUCK10 {
> +				regulator-name = "vdd_mem2";
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&hsi2c_8 {
> +	status = "okay";
> +
> +	max77843 at 66 {
> +		compatible = "samsung,max77843";
> +		interrupt-parent = <&gpa1>;
> +		interrupts = <5 2>;
> +		reg = <0x66>;
> +		wakeup;

Use common binding.

> +
> +		muic: max77843-muic {
> +			compatible = "maxim,max77843-muic";
> +		};
