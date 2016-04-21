From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Apr 2016 00:02:43 +0200
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <3937420.4aN2rRBlcO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jay,

Am Donnerstag, 21. April 2016, 11:58:12 schrieb Jianqun Xu:
> This patch adds rk3399.dtsi for rk3399 found on Rockchip
> RK3399 SoCs, also add rk3399-evb.dts for Rockchip RK3399
> Evaluation Board.
> 
> Patch is tested on RK3399 evb.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

please split this into
- patch adding the dtsi
- patch adding the evb dts
- patch adding the new  board to bindings/arm/rockchip.txt

more inline below

> ---
>  arch/arm64/boot/dts/rockchip/Makefile       |    1 +
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  537 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 1757
> +++++++++++++++++++++++++++ 3 files changed, 2295 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts new file mode 100644
> index 0000000..4cb0028
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -0,0 +1,537 @@
> +/*
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
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
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3399 Evaluation Board";
> +	compatible = "rockchip,evb", "rockchip,rk3399-evb";
> +
> +	chosen {
> +		bootargs = "console=uart,mmio32,0xff1a0000";

I'd think we'll want a
	stdout-path = something
property here, instead of hard-coding bootargs.

[...]

> +&i2c4 {
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <600>;
> +	i2c-scl-falling-time-ns = <20>;
> +
> +	gt9xx: gt9xx at 14 {
> +		compatible = "goodix,gt9xx";

same as Rob said for the ramoops, I don't see this one in the devicetree 
bindings. Also gt9xx should instead specify an actual chip, not a chip-family.
See drivers/input/touchscreen/goodix.c and 
Documentation/devicetree/bindings/input/touchscreen for supported chips and 
the real devicetree bindings.


> +		reg = <0x14>;
> +		touch-gpio = <&gpio1 20 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
> +		max-x = <1200>;
> +		max-y = <1900>;
> +		tp-size = <911>;
> +		tp-supply = <&vcc3v0_tp>;
> +	};
> +};

[...]

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi new file mode 100644
> index 0000000..7c3015c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -0,0 +1,1757 @@
> +/*
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +#include <dt-bindings/clock/rk3399-cru.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3399-power.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {

[...]

> +	sdhci: sdhci at fe330000 {
> +		compatible = "arasan,sdhci-5.1";

not 100% sure, but we might want a
		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";

allowing us to get more specific, if implementation oddities surface later.

> +		reg = <0x0 0xfe330000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		phys = <&emmc_phy>;
> +		phy-names = "phy_arasan";
> +		status = "disabled";
> +	};
> +
> +	usb2phy: usb2phy {
> +		compatible = "rockchip,rk3399-usb-phy";

this doesn't look like it got submitted yet.

Also, the newer socs (rk3399. rk3036, rk3228) seem to use a different usbphy 
block than rk3288 and before (with a big bunch of new phy-related register 
blocks I haven't looked at yet) - so this should probably get a new driver as 
well and not be crammed into the current phy driver, which is for the older 
picophy (or what it was called).


> +		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb2phy0: usb2-phy0 {
> +			#phy-cells = <0>;
> +			#clock-cells = <0>;
> +			reg = <0xe458>;
> +		};

When we're doing a new driver, could we please get rid of these subnodes and 
instead access phys via something like

	phys = <&usb2phy 0>;


> +
> +		usb2phy1: usb2-phy1 {
> +			#phy-cells = <0>;
> +			#clock-cells = <0>;
> +			reg = <0xe468>;
> +		};
> +	};
> +
> +	usb_host0_echi: usb at fe380000 {

not "echi" please :-)

> +		compatible = "generic-ehci";
> +		reg = <0x0 0xfe380000 0x0 0x20000>;
> +		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
> +		clock-names = "hclk_host0", "hclk_host0_arb";
> +		phys = <&usb2phy0>;
> +		phy-names = "usb2_phy0";
> +		status = "disabled";
> +	};

[...]

> +	usbdrd3_0: usb at fe800000 {
> +		compatible = "rockchip,dwc3";

is this in some tree already?

> +		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "clk_usb3otg0_ref", "clk_usb3otg0_suspend",
> +			      "aclk_usb3otg0", "aclk_usb3_rksoc_axi_perf",
> +			      "aclk_usb3", "aclk_usb3_grf";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +		usbdrd_dwc3_0: dwc3 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe800000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "otg";
> +			tx-fifo-resize;
> +			snps,dis_enblslpm_quirk;
> +			snps,phyif_utmi_16_bits;
> +			snps,dis_u2_freeclk_exists_quirk;
> +			snps,dis_del_phy_power_chg_quirk;
> +			status = "disabled";
> +		};
> +	};
> +
> +	usbdrd3_1: usb at fe900000 {
> +		compatible = "rockchip,dwc3";

same here

> +		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "clk_usb3otg1_ref", "clk_usb3otg1_suspend",
> +			      "aclk_usb3otg1", "aclk_usb3_rksoc_axi_perf",
> +			      "aclk_usb3", "aclk_usb3_grf";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +		usbdrd_dwc3_1: dwc3 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe900000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			dr_mode = "otg";
> +			tx-fifo-resize;
> +			snps,dis_enblslpm_quirk;
> +			snps,phyif_utmi_16_bits;
> +			snps,dis_u2_freeclk_exists_quirk;
> +			snps,dis_del_phy_power_chg_quirk;
> +			status = "disabled";
> +		};
> +	};
> +

[...]

> +	i2c1: i2c at ff110000 {
> +		compatible = "rockchip,rk3399-i2c";

David respun the rk3399 i2c-support on tuesday, so this and the others below 
are waiting on Wolfram to take a look.


> +		reg = <0x0 0xff110000 0x0 0x1000>;
> +		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c1_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};

[...]

> +	pmu: power-management at ff31000 {

address is missing "0" :-)

[...]

> +	};

[...]

> +	i2c0: i2c at ff3c0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3c0000 0x0 0x1000>;
> +		clocks =  <&pmucru SCLK_I2C0_PMU>, <&pmucru PCLK_I2C0_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c0_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c4: i2c at ff3d0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3d0000 0x0 0x1000>;
> +		clocks = <&pmucru SCLK_I2C4_PMU>, <&pmucru PCLK_I2C4_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c4_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	i2c8: i2c at ff3e0000 {
> +		compatible = "rockchip,rk3399-i2c";
> +		reg = <0x0 0xff3e0000 0x0 0x1000>;
> +		clocks = <&pmucru SCLK_I2C8_PMU>, <&pmucru PCLK_I2C8_PMU>;
> +		clock-names = "i2c", "pclk";
> +		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&i2c8_xfer>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};



> +	rga: rga at ff680000 {
> +		compatible = "rockchip,rk3399-rga";

not yet accepted component, please leave out for now

> +		reg = <0x0 0xff680000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "rga";
> +		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
> +		clock-names = "aclk", "hclk", "sclk";
> +		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
> +		reset-names = "core", "axi", "ahb";
> +		status = "disabled";
> +	};
> +

[...]

> +	gpu: gpu at ff9a0000 {
> +		compatible = "arm,malit860",
> +			     "arm,malit86x",
> +			     "arm,malit8xx",
> +			     "arm,mali-midgard";

mali kernel-part is out-of-tree code with a unreviewed binding, so should not 
be part of the mainline devicetree

> +		reg = <0x0 0xff9a0000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "GPU", "JOB", "MMU";
> +
> +		clocks = <&cru ACLK_GPU>;
> +		clock-names = "clk_mali";
> +		#cooling-cells = <2>; /* min followed by max */
> +		status = "disabled";
> +	};

