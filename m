From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 10 Dec 2015 01:32:03 +0100
Subject: [PATCH v1 7/8] ARM: dts: rockchip: add core rk3228 dtsi
In-Reply-To: <1449651853-1667-8-git-send-email-jeffy.chen@rock-chips.com>
References: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
 <1449651853-1667-8-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <24573164.okRNXjvZ1B@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Mittwoch, 9. Dezember 2015, 17:04:12 schrieb Jeffy Chen:
> Initial release for rk3228 shared dtsi.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3228.dtsi | 478 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 478 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3228.dtsi
> 
> diff --git a/arch/arm/boot/dts/rk3228.dtsi b/arch/arm/boot/dts/rk3228.dtsi
> new file mode 100644
> index 0000000..d6b3e40
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3228.dtsi
> @@ -0,0 +1,478 @@
> +/*
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
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/clock/rk3228-cru.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +	compatible = "rockchip,rk3228";
> +
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x60000000 0x40000000>;
> +	};

The amount of memory is a property of the board

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

no enable-method?

As the rk3228 also does not have a pmu, does the newly created
"rockchip,rk3036-smp" work for you?

> +
> +		cpu0: cpu at f00 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0xf00>;
> +			resets = <&cru SRST_CORE0>;
> +			operating-points = <
> +				/* KHz    uV */
> +				 816000 1000000
> +			>;
> +			clock-latency = <40000>;
> +			clocks = <&cru ARMCLK>;
> +		};
> +
> +		cpu1: cpu at f01 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0xf01>;
> +			resets = <&cru SRST_CORE1>;
> +		};
> +
> +		cpu2: cpu at f02 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0xf02>;
> +			resets = <&cru SRST_CORE2>;
> +		};
> +
> +		cpu3: cpu at f03 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0xf03>;
> +			resets = <&cru SRST_CORE3>;
> +		};
> +	};
> +
> +	amba {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pdma: pdma at 110f0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x110f0000 0x4000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&cru ACLK_DMAC>;
> +			clock-names = "apb_pclk";
> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		arm,cpu-registers-not-fw-configured;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +		clock-frequency = <24000000>;
> +	};
> +
> +	hdmiphy_phy: hdmiphy_phy {
> +		compatible = "fixed-clock";
> +		clock-frequency = <594000000>;
> +		clock-output-names = "hdmiphy_phy";
> +		#clock-cells = <0>;
> +	};
> +
> +	phy_50m_out: phy_50m_out {
> +		compatible = "fixed-clock";
> +		clock-frequency = <50000000>;
> +		clock-output-names = "phy_50m_out";
> +		#clock-cells = <0>;
> +	};
> +
> +	usb480m_phy0: usb480m_phy0 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <480000000>;
> +		clock-output-names = "usb480m_phy0";
> +		#clock-cells = <0>;
> +	};
> +
> +	usb480m_phy1: usb480m_phy1 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <480000000>;
> +		clock-output-names = "usb480m_phy1";
> +		#clock-cells = <0>;
> +	};

these clocks starting with hdmiphy clock come from IPs in the soc, so the
relevant drivers should provide them (see my patch series for the picophy,
or how rk808 and hym8563 do it) - especially as these clocks might get
turned off in the IP-block itself.

The clock framework can handle orphans, so just leave these out for now
please.


