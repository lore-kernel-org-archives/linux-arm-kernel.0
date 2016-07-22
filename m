From: oss@buserror.net (Scott Wood)
Date: Fri, 22 Jul 2016 09:29:35 -0500
Subject: [PATCH] [linux-devel]arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1469197775.25630.72.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-22 at 11:05 +0530, Bhaskar Upadhaya wrote:
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 1b7783d..4aa3bee 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -3,6 +3,9 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> ?dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
> ?dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
> ?dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
?
Please keep such lists sorted.

> +&i2c0 {
> +	status = "okay";
> +
> +	codec: sgtl5000 at a {
> +		#sound-dai-cells = <0>;
> +		compatible = "fsl,sgtl5000";
> +		reg = <0xa>;
> +		VDDA-supply = <&reg_1p8v>;
> +		VDDIO-supply = <&reg_1p8v>;
> +		clocks = <&sys_mclk 1>;

sys_mclk is a fixed-clock, with #clock-cells = <0>. ?What is the "1" for?

> +	ethernet at 1 {
> +		compatible = "fsl,pfe-gemac-port";

Binding?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <	0x1 >;	/* GEM_ID */
> +		fsl,gemac-bus-id = < 0x1 >;	/* BUS_ID */
> +		fsl,gemac-phy-id = < 0x1 >;	/* PHY_ID */
> +		fsl,mdio-mux-val = <0x0>;

No spaces inside <>

> +		local-mac-address = [ 00 AA BB CC DD EE ];

No.

> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

simple-bus does not make sense with #size-cells = <0>. ?It's for memory-mapped 
devices.

> +};
> +&ftm0 {

Leave a blank line between nodes.

> +/ {
> +	compatible = "fsl,ls1012a";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		/*
> +		?* We expect the enable-method for cpu's to be "psci", but
> this
> +		?* is dependent on the SoC FW, which will fill this in.
> +		?*
> +		?* Currently supported enable-method is psci v0.2
> +		?*/

Why do you expect any enable-method on a chip with only one CPU?


> +	sysclk: sysclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +		clock-output-names = "sysclk";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 0x1>, /* Physical Secure PPI */
> +			?????<1 14 0x1>, /* Physical Non-Secure PPI */
> +			?????<1 11 0x1>, /* Virtual PPI */
> +			?????<1 10 0x1>; /* Hypervisor PPI */
> +		arm,reread-timer;
> +	};

arm,reread-timer does not belong here.

Please don't blindly copy and paste things, either from one chip to another or
from old deprecated internal stuff.


> +
> +		clockgen: clocking at 1ee1000 {
> +			compatible = "fsl,ls1012a-clockgen","fsl,ls1043a-
> clockgen";
> +			reg = <0x0 0x1ee1000 0x0 0x1000>;
> +			#clock-cells = <2>;
> +			clocks = <&sysclk>;
> +		};

clockgen nodes should not claim compatibility with another SoC. ?The clocking
options on ls1012a are not the same as on ls1043a.


> +
> +		scfg: scfg at 1570000 {
> +			compatible = "fsl,ls1012a-scfg", "fsl,ls1043a-
> scfg", "syscon";
> +			reg = <0x0 0x1570000 0x0 0x10000>;
> +			big-endian;
> +		};

The SCFG on ls1021a is not compatible with ls1043a.

> +		reset: reset at 1EE00B0 {
> +			compatible = "fsl,ls-reset";
> +			reg = <0x0 0x1EE00B0 0x0 0x4>;
> +			big-endian;
> +		};

This was an old internal hack that doesn't belong here.

> +
> +		rcpm: rcpm at 1ee2000 {
> +			compatible = "fsl,ls1012a-rcpm", "fsl,ls1043a-
> rcpm", "fsl,qoriq-rcpm-2.1";
> +			reg = <0x0 0x1ee2000 0x0 0x10000>;

The RCPM on ls1043a has several registers that ls1012a does not have. ?They
are not compatible.

"rcpm-2.1" is probably not appropriate either.

> +		};
> +
> +????????????????ftm0: ftm0 at 29d0000 {
> +????????????????????????compatible = "fsl,ftm-alarm";
> +????????????????????????reg = <0x0 0x29d0000 0x0 0x10000>;
> +????????????????????????interrupts = <0 86 0x4>;
> +????????????????????????big-endian;
> +			rcpm-wakeup = <&rcpm 0x00020000 0x0>;
> +????????????????????????status = "disabled";
> +????????????????};
> +
> +		esdhc0: esdhc at 1560000 {

Whitespace

> +		tmu: tmu at 1f00000 {
> +			compatible = "fsl,qoriq-tmu", "fsl,ls1012a-tmu";

More specific compatibles come first.

> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		pfe_reserved: packetbuffer at 83400000 {
> +			reg = <0 0x83400000 0 0xc00000>;
> +		};
> +	};

Could you explain this reservation?

> +
> +	pfe: pfe at 04000000 {
> +		compatible = "fsl,pfe";
> +		ranges = <0x0 0x00 0x04000000 0xc00000
> +			??0x1 0x00 0x83400000 0xc00000>;
> +		reg =???<0x0 0x90500000 0x0 0x10000>,	/* APB 64K */
> +			<0x0 0x04000000 0x0 0xc00000>,	/* AXI 16M */
> +			<0x0 0x83400000 0x0 0xc00000>,????/* PFE DDR 12M */
> +			<0x0 0x10000000 0x0 0x2000>;	/* OCRAM 8K??*/
> +		fsl,pfe-num-interfaces = < 0x2 >;
> +		interrupts = <0 172 0x4>;
> +		#interrupt-names = "hifirq";
> +		memory-region = <&pfe_reserved>;
> +		fsl,pfe-scfg = <&scfg 0>;

Binding?

> +	};
> +
> +};

Don't put a blank line between these.

-Scott
