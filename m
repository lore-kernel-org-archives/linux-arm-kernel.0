From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Jul 2015 10:06:38 +0200
Subject: [PATCH v4 1/2] arm64: dts: Add dts files for Marvell Berlin4CT SoC
In-Reply-To: <1437557992-7111-2-git-send-email-jszhang@marvell.com>
References: <1437557992-7111-1-git-send-email-jszhang@marvell.com>
 <1437557992-7111-2-git-send-email-jszhang@marvell.com>
Message-ID: <55B9DB0E.7010303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 11:39 AM, Jisheng Zhang wrote:
> Add initial dtsi file to support Marvell Berlin4CT SoC with
> quad Cortex-A53 CPUs.
>
> It also adds dts file for Marvell Berlin4CT DMP board which is
> based on Berlin4CT SoC.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
[...]
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
> new file mode 100644
> index 0000000..d1152c0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Author: Jisheng Zhang <jszhang@marvell.com>
[...]
> +/ {

Jisheng,

before I take this series, some nitpicking.

> +	model = "MARVELL BG4CT DMP BOARD";

Are you fine with fixing the broken CAPSLOCK key, i.e. make above
"Marvell BG4CT DMP board" ?

> +	compatible = "marvell,berlin4ct-dmp", "marvell,berlin4ct", "marvell,berlin";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		/* the first 16MB is for firmwares's usage */
> +		reg = <0 0x01000000 0 0x80000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> new file mode 100644
> index 0000000..becaedc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -0,0 +1,164 @@
> +/*
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Author: Jisheng Zhang <jszhang@marvell.com>
[...]
> +
> +/ {
> +	compatible = "marvell,berlin";

compatible = "marvell,berlin4ct", "marvell,berlin";

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
[...]
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0xf7000000 0x1000000>;
> +
> +		osc: osc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;
> +		};

Is the oscillator above really part of the SoC bus fabric? If 25MHz is
the only option for an external OSC, I suggest to move it at least out
of the soc {} node.

Sebastian

> +		gic: interrupt-controller at 901000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x901000 0x1000>,
> +			      <0x902000 0x2000>,
> +			      <0x904000 0x2000>,
> +			      <0x906000 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb at fc0000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xfc0000 0x10000>;
> +			interrupt-parent = <&sic>;
> +
> +			sic: interrupt-controller at 1000 {
> +				compatible = "snps,dw-apb-ictl";
> +				reg = <0x1000 0x30>;
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			uart0: uart at d000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0xd000 0x100>;
> +				interrupts = <8>;
> +				clocks = <&osc>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
>
