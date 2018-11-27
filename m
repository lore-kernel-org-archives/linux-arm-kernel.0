From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:59:58 +0100
Subject: [RFC PATCH v4 16/17] ARM: dts: suniv: add initial DTSI file for
 F1C100s
In-Reply-To: <3a0db6052d58eb440ea29772fc7ad2502a1dfa3b.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <3a0db6052d58eb440ea29772fc7ad2502a1dfa3b.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <20181127095958.vxyymf63ehdyem4z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2018 at 10:43:19AM +0300, Mesih Kilinc wrote:
> F1C100s is one product with the suniv die, which has a 32MiB co-packaged
> DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
> initial DTSI for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 147 +++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> new file mode 100644
> index 0000000..11bc999
> --- /dev/null
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -0,0 +1,147 @@
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
> +			compatible = "allwinner,suniv-f1c100s-system-control",
> +				     "allwinner,sun4i-a10-system-control";
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
> +					compatible = "allwinner,suniv-f1c100s-sram-d",
> +						     "allwinner,sun4i-a10-sram-d";
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

The dt bindings headers and those DT are going to be merged through
separate trees, so you can't use these defines yet. Please use the
actual numbers in the DT for now, and send a patch fixing this when
4.21-rc1 will be out.

> +			clock-names = "apb", "hosc", "losc";
> +			gpio-controller;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#gpio-cells = <3>;
> +
> +			uart0_pins_a: uart-pins-pe {

This would be uart0_pe_pins: uart0-pe-pins.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/3c90d43b/attachment.sig>
