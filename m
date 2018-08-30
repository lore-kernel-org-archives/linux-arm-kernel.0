From: hjc@rock-chips.com (Sandy Huang)
Date: Thu, 30 Aug 2018 19:59:35 +0800
Subject: [PATCH] ARM: dts: rockchip: add rk3188 lcd controller nodes
In-Reply-To: <20180830111134.2098-1-heiko@sntech.de>
References: <20180830111134.2098-1-heiko@sntech.de>
Message-ID: <42ff42a7-ebd8-e717-af3d-a18de5e4d05c@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heiko,

? 2018/8/30 19:11, Heiko Stuebner ??:
> Add the core display subsystem and vop nodes to rk3188.
> Vop0 has a fully dedicated set of pins and only vop1 needs to
> do pinctrl to have display output, so also add the necessary
> pinctrl entries for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/boot/dts/rk3188.dtsi | 84 +++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index aa123f93f181..ff607f11f5b0 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -56,6 +56,11 @@
>   		};
>   	};
>   
> +	display-subsystem {
> +		compatible = "rockchip,display-subsystem";
> +		ports = <&vop0_out>, <&vop1_out>;
> +	};
> +
>   	sram: sram at 10080000 {
>   		compatible = "mmio-sram";
>   		reg = <0x10080000 0x8000>;
> @@ -69,6 +74,40 @@
>   		};
>   	};
>   
> +	vop0: vop at 1010c000 {
> +		compatible = "rockchip,rk3188-vop";
> +		reg = <0x1010c000 0x1000>;
> +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_LCDC0>, <&cru HCLK_LCDC0>;
> +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> +		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
> +		reset-names = "axi", "ahb", "dclk";
> +		status = "disabled";
> +
> +		vop0_out: port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	vop1: vop at 1010e000 {
> +		compatible = "rockchip,rk3188-vop";
> +		reg = <0x1010e000 0x1000>;
> +		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_LCDC1>, <&cru DCLK_LCDC1>, <&cru HCLK_LCDC1>;
> +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcdc1_dclk &lcdc1_den &lcdc1_hsync &lcdc1_vsync &lcdc1_rgb24>;
Some product maybe use vop0 for display, this io maybe used for other 
function. So i think pincrtl default state should be moved from here and 
define at dts file.

> +		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
> +		reset-names = "axi", "ahb", "dclk";
> +		status = "disabled";
> +
> +		vop1_out: port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>   	timer3: timer at 2000e000 {
>   		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
>   		reg = <0x2000e000 0x20>;
> @@ -309,6 +348,51 @@
>   			};
>   		};
>   
> +		lcdc1 {
> +			lcdc1_dclk: lcdc1-dclk {
> +				rockchip,pins = <2 RK_PD0 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			lcdc1_den: lcdc1-den {
> +				rockchip,pins = <2 RK_PD1 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			lcdc1_hsync: lcdc1-hsync {
> +				rockchip,pins = <2 RK_PD2 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			lcdc1_vsync: lcdc1-vsync {
> +				rockchip,pins = <2 RK_PD3 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			lcdc1_rgb24: ldcd1-rgb24 {
> +				rockchip,pins = <2 RK_PA0 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA1 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA2 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA3 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA4 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA5 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA6 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PA7 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB0 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB1 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB2 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB3 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB4 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB5 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB6 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PB7 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC0 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC1 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC2 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC3 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC4 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC5 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC6 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 RK_PC7 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
>   		pwm0 {
>   			pwm0_out: pwm0-out {
>   				rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_none>;
> 