> +
> +	xin24m: oscillator {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +		#clock-cells = <0>;
> +	};
> +
> +	cru: clock-controller at 110e0000 {
> +		compatible = "rockchip,rk3228-cru";
> +		reg = <0x110e0000 0x1000>;
> +		rockchip,grf = <&grf>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +		assigned-clocks = <&cru PLL_GPLL>;
> +		assigned-clock-rates = <594000000>;
> +	};
> +
> +	gic: interrupt-controller at 32010000 {

please order by register address, so gic should move quite
a bit lower.

> +		compatible = "arm,gic-400";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +
> +		reg = <0x32011000 0x1000>,
> +		      <0x32012000 0x1000>;

please also provide the vgic registers and interrupt.


> +	};
> +
> +	grf: syscon at 11000000 {
> +		compatible = "syscon";
> +		reg = <0x11000000 0x1000>;
> +	};
> +
> +	timer: timer at 110c0000 {
> +		compatible = "rockchip,rk3288-timer";
> +		reg = <0x110c0000 0x20>;
> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&xin24m>, <&cru PCLK_TIMER>;
> +		clock-names = "timer", "pclk";
> +	};
> +
> +	emmc: dwmmc at 30020000 {
> +		compatible = "rockchip,rk3288-dw-mshc";
> +		clock-frequency = <37500000>;
> +		clock-freq-min-max = <400000 37500000>;
> +		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> +		<&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> +		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
> +		fifo-depth = <0x100>;
> +		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x30020000 0x4000>;
> +		broken-cd;
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
> +		mmc-ddr-1_8v;
> +		disable-wp;
> +		non-removable;
> +		num-slots = <1>;
> +		default-sample-phase = <158>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;

please separate board and core properties.
broken-cd, cap-*, mmc-ddr-1_8v, disable-wp, non-removable
are per-board properties as they depend on what is connected to
the controller.

> +		status = "disabled";
> +	};
> +
> +	pwm0: pwm at 110b0000 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0x110b0000 0x10>;
> +		#pwm-cells = <3>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm0_pin>;
> +		status = "disabled";
> +	};
> +
> +	pwm1: pwm at 110b0010 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0x110b0010 0x10>;
> +		#pwm-cells = <3>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm1_pin>;
> +		status = "disabled";
> +	};
> +
> +	pwm2: pwm at 110b0020 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0x110b0020 0x10>;
> +		#pwm-cells = <3>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm2_pin>;
> +		status = "disabled";
> +	};
> +
> +	pwm3: pwm at 110b0030 {
> +		compatible = "rockchip,rk3288-pwm";
> +		reg = <0x110b0030 0x10>;
> +		#pwm-cells = <2>;
> +		clocks = <&cru PCLK_PWM>;
> +		clock-names = "pwm";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwm3_pin>;
> +		status = "disabled";
> +	};
> +
> +	uart0: serial at 11010000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x11010000 0x100>;
> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		clock-frequency = <24000000>;
> +		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> +		clock-names = "baudclk", "apb_pclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> +		status = "disabled";
> +	};
> +
> +	uart1: serial at 11020000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x11020000 0x100>;
> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		clock-frequency = <24000000>;
> +		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> +		clock-names = "baudclk", "apb_pclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&uart1_xfer>;
> +		status = "disabled";
> +	};
> +
> +	uart2: serial at 11030000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x11030000 0x100>;
> +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		clock-frequency = <24000000>;
> +		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> +		clock-names = "baudclk", "apb_pclk";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&uart2_xfer>;
> +		status = "disabled";
> +	};
> +
> +
> +	pinctrl: pinctrl {
> +		compatible = "rockchip,rk3228-pinctrl";
> +		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gpio0: gpio0 at 11110000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x11110000 0x100>;
> +			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO0>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio1: gpio1 at 11120000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x11120000 0x100>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO1>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio2: gpio2 at 11130000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x11130000 0x100>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO2>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio3: gpio3 at 11140000 {
> +			compatible = "rockchip,gpio-bank";
> +			reg = <0x11140000 0x100>;
> +			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru PCLK_GPIO3>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pcfg_pull_up: pcfg-pull-up {
> +			bias-pull-up;
> +		};
> +
> +		pcfg_pull_down: pcfg-pull-down {
> +			bias-pull-down;
> +		};
> +
> +		pcfg_pull_none: pcfg-pull-none {
> +			bias-disable;
> +		};
> +
> +		emmc {
> +			emmc_clk: emmc-clk {
> +				rockchip,pins = <2 7 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +
> +			emmc_cmd: emmc-cmd {
> +				rockchip,pins = <1 22 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +
> +			emmc_bus8: emmc-bus8 {
> +				rockchip,pins = <1 24 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 25 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 26 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 27 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 28 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 29 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 30 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 31 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm0 {
> +			pwm0_pin: pwm0-pin {
> +				rockchip,pins = <3 21 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm1 {
> +			pwm1_pin: pwm1-pin {
> +				rockchip,pins = <0 30 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm2 {
> +			pwm2_pin: pwm2-pin {
> +				rockchip,pins = <1 12 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pwm3 {
> +			pwm3_pin: pwm3-pin {
> +				rockchip,pins = <1 11 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		uart0 {
> +			uart0_xfer: uart0-xfer {
> +				rockchip,pins = <2 26 RK_FUNC_1 &pcfg_pull_none>,
> +						<2 27 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			uart0_cts: uart0-cts {
> +				rockchip,pins = <2 29 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			uart0_rts: uart0-rts {
> +				rockchip,pins = <0 17 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		uart1 {
> +			uart1_xfer: uart1-xfer {
> +				rockchip,pins = <1 9 RK_FUNC_1 &pcfg_pull_none>,
> +						<1 10 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			uart1_cts: uart1-cts {
> +				rockchip,pins = <1 8 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			uart1_rts: uart1-rts {
> +				rockchip,pins = <1 11 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		uart2 {
> +			uart2_xfer: uart2-xfer {
> +				rockchip,pins = <1 18 RK_FUNC_2 &pcfg_pull_none>,
> +						<1 19 RK_FUNC_2 &pcfg_pull_none>;
> +			};
> +
> +			uart2_cts: uart2-cts {
> +				rockchip,pins = <0 25 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +
> +			uart2_rts: uart2-rts {
> +				rockchip,pins = <0 24 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +	};
> +};
> 
