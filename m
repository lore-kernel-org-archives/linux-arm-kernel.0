From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 13 Mar 2014 10:05:31 +0000
Subject: [PATCH 1/2] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
 (BG2Q) device tree
In-Reply-To: <1394622364-6848-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394622364-6848-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <532182EB.7090002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 11:06 AM, Antoine T?nart wrote:
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Missed some comments on the nodes below.

[...]
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> new file mode 100644
> index 000000000000..f58c9c64c60e
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright (C) 2014 Antoine T?nart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 1500 pro (BG2-Q) SoC";
> +	compatible = "marvell,berlin2q", "marvell,berlin";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <0>;
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <1>;
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <2>;
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			next-level-cache = <&l2>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;

You are not numbering the clocks below. Shouldn't this be

#address-cells = <0>;
#size-cells = <0>;

then?

> +
> +		smclk: sysmgr-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;
> +		};
> +
> +		sysclk: system-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		ranges = <0 0xf7000000 0x1000000>;
> +		interrupt-parent = <&gic>;
> +
> +		l2: l2-cache-controller at ac0000 {
> +			compatible = "arm,pl310-cache";
> +			reg = <0xac0000 0x1000>;
> +			cache-level = <2>;
> +		};
> +
> +		gic: interrupt-controller at ad1000 {
> +			compatible = "arm,cortex-a9-gic";
> +			reg = <0xad1000 0x1000>, <0xad0100 0x100>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +
> +		local-timer at ad0600 {

Please keep nodes sorted by address.

> +			compatible = "arm,cortex-a9-twd-timer";
> +			reg = <0xad0600 0x20>;
> +			clocks = <&sysclk>;

Playing with Chromecast, I remember local-timer running at sysclk/3 or
something. I know berlin2/berlin2cd is wrong here. Can you check that
for berlin2q local-timer also runs at sysclk/n?

> +			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";
> +		};
> +
> +		apb at e80000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0xe80000 0x10000>;
> +			interrupt-parent = <&aic>;
> +
> +			timer0: timer at 2c00 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c00 0x14>;
> +				interrupts = <8>;
> +				clock-freq = <100000000>;
> +				status = "okay";
> +			};
> +
> +			timer1: timer at 2c14 {
> +				compatible = "snps,dw-apb-timer";
> +				reg = <0x2c14 0x14>;
> +				clock-freq = <100000000>;
> +				status = "disabled";
> +			};

berlin2/berlin2cd have a vast amount of 8 apb timers. Any timers missing
here or did Marvell remove them?

> +			aic: interrupt-controller at 3800 {
> +				compatible = "snps,dw-apb-ictl";
> +				reg = <0x3800 0x30>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		apb at fc0000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0xfc0000 0x10000>;
> +			interrupt-parent = <&sic>;
> +
> +			uart0: uart at 9000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x9000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <8>;
> +				clock-frequency = <25000000>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			uart1: uart at a000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0xa000 0x100>;
> +				interrupt-parent = <&sic>;
> +				interrupts = <9>;
> +				clock-frequency = <25000000>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};

Also for uart, can you please double-check if there is no uart2?

Sebastian

> +			sic: interrupt-controller at e000 {
> +				compatible = "snps,dw-apb-ictl";
> +				reg = <0xe000 0x30>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +	};
> +};
>
