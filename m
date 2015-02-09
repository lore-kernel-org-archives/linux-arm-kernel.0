From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 9 Feb 2015 12:02:05 +0000
Subject: [PATCH 2/3] arm64, ft-1500a: Add initial dts for Phytium
 FT-1500A SoC
In-Reply-To: <1423285636-8623-3-git-send-email-cbz@baozis.org>
References: <1423285636-8623-1-git-send-email-cbz@baozis.org>
 <1423285636-8623-3-git-send-email-cbz@baozis.org>
Message-ID: <20150209120205.GE4250@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 07, 2015 at 05:07:15AM +0000, Chen Baozi wrote:
> Add initial device tree nodes for Phytium FT-1500A SoC with support of
> 16 cores, gicv3 interrupt controller, serial port, PCIe host and
> on-chip GMAC ethernet controller.
> 
> Signed-off-by: Chen Baozi <chenbaozi@kylinos.com.cn>
> ---
>  arch/arm64/boot/dts/Makefile                      |   1 +
>  arch/arm64/boot/dts/phytium/Makefile              |   5 +
>  arch/arm64/boot/dts/phytium/ft-1500a.dtsi         | 269 ++++++++++++++++++++++
>  arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts |  39 ++++
>  4 files changed, 314 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/phytium/Makefile
>  create mode 100644 arch/arm64/boot/dts/phytium/ft-1500a.dtsi
>  create mode 100644 arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index c62b0f4..e7e9e3d 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -2,5 +2,6 @@ dts-dirs += amd
>  dts-dirs += apm
>  dts-dirs += arm
>  dts-dirs += cavium
> +dts-dirs += phytium
>  
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/phytium/Makefile b/arch/arm64/boot/dts/phytium/Makefile
> new file mode 100644
> index 0000000..12a22c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_PHYTIUM) += ft1500a-v2-dsk-v2.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/phytium/ft-1500a.dtsi b/arch/arm64/boot/dts/phytium/ft-1500a.dtsi
> new file mode 100644
> index 0000000..9005389
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/ft-1500a.dtsi
> @@ -0,0 +1,269 @@
> +/*
> + * DTS file for Phytium FT-1500A SoC
> + *
> + * Copyright (C) 2015, Phytium Technology Co., Ltd.
> + *
> + * This file is licensed under a dual GPLv2 or BSD license.
> + */
> +
> +/memreserve/    0x80000000 0x100000;

Please add a comment describing what this protects. It looks like it's
for the spin-table implementation?

> +/ {
> +	compatible = "phytium,ft-1500a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};

No serial aliases? With a serial0 alias here, it would allow you to
have: /chosen/stdout-path = "serial0:${RATE}";

That would make the user's experience with serial _far_ nicer as the
rate would be guaranteed to be consistent, and you can get earlycon
really easily.

> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";

Please prepend the compatible string for the actual CPU you are using.

> +			reg = <0x0 0x000>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x8007fff0>;
> +		};

It's a shame that you are using spin-table. Is there no chance of PSCI?

It's also a great shame that every CPU shares the same release address;
it was a mistake that we made with the early model bringup, and not
something that should be copied where possible to avoid.

[...]

> +		cpu at 15 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x303>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x8007fff0>;
> +		};

The unit-address should match the reg, so this should be cpu at 303
(likewise the other CPU nodes need to be updated).

> +	};
> +
> +	gic: interrupt-controller at 29800000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +		reg = <0x0 0x29800000 0 0x10000>,	/* GICD */
> +		      <0x0 0x29a00000 0 0x200000>,	/* GICR */
> +		      <0x0 0x29c00000 0 0x10000>,	/* GICC */
> +		      <0x0 0x29c10000 0 0x10000>,	/* GICH */
> +		      <0x0 0x29c20000 0 0x10000>;	/* GICV */
> +		interrupts = <1 9 4>;
> +
> +		its: gic-its at 29820000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0x29820000 0x0 0x20000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 8>,
> +			     <1 14 8>,
> +			     <1 11 8>,
> +			     <1 10 8>;
> +		clock-frequency = <50000000>;

Please fix your firmware to configure CNTFRQ on _all_ CPUs.

Are CPUs booted at EL2, or at EL1?

If you're booting at EL2, virtualisation will not function correctly
unless you configure CNTFRQ.

