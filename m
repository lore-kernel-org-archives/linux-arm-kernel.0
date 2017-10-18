From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 18 Oct 2017 16:49:34 +0800
Subject: [RFC 06/11] arm64: dts: mediatek: Add Elm Rev. 3 device tree
In-Reply-To: <1506690553-27357-7-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1506690553-27357-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1506690553-27357-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1508316574.13340.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,


On Fri, 2017-09-29 at 15:09 +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile            |    1 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts |   21 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi     |  210 +++++
>  arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi     | 1014 ++++++++++++++++++++++
>  4 files changed, 1246 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 151723b..0521e29 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-rev3.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts
> new file mode 100644
> index 0000000..68d4095
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2016 MediaTek Inc.
> + * Author: Eddie Huang <eddie.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "mt8173-elm.dtsi"
> +
> +/ {
> +	model = "Mediatek Elm rev3 board";
> +	compatible = "google,elm-rev3", "google,elm", "mediatek,mt8173";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> new file mode 100644
> index 0000000..850037f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -0,0 +1,210 @@
> +/*
> + * Copyright 2016 MediaTek Inc.
> + * Author: Eddie Huang <eddie.huang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "mt8173-oak.dtsi"
> +
> +/ {
> +	hdmicon: connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_mux_out_hdmi>;
> +			};
> +		};
> +	};
> +
> +	hdmi_mux: hdmi_mux {
> +		compatible = "gpio-display-mux";

Where is the binding for this?

> +		status = "okay";
> +		detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmi_mux_pins>;


If you use gpio_request or related api, it will set pinmux
automatically.
Do we really need this pinctrl?

> +		ddc-i2c-bus = <&hdmiddc0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 { /* input */
> +				reg = <0>;
> +
> +				hdmi_mux_in: endpoint {
> +					remote-endpoint = <&hdmi0_out>;
> +				};
> +			};
> +
> +			port at 1 { /* output */
> +				reg = <1>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				hdmi_mux_out_anx: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&anx7688_in>;
> +				};
> +
> +				hdmi_mux_out_hdmi: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	sound: sound {
> +		compatible = "mediatek,mt8173-rt5650";
> +		mediatek,audio-codec = <&rt5650 &hdmi0>;
> +		mediatek,mclk = <1>;
> +		mediatek,platform = <&afe>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&aud_i2s2>;
> +		codec-capture {
> +			sound-dai = <&rt5650 1>;
> +		};
> +	};
> +};
> +
> +&aud_i2s2 {
> +	pins1 {
> +		pinmux = <MT8173_PIN_128_I2S0_LRCK__FUNC_I2S1_WS>,
> +			 <MT8173_PIN_129_I2S0_BCK__FUNC_I2S1_BCK>,
> +			 <MT8173_PIN_130_I2S0_MCK__FUNC_I2S1_MCK>,
> +			 <MT8173_PIN_131_I2S0_DATA0__FUNC_I2S1_DO_1>,
> +			 <MT8173_PIN_12_EINT12__FUNC_I2S2_WS>,
> +			 <MT8173_PIN_13_EINT13__FUNC_I2S2_BCK>,
> +			 <MT8173_PIN_132_I2S0_DATA1__FUNC_I2S2_DI_2>;
> +		bias-pull-down;
> +	};
> +};
> +
> +&cpu_thermal {
> +	sustainable-power = <4500>; /* milliwatts */
> +	trips {
> +		threshold: trip-point at 0 {
> +			temperature = <60000>;
> +		};
> +
> +		target: trip-point at 1 {
> +			temperature = <65000>;
> +		};
> +	};
> +};
> +
> +&cros_ec {
> +	i2c_tunnel_b: i2c-tunnel at 1 {
> +		compatible = "google,cros-ec-i2c-tunnel";
> +		google,remote-bus = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		anx7688: anx7688 at 2c {
> +			compatible = "analogix,anx7688";
> +			status = "okay";
> +			reg = <0x2c>;
> +
> +			port {
> +				anx7688_in: endpoint {
> +					remote-endpoint = <&hdmi_mux_out_anx>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi0 {
> +	status = "okay";
> +
> +	ports {
> +		port at 1 {
> +			reg = <1>;
> +			hdmi0_out: endpoint {
> +				remote-endpoint = <&hdmi_mux_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_phy {
> +	status = "okay";
> +	mediatek,ibias = <0xc>;
> +};
> +
> +&i2c0 {
> +	ps8640: edp-bridge at 8 {
> +		compatible = "parade,ps8640";

binding?

> +		reg = <0x8>;
> +		sleep-gpios = <&pio 127 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pio 115 GPIO_ACTIVE_HIGH>;
> +		mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ps8640_pins>;

same here.
Please check all pinctrl nodes that set FUNC to GPIO in this patch.

> +		vdd12-supply = <&ps8640_fixed_1v2>;
> +		vdd33-supply = <&mt6397_vgp2_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 0 {
> +			reg = <0>;
> +
> +			ps8640_in: endpoint {
> +				remote-endpoint = <&dsi0_out>;
> +			};
> +		};
> +
> +		port at 1 {
> +			reg = <1>;
> +
> +			ps8640_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&gpio_keys {
> +	lid {
> +		gpios = <&pio 69 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mt6397_vgp6_reg {
> +	regulator-always-on;
> +};
> +
> +&pio {
> +	hdmi_mux_pins: hdmi_mux_pins {
> +		pins1 {
> +			pinmux = <MT8173_PIN_36_DAISYNC__FUNC_GPIO36>;
> +		};
> +	};
> +};
> +
> +&ps8640_fixed_1v2 {
> +	regulator-enable-ramp-delay = <2000>;
> +};
> +
> +&rt5650 {
> +	#sound-dai-cells = <1>;
> +	realtek,dmic1-data-pin = <2>;
> +	realtek,jd-mode = <2>;
> +};
> +
> +
> +&trackpad {
> +	vcc-supply = <&mt6397_vgp6_reg>;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi
> new file mode 100644
> index 0000000..33a5b07
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi
> @@ -0,0 +1,1014 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "mt8173.dtsi"
> +#include "mt8173-pinfunc.h"
> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	backlight_lcd: backlight_lcd {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 1000000>;
> +		brightness-levels = <
> +			  0  16  32  48  64  80  96 112
> +			128 144 160 176 192 208 224 240
> +			255
> +		>;
> +		default-brightness-level = <9>;
> +		power-supply = <&bl_fixed_reg>;
> +		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&disp_pwm0_pins>;
> +		status = "okay";
> +	};
> +
> +	bl_fixed_reg: fixedregulator at 2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl_fixed";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		startup-delay-us = <1000>;
> +		enable-active-high;
> +		gpio = <&pio 32 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bl_fixed_pins>;
> +	};
> +
> +	chosen {
> +		linux,stdout-path = &uart0;
> +	};
> +
> +	firmware {
> +		chromeos {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&chromeos_write_protect>;
> +			write-protect-gpio = <&pio 4 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins>;
> +
> +		lid {
> +			label = "Lid";
> +			gpios = <&pio 12 GPIO_ACTIVE_LOW>;
> +			linux,code = <0>; /* SW_LID */
> +			linux,input-type = <5>; /* EV_SW */
> +			gpio-key,wakeup;
> +		};
> +
> +		power {
> +			label = "Power";
> +			gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
> +			linux,code = <KEY_POWER>;
> +			debounce-interval = <30>;
> +			gpio-key,wakeup;
> +		};
> +
> +		tablet_mode {
> +			label = "Tablet_mode";
> +			gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
> +			linux,code = <1>; /* SW_TABLET_MODE */
> +			linux,input-type = <5>; /* EV_SW */
> +			gpio-key,wakeup;
> +		};
> +
> +		volume_down {
> +			label = "Volume_down";
> +			gpios = <&pio 123 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +		};
> +
> +		volume_up {
> +			label = "Volume_up";
> +			gpios = <&pio 124 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible = "lg,lp120up1";
> +		power-supply = <&panel_fixed_3v3>;
> +		ddc-i2c-bus = <&i2c4>;
> +		backlight = <&backlight_lcd>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&ps8640_out>;
> +			};
> +		};
> +	};
> +
> +	panel_fixed_3v3: regulator at 1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "PANEL_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&pio 41 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel_fixed_pins>;
> +	};
> +
> +	ps8640_fixed_1v2: regulator at 2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "PS8640_1V2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 30 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ps8640_fixed_pins>;
> +	};
> +
> +	sdio_fixed_3v3: fixedregulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 85 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	usb_p1_vbus: regulator at 3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 130 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	usb_p0_vbus: regulator at 4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&cec {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	proc-supply = <&mt6397_vpca15_reg>;
> +};
> +
> +&cpu1 {
> +	proc-supply = <&mt6397_vpca15_reg>;
> +};
> +
> +&cpu2 {
> +	proc-supply = <&da9211_vcpu_reg>;
> +	sram-supply = <&mt6397_vsramca7_reg>;
> +};
> +
> +&cpu3 {
> +	proc-supply = <&da9211_vcpu_reg>;
> +	sram-supply = <&mt6397_vsramca7_reg>;
> +};
> +
> +&cpu_thermal {
> +	sustainable-power = <5000>; /* milliwatts */
> +};
> +
> +&dsi0 {
> +	status = "okay";
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 1 {
> +			reg = <1>;
> +
> +			dsi0_out: endpoint {
> +				remote-endpoint = <&ps8640_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&dpi0 {
> +	status = "okay";
> +};
> +
> +&hdmi_phy {
> +	status = "okay";
> +	mediatek,ibias = <0x3f>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rt5650: audio-codec at 1a {
> +		compatible = "realtek,rt5650";
> +		reg = <0x1a>;
> +		avdd-supply = <&mt6397_vgp1_reg>;
> +		cpvdd-supply = <&mt6397_vcama_reg>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rt5650_irq>;
> +		realtek,jd-mode = <3>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <1500000>;
> +	status = "okay";
> +
> +	da9211: da9211 at 68 {
> +		compatible = "dlg,da9211";
> +		reg = <0x68>;
> +
> +		regulators {
> +			da9211_vcpu_reg: BUCKA {
> +				regulator-name = "VBUCKA";
> +				regulator-min-microvolt = < 700000>;
> +				regulator-max-microvolt = <1310000>;
> +				regulator-min-microamp  = <2000000>;
> +				regulator-max-microamp  = <4400000>;
> +				regulator-ramp-delay = <10000>;
> +				regulator-always-on;
> +/*				regulator-supported-modes =
> +					<REGULATOR_OPERATION_MODE_FAST
> +					 REGULATOR_OPERATION_MODE_NORMAL>;*/

Please remove unused code.
Same for all comment out parts in this patch.


Joe.C
