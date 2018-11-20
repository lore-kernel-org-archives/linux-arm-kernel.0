From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:55:36 +0100
Subject: [RFC PATCH v2 13/14] ARM: dts: suniv: add initial DTSI file for
 F1C100s
In-Reply-To: <b1cc86d5330df59e75914ab3c3a773900b589455.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <b1cc86d5330df59e75914ab3c3a773900b589455.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120085536.gulglvm7dvlckzle@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 05:17:12PM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
> initial DTSI for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilnc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 158 +++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> new file mode 100644
> index 0000000..d98f658
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +/*
> + * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
> + */
> +
> +#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
> +#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&intc>;
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		osc24M: clk-24M {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +			clock-output-names = "osc24M";
> +		};
> +
> +		osc32k: clk-32k {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +			clock-output-names = "osc32k";
> +		};
> +
> +		fake100M: clk-100M {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <100000000>;
> +			clock-output-names = "fake-100M";
> +		};

Why do you need that fake clock?

> +	};
> +
> +	cpus {
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +
> +		cpu {
> +			compatible = "arm,arm926ej-s";
> +			device_type = "cpu";
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		sram-controller at 1c00000 {
> +			compatible = "allwinner,sun4i-a10-sram-controller";

You should have a compatible for that SoC there (possibly keeping the
A10 compatible if that makes sense).

> +			reg = <0x01c00000 0x30>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_d: sram at 10000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00010000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00010000 0x1000>;
> +
> +				otg_sram: sram-section at 0 {
> +					compatible = "allwinner,sun4i-a10-sram-d";

Ditto

> +					reg = <0x0000 0x1000>;
> +					status = "disabled";
> +				};
> +			};
> +		};
> +
> +		ccu: clock at 1c20000 {
> +			compatible = "allwinner,suniv-f1c100s-ccu";
> +			reg = <0x01c20000 0x400>;
> +			clocks = <&osc24M>, <&osc32k>;
> +			clock-names = "hosc", "losc";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		intc: interrupt-controller at 1c20400 {
> +			compatible = "allwinner,suniv-f1c100s-ic";
> +			reg = <0x01c20400 0x400>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		pio: pinctrl at 1c20800 {
> +			compatible = "allwinner,suniv-f1c100s-pinctrl";
> +			reg = <0x01c20800 0x400>;
> +			interrupts = <38>, <39>, <40>;
> +			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
> +			clock-names = "apb", "hosc", "losc";
> +			gpio-controller;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#gpio-cells = <3>;
> +
> +			uart0_pins_a: uart-pins-pe {
> +				pins = "PE0", "PE1";
> +				function = "uart0";
> +			};
> +		};
> +
> +		timer at 1c20c00 {
> +			compatible = "allwinner,suniv-f1c100s-timer";
> +			reg = <0x01c20c00 0x90>;
> +			interrupts = <13>;
> +			clocks = <&osc24M>;
> +		};
> +
> +		wdt: watchdog at 1c20ca0 {
> +			compatible = "allwinner,sun6i-a31-wdt";

Ditto.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/05545ac8/attachment-0001.sig>
