From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 15:26:46 +0100
Subject: [PATCH 7/9] dt: mb86s7x: add dt files for MB86S7x evbs
In-Reply-To: <1416487126-25509-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416487126-25509-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <2581182.ZW92kSfUJp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 20:38:46 Vincent Yang wrote:
> diff --git a/arch/arm/boot/dts/mb86s70eb.dts b/arch/arm/boot/dts/mb86s70eb.dts
> new file mode 100644
> index 0000000..a19c72f
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s70eb.dts
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
> + * Copyright (C) 2014 Linaro Ltd.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +/dts-v1/;
> +
> +#include "mb86s70.dtsi"
> +
> +/ {
> +	model = "Fujitsu MB86S70 EVB";
> +	compatible = "fujitsu,mb86s70-evb";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x80000000 0x80000000>, <0x08 0x80000000 0x80000000>;
> +
> +	};
> +
> +	chosen {
> +		bootargs = "loglevel=8 console=ttyS0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait rw";
> +		linux,initrd-start = <0xc0000000>;
> +		linux,initrd-end =   <0xc0800000>;
> +	};

The initrd parameters seem misplaced here, they should be set by the
boot loader. The loglevel=8 seems to be for debugging only, better
remove that.

> +        vccq_sdhci1: regulator at 0 {
> +                compatible = "regulator-gpio";
> +                regulator-name = "SDHCI1 VccQ";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <3300000>;
> +                gpios = <&gpio0 7 0>;
> +                gpios-states = <1>;
> +                states = <3300000 1
> +                          1800000 0>;
> +        };

This looks whitespace damaged, have you used checkpatch.pl to check your
patch before submitting?

> +	sdhci1: sdio at 36600000 {

I think the node name should be 'mmc'

> +		compatible = "fujitsu,mb86s70-sdh30";
> +		reg = <0 0x36600000 0x1000>;
> +		interrupts = <0 172 0x4>,
> +			     <0 173 0x4>;
> +		voltage-ranges = <1800 1800>, <3300 3300>;
> +		bus-width = <4>;
> +		clocks = <&clk_main_c_0>, <&clk_main_d_0>;
> +		clock-names = "iface", "core";
> +		vqmmc-supply = <&vccq_sdhci1>;
> +	};
> +};

Better move the actual node into the main dtsi file for the chip that
contains it, and add a 'status="disabled" property, then just
do this here:

	&sdhci1 {
		status = "ok";
	};

It probably makes sense to also leave the bus-width and voltage-ranges
properties in the per-board file if they are specific to the attached
device rather than the controller.

> diff --git a/arch/arm/boot/dts/mb86s73eb.dts b/arch/arm/boot/dts/mb86s73eb.dts
> new file mode 100644
> index 0000000..2bb55a3
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s73eb.dts

Some comments for this file.

> diff --git a/arch/arm/boot/dts/mb86s7x.dtsi b/arch/arm/boot/dts/mb86s7x.dtsi
> new file mode 100644
> index 0000000..50dcf04
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s7x.dtsi
> @@ -0,0 +1,595 @@
> +/*
> + * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
> + * Copyright (C) 2014 Linaro Ltd.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/mb86s70-clk.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};

Please move the aliases into the per-board file as well, some other
boards might not support all the uarts and should only list the
ones that have a connector.
> +	/**
> +	 * The UngatedCLK is the source of 8 maskable clock ports
> +	 * as well as having its own output port which can't be masked.
> +	 */
> +	clocks {
> +		clk_alw_0_0: clk_alw_0_0 {
> +			compatible = "fujitsu,mb86s70-clk";
> +			#clock-cells = <0>;
> +			cntrlr = <MB86S70_CRG11_ALW>;
> +			domain = <0>;
> +			port = <0>;
> +		};
> +
> +		clk_alw_0_1: clk_alw_0_1 {
> +			compatible = "fujitsu,mb86s70-clk";
> +			#clock-cells = <0>;
> +			cntrlr = <MB86S70_CRG11_ALW>;
> +			domain = <0>;
> +			port = <1>;
> +		};

This seems weird: rather than have one clock controller node per
clock source, why not just have one node with #clock-cells = <3>?

Your controller seems perfectly capable of this, and you even
put the numbers in the label. It would be much more straightforward
to do

	clocks = <&clk_alw 0 1>;

than 

	clocks = <&clk_alw_0_1>;

here. Possibly even

	clocks = <&clk MB86S70_CRG11_ALW 0 1>;

with #clock-cells = <3>

> +
> +	timer0: timer at 31080000 {
> +		compatible = "arm,sp804", "arm,primecell";
> +		reg = <0 0x31080000 0x1000>;
> +		interrupts = <0 324 4>,
> +			     <0 325 4>;
> +		clocks = <&clk_alw_6_8>;
> +		clock-names = "apb_pclk";
> +	};
> +
> +	timer1: archtimer {
> +		compatible = "arm,armv7-timer";
> +		clock-frequency = <125000000>;
> +		interrupts = <1 13 0xf08>,
> +			     <1 14 0xf08>,
> +			     <1 11 0xf08>,
> +			     <1 10 0xf08>;
> +	};

Inconsistent node names: please call the archtimer node 'timer'
as well, like the other one.

The label is free-form though, so you can just use 'archtimer:'
ther if you need to reference it.

> +	sdhci0: emmc at 300c0000 {
> +		compatible = "fujitsu,mb86s70-sdh30";
> +		reg = <0 0x300c0000 0x1000>;
> +		interrupts = <0 164 0x4>,
> +			     <0 165 0x4>;
> +		voltage-ranges = <1800 1800>, <3300 3300>;
> +		bus-width = <8>;
> +		clocks = <&clk_alw_c_0>, <&clk_alw_b_0>;
> +		clock-names = "iface", "core";
> +	};
> +};

Maybe also leave this as disabled in the base dtsi file and move the
status="ok" property and the bus width into the per-board file.

Also change the node name to mmc.

	Arnd
