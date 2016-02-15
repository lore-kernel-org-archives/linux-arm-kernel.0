From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 09:32:08 +0000
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <56C19B18.8090005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 15/02/16 08:47, Thomas Petazzoni wrote:
> This commit adds the base Device Tree files for the Armada 7K and 8K
> SoCs, as well as the Armada 8040 DB board.
> 
> The Armada 7020, 7040 (7K family) and 8020, 8040 (8K family) are
> composed of:
> 
>  - An AP806 block that contains the CPU core and a few basic
>    peripherals. The AP806 is available in dual core configurations
>    (used in 7020 and 8020) and quad core configurations (used in 8020
>    and 8040).
> 
>  - One or two CP110 blocks that contain all the high-speed interfaces
>    (SATA, PCIe, Ethernet, etc.). The 7K family chips have one CP110,
>    and the 8K family chips have two CP110, giving them twice the
>    number of HW interfaces.
> 
> In order to represent this from a Device Tree point of view, this
> commit creates the following hierarchy:
> 
>  * armada-ap806.dtsi - definitions common to dual/quad ap806
>    * armada-ap806-dual.dtsi - description of the two CPUs
>      * armada-7020.dtsi - description of the 7020 SoC
>      * armada-8020.dtsi - description of the 8020 SoC
>    * armada-ap806-quad.dtsi - description of the four CPUs
>      * armada-7040.dtsi - description of the 7040 SoC
>        * armada-7040-db.dts - description of the 7040 board
>      * armada-8040.dtsi - description of the 8040 SoC
> 
> The CP110 blocks are not described yet, and will be part of future
> patch series.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../bindings/arm/marvell/armada-7k-8k.txt          |  24 +++
>  arch/arm64/boot/dts/marvell/Makefile               |   1 +
>  arch/arm64/boot/dts/marvell/armada-7020.dtsi       |  54 +++++
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  92 ++++++++
>  arch/arm64/boot/dts/marvell/armada-7040.dtsi       |  54 +++++
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  54 +++++
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       |  54 +++++
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  71 +++++++
>  arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  84 ++++++++
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 235 +++++++++++++++++++++
>  10 files changed, 723 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-7020.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-db.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-7040.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8020.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-8040.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> 

[...[

> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> new file mode 100644
> index 0000000..3303db2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -0,0 +1,235 @@
> +/*
> + * Copyright (C) 2016 Marvell Technology Group Ltd.
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
> +/*
> + * Device Tree file for Marvell Armada AP806.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "Marvell Armada AP806";
> +	compatible = "marvell,armada-ap806";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +
> +	ap806 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		config-space {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			ranges = <0x0 0x0 0xf0000000 0x1000000>;
> +
> +			gic: interrupt-controller at 210000 {
> +				compatible = "arm,cortex-a15-gic",
> +					     "arm,cortex-a9-gic";
> +				#interrupt-cells = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges;
> +				interrupt-controller;
> +				interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +				reg = <0x210000 0x1000>,
> +				      <0x220000 0x1000>,

Assuming we do have a GIC400 here (which is extremely likely), the GICC
block should be at least 8kB to reflect the fact that this is a GICv2.

> +				      <0x240000 0x2000>,
> +				      <0x260000 0x2000>;
> +
> +				gic_v2m0: v2m at 280000 {
> +					compatible = "arm,gic-v2m-frame";
> +					msi-controller;
> +					reg = <0x280000 0x1000>;
> +					arm,msi-base-spi = <160>;
> +					arm,msi-num-spis = <32>;
> +				};
> +				gic_v2m1: v2m at 290000 {
> +					compatible = "arm,gic-v2m-frame";
> +					msi-controller;
> +					reg = <0x290000 0x1000>;
> +					arm,msi-base-spi = <192>;
> +					arm,msi-num-spis = <32>;
> +				};
> +				gic_v2m2: v2m at 2a0000 {
> +					compatible = "arm,gic-v2m-frame";
> +					msi-controller;
> +					reg = <0x2a0000 0x1000>;
> +					arm,msi-base-spi = <224>;
> +					arm,msi-num-spis = <32>;
> +				};
> +				gic_v2m3: v2m at 2b0000 {
> +					compatible = "arm,gic-v2m-frame";
> +					msi-controller;
> +					reg = <0x2b0000 0x1000>;
> +					arm,msi-base-spi = <256>;
> +					arm,msi-num-spis = <32>;
> +				};
> +			};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