[...]

> +	mipi_dsi: mipi at ff960000 {
> +		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";

missing binding in the kernel

> +		reg = <0x0 0xff960000 0x0 0x8000>;
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_MIPIDPHY_REF>, <&cru PCLK_MIPI_DSI0>,
> +			 <&cru SCLK_DPHY_TX0_CFG>;
> +		clock-names = "ref", "pclk", "phy_cfg";
> +		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			mipi_in: port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mipi_in_vopb: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vopb_out_mipi>;
> +				};
> +				mipi_in_vopl: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vopl_out_mipi>;
> +				};
> +			};
> +		};
> +	};
> +
> +	edp: edp at ff970000 {
> +		compatible = "rockchip,rk3399-edp";

missing binding in the kernel?


> +		reg = <0x0 0xff970000 0x0 0x8000>;
> +		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
> +		clock-names = "dp", "pclk";
> +		resets = <&cru SRST_P_EDP_CTRL>;
> +		reset-names = "dp";
> +		rockchip,grf = <&grf>;
> +		status = "disabled";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_hpd>;

I think the hotplug detection is pretty optional, so should live in the board 
files instead

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			edp_in: port at 0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				edp_in_vopb: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vopb_out_edp>;
> +				};
> +
> +				edp_in_vopl: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vopl_out_edp>;
> +				};
> +			};
> +		};
> +	};
