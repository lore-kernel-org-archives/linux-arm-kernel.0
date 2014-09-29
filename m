From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 15:47:47 +0200
Subject: [PATCH 2/6] arm64: Add DTS support for Spreadtrum's Shark64 SoC
In-Reply-To: <1411992293-7729-3-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-3-git-send-email-zhang.lyra@gmail.com>
Message-ID: <4004425.NZAxCnE0qr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 20:04:49 zhang.lyra at gmail.com wrote:
> +
> +/memreserve/ 0x80000000 0x00010000;

Maybe add a comment explaining why it is reserved?

> +	chosen {
> +		bootargs = "earlycon=serial_sprd,0x70000000";
> +      };

Just remove this for now, the command line should really be set by the
boot loader, not hardcoded in the dts file.

IIRC, the earlycon=... syntax is not recommended on DT based systems,
better use the "stdout-path" syntax instead.

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x8000fff8>;
> +		};

New platforms should avoid using "spin-table" method. Please
change the boot loader to implement PSCI if you can.

> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0 0x80000000 0 0x20000000>;
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};

These two belong into a board-specific file. I'd suggest renaming this
file to sprd_shark64.dtsi (or whatever the SoC is called) and adding a
.dts file that includes this and sets the aliases and memory node
according to what the particular board has.

> +	intc:interrupt-controller at 71400000 {
> +		compatible = "sprd,intc";
> +		#interrupt-cells = <0>;
> +		interrupt-controller;
> +		reg =	<0 0x71400000 0 0x1000>,
> +			<0 0x71500000 0 0x1000>,
> +			<0 0x71600000 0 0x1000>,
> +			<0 0x71700000 0 0x1000>;
> +	};

This interrupt controller does not have a binding, so please add at least
a documentation for the binding as well. The name should probably be more
specific that this. Also, explain why you have an interrupt controller
that has four memory regions but only one interrupt sink but no interrupt
source.

I assume this is a nested interrupt controller to which some internal
peripherals are connected?

> +	uart0: uart at 70000000 {
> +		compatible = "sprd,serial";
> +		reg = <0 0x70000000 0 0x100>;
> +		interrupts = <0 2 0xf04>;
> +	};
> +
> +	uart1: uart at 70100000 {
> +		compatible = "sprd,serial";
> +		reg = <0 0x70100000 0 0x100>;
> +		interrupts = <0 3 0xf04>;
> +	};

Please rename these to serial at 70000000. Like the interrupt controller,
it would be good to have a more specific compatible string.
You may want to add a status="disabled" property in both these
nodes, and override them from the board.dts file for the ports that
are actually available.

	Arnd
