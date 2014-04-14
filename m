From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 12:33:01 +0200
Subject: [PATCH 11/29] ARM: orion5x: convert DT to use the mvebu-mbus
 driver
In-Reply-To: <1397400006-4315-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BB95D.7080100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit switches the Orion5x Device Tree files to use the DT
> representation and probing for the mvebu-mbus driver. The changes are
> mainly:
>
>   * Re-organize the DT to follow the same organization as the one used
>     on Armada 370/XP, which is needed for mvebu-mbus to work: a
>     top-level soc { ... } node, which corresponds to the MBus bus, and
>     a sub-node internal-regs { ... } for all peripherals whose register
>     sit only in the "Internal Register Window". This change re-indents
>     by one level the definition of all nodes in the Device Tree, which
>     explains the large change.
>
>   * Use custom functions orion5x_dt_init_early() and
>     orion5x_dt_init_time() instead of orion5x_init_early() and
>     orion5x_timer_init() as we now want the MBus driver to be probed
>     from the Device Tree. We still use the old-style timer
>     initialization, but that will be changed in a followup commit.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  23 +-
>   arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |  24 ++
>   arch/arm/boot/dts/orion5x.dtsi                     | 245 +++++++++++----------
>   arch/arm/mach-orion5x/board-dt.c                   |  19 +-
>   4 files changed, 181 insertions(+), 130 deletions(-)
>   create mode 100644 arch/arm/boot/dts/orion5x-mv88f5182.dtsi
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index 24f1ce7..d66d2fa 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -10,7 +10,7 @@
>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
> -#include "orion5x.dtsi"
> +#include "orion5x-mv88f5182.dtsi"
>
>   / {
>   	model = "LaCie Ethernet Disk mini V2";
> @@ -24,15 +24,20 @@
>   		bootargs = "console=ttyS0,115200n8 earlyprintk";

+ linux,stdout-path = &uart0;

You need labels for it in the SoC dtsi and probably the "linux,"
prefix has already been removed.

I am having a hard time with this and missing node labels on
barebox for kirkwood already. So it would be good to not make
the same mistakes on Orion5x again.

>   	};
>
> -	ocp at f1000000 {
> -		serial at 12000 {
> -			clock-frequency = <166666667>;
> -			status = "okay";
> -		};
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> +			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
> +
> +		internal-regs {
> +			serial at 12000 {
> +				clock-frequency = <166666667>;

With node labels, you don't have to replay bus nodes here again
but can just do

&uart0 {
	status = "okay";
};

Also, the clock-frequency property should rather been clocks
and part of SoC dtsi. IIRC, Andrew already mentioned it.

> +				status = "okay";
> +			};
>
> -		sata at 80000 {
> -			status = "okay";
> -			nr-ports = <2>;
> +			sata at 80000 {

Same comment about node labels for sata.

> +				status = "okay";
> +				nr-ports = <2>;

Not your problem right now, but sata binding and nr-ports
property is broken. It doesn't allow us to distinguish
clocks, sata-phys, and most important does not allow to
disable port0 while using port1.

We should really have a look at it soon.

> +			};
>   		};
>   	};
>
> diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
> new file mode 100644
> index 0000000..ddfb4d1
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include "orion5x.dtsi"
> +
> +/ {
> +	compatible = "marvell,orion5x-88f5182", "marvell,orion5x";
> +
> +	soc {
> +		compatible = "marvell,orion5x-88f5182-mbus", "simple-bus";
> +
> +		internal-regs {
> +			mbusc: mbus-controller at 20000 {
> +				compatible = "marvell,mbus-controller";
> +				reg = <0x20000 0x100>, <0x1500 0x20>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index 2364e3d..31d46e6 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -8,6 +8,8 @@
>
>   #include "skeleton.dtsi"
>
> +#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
> +
>   / {
>   	model = "Marvell Orion5x SoC";
>   	compatible = "marvell,orion5x";
> @@ -17,149 +19,154 @@
>   		gpio0 = &gpio0;
>   	};
>
> -	ocp at f1000000 {
> -		compatible = "simple-bus";
> -		ranges = <0x00000000 0xf1000000 0x4000000
> -		          0xf2200000 0xf2200000 0x0000800>;
> -		#address-cells = <1>;
> +	soc {
> +		#address-cells = <2>;
>   		#size-cells = <1>;
> +		controller = <&mbusc>;
>
> -		gpio0: gpio at 10100 {
> -			compatible = "marvell,orion-gpio";
> -			#gpio-cells = <2>;
> -			gpio-controller;
> -			reg = <0x10100 0x40>;
> -			ngpios = <32>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			interrupts = <6>, <7>, <8>, <9>;
> -		};
> -
> -		spi at 10600 {
> -			compatible = "marvell,orion-spi";
> +		internal-regs {
> +			compatible = "simple-bus";
>   			#address-cells = <1>;
> -			#size-cells = <0>;
> -			cell-index = <0>;
> -			reg = <0x10600 0x28>;
> -			status = "disabled";
> -		};
> -
> -		i2c at 11000 {
> -			compatible = "marvell,mv64xxx-i2c";
> -			reg = <0x11000 0x20>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			interrupts = <5>;
> -			clock-frequency = <100000>;
> -			status = "disabled";
> -		};
> +			#size-cells = <1>;
> +			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
> +
> +			gpio0: gpio at 10100 {
> +				compatible = "marvell,orion-gpio";
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				reg = <0x10100 0x40>;
> +				ngpios = <32>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <6>, <7>, <8>, <9>;
> +			};
>
> -		serial at 12000 {
> -			compatible = "ns16550a";
> -			reg = <0x12000 0x100>;
> -			reg-shift = <2>;
> -			interrupts = <3>;
> -			/* set clock-frequency in board dts */
> -			status = "disabled";
> -		};
> +			spi at 10600 {

Please add a node label.

> +				compatible = "marvell,orion-spi";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				cell-index = <0>;
> +				reg = <0x10600 0x28>;
> +				status = "disabled";
> +			};
>
> -		serial at 12100 {
> -			compatible = "ns16550a";
> -			reg = <0x12100 0x100>;
> -			reg-shift = <2>;
> -			interrupts = <4>;
> -			/* set clock-frequency in board dts */
> -			status = "disabled";
> -		};
> +			i2c at 11000 {

ditto.

> +				compatible = "marvell,mv64xxx-i2c";
> +				reg = <0x11000 0x20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <5>;
> +				clock-frequency = <100000>;
> +				status = "disabled";
> +			};
>
> -		intc: interrupt-controller at 20200 {
> -			compatible = "marvell,orion-intc";
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -			reg = <0x20200 0x08>;
> -		};
> +			serial at 12000 {

ditto.

> +				compatible = "ns16550a";
> +				reg = <0x12000 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <3>;
> +				/* set clock-frequency in board dts */

clocks = <&reference-to-tclk>;

> +				status = "disabled";
> +			};
>
> -		wdt at 20300 {
> -			compatible = "marvell,orion-wdt";
> -			reg = <0x20300 0x28>;
> -			status = "okay";
> -		};
> +			serial at 12100 {

ditto.

> +				compatible = "ns16550a";
> +				reg = <0x12100 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <4>;
> +				/* set clock-frequency in board dts */

clocks = <&reference-to-tclk>;

> +				status = "disabled";
> +			};
>
> -		ehci at 50000 {
> -			compatible = "marvell,orion-ehci";
> -			reg = <0x50000 0x1000>;
> -			interrupts = <17>;
> -			status = "disabled";
> -		};
> +			intc: interrupt-controller at 20200 {
> +				compatible = "marvell,orion-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				reg = <0x20200 0x08>;
> +			};
>
> -		xor at 60900 {
> -			compatible = "marvell,orion-xor";
> -			reg = <0x60900 0x100
> -			       0x60b00 0x100>;
> -			status = "okay";
> +			wdt at 20300 {

I suggest to keep on adding node labels for everything.

> +				compatible = "marvell,orion-wdt";
> +				reg = <0x20300 0x28>;
> +				status = "okay";
> +			};
>
> -			xor00 {
> -			      interrupts = <30>;
> -			      dmacap,memcpy;
> -			      dmacap,xor;
> +			ehci at 50000 {

Please add a node label.

> +				compatible = "marvell,orion-ehci";
> +				reg = <0x50000 0x1000>;
> +				interrupts = <17>;
> +				status = "disabled";
>   			};
> -			xor01 {
> -			      interrupts = <31>;
> -			      dmacap,memcpy;
> -			      dmacap,xor;
> -			      dmacap,memset;
> +
> +			xor at 60900 {

ditto, also ePAPR suggests "dma-controller" as node name,
so this should become:

xor0: dma-controller at 60900 {
	...
};

> +				compatible = "marvell,orion-xor";
> +				reg = <0x60900 0x100
> +				       0x60b00 0x100>;
> +				status = "okay";
> +
> +				xor00 {
> +				      interrupts = <30>;
> +				      dmacap,memcpy;
> +				      dmacap,xor;
> +				};
> +				xor01 {
> +				      interrupts = <31>;
> +				      dmacap,memcpy;
> +				      dmacap,xor;
> +				      dmacap,memset;
> +				};
>   			};
> -		};
>
> -		eth: ethernet-controller at 72000 {
> -			compatible = "marvell,orion-eth";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0x72000 0x4000>;
> -			marvell,tx-checksum-limit = <1600>;
> -			status = "disabled";
> -
> -			ethernet-port at 0 {
> -				compatible = "marvell,orion-eth-port";
> -				reg = <0>;
> -				/* overwrite MAC address in bootloader */
> -				local-mac-address = [00 00 00 00 00 00];
> -				/* set phy-handle property in board file */
> +			eth: ethernet-controller at 72000 {
> +				compatible = "marvell,orion-eth";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x72000 0x4000>;
> +				marvell,tx-checksum-limit = <1600>;
> +				status = "disabled";
> +
> +				ethernet-port at 0 {

Please add a node label for the port, too.

> +					compatible = "marvell,orion-eth-port";
> +					reg = <0>;
> +					/* overwrite MAC address in bootloader */
> +					local-mac-address = [00 00 00 00 00 00];
> +					/* set phy-handle property in board file */
> +				};
>   			};
> -		};
>
> -		mdio: mdio-bus at 72004 {
> -			compatible = "marvell,orion-mdio";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0x72004 0x84>;
> -			interrupts = <22>;
> -			status = "disabled";
> +			mdio: mdio-bus at 72004 {
> +				compatible = "marvell,orion-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x72004 0x84>;
> +				interrupts = <22>;
> +				status = "disabled";
>
> -			/* add phy nodes in board file */
> -		};
> +				/* add phy nodes in board file */
> +			};
> +
> +			sata at 80000 {

ditto.

> +				compatible = "marvell,orion-sata";
> +				reg = <0x80000 0x5000>;
> +				interrupts = <29>;
> +				status = "disabled";
> +			};
>
> -		sata at 80000 {
> -			compatible = "marvell,orion-sata";
> -			reg = <0x80000 0x5000>;
> -			interrupts = <29>;
> -			status = "disabled";
> +			ehci at a0000 {
> +				compatible = "marvell,orion-ehci";
> +				reg = <0xa0000 0x1000>;
> +				interrupts = <12>;
> +				status = "disabled";
> +			};
>   		};
>
>   		crypto at 90000 {

ditto, something like "cesa: crypto at 90000 {"

Sebastian

>   			compatible = "marvell,orion-crypto";
> -			reg = <0x90000 0x10000>,
> -			      <0xf2200000 0x800>;
> +			reg = <MBUS_ID(0xf0, 0x01) 0x90000 0x10000>,
> +			      <MBUS_ID(0x09, 0x00) 0x0 0x800>;
>   			reg-names = "regs", "sram";
>   			interrupts = <28>;
>   			status = "okay";
>   		};
> -
> -		ehci at a0000 {
> -			compatible = "marvell,orion-ehci";
> -			reg = <0xa0000 0x1000>;
> -			interrupts = <12>;
> -			status = "disabled";
> -		};
>   	};
>   };
> diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
> index c134a82..f6a388a 100644
> --- a/arch/arm/mach-orion5x/board-dt.c
> +++ b/arch/arm/mach-orion5x/board-dt.c
> @@ -15,10 +15,14 @@
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
>   #include <linux/cpu.h>
> +#include <linux/mbus.h>
>   #include <asm/system_misc.h>
>   #include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
>   #include <mach/orion5x.h>
> +#include <mach/bridge-regs.h>
>   #include <plat/irq.h>
> +#include <plat/time.h>
>   #include "common.h"
>
>   static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
> @@ -31,6 +35,17 @@ static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
>   	{},
>   };
>
> +static void orion5x_dt_init_early(void)
> +{
> +	orion_time_set_base(TIMER_VIRT_BASE);
> +}
> +
> +static void orion5x_dt_init_time(void)
> +{
> +	orion5x_timer_init();
> +	BUG_ON(mvebu_mbus_dt_init());
> +}
> +
>   static void __init orion5x_dt_init(void)
>   {
>   	char *dev_name;
> @@ -71,9 +86,9 @@ static const char *orion5x_dt_compat[] = {
>   DT_MACHINE_START(ORION5X_DT, "Marvell Orion5x (Flattened Device Tree)")
>   	/* Maintainer: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> */
>   	.map_io		= orion5x_map_io,
> -	.init_early	= orion5x_init_early,
> +	.init_early	= orion5x_dt_init_early,
>   	.init_irq	= orion_dt_init_irq,
> -	.init_time	= orion5x_timer_init,
> +	.init_time	= orion5x_dt_init_time,
>   	.init_machine	= orion5x_dt_init,
>   	.restart	= orion5x_restart,
>   	.dt_compat	= orion5x_dt_compat,
>
