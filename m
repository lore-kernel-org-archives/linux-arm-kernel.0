From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Aug 2017 19:14:14 -0500
Subject: [PATCH] arm64: dts: Add support for NXP's LX2160A SoC
In-Reply-To: <1503053736-18232-1-git-send-email-sriram.dash@nxp.com>
References: <1503053736-18232-1-git-send-email-sriram.dash@nxp.com>
Message-ID: <20170823001414.ovvgwqhwvisuqea2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 04:25:36PM +0530, Sriram Dash wrote:
> The QorIQ LX2160A processor is built in the 16FFC process on
> the Layerscape architecture combining sixteen ARM A72 processor
> cores with advanced, high-performance datapath acceleration and
> network, peripheral interfaces required for networking, wireless
> infrastructure, storage, and general-purpose embedded applications.
> 
> Features summary:
>     - Sixteen 32-bit / 64-bit ARM v8 A72 CPUs
>     - Cache Coherent Interconnect Fabric (CCN508 aka ?Eliot?)
>     - Two 64-bit 3.2GT/s DDR4 SDRAM memory controllers with ECC.
>     - Data path acceleration architecture (DPAA2)
>     - 24 Serdes lanes at up to 25 GHz
>     - Ethernet interfaces
>       Single WRIOP tile supporting 130Gbps using 18 MACs
>       Support for 10G-SXGMII (aka USXGMII).
>       Support for SGMII (and 1000Base-KX)
>       Support for XFI (and 10GBase-KR)
>       Support for CAUI4 (100G); CAUI2 (50G) and 25G-AUI(25G).
>       Support for XLAUI4 (and 40GBase-KR4) for 40G.
>       Support for two RGMII parallel interfaces.
>       Energy efficient Ethernet support (802.3az)
>       IEEE 1588 support.
>     - High-speed peripheral interfaces
>       Two PCIe Gen 4.0 8-lane controllers supporting SR-IOV,
>       Four PCIe Gen 4.0 4-lane controllers.
>       Four serial ATA (SATA 3.0) controllers.
>       Two USB 3.0 controllers with integrated PHY
>       Two Enhanced secure digital host controllers
>       Two Controller Area Network (CAN) modules
>       Flexible Serial peripheral interface (FlexSPI) controller.
>       Three Serial peripheral interface (SPI) controllers.
>       Nine I2C Controllers.
>       Four UARTs supporting two 4-pin UART ports or four 2-pin UART ports.
>       General Purpose IO (GPIO)
>     - Support for hardware virtualization and partitioning (ARM MMU-500)
>     - Support for GIC (ARM GIC-500)
>     - QorIQ platform Trust Architecture 3.0
>     - One Secure WatchDog timer and one Non-Secure Watchdog timer.
>     - ARM Generic Timer
>     - Two Flextimers
>     - Debug supporting run control, data acquisition, high-speed trace,
>       performance/event monitoring
>     - Thermal Monitor Unit (TMU) with +/- 2C accuracy
>     - Support for Voltage ID (VID) for yield improvement
> 
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt  |   8 +
>  arch/arm64/boot/dts/freescale/Makefile         |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 240 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2qds1.dts  |  54 ++++++
>  4 files changed, 303 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2qds1.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index cdb9dd7..6069434 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -218,3 +218,11 @@ Required root node properties:
>  LS2088A ARMv8 based RDB Board
>  Required root node properties:
>      - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
> +
> +LX2160A SoC
> +Required root node properties:
> +    - compatible = "fsl,lx2160a";
> +
> +LX2160A ARMv8 based QDS Board
> +Required root node properties:
> +    - compatible = "fsl,lx2qds1", "fsl,lx2160a";
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 72c4b52..634f6d4 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2qds1.dtb
>   
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> new file mode 100644
> index 0000000..48874cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -0,0 +1,240 @@
> +/*
> + * Device Tree Include file for Layerscape-LX2160A family SoC.
> + *
> + * Copyright 2017 NXP
> + *
> + * Sriram Dash <sriram.dash@nxp.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPLv2 or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +	compatible = "fsl,lx2160a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* We have 8 clusters having 2 Cortex-A72 cores each */
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x0>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x1>;
> +		};
> +
> +		cpu at 100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x100>;
> +		};
> +
> +		cpu at 101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x101>;
> +		};
> +
> +		cpu at 200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x200>;
> +		};
> +
> +		cpu at 201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x201>;
> +		};
> +
> +		cpu at 300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x300>;
> +		};
> +
> +		cpu at 301 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x301>;
> +		};
> +
> +		cpu at 400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x400>;
> +		};
> +
> +		cpu at 401 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x401>;
> +		};
> +
> +		cpu at 500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x500>;
> +		};
> +
> +		cpu at 501 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x501>;
> +		};
> +
> +		cpu at 600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x600>;
> +		};
> +
> +		cpu at 601 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x601>;
> +		};
> +
> +		cpu at 700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x700>;
> +		};
> +
> +		cpu at 701 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x701>;
> +		};
> +
> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0 0x80000000>;
> +		      /* DRAM space - 1, size : 2 GB DRAM */
> +	};
> +
> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	gic: interrupt-controller at 6000000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> +		      <0x0 0x06200000 0 0x200000>, /*GICR(RD_base + SGI_base)*/
> +		      <0x0 0x0c0c0000 0 0x2000>, /* GICC */
> +		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
> +		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;

Both of these can be 1.

> +		ranges;

It's preferred to have a value here.

> +		interrupt-controller;
> +		interrupts = <1 9 0x4>;
> +
> +		its: gic-its at 6020000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0x6020000 0 0x20000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
> +			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
> +			     <1 11 4>, /* Virtual PPI, active-low */
> +			     <1 10 4>; /* Hypervisor PPI, active-low */
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

These can be 1 if the I/O devices fit into 4GB space.

> +		ranges;
> +
> +		uart0: serial at 21c0000 {
> +			device_type = "serial";
> +			compatible = "arm,pl011","arm,sbsa-uart";
> +			reg = <0x0 0x21c0000 0x0 0x1000>;
> +			interrupts = <0 32 0x4>;
> +			current-speed = <115200>;
> +		};
> +
> +		uart1: serial at 21d0000 {
> +			device_type = "serial";
> +			compatible = "arm,pl011","arm,sbsa-uart";
> +			reg = <0x0 0x21d0000 0x0 0x1000>;
> +			interrupts = <0 33 0x4>;
> +			current-speed = <115200>;
> +		};
> +
> +		uart2: serial at 21e0000 {
> +			device_type = "serial";
> +			compatible = "arm,pl011","arm,sbsa-uart";
> +			reg = <0x0 0x21e0000 0x0 0x1000>;
> +			interrupts = <0 72 0x4>;
> +			current-speed = <115200>;
> +		};
> +
> +		uart3: serial at 21f0000 {
> +			device_type = "serial";
> +			compatible = "arm,pl011","arm,sbsa-uart";
> +			reg = <0x0 0x21f0000 0x0 0x1000>;
> +			interrupts = <0 73 0x4>;
> +			current-speed = <115200>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2qds1.dts b/arch/arm64/boot/dts/freescale/fsl-lx2qds1.dts
> new file mode 100644
> index 0000000..0a8f525
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2qds1.dts
> @@ -0,0 +1,54 @@
> +/*
> + * Device Tree file for LX2 QDS1 Board
> + *
> + * Copyright 2017 NXP
> + *
> + * Sriram Dash <sriram.dash@nxp.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape LX2 QDS1 Board";
> +	compatible = "fsl,lx2qds1", "fsl,lx2160a";
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
