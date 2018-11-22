From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 09:43:48 +0100
Subject: [RFC PATCH v3 16/17] ARM: dts: suniv: add initial DTSI file for
 F1C100s
In-Reply-To: <05dab577154c72117678c2f49ae85a9663a630e2.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <05dab577154c72117678c2f49ae85a9663a630e2.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <20181122084348.fls7th5psdqulncl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 09:30:49PM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
> initial DTSI for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilnc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 151 +++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> new file mode 100644
> index 0000000..3ad64ee
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -0,0 +1,151 @@
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
> +	};
> +
> +	cpus {
> +		#address-cells = <0>;
> +		#size-cells = <0>;

I don't think you need those two properties (and the for the clocks as
well). Ideally, if you could compile the dtbs with W=1, and fix any
warning, that would be awesome. We're trying to get rid of them, so
let's not add some new ones.

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
> +			compatible = "allwinner,suniv-f1c100s-system-control";
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
> +					compatible = "allwinner,suniv-f1c100s-sram-d";
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
> +			compatible = "allwinner,suniv-f1c100s-wdt";

If you don't have any difference with the A31 watchdog (and this is
the same case for the A10 system controller and SRAM's), you can just have

compatible = "allwinner,suniv-f1c100s-wdt", "allwinner,sun6i-a31-wdt";

This way, you don't have to patch the driver to add the compatible, it
will fall back to the A31 one (just make sure to document this
properly in the binding doc, you can follow the A64 example).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/8356a335/attachment.sig>
