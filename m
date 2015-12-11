From: robh@kernel.org (Rob Herring)
Date: Fri, 11 Dec 2015 10:28:47 -0600
Subject: [PATCH v3 7/7] ARM: dts: add dts files for Hi3519
In-Reply-To: <1449819921-18464-8-git-send-email-xuejiancheng@huawei.com>
References: <1449819921-18464-1-git-send-email-xuejiancheng@huawei.com>
 <1449819921-18464-8-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20151211162847.GC21272@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 03:45:21PM +0800, Jiancheng Xue wrote:
> add dts files for Hi3519
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  arch/arm/boot/dts/Makefile        |   2 +
>  arch/arm/boot/dts/hi3519-demb.dts |  42 +++++++++++
>  arch/arm/boot/dts/hi3519.dtsi     | 142 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
>  create mode 100644 arch/arm/boot/dts/hi3519.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 30bbc37..1ff3ed9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -135,6 +135,8 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5800-peach-pi.dtb
>  dtb-$(CONFIG_ARCH_HI3xxx) += \
>  	hi3620-hi4511.dtb
> +dtb-$(CONFIG_ARCH_HISI) += \
> +	hi3519-demb.dtb
>  dtb-$(CONFIG_ARCH_HIX5HD2) += \
>  	hisi-x5hd2-dkb.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += \
> diff --git a/arch/arm/boot/dts/hi3519-demb.dts b/arch/arm/boot/dts/hi3519-demb.dts
> new file mode 100644
> index 0000000..6991ab6
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3519-demb.dts
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +/dts-v1/;
> +#include "hi3519.dtsi"
> +
> +/ {
> +	model = "HiSilicon HI3519 DEMO Board";
> +	compatible = "hisilicon,hi3519";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&dual_timer0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
> new file mode 100644
> index 0000000..50b736e
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3519.dtsi
> @@ -0,0 +1,142 @@
> +/*
> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "skeleton.dtsi"

Don't include skeleton.dtsi. We've decided it was a bad idea.

> +#include <dt-bindings/clock/hi3519-clock.h>
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {

Single core system? Add the other cpu nodes if not. Adding them doesn't 
have to be in sync with SMP kernel support.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0>;
> +		};
> +	};
> +
> +	gic: interrupt-controller at 10300000 {
> +		compatible = "arm,cortex-a7-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x10301000 0x1000>, <0x10302000 0x1000>;
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;

Looks like everything is in 0x12xxxxxx range, so you should add actual 
translation here if that's the case.

> +
> +		amba {

Is this actually a separate bus in the physical design of the chip?

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "arm,amba-bus";

Just simple-bus. "arm,amba-bus" is not any type of bus, nor is it 
documented.

> +			ranges;
> +
> +			uart0: serial at 12100000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x12100000 0x1000>;
> +				interrupts = <0 4 4>;
> +				clocks = <&crg HI3519_UART0_CLK>;
> +				clock-names = "apb_pclk";
> +				status = "disable";
> +			};
> +
> +			uart1: serial at 12101000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x12101000 0x1000>;
> +				interrupts = <0 5 4>;
> +				clocks = <&crg HI3519_UART1_CLK>;
> +				clock-names = "apb_pclk";
> +				status = "disable";
> +			};
> +
> +			uart2: serial at 12102000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x12102000 0x1000>;
> +				interrupts = <0 6 4>;
> +				clocks = <&crg HI3519_UART2_CLK>;
> +				clock-names = "apb_pclk";
> +				status = "disable";
> +			};
> +
> +			uart3: serial at 12103000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x12103000 0x1000>;
> +				interrupts = <0 7 4>;
> +				clocks = <&crg HI3519_UART3_CLK>;
> +				clock-names = "apb_pclk";
> +				status = "disable";
> +			};
> +
> +			uart4: serial at 12104000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x12104000 0x1000>;
> +				interrupts = <0 8 4>;
> +				clocks = <&crg HI3519_UART4_CLK>;
> +				clock-names = "apb_pclk";
> +				status = "disable";
> +			};
> +
> +			dual_timer0: timer at 12000000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				interrupts = <0 64 4>, <0 65 4>;
> +				reg = <0x12000000 0x1000>;
> +				clocks = <&crg HI3519_FIXED_3M>;
> +				status = "disable";
> +			};
> +
> +			dual_timer1: timer at 12001000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				interrupts = <0 66 4>, <0 67 4>;
> +				reg = <0x12001000 0x1000>;
> +				clocks = <&crg HI3519_FIXED_3M>;
> +				status = "disable";
> +			};
> +
> +			dual_timer2: timer at 12002000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				interrupts = <0 68 4>, <0 69 4>;
> +				reg = <0x12002000 0x1000>;
> +				clocks = <&crg HI3519_FIXED_3M>;
> +				status = "disable";
> +			};
> +		};
> +
> +		sysctrl: system-controller at 12020000 {
> +			compatible = "hisilicon,hi3519-sysctrl", "syscon";
> +			reg = <0x12020000 0x1000>;
> +		};
> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&sysctrl>;
> +			offset = <0x4>;
> +			mask = <0xdeadbeef>;
> +		};
> +
> +		crg: clock-reset-controller at 12010000 {
> +			compatible = "hisilicon,hi3519-crg";
> +			#clock-cells = <1>;
> +			#reset-cells = <2>;
> +			reg = <0x12010000 0x10000>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
