From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Sep 2017 16:42:13 -0500
Subject: [PATCH v6 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20170919224001.22284-3-brendanhiggins@google.com>
References: <20170919224001.22284-1-brendanhiggins@google.com>
 <20170919224001.22284-3-brendanhiggins@google.com>
Message-ID: <20170927214213.qjz7qalvvmhpxxmy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 03:40:00PM -0700, Brendan Higgins wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ---
>  .../arm/cpu-enable-method/nuvoton,npcm7xx-smp      |  42 ++++
>  .../devicetree/bindings/arm/npcm/npcm.txt          |   6 +
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |  48 +++++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 211 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clks.h   |  39 ++++
>  5 files changed, 346 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp
> new file mode 100644
> index 000000000000..e81f85b400cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm7xx-smp
> @@ -0,0 +1,42 @@
> +=========================================================
> +Secondary CPU enable-method "nuvoton,npcm7xx-smp" binding
> +=========================================================
> +
> +To apply to all CPUs, a single "nuvoton,npcm7xx-smp" enable method should be
> +defined in the "cpus" node.
> +
> +Enable method name:	"nuvoton,npcm7xx-smp"
> +Compatible machines:	"nuvoton,npcm750"
> +Compatible CPUs:	"arm,cortex-a9"
> +Related properties:	(none)
> +
> +Note:
> +This enable method needs valid nodes compatible with "arm,cortex-a9-scu" and
> +"nuvoton,npcm750-gcr".
> +
> +Example:
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "nuvoton,npcm7xx-smp";
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			clocks = <&clk NPCM7XX_CLK_CPU>;
> +			clock-names = "clk_cpu";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			clocks = <&clk NPCM7XX_CLK_CPU>;
> +			clock-names = "clk_cpu";
> +			reg = <1>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> new file mode 100644
> index 000000000000..2d87d9ecea85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> @@ -0,0 +1,6 @@
> +NPCM Platforms Device Tree Bindings
> +-----------------------------------
> +NPCM750 SoC
> +Required root node properties:
> +	- compatible = "nuvoton,npcm750";
> +
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> new file mode 100644
> index 000000000000..a0675e584125
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> @@ -0,0 +1,48 @@
> +/*
> + * DTS file for all NPCM750 SoCs
> + *
> + * Copyright 2012 Tomer Maimon <tomer.maimon@nuvoton.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "nuvoton-npcm750.dtsi"
> +
> +/ {
> +	model = "Nuvoton npcm750 Development Board (Device Tree)";
> +	compatible = "nuvoton,npcm750";
> +
> +	chosen {
> +		stdout-path = &serial3;
> +	};
> +
> +	memory {
> +		reg = <0 0x40000000>;
> +	};
> +};
> +
> +&watchdog1 {
> +	status = "okay";
> +};
> +
> +&serial0 {
> +	status = "okay";
> +};
> +
> +&serial1 {
> +	status = "okay";
> +};
> +
> +&serial2 {
> +	status = "okay";
> +};
> +
> +&serial3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> new file mode 100644
> index 000000000000..5d8a48e44274
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> @@ -0,0 +1,211 @@
> +/*
> + * DTSi file for the NPCM750 SoC
> + *
> + * Copyright 2012 Tomer Maimon <tomer.maimon@nuvoton.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/nuvoton,npcm7xx-clks.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "nuvoton,npcm7xx-smp";
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			clocks = <&clk NPCM7XX_CLK_CPU>;
> +			clock-names = "clk_cpu";
> +			reg = <0>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			clocks = <&clk NPCM7XX_CLK_CPU>;
> +			clock-names = "clk_cpu";
> +			reg = <1>;
> +			next-level-cache = <&l2>;
> +		};
> +	};
> +

> +	gcr: gcr at f0800000 {
> +		compatible = "nuvoton,npcm750-gcr", "syscon",
> +			"simple-mfd";
> +		reg = <0xf0800000 0x1000>;
> +	};
> +
> +	scu: scu at f03fe000 {
> +		compatible = "arm,cortex-a9-scu";
> +		reg = <0xf03fe000 0x1000>;
> +	};
> +
> +	l2: cache-controller at f03fc000 {
> +		compatible = "arm,pl310-cache";
> +		reg = <0xf03fc000 0x1000>;
> +		interrupts = <0 21 4>;
> +		cache-unified;
> +		cache-level = <2>;
> +		clocks = <&clk NPCM7XX_CLK_AXI>;
> +	};
> +
> +	gic: interrupt-controller at f03ff000 {
> +		compatible = "arm,cortex-a9-gic";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		reg = <0xf03ff000 0x1000>,
> +		    <0xf03fe100 0x100>;
> +	};
> +
> +	timer at f03fe600 {
> +		compatible = "arm,cortex-a9-twd-timer";
> +		reg = <0xf03fe600 0x20>;
> +		interrupts = <1 13 0x304>;
> +		clocks = <&clk NPCM7XX_CLK_TIMER>;
> +	};

All these nodes with a memory mapped address should go under a bus node.

> +
> +	ahb {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges = <0x80000000 0x80000000 0x40000000
> +			  0xc0000000 0xc0000000 0x00002000
> +			  0xc0008000 0xc0008000 0x00001000
> +			  0xe0800000 0xe0800000 0x00001000
> +			  0xe1000000 0xe1000000 0x00001000
> +			  0xe8000000 0xe8000000 0x08000000

These addresses don't appear to be used. These are coming later? They 
could be collapsed down into 2 entries.

<0x80000000 0x80000000 0x40010000>
<0xe0800000 0xe0800000 0x0f800000>

> +			  /* APB start */
> +			  0xf0000000 0xf0000000 0x00005000
> +			  0xf0007000 0xf0007000 0x00005000
> +			  0xf0010000 0xf0010000 0x00008000
> +			  0xf0080000 0xf0080000 0x00010000
> +			  0xf009f000 0xf009f000 0x00001000
> +			  0xf0100000 0xf0100000 0x00005000
> +			  0xf0180000 0xf0180000 0x0000b000
> +			  0xf0200000 0xf0200000 0x00002000

Not necessary to be so fine grained and shouldn't just be 1:1. So 
for these just:

<0 0xf0000000 0x00900000>


> +			  /* APB end */
> +			  0xf0800000 0xf0800000 0x000fc000
> +			  0xf8000000 0xf8000000 0x02000000
> +			  0xfb000000 0xfb000000 0x00002000>;

> +
> +		clk: clock-controller at f0801000 {
> +			compatible = "nuvoton,npcm750-clk";
> +			#clock-cells = <1>;
> +			reg = <0xf0801000 0x1000>;

Then this becomes: 0x801000 0x1000

> +			status = "okay";
> +		};
> +
> +		/* external clock signal rg1refck, supplied by the phy */
> +		clk-rg1refck {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <125000000>;
> +		};
> +
> +		/* external clock signal rg2refck, supplied by the phy */
> +		clk-rg2refck {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <125000000>;
> +		};
> +
> +		clk-xin {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +		};

These clocks are not on the bus, so move them out of the bus node to the 
top level.

> +
> +		apb {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			interrupt-parent = <&gic>;
> +			ranges = <0xf0000000 0xf0000000 0x00005000
> +				  0xf0007000 0xf0007000 0x00005000
> +				  0xf0010000 0xf0010000 0x00008000
> +				  0xf0080000 0xf0080000 0x00010000
> +				  0xf009f000 0xf009f000 0x00001000
> +				  0xf0100000 0xf0100000 0x00005000
> +				  0xf0180000 0xf0180000 0x0000b000
> +				  0xf0200000 0xf0200000 0x00002000>;

With above changes this can be just: <0 0 0x300000>

> +
> +			timer0: timer at f0000000 {
> +				compatible = "nuvoton,npcm750-timer";
> +				interrupts = <0 32 4>;
> +				reg = <0xf0000000 0x1000>;
> +				clocks = <&clk NPCM7XX_CLK_TIMER>;
> +			};
> +
> +			watchdog0: watchdog at f0008000 {
> +				compatible = "nuvoton,npcm750-wdt";
> +				interrupts = <0 47 4>;
> +				reg = <0xf0008000 0x1000>;
> +				status = "disabled";
> +				clocks = <&clk NPCM7XX_CLK_TIMER>;
> +			};
> +
> +			watchdog1: watchdog at f0009000 {
> +				compatible = "nuvoton,npcm750-wdt";
> +				interrupts = <0 48 4>;
> +				reg = <0xf0009000 0x1000>;
> +				status = "disabled";
> +				clocks = <&clk NPCM7XX_CLK_TIMER>;
> +			};
> +
> +			watchdog2: watchdog at f000a000 {
> +				compatible = "nuvoton,npcm750-wdt";
> +				interrupts = <0 49 4>;
> +				reg = <0xf000a000 0x1000>;
> +				status = "disabled";
> +				clocks = <&clk NPCM7XX_CLK_TIMER>;
> +			};
> +
> +			serial0: serial0 at f0001000 {

Sorry I miss this earlier, but need to drop the 0 in the node names. 
IOW, should be "serial at f0001000".

> +				compatible = "nuvoton,npcm750-uart";
> +				reg = <0xf0001000 0x1000>;
> +				clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +				interrupts = <0 2 4>;
> +				status = "disabled";
> +			};
> +
> +			serial1: serial1 at f0002000 {
> +				compatible = "nuvoton,npcm750-uart";
> +				reg = <0xf0002000 0x1000>;
> +				clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +				interrupts = <0 3 4>;
> +				status = "disabled";
> +			};
> +
> +			serial2: serial2 at f0003000 {
> +				compatible = "nuvoton,npcm750-uart";
> +				reg = <0xf0003000 0x1000>;
> +				clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +				interrupts = <0 4 4>;
> +				status = "disabled";
> +			};
> +
> +			serial3: serial3 at f0004000 {
> +				compatible = "nuvoton,npcm750-uart";
> +				reg = <0xf0004000 0x1000>;
> +				clocks = <&clk NPCM7XX_CLK_UART_CORE>;
> +				interrupts = <0 5 4>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
