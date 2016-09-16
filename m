From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 10:02:48 +0200
Subject: [RFC PATCH v2 5/5] ARM: hisi: add devicetree for hi3520
In-Reply-To: <20160915210505.21878-6-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
 <20160915210505.21878-6-netz.kernel@gmail.com>
Message-ID: <5685990.mcHrueECGo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 4:05:05 PM CEST Marty Plummer wrote:
> diff --git a/arch/arm/boot/dts/hi3520-1176-dm77a.dts b/arch/arm/boot/dts/hi3520-1176-dm77a.dts
> new file mode 100644
> index 0000000..c87a18e
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3520-1176-dm77a.dts
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (C) 2016  Marty Plummer <netz.kernel@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 3 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +#include "hi3520-1176.dtsi"
> +
> +/ {
> +	model = "Nightowl zeus-dvr";
> +	compatible = "hisilicon,hi3520-1176";

Please add a board specific compatible string in front of the string
for the soc.

> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};

Do you actually have access to all four serial ports on this board?
If not, just add aliases for the ones you see.

> +	/* chosen { */
> +	/* 	bootargs = "mem=72M console=ttyAMA0,115200 root=/dev/ram"; */
> +	/* 	stdout-path = "serial0:115200n8"; */
> +	/* }; */

I'd leave the stdout-path property in here, but not the bootargs.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,arm1176jzf-s";
> +			reg = <0>;
> +		};
> +	};

I guess in the long run we will want to support both the ARM926 and
the ARM1176, so maybe split the .dtsi file into two: one for whatever
is common to both cores, and one for the ARM1176 CPU and anything
exlusively used by that.

> +
> +		amba {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			ranges;
> +
> +			uart0: uart at 20090000 {

The name should be serial at 20090000

> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x20090000 0x1000>;
> +				clocks = <&uartclk &clk_3m>;
> +				clock-names = "uartclk", "apb_pclk";
> +				interrupts-extended = <&vic0 12 4>;
> +				status = "disable";
> +			};

status="disabled" (with 'd')

> +
> +			uart1: uart at 200a0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x200a0000 0x1000>;
> +				clocks = <&uartclk &clk_3m>;
> +				clock-names = "uartclk", "apb_pclk";
> +				interrupts-extended = <&vic0 12 4>;
> +			};
> +
> +			uart2: uart at 200b0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x200b0000 0x1000>;
> +				clocks = <&uartclk &clk_3m>;
> +				clock-names = "uartclk", "apb_pclk";
> +				interrupts-extended = <&vic0 13 4>;
> +			};
> +
> +			uart3: uart at 200c0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x200c0000 0x1000>;
> +				clocks = <&uartclk &clk_3m>;
> +				clock-names = "uartclk", "apb_pclk";
> +				interrupts-extended = <&vic0 13 4>;
> +			};

Why are these not disabled?

> +			gpio0: gpio at 20150000 {
> +				compatible = "arm,pl061", "arm,primecell";
> +				reg = <0x20150000 0x1000>;
> +				interrupts-extended = <&vic1 6 4>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				clocks = <&uartclk &clk_3m>;
> +				clock-names = "apb_pclk";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				status = "disabled";
> +			};

This one should probably not be disabled in turn.

> +			dual_timer0: dual_timer at 20000000 {

	timer at 20000000


> +			spi_bus0: spi at 200e0000 {
> +				compatible = "arm,pl022", "arm,primecell";
> +				reg = <0x200e0000 0x1000>;
> +				interrupts-extended = <&vic0 11 4>;
> +				num-cs = <1>;
> +			};
> +		};

There should be a #address-cells, also you probably want to
disable this if there are no child devices.

> +		sysctrl: system-controller at 20050000 {
> +			compatible = "hisilicon,hi3520-sysctrl", "syscon";
> +			reg = <0x20050000 0x1000>;
> +		};

The new compatible string needs to be listed in the sysctrl binding
document.

> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&sysctrl>;
> +			offset = <0x4>;
> +			mask = <0xdeadbeef>;
> +		};
> +
> +		/* gmac0: ethernet at 10090000 { */
> +		/* 	compatible = "hisilicon,hix5hd2-gmac"; */
> +		/* 	reg = <0x10090000 0x1000>,<0x20050000 0x1000>; */
> +		/* 	interrupts-extended = <&vic0 14 4>; */
> +		/* 	clocks = <&clk_3m>; */
> +		/* 	status = "disabled"; */
> +		/* }; */
> +
> +		usb0: ehci at 100b0000 {

	usb at 100b0000

	Arnd
