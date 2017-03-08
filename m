From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 17:31:46 +0100
Subject: [PATCH 3/3] arm64: dts: Add support for FSL's LS1088A SoC
In-Reply-To: <1486638261-10070-1-git-send-email-harninder.rai@nxp.com>
References: <1486638261-10070-1-git-send-email-harninder.rai@nxp.com>
Message-ID: <20170308163145.GF19934@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 04:34:21PM +0530, Harninder Rai wrote:
> LS1088A contains eight ARM v8 CortexA53 processor cores
> with 32 KB L1-D cache and 32 KB L1-I cache
> 
> Features summary
>  Eight 32-bit / 64-bit ARM v8 Cortex-A53 CPUs
>   - Arranged as two clusters of four cores sharing a 1 MB L2 cache
>   - Speed Up to 1.5 GHz
>   - Support for cluster power-gating.
>  Cache coherent interconnect (CCI-400)
>   - Hardware-managed data coherency
>   - Up to 700 MHz
>  One 64-bit DDR4 SDRAM memory controller with ECC
>  Data path acceleration architecture 2.0 (DPAA2)
>  Three PCIe 3.0 controllers
>  One serial ATA (SATA 3.0) controller
>  Three high-speed USB 3.0 controllers with integrated PHY
> 
>  Following levels of DTSI/DTS files have been created for the LS1088A
>   SoC family:
> 
>          - fsl-ls1088a.dtsi:
>                  DTS-Include file for NXP LS1088A SoC.
> 
>          - fsl-ls1088a-qds.dts:
>                  DTS file for NXP LS1088A QDS board.
> 
>          - fsl-ls1088a-rdb.dts:
>                  DTS file for NXP LS1088A RDB board
> 
> Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 102 ++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  86 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 234 ++++++++++++++++++++++
>  4 files changed, 424 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 39db645..cdf7307 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -5,6 +5,8 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
> new file mode 100644
> index 0000000..de0604a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
> @@ -0,0 +1,102 @@
> +/*
> + * Device Tree file for NXP LS1088a QDS Board
> + *
> + * Copyright 2017 NXP
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

Would you please consider to use GPL/X11 dual licence like other files
in arch/arm64/boot/dts/freescale?

> +
> +/dts-v1/;
> +
> +#include "fsl-ls1088a.dtsi"
> +
> +/ {
> +	model = "LS1088A QDS Board";
> +	compatible = "fsl,ls1088a-qds", "fsl,ls1088a";
> +};
> +
> +&ifc {
> +	status = "disabled";

If this is an interface device which may or may not be available on
particular board design, we should have it disabled by default in
<soc>.dtsi, and enable it in <board>.dts as per board design.

> +};
> +
> +&i2c0 {
> +	status = "okay";

Have a newline between property list and child node.

> +	pca9547 at 77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			ina220 at 40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +
> +			ina220 at 41 {
> +				compatible = "ti,ina220";
> +				reg = <0x41>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			rtc at 51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +				/* IRQ10_B */
> +				interrupts = <0 150 0x4>;
> +			};
> +
> +			eeprom at 56 {
> +				compatible = "atmel,24c512";
> +				reg = <0x56>;
> +			};
> +
> +			eeprom at 57 {
> +				compatible = "atmel,24c512";
> +				reg = <0x57>;
> +			};
> +
> +			temp-sensor at 4c {
> +				compatible = "adi,adt7461a";
> +				reg = <0x4c>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	status = "disabled";
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	status = "disabled";
> +};

These I2C devices are already disabled by default in fsl-ls1088a.dtsi.

> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> new file mode 100644
> index 0000000..c825a8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -0,0 +1,86 @@
> +/*
> + * Device Tree file for NXP LS1088a RDB board
> + *
> + * Copyright 2017 NXP
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1088a.dtsi"
> +
> +/ {
> +	model = "L1088A RDB Board";
> +	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
> +};
> +
> +&ifc {
> +	status = "disabled";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	pca9547 at 77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			ina220 at 40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			rtc at 51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +				/* IRQ10_B */
> +				interrupts = <0 150 0x4>;
> +			};
> +
> +			adt7461a at 4c {

temp-sensor

> +				compatible = "adt7461a";

"adi,adt7461a"

> +				reg = <0x4c>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	status = "disabled";
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	status = "disabled";
> +};
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> new file mode 100644
> index 0000000..da2f864
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -0,0 +1,234 @@
> +/*
> + * Device Tree Include file for NXP Layerscape-1088A family SoC.
> + *
> + * Copyright 2017 NXP
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "fsl,ls1088a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* We have 2 clusters having 4 Cortex-A53 cores each */
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			clocks = <&clockgen 1 0>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			clocks = <&clockgen 1 0>;
> +		};
> +
> +		cpu2: cpu at 2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			clocks = <&clockgen 1 0>;
> +		};
> +
> +		cpu3: cpu at 3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			clocks = <&clockgen 1 0>;
> +		};
> +
> +		cpu4: cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			clocks = <&clockgen 1 1>;
> +		};
> +
> +		cpu5: cpu at 101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			clocks = <&clockgen 1 1>;
> +		};
> +
> +		cpu6: cpu at 102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			clocks = <&clockgen 1 1>;
> +		};
> +
> +		cpu7: cpu at 103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			clocks = <&clockgen 1 1>;
> +		};
> +	};
> +
> +	gic: interrupt-controller at 6000000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> +		      <0x0 0x06100000 0 0x100000>, /* GICR(RD_base+SGI_base)*/
> +		      <0x0 0x0c0c0000 0 0x2000>, /* GICC */
> +		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
> +		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
> +		interrupts = <1 9 0x4>;
> +	};
> +
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clockgen: clocking at 1300000 {
> +			compatible = "fsl,ls1088a-clockgen";
> +			reg = <0 0x1300000 0 0xa0000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
> +		};
> +
> +		duart0: serial at 21c0500 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21c0500 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		duart1: serial at 21c0600 {
> +			compatible = "fsl,ns16550", "ns16550a";
> +			reg = <0x0 0x21c0600 0x0 0x100>;
> +			clocks = <&clockgen 4 3>;
> +			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio at 2300000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2300000 0x0 0x10000>;
> +			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio1: gpio at 2310000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2310000 0x0 0x10000>;
> +			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio2: gpio at 2320000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2320000 0x0 0x10000>;
> +			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gpio3: gpio at 2330000 {
> +			compatible = "fsl,qoriq-gpio";
> +			reg = <0x0 0x2330000 0x0 0x10000>;
> +			interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		ifc: ifc at 2240000 {
> +			compatible = "fsl,ifc", "simple-bus";
> +			reg = <0x0 0x2240000 0x0 0x20000>;
> +			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
> +			little-endian;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0 0x5 0x80000000 0x08000000
> +				  2 0 0x5 0x30000000 0x00010000
> +				  3 0 0x5 0x20000000 0x00010000>;
> +			};
> +
> +		i2c0: i2c at 2000000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2000000 0x0 0x10000>;
> +			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at 2010000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2010000 0x0 0x10000>;
> +			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at 2020000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2020000 0x0 0x10000>;
> +			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c at 2030000 {
> +			compatible = "fsl,vf610-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2030000 0x0 0x10000>;
> +			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;
> +			status = "disabled";
> +		};
> +
> +		sata0: sata at 3200000 {
> +			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>;
> +			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 3>;

status = "disabled";

> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
> +			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
> +			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
> +			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
> +	};

Can we move this forward, probably around gic node?

Shawn

> +};
> -- 
> 2.7.4
> 
