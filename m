From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Oct 2018 13:52:01 +0800
Subject: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
In-Reply-To: <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <20181008055159.GH3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 06:33:51AM +0530, Vabhav Sharma wrote:
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100 ++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..1483071
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape LX2160ARDB";
> +	compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	sb_3v3: regulator-fixed {

The node name should probably be named like regulator-sb3v3 or
something, so that the pattern can be followed when we have another
fixed regulator to be added.

> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";

The name should be something we can find on board schematics.

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {

Please keep these labeled nodes sorted alphabetically.

> +	status = "okay";

Have a newline between properties and child node.

> +	i2c-mux at 77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			power-monitor at 40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			temperature-sensor at 4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +
> +			temperature-sensor at 4d {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4d>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	rtc at 51 {
> +		compatible = "nxp,pcf2129";
> +		reg = <0x51>;
> +		// IRQ10_B
> +		interrupts = <0 150 0x4>;
> +		};

Bad indentation.

Shawn

> +
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 
