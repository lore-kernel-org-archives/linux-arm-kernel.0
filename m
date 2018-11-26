From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Nov 2018 00:48:23 +0100
Subject: [PATCH v3] arm64: dts: rockchip: Add DT for nanopc-t4
In-Reply-To: <20181126145107.38222-1-tomeu.vizoso@collabora.com>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
 <20181126145107.38222-1-tomeu.vizoso@collabora.com>
Message-ID: <26178858.xdqtN7Rtck@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

Am Montag, 26. November 2018, 15:47:49 CET schrieb Tomeu Vizoso:
> This adds a device tree for the NanoPC-T4 SBC, which is based on the
> Rockchip RK3399 SoC and marketed by FriendlyELEC.
> 
> Known working:
> 
> - Serial
> - Ethernet
> - HDMI
> - USB 2.0
> 
> All of the interesting stuff is in a .dtsi because there are at least
> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

looks pretty good overall, just some more small-scale things
below.

> ---
> 
> v2: - Rename compatible from friendlyelec to friendlyarm, to match
>       existing bindings
>     - Remove superfluous node spi1
> 
> v3: - Rewrite regulator tree to match the schematics (Heiko)
>     - Sort top-level nodes alphabetically (Heiko)
>     - Used defines for GPIO numbers (Heiko)
>     - Enabled rga (Heiko)
>     - Removed cdn_dp node (Heiko)
>     - Removed dependencies to fusb0 as extcon (Heiko)
>     - Removed superfluous properties (Heiko)


> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 49042c477870..4cbd2c461052 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb

These are definitly sorted in the Makefile, so this should move between
rk3399-gru-scarlet-kd.dtb and rk3399-puma-haikou.dtb :-)


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> new file mode 100644
> index 000000000000..f102ff2317c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * RK3399-based FriendlyElec boards device tree source
> + *
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
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
> +	vdd_5v: vdd_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v0_core: vcc5v0_core {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_core";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3_sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_core>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0_sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc5v0_usb1: vcc5v0_usb1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb1";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb2: vcc5v0_usb2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb2";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* switched by pmic_sleep */
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcc3v0_sd: vcc3v0_sd {

dt-spec mandates node names with "-", so this should become
	vcc3v0_sd: vcc3v0-sd {

Same for most regulators above.

> +	rk808: pmic at 1b {
> +		compatible = "rockchip,rk808";
> +		reg = <0x1b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";

rename rk808-clkout1 to xin32k so that it hooks correctly into
the rk3399 clock controller, as that signals is providing the 32kHz clock
for the system. (see $debug/clk/clk_summary and rk3399-cru dt binding)


> +&pinctrl {
> +

unnecessary empty line

> +	pmic {


> +&rga {
> +	status = "okay";
> +};

rga is not dependant on pinout, so is always enabled in rk3399.dtsi
So this node can go away.

> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	supports-emmc;

remnant from the vendor-kernel?
Should also go away.

> +	non-removable;
> +	keep-power-in-suspend;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +

> +&usbdrd3_0 {
> +	status = "okay";
> +	extcon = <&fusb0>;

I still don't think that extcon gets defined at all and is also
not specified in any dwc3 binding, so should probably go away.


Heiko
