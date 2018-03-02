From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 12:02:58 -0600
Subject: [PATCH v2 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
In-Reply-To: <68acadbb82fb0a8ac5abb9b1e156b9a9cf5b0f11.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <68acadbb82fb0a8ac5abb9b1e156b9a9cf5b0f11.1519396753.git.michal.simek@xilinx.com>
Message-ID: <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 03:40:26PM +0100, Michal Simek wrote:
> Xilinx zcu104 is another customer board. It is sort of zcu102 clone
> with some differences.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Remove i2c mw u-boot commands
> - Record compatible string to xilinx.txt
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 197 ++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index 2b922ec3c82a..a9ce08a68711 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -26,3 +26,6 @@ Additional compatible strings:
>    "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
>    "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
>    "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
> +
> +- Xilinx evaluation board zcu104
> +  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 24e3ce801304..1c039e59c7c3 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> new file mode 100644
> index 000000000000..89d26f56514b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU104
> + *
> + * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "ZynqMP ZCU104 RevA";
> +	compatible = "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104", "xlnx,zynqmp";
> +
> +	aliases {
> +		ethernet0 = &gem3;
> +		gpio0 = &gpio;

Drop. Not a supported alias.

> +		i2c0 = &i2c1;
> +		mmc0 = &sdhci1;
> +		rtc0 = &rtc;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &dcc;
> +		usb0 = &usb0;

Drop. Not a supported alias.

> +	};
> +
> +	chosen {
> +		bootargs = "earlycon";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&dcc {
> +	status = "okay";
> +};
> +
> +&gem3 {
> +	status = "okay";
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	phy0: phy at c {
> +		reg = <0xc>;
> +		ti,rx-internal-delay = <0x8>;
> +		ti,tx-internal-delay = <0xa>;
> +		ti,fifo-depth = <0x1>;
> +	};
> +};
> +
> +&gpio {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
> +	i2cswitch at 74 { /* u34 */

i2c-mux at 74

> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x74>;
> +		i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			/*
> +			 * IIC_EEPROM 1kB memory which uses 256B blocks
> +			 * where every block has different address.
> +			 *    0 - 256B address 0x54
> +			 * 256B - 512B address 0x55
> +			 * 512B - 768B address 0x56
> +			 * 768B - 1024B address 0x57
> +			 */
> +			eeprom at 54 { /* u23 */
> +				compatible = "atmel,24c08";
> +				reg = <0x54>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +			};
> +		};
> +
> +		i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			clock_8t49n287: clock-generator at 6c { /* 8T49N287 - u182 */
> +				reg = <0x6c>;
> +			};
> +		};
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			irps5401_43: irps54012 at 43 { /* IRPS5401 - u175 */
> +				reg = <0x43>;
> +			};
> +			irps5401_4d: irps54012 at 4d { /* IRPS5401 - u180 */
> +				reg = <0x4d>;
> +			};
> +		};
> +
> +		i2c at 4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +			tca6416_u97: gpio at 21 {
> +				compatible = "ti,tca6416";
> +				reg = <0x21>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				/*
> +				 * IRQ not connected
> +				 * Lines:
> +				 * 0 - IRPS5401_ALERT_B
> +				 * 1 - HDMI_8T49N241_INT_ALM
> +				 * 2 - MAX6643_OT_B
> +				 * 3 - MAX6643_FANFAIL_B
> +				 * 5 - IIC_MUX_RESET_B
> +				 * 6 - GEM3_EXP_RESET_B
> +				 * 7 - FMC_LPC_PRSNT_M2C_B
> +				 * 4, 10 - 17 - not connected
> +				 */
> +			};
> +		};
> +
> +		i2c at 5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		i2c at 7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +
> +		/* 3, 6 not connected */
> +	};
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +	/* SATA OOB timing settings */
> +	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +};
> +
> +/* SD1 with level shifter */
> +&sdhci1 {
> +	status = "okay";
> +	no-1-8-v;
> +	disable-wp;
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
> +/* ULPI SMSC USB3320 */
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&watchdog0 {
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 
