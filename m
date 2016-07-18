From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 18 Jul 2016 09:13:49 +0800
Subject: [PATCH v3] arm64: dts: rockchip: Add basic support for orion-r68
In-Reply-To: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
References: <1468577391-5096-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <24940135-f3a9-547f-641b-29cd6b17b663@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/7/15 18:09, Matthias Brugger ??:
> This patch adds basic support for the Tronsmart orion r86 set-top-box.
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
> Changes since v2:
> - gpio-keys cleanpup
> - set sdmmc properties correctly

It seems there are two "cap-mmc-highspeed;" for emmc.

>
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 385 +++++++++++++++++++++
>  3 files changed, 390 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 715d960..1d5c65e0 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -110,3 +110,7 @@ Rockchip platforms device tree bindings
>  - Rockchip RK3399 evb:
>      Required root node properties:
>        - compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
> +
> +- Tronsmart Orion R68 Meta
> +    Required root node properties:
> +      - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 7037a16..87669f6 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,5 +1,6 @@
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
> new file mode 100644
> index 0000000..d5e1af5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
> @@ -0,0 +1,385 @@
> +/*
> + * Copyright (c) 2016 Matthias Brugger <mbrugger@suse.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include "rk3368.dtsi"
> +
> +/ {
> +	model = "Rockchip Orion R68";
> +	compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		pinctrl-0 = <&emmc_reset>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	ext_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +	};
> +
> +	keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_key>;
> +
> +		power {
> +			wakeup-source;
> +			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> +			label = "GPIO Power";
> +			linux,code = <KEY_POWER>;
> +		};
> +	};
> +
> +	leds: gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		red {
> +			gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
> +			label = "orion:red:led";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_ctl>;
> +			default-state = "on";
> +		};
> +
> +		blue {
> +			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +			label = "orion:blue:led";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&stby_pwren>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	vcc_18: vcc18-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	/* supplies both host and otg */
> +	vcc_host: vcc-host-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 4 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_vbus_drv>;
> +		regulator-name = "vcc_host";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vccio_sd: vcc-io-sd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name= "vccio_sd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vcc_sd: vcc-sd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sd";
> +		gpio = <&gpio3 11 GPIO_ACTIVE_LOW>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vcc_io: vcc-io-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_io";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vcc_lan: vcc-lan-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_lan";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vcc_sys: vcc-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vccio_wl: vccio-wl-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccio_wl";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vdd_10: vdd-10-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_10";
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	disable-wp;
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
> +	keep-power-in-suspend;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_2v;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&gmac {
> +	assigned-clocks = <&cru SCLK_MAC>;
> +	assigned-clock-parents = <&ext_gmac>;
> +	phy-supply = <&vcc_lan>;
> +	phy-mode = "rgmii";
> +	clock_in_out = "input";
> +	snps,reset-gpio = <&gpio3 12 0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	tx_delay = <0x30>;
> +	rx_delay = <0x10>;
> +	status = "ok";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: syr827 at 40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-enable-ramp-delay = <300>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <8000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	hym8563: hym8563 at 51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "xin32k";
> +		/* rtc_int is not connected */
> +	};
> +};
> +
> +&pinctrl {
> +	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
> +		bias-disable;
> +		drive-strength = <8>;
> +	};
> +
> +	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
> +		bias-pull-up;
> +		drive-strength = <8>;
> +	};
> +
> +	emmc {
> +		emmc_bus8: emmc-bus8 {
> +			rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 19 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 20 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 21 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 22 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 23 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 24 RK_FUNC_2 &pcfg_pull_up_drv_8ma>,
> +					<1 25 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
> +		};
> +
> +		emmc-clk {
> +			rockchip,pins = <2 4 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
> +		};
> +
> +		emmc-cmd {
> +			rockchip,pins = <1 26 RK_FUNC_2 &pcfg_pull_up_drv_8ma>;
> +		};
> +
> +		emmc_reset: emmc-reset {
> +			rockchip,pins = <2 3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	keys {
> +		pwr_key: pwr-key {
> +			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	leds {
> +		stby_pwren: stby-pwren {
> +			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		led_ctl: led-ctl {
> +			rockchip,pins = <3 29 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_clk: sdmmc-clk {
> +			rockchip,pins = <2 9 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
> +		};
> +
> +		sdmmc_cmd: sdmmc-cmd {
> +			rockchip,pins = <2 10 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> +		};
> +
> +		sdmmc_cd: sdmmc-cd {
> +			rockchip,pins = <2 11 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> +		};
> +
> +		sdmmc_bus1: sdmmc-bus1 {
> +			rockchip,pins = <2 5 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> +		};
> +
> +		sdmmc_bus4: sdmmc-bus4 {
> +			rockchip,pins = <2 5 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> +					<2 6 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> +					<2 7 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> +					<2 8 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> +		};
> +	};
> +
> +	usb {
> +		host_vbus_drv: host-vbus-drv {
> +			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_18>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	clock-frequency = <50000000>;
> +	clock-freq-min-max = <400000 50000000>;
> +	cap-sd-highspeed;
> +	card-detect-delay = <200>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> +	bus-width = <4>;
> +	num-slots = <1>;
> +	keep-power-in-suspend;
> +
> +	vmmc-supply = <&vcc_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart4_xfer>;
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	status = "okay";
> +};
> +
> +&wdt {
> +	status = "okay";
> +};
>


-- 
Best Regards
Shawn Lin
