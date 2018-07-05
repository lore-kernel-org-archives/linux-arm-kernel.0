From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Jul 2018 17:41:24 -0600
Subject: [PATCH v3 2/2] arm64: dts: rockchip: add 96boards RK3399 Ficus
 board
In-Reply-To: <20180705150818.29931-3-ezequiel@collabora.com>
References: <20180705150818.29931-1-ezequiel@collabora.com>
 <20180705150818.29931-3-ezequiel@collabora.com>
Message-ID: <20180705234124.GA32051@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 12:08:18PM -0300, Ezequiel Garcia wrote:
> The RK3399 Ficus board is an Enterprise Edition board
> manufactured by Vamrs Ltd., based on the Rockchip RK3399 SoC.
> 
> The board exposes a bunch of nice peripherals, including
> SATA, HDMI, MIPI CSI, Ethernet, WiFi, and PCIe.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../devicetree/bindings/arm/rockchip.txt      |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 514 ++++++++++++++++++
>  3 files changed, 520 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 1c1d62d03c4f..d46c5d43e27f 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -1,5 +1,10 @@
>  Rockchip platforms device tree bindings
>  ---------------------------------------
> +
> +- 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
> +    Required root node properties:
> +      - compatible = "vamrs,ficus", "rockchip,rk3399";
> +
>  - Amarula Vyasa RK3288 board
>      Required root node properties:
>        - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 48a83f882947..2811fb701f12 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> new file mode 100644
> index 000000000000..b17b831df90e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> @@ -0,0 +1,514 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Collabora Ltd.
> + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> + *
> + * Schematics available at https://dl.vamrs.com/products/ficus/docs/hw
> + */
> +
> +/dts-v1/;
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "96boards RK3399 Ficus";
> +	compatible = "vamrs,ficus", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	vcc1v8_s0: vcc1v8-s0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s0";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_sys: vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vcc3v3_pcie: vcc3v3-pcie-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_drv>;
> +		regulator-boot-on;
> +		regulator-name = "vcc3v3_pcie";
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vdd_log: vdd-log {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm2 0 25000 0>;
> +		regulator-name = "vdd_log";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		/* for rockchip boot on */
> +		rockchip,pwm_id= <2>;
> +		rockchip,pwm_voltage = <900000>;
> +
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&gmac {
> +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> +	assigned-clock-parents = <&clkin_gmac>;
> +	clock_in_out = "input";
> +	phy-supply = <&vcc3v3_sys>;
> +	phy-mode = "rgmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 50000>;
> +	tx_delay = <0x28>;
> +	rx_delay = <0x11>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	ddc-i2c-bus = <&i2c3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_cec>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	i2c-scl-rising-time-ns = <168>;
> +	i2c-scl-falling-time-ns = <4>;
> +	status = "okay";
> +
> +	vdd_cpu_b: syr827 at 40 {

regulator at 40

> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;

Strange to have a different vendor for this property...

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		regulator-name = "vdd_cpu_b";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +		status = "okay";
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
