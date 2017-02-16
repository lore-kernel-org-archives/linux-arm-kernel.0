From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Thu, 16 Feb 2017 10:56:31 +0800
Subject: [PATCH] arm64: dts: hisilicon: add dts files for
 hi3798cv200-poplar board
In-Reply-To: <1486624027-15156-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1486624027-15156-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <f9be6c55-b37b-65e0-d5ba-cc19307687fe@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017/2/9 15:07, Jiancheng Xue wrote:
> Add basic dts files for hi3798cv200-poplar board. Poplar is the
> first development board compliant with the 96Boards Enterprise
> Edition TV Platform specification. The board features the
> Hi3798CV200 with an integrated quad-core 64-bit ARM Cortex A53
> processor and high performance Mali T720 GPU.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Reviewed-by: Alex Elder <elder@linaro.org>
> ---

I found a few issues by myself. I will update a new version after you finish the review.

>  .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
>  arch/arm64/boot/dts/hisilicon/Makefile             |   1 +
>  .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 169 +++++++++
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 413 +++++++++++++++++++++
>  4 files changed, 587 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index 7df79a7..7d90bf1 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -1,5 +1,9 @@
>  Hisilicon Platforms Device Tree Bindings
>  ----------------------------------------------------
> +Hi3798cv200 Poplar Board
> +Required root node properties:
> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> +
>  Hi4511 Board
>  Required root node properties:
>  	- compatible = "hisilicon,hi3620-hi4511";
> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
> index c8b8f80..96202fe 100644
> --- a/arch/arm64/boot/dts/hisilicon/Makefile
> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
> +dtb-$(CONFIG_ARCH_HISI) += hi3798cv200-poplar.dtb
>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> new file mode 100644
> index 0000000..4e2b1d1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -0,0 +1,169 @@
> +/*
> + * DTS File for HiSilicon Poplar Development Board
> + *
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "hi3798cv200.dtsi"
> +
> +/ {
> +	model = "HiSilicon Poplar Development Board";
> +	compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x000000000 0x00000000 0x00000000 0x80000000>;
> +	};
> +
> +	soc {
> +		leds {
> +			compatible = "gpio-leds";
> +
> +			user-led0 {
> +				label = "USER-LED0";
> +				gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
> +				linux,default-trigger = "heartbeat";
> +				default-state = "off";
> +			};
> +
> +			user-led1 {
> +				label = "USER-LED1";
> +				gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +				linux,default-trigger = "mmc0";
> +				default-state = "off";
> +			};
> +
> +			user-led2 {
> +				label = "USER-LED2";
> +				gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> +				linux,default-trigger = "none";
> +				default-state = "off";
> +			};
> +
> +			user-led3 {
> +				label = "USER-LED3";
> +				gpios = <&gpio10 6 GPIO_ACTIVE_LOW>;
> +				linux,default-trigger = "cpu0";
> +				default-state = "off";
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "ok";
> +};
> +
> +&uart2 {
> +	status = "ok";
> +	label = "LS-UART0";
> +};
> +/* No optional LS-UART1 on Low Speed Expansion Connector. */
> +
> +&i2c0 {
> +	status = "ok";
> +	label = "LS-I2C0";
> +};
> +
> +&i2c2 {
> +	status = "ok";
> +	label = "LS-I2C1";
> +};
> +
> +&spi0 {
> +	status = "ok";
> +	label = "LS-SPI0";
> +};
> +
> +&gpio1 {
> +	status = "ok";
> +	gpio-line-names = "LS-GPIO-E",	"",
> +			  "",		"",
> +			  "",		"LS-GPIO-F",
> +			  "",		"LS-GPIO-J";
> +};
> +
> +&gpio2 {
> +	status = "ok";
> +	gpio-line-names = "LS-GPIO-H",	"LS-GPIO-I",
> +			  "LS-GPIO-L",	"LS-GPIO-G",
> +			  "LS-GPIO-K",	"",
> +			  "",		"";
> +};
> +
> +&gpio3 {
> +	status = "ok";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "LS-GPIO-C",	"",
> +			  "",		"LS-GPIO-B";
> +};
> +
> +&gpio4 {
> +	status = "ok";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "",		"LS-GPIO-D",
> +			  "",		"";
> +};
> +
> +&gpio5 {
> +	status = "ok";
> +	gpio-line-names = "",		"USER-LED-1",
> +			  "USER-LED-2",	"",
> +			  "",		"LS-GPIO-A",
> +			  "",		"";
> +};
> +
> +&gpio6 {
> +	status = "ok";
> +	gpio-line-names = "",		"",
> +			  "",		"USER-LED-0",
> +			  "",		"",
> +			  "",		"";
> +};
> +
> +&gpio10 {
> +	status = "ok";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "",		"",
> +			  "USER-LED-3",	"";
> +};
> +
> +&gmac0 {

Here should be &gmac1

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	phy-handle = <&eth_phy1>;
> +	phy-mode = "rgmii";
> +	hisilicon,phy-reset-delays-us = <10000 10000 30000>;
> +	status = "ok";
> +
> +	eth_phy1: phy at 3{
> +		reg = <3>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> new file mode 100644
> index 0000000..ae3ce6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -0,0 +1,413 @@
> +/*
> + * DTS File for HiSilicon Hi3798cv200 SOC.
> + *
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/histb-clock.h>
> +#include <dt-bindings/reset/ti-syscon.h>
> +
> +/ {
> +	compatible = "hisilicon,hi3798cv200";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	gic: interrupt-controller at f1001000 {
> +		compatible = "arm,gic-400";
> +		reg = <0x0 0xf1001000 0x0 0x1000>,  /*GICD*/
> +		      <0x0 0xf1002000 0x0 0x100>;   /*GICC*/
> +		#address-cells = <0>;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x00000000 0x0 0xffffffff>;
> +
> +		crg: clock-reset-controller at f8a22000 {
> +			compatible = "hisilicon,hi3798cv200-crg", "simple-mfd";

The compatible string here should contain "syscon". It should be
			compatible = "hisilicon,hi3798cv200-crg", "syscon", "simple-mfd";

> +			reg = <0xf8a22000 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <2>;
> +
> +			gmacphyrst: reset-controller {
> +				compatible = "ti,syscon-reset";
> +				reset-cells = <1>;

Here should be #reset-cells.

Regards,
Jiancheng

> +				ti,reset-bits = <
> +					0xcc 12 0xcc 12 0 0 (ASSERT_CLEAR|DEASSERT_SET|STATUS_NONE)  /* 0: gmac0-phy-rst */
> +					0xcc 13 0xcc 13 0 0 (ASSERT_CLEAR|DEASSERT_SET|STATUS_NONE)  /* 1: gmac1-phy-rst */
> +				>;
> +			};
> +		};
> +
> +		sysctrl: system-controller at f8000000 {
> +			compatible = "hisilicon,hi3798cv200-sysctrl", "syscon";
> +			reg = <0xf8000000 0x1000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <2>;
> +		};
> +
> +		uart0: serial at f8b00000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0xf8b00000 0x1000>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysctrl HISTB_UART0_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial at f8b02000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0xf8b02000 0x1000>;
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg HISTB_UART2_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c at f8b10000 {
> +			compatible = "hisilicon,hix5hd2-i2c";
> +			reg = <0xf8b10000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg HISTB_I2C0_CLK>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at f8b11000 {
> +			compatible = "hisilicon,hix5hd2-i2c";
> +			reg = <0xf8b11000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg HISTB_I2C1_CLK>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at f8b12000 {
> +			compatible = "hisilicon,hix5hd2-i2c";
> +			reg = <0xf8b12000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg HISTB_I2C2_CLK>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c at f8b13000 {
> +			compatible = "hisilicon,hix5hd2-i2c";
> +			reg = <0xf8b13000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg HISTB_I2C3_CLK>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c at f8b14000 {
> +			compatible = "hisilicon,hix5hd2-i2c";
> +			reg = <0xf8b14000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg HISTB_I2C4_CLK>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi at f8b1a000 {
> +			compatible = "arm,pl022", "arm,primecell";
> +			reg = <0xf8b1a000 0x1000>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			num-cs = <1>;
> +			cs-gpios = <&gpio7 1 0>;
> +			clocks = <&crg HISTB_SPI0_CLK>;
> +			clock-names = "apb_pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		emmc: mmc at f9830000 {
> +			compatible = "snps,dw-mshc";
> +			reg = <0xf9830000 0x10000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg HISTB_MMC_CIU_CLK>,
> +				 <&crg HISTB_MMC_BIU_CLK>;
> +			clock-names = "ciu", "biu";
> +		};
> +
> +		gpio0: gpio at f8b20000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b20000 0x1000>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio1: gpio at f8b21000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b21000 0x1000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio2: gpio at f8b22000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b22000 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio3: gpio at f8b23000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b23000 0x1000>;
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio4: gpio at f8b24000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b24000 0x1000>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio5: gpio at f8004000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8004000 0x1000>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio6: gpio at f8b26000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b26000 0x1000>;
> +			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio7: gpio at f8b27000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b27000 0x1000>;
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio8: gpio at f8b28000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b28000 0x1000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio9: gpio at f8b29000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b29000 0x1000>;
> +			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio10: gpio at f8b2a000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b2a000 0x1000>;
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio11: gpio at f8b2b000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b2b000 0x1000>;
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gpio12: gpio at f8b2c000 {
> +			compatible = "arm,pl061", "arm,primecell";
> +			reg = <0xf8b2c000 0x1000>;
> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			clocks = <&crg HISTB_APB_CLK>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +		};
> +
> +		gmac0: ethernet at f9840000 {
> +			compatible = "hisilicon,hi3798cv200-gmac", "hisilicon,hisi-gmac-v2";
> +			reg = <0xf9840000 0x1000>,
> +			      <0xf984300c 0x4>;
> +			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg HISTB_ETH0_MAC_CLK>,
> +				 <&crg HISTB_ETH0_MACIF_CLK>;
> +			clock-names = "mac_core", "mac_ifc";
> +			resets = <&crg 0xcc 8>,
> +				 <&crg 0xcc 10>,
> +				 <&gmacphyrst 0>;
> +			reset-names = "mac_core", "mac_ifc", "phy";
> +		};
> +
> +		gmac1: ethernet at f9841000 {
> +			compatible = "hisilicon,hi3798cv200-gmac", "hisilicon,hisi-gmac-v2";
> +			reg = <0xf9841000 0x1000>,
> +			      <0xf9843010 0x4>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg HISTB_ETH1_MAC_CLK>,
> +				 <&crg HISTB_ETH1_MACIF_CLK>;
> +			clock-names = "mac_core", "mac_ifc";
> +			resets = <&crg 0xcc 9>,
> +				 <&crg 0xcc 11>,
> +				 <&gmacphyrst 1>;
> +			reset-names = "mac_core", "mac_ifc", "phy";
> +		};
> +
> +		ir: ir at f8001000 {
> +			compatible = "hisilicon,hix5hd2-ir";
> +			reg = <0xf8001000 0x1000>;
> +			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysctrl HISTB_IR_CLK>;
> +		};
> +	};
> +};
> 
