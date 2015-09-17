From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 17 Sep 2015 16:51:53 +0800
Subject: [PATCH v1 1/3] ARM: dts: rockchip: add core rk3036 dts
In-Reply-To: <1871781.cSEoq02CXi@phil>
References: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
 <1440740808-15004-2-git-send-email-zhengxing@rock-chips.com>
 <1871781.cSEoq02CXi@phil>
Message-ID: <55FA7F29.4050403@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?08?28? 16:59, Heiko Stuebner wrote:
> Hi,
>
> Am Freitag, 28. August 2015, 13:46:46 schrieb Xing Zheng:
>> Initial release for rk3036, node definitions rk3036 sdk board.
>>
>> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
>> ---
>>
>> Changes in v1: None
>>
>>   arch/arm/boot/dts/Makefile       |    1 +
>>   arch/arm/boot/dts/rk3036-sdk.dts |  362
>> ++++++++++++++++++++++++++++++++++++++ 2 files changed, 363 insertions(+)
> as Eddie already said, please split into two files ... just look at the other
> Rockchip socs for inspiration :-)
Done.
>>   create mode 100644 arch/arm/boot/dts/rk3036-sdk.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 6d7cec1..7014a3b 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -501,6 +501,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>>   	rk3066a-bqcurie2.dtb \
>>   	rk3066a-marsboard.dtb \
>>   	rk3066a-rayeager.dtb \
>> +	rk3036-sdk.dtb \
>>   	rk3188-radxarock.dtb \
>>   	rk3288-evb-act8846.dtb \
>>   	rk3288-evb-rk808.dtb \
>> diff --git a/arch/arm/boot/dts/rk3036-sdk.dts
>> b/arch/arm/boot/dts/rk3036-sdk.dts new file mode 100644
>> index 0000000..0149c9a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3036-sdk.dts
>> @@ -0,0 +1,362 @@
>> +/*
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include<dt-bindings/gpio/gpio.h>
>> +#include<dt-bindings/interrupt-controller/irq.h>
>> +#include<dt-bindings/interrupt-controller/arm-gic.h>
>> +#include<dt-bindings/pinctrl/rockchip.h>
>> +#include<dt-bindings/clock/rk3036-cru.h>
>> +#include "skeleton.dtsi"
>> +
>> +/ {
>> +	compatible = "rockchip,rk3036";
>> +
>> +	interrupt-parent =<&gic>;
>> +
>> +	aliases {
>> +		serial0 =&uart0;
>> +		serial1 =&uart1;
>> +		serial2 =&uart2;
>> +	};
>> +
>> +	memory {
>> +		reg =<0x60000000 0x40000000>;
> missing
> 	device_type = "memory";
Done.
>
>> +	};
>> +
>> +        arm-pmu {
>> +                compatible = "arm,cortex-a7-pmu";
>> +                interrupts =<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> missing interrupt-affinity to map irq->cpu_core ?
Done.
>> +        };
>> +
>> +	cpus {
>> +		#address-cells =<1>;
>> +		#size-cells =<0>;
>> +		//enable-method = "rockchip,rk3066-smp";
> please don't leave commented code around
>
Done.
>> +
>> +		cpu at f00 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg =<0xf00>;
>> +			operating-points =<
>> +				/* KHz    uV */
>> +				 816000 1000000
>> +			>;
>> +			#cooling-cells =<2>; /* min followed by max */
>> +			clock-latency =<40000>;
>> +			clocks =<&cru ARMCLK>;
>> +			resets =<&cru SRST_CORE0>;
>> +		};
>> +		cpu at f01 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg =<0xf01>;
>> +			resets =<&cru SRST_CORE1>;
>> +		};
>> +	};
>> +
>> +	amba {
>> +		compatible = "arm,amba-bus";
>> +		#address-cells =<1>;
>> +		#size-cells =<1>;
>> +		ranges;
>> +
>> +                pdma: pdma at 20078000 {
>> +                        compatible = "arm,pl330", "arm,primecell";
>> +                        reg =<0x20078000 0x4000>;
>> +                        interrupts =<GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +<GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> +                        #dma-cells =<1>;
>> +                        clocks =<&cru ACLK_DMAC2>;
>> +                        clock-names = "apb_pclk";
>> +                };
> indentation of the dma controller looks wrong
>
In my opnion, it seems ok, where is it wrong?
Thanks.
>> +	};
>> +
>> +	xin24m: oscillator {
>> +		compatible = "fixed-clock";
>> +		clock-frequency =<24000000>;
>> +		clock-output-names = "xin24m";
>> +		#clock-cells =<0>;
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		arm,cpu-registers-not-fw-configured;
>> +		interrupts =<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>,
>> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_HIGH)>;
>
> please provide all 4 irqs (secure, non-secure, virtual and hypervisor)
Done, but I don't quite understand.
>> +		clock-frequency =<24000000>;
>> +		always-on;
>> +	};
>> +
>> +	cru: clock-controller at 20000000 {
>> +		compatible = "rockchip,rk3036-cru";
>> +		reg =<0x20000000 0x1000>;
>> +		rockchip,grf =<&grf>;
>> +		#clock-cells =<1>;
>> +		#reset-cells =<1>;
>> +		assigned-clocks =<&cru PLL_GPLL>;
>> +		assigned-clock-rates =<594000000>;
>> +	};
>> +
>> +	uart0: serial at 20060000 {
>> +		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
>> +		reg =<0x20060000 0x100>;
>> +		interrupts =<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg-shift =<2>;
>> +		reg-io-width =<4>;
>> +		clock-frequency =<24000000>;
>> +		clocks =<&cru SCLK_UART0>,<&cru PCLK_UART0>;
>> +		clock-names = "baudclk", "apb_pclk";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&uart0_xfer&uart0_cts&uart0_rts>;
>> +	};
>> +
>> +	uart1: serial at 20064000 {
>> +		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
>> +		reg =<0x20064000 0x100>;
>> +		interrupts =<GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg-shift =<2>;
>> +		reg-io-width =<4>;
>> +		clock-frequency =<24000000>;
>> +		clocks =<&cru SCLK_UART1>,<&cru PCLK_UART1>;
>> +		clock-names = "baudclk", "apb_pclk";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&uart1_xfer>;
>> +	};
>> +
>> +	uart2: serial at 20068000 {
>> +		compatible = "rockchip,rk3036-uart", "snps,dw-apb-uart";
>> +		reg =<0x20068000 0x100>;
>> +		interrupts =<GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>> +		reg-shift =<2>;
>> +		reg-io-width =<4>;
>> +		clock-frequency =<24000000>;
>> +		clocks =<&cru SCLK_UART2>,<&cru PCLK_UART2>;
>> +		clock-names = "baudclk", "apb_pclk";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&uart2_xfer>;
>> +	};
>> +
>> +	pwm0: pwm at 20050000 {
>> +		compatible = "rockchip,rk2928-pwm";
>> +		reg =<0x20050000 0x10>;
>> +		#pwm-cells =<3>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&pwm0_pin>;
>> +		clocks =<&cru PCLK_PWM>;
>> +		clock-names = "pwm";
>> +		status = "disabled";
>> +	};
>> +
>> +	pwm1: pwm at 20050010 {
>> +		compatible = "rockchip,rk2928-pwm";
>> +		reg =<0x20050010 0x10>;
>> +		#pwm-cells =<3>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&pwm1_pin>;
>> +		clocks =<&cru PCLK_PWM>;
>> +		clock-names = "pwm";
>> +		status = "disabled";
>> +	};
>> +
>> +	pwm2: pwm at 20050020 {
>> +		compatible = "rockchip,rk2928-pwm";
>> +		reg =<0x20050020 0x10>;
>> +		#pwm-cells =<3>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&pwm2_pin>;
>> +		clocks =<&cru PCLK_PWM>;
>> +		clock-names = "pwm";
>> +		status = "disabled";
>> +	};
>> +
>> +	pwm3: pwm at 20050030 {
>> +		compatible = "rockchip,rk2928-pwm";
>> +		reg =<0x20050030 0x10>;
>> +		#pwm-cells =<2>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 =<&pwm3_pin>;
>> +		clocks =<&cru PCLK_PWM>;
>> +		clock-names = "pwm";
>> +		status = "disabled";
>> +	};
>> +
>> +	sram at 10080000 {
>> +		compatible = "mmio-sram";
>> +		reg =<0x10080000 0x2000>;
>> +		map-exec;
>> +	};
>> +
>> +	gic: interrupt-controller at 10139000 {
>> +		compatible = "arm,gic-400";
>> +		interrupt-controller;
>> +		#interrupt-cells =<3>;
>> +		#address-cells =<0>;
>> +
>> +		reg =<0x10139000 0x1000>,
>> +		<0x1013a000 0x1000>;
> please also provide the vgic registers and interrupt
Done, but I checked GIC_SPEC.pdf and I'm not sure it is correct...
>> +	};
>> +
>> +	grf: syscon at 20008000 {
>> +		compatible = "rockchip,rk3036-grf", "syscon";
>> +		reg =<0x20008000 0x1000>;
>> +	};
>> +
>> +	pinctrl: pinctrl {
>> +		compatible = "rockchip,rk3036-pinctrl";
>> +		rockchip,grf =<&grf>;
>> +		#address-cells =<1>;
>> +		#size-cells =<1>;
>> +		ranges;
>> +
>> +		gpio0: gpio0 at 2007c000 {
>> +			compatible = "rockchip,gpio-bank";
>> +			reg =	<0x2007c000 0x100>;
> please use a space after the "=" in "reg =<..."
Done.
>> +			interrupts =<GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =<&cru PCLK_GPIO0>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =<2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =<2>;
>> +		};
>> +
>> +		gpio1: gpio1 at 20080000 {
>> +			compatible = "rockchip,gpio-bank";
>> +			reg =<0x20080000 0x100>;
>> +			interrupts =<GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =<&cru PCLK_GPIO1>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =<2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =<2>;
>> +		};
>> +
>> +		gpio2: gpio2 at 20084000 {
>> +			compatible = "rockchip,gpio-bank";
>> +			reg =<0x20084000 0x100>;
>> +			interrupts =<GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =<&cru PCLK_GPIO2>;
>> +
>> +			gpio-controller;
>> +			#gpio-cells =<2>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells =<2>;
>> +		};
>> +
>> +		pcfg_pull_up: pcfg-pull-up {
>> +			bias-pull-up;
>> +		};
>> +
>> +		pcfg_pull_down: pcfg-pull-down {
>> +			bias-pull-down;
>> +		};
>> +
>> +		pcfg_pull_none: pcfg-pull-none {
>> +			bias-disable;
>> +		};
>> +
>> +		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
>> +			bias-disable;
>> +			drive-strength =<12>;
>> +		};
> The rk3036 iomux does not have a per-pin drive-strength setting it seems, so
> at the moment the pinctrl driver does not support changing the drive-strength,
> so this node should probably be dropped. It seems unused anyway.
Done.
>> +
>> +		uart0 {
>> +			uart0_xfer: uart0-xfer {
>> +				rockchip,pins =<0 16 RK_FUNC_1&pcfg_pull_none>,
>> +						<0 17 RK_FUNC_1&pcfg_pull_none>;
>> +			};
>> +
>> +			uart0_cts: uart0-cts {
>> +				rockchip,pins =<0 18 RK_FUNC_1&pcfg_pull_none>;
>> +			};
>> +
>> +			uart0_rts: uart0-rts {
>> +				rockchip,pins =<0 19 RK_FUNC_1&pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		uart1 {
>> +			uart1_xfer: uart1-xfer {
>> +				rockchip,pins =<2 22 RK_FUNC_1&pcfg_pull_none>,
>> +						<2 23 RK_FUNC_1&pcfg_pull_none>;
>> +			};
>> +			/* no rts / cts for uart1 */
>> +		};
>> +
>> +                uart2 {
>> +                        uart2_xfer: uart2-xfer {
>> +                                rockchip,pins =<1 18 RK_FUNC_2
>> &pcfg_pull_none>, +<1 19
>> RK_FUNC_2&pcfg_pull_none>; +                        };
>> +                        /* no rts / cts for uart2 */
>> +                };
>> +
>> +		pwm0 {
>> +			pwm0_pin: pwm0-pin {
>> +				rockchip,pins =<0 0 RK_FUNC_2&pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		pwm1 {
>> +			pwm1_pin: pwm1-pin {
>> +				rockchip,pins =<0 1 RK_FUNC_2&pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		pwm2 {
>> +			pwm2_pin: pwm2-pin {
>> +				rockchip,pins =<0 1 2&pcfg_pull_none>;
>> +			};
>> +		};
>> +
>> +		pwm3 {
>> +			pwm3_pin: pwm3-pin {
>> +				rockchip,pins =<0 27 1&pcfg_pull_none>;
>> +			};
>> +		};
>> +	};
>> +};
>