If you're booting at EL1, you must configure CNTVOFF to a consistent
value on all CPUs.

Where possible, please boot at EL2. It means less work for the
bootloader (as the kernel can configure more CPU state), and shouldn't
result in any overhead.

> +	};
> +
> +	soc {
> +		compatible = "arm,amba-bus", "simple-bus";

This should be either an AMBA bus or a simple-bus, not both.

As far as I can tell, "simple-bus" alone should be sufficient.

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gmac_clk: clk_csr {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <250000000>;
> +		};
> +
> +		uart0: serial at 28000000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x28000000 0x0 0x1000>;
> +			clock-frequency = <50000000>;
> +			interrupts = <0 34 4>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disable";

s/disable/disabled/ (please fix this for other nodes too).

> +		};
> +
> +		uart1: serial at 28001000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x28001000 0x0 0x1000>;
> +			clock-frequency = <50000000>;
> +			interrupts = <0 35 4>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disable";
> +		};
> +
> +		gmac0: ethernet at 28c00000 {
> +			compatible = "snps,dwmac";
> +			reg = <0 0x28c00000 0x0 0x2000>;
> +			interrupts = <0 44 4>;
> +			interrupt-names = "macirq";
> +			clocks = <&gmac_clk>;
> +			clock-names = "stmmaceth";
> +			snps,pbl = <16>;
> +			snps,abl = <32>;
> +			snps,fixed-burst;
> +			snps,force_sf_dma_mode;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <1>;
> +			max-frame-size = <9000>;
> +			status = "disable";
> +		};
> +
> +		gmac1: ethernet at 28c02000 {
> +			compatible = "snps,dwmac";
> +			reg = <0 0x28c02000 0x0 0x2000>;
> +			interrupts = <0 45 4>;
> +			interrupt-names = "macirq";
> +			clocks = <&gmac_clk>;
> +			clock-names = "stmmaceth";
> +			snps,pbl = <16>;
> +			snps,abl = <32>;
> +			snps,fixed-burst;
> +			snps,force_sf_dma_mode;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <1>;
> +			max-frame-size = <9000>;
> +			status = "disable";
> +		};
> +
> +		pcie0: pcie-controller {
> +			compatible = "pci-host-ecam-generic";
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			reg = <0 0x40000000 0 0x10000000>;
> +			dma-coherent;
> +			msi-parent = <&its>;
> +			interrupt-map-mask = <0x0000 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 0x0 0x33 0x4>,
> +					<0x0 0x0 0x0 0x2 &gic 0x0 0x0 0x0 0x34 0x4>,
> +					<0x0 0x0 0x0 0x3 &gic 0x0 0x0 0x0 0x35 0x4>,
> +					<0x0 0x0 0x0 0x4 &gic 0x0 0x0 0x0 0x36 0x4>;
> +			ranges = <0x01000000 0x00 0x00000000 0x00 0x50000000 0x00 0x1000000>,
> +				 <0x02000000 0x00 0x60000000 0x00 0x60000000 0x00 0x20000000>,
> +				 <0x03000000 0x01 0x00000000 0x01 0x00000000 0x01 0x00000000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts b/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts
> new file mode 100644
> index 0000000..7717112
> --- /dev/null
> +++ b/arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts
> @@ -0,0 +1,39 @@
> +/*
> + * DTS file for Phytium FT1500A-V2-DSK-V2 board
> + *
> + * Copyright (C) 2015, Phytium Technology Co., Ltd.
> + *
> + * This file is licensed under a dual GPLv2 or BSD license.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "ft-1500a.dtsi"
> +
> +/ {
> +	model = "Phytium ft1500a-v2-dsk-v2 board";
> +	compatible = "phytium,ft-1500a";
> +
> +	chosen {
> +		linux,pci-probe-only;

We should really update Linux to be able to handle this per root
complex. It's not so much something we've chosen taht the kernel should
do so much as a fundamental property of the integration of the root
complex in the system.

As mentioned above, it would be good to have stdout-path set here.

Thanks,
Mark.

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;	/* Updated by bootloader */
> +	};
> +};
> +
> +&uart1 {
> +	status = "ok";
> +};
> +
> +&gmac0 {
> +	phy-mode = "gmii";
> +	status = "ok";
> +};
> +
> +&gmac1 {
> +	phy-mode = "gmii";
> +	status = "ok";
> +};
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
