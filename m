From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 12 Apr 2015 13:20:00 +0200
Subject: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
 <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
Message-ID: <552A54E0.2080005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.04.2015 22:29, Andrew Andrianov wrote:
> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>

Andrew,

thanks for providing this dts, please _always_ add a commit log
describing what the patch is about. The introduction in the cover
letter is nice, but it will be gone once the patches are applied,
so this patch needs some log, too.

I also have a DNS-327L and I thought I started a dts, but either
I misremember or I just cannot find it.

Anyways, some comments below.

> ---
>   arch/arm/boot/dts/Makefile                     |    1 +
>   arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  309 ++++++++++++++++++++++++
>   2 files changed, 310 insertions(+)
>   create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a1c776b..8535e4e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -612,6 +612,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>   	zynq-zybo.dtb
>   dtb-$(CONFIG_MACH_ARMADA_370) += \
>   	armada-370-db.dtb \
> +	armada-370-dlink-dns327l.dtb \
>   	armada-370-mirabox.dtb \
>   	armada-370-netgear-rn102.dtb \
>   	armada-370-netgear-rn104.dtb \
> diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> new file mode 100644
> index 0000000..12bc072
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> @@ -0,0 +1,309 @@
> +/*
> + * Device Tree file for DLINK DNS-327L

Just a nit, but the company's logo uses "D-Link" so we should
use that in here.

I am fine with the file named "-370-dlink-dns" though.

> + * Copyright (C) 2014, Andrew Andrianov <andrew@ncrmnt.org>

+2015?

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

Andrew Lunn already mentioned dual licensing here.

> +/* Remaining mysteries:
> + *
> + * There's still something unknown on i2c address 0x13

Well, I can at least tell it is a "device" instead of "something" ;)

I am ok with the comment about an "unknown device at i2c address 0x13".

> + * CONFIG_ARM_MVEBU_V7_CPUIDLE=y causes hard freezes every 1-8 hours

I don't think the dts is the right place for Linux issues.

> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-370.dtsi"
> +
> +/ {
> +	model = "DLINK DNS-327L";

"D-Link DNS-327L"

> +	compatible = "dlink,dns327l",
> +		"marvell,armada370",
> +		"marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};

Andrew Lunn already mentioned stdout-path property.

> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MiB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
> +			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* Connected to Marvell SATA controller */

Really? It is actually using the two internal SATA ports.

> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/* Connected to NEC USB 3.0 controller */

Please just enable the port where the USB3 controller is connected
to. Could be the other one.

> +			pcie at 2,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			serial at 12000 {
> +				status = "okay";
> +			};
> +
> +			serial at 12100 {
> +				status = "okay";
> +			};

&uart0 { status = "okay" };
&uart1 { status = "okay" };

And move to bottom of the file. We try not to replay the bus structure
on board level all the time, if possible.

> +			sata at a0000 {
> +				nr-ports = <2>;
> +				status = "okay";
> +			};

Ok, sata has no node label, yet. It has to stay here.

> +			mdio {
> +			phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
> +					reg = <0>;
> +				};
> +			};

Something is wrong with indention of the node above and we do have
a node label for &mdio so it can also move.

> +			ethernet at 74000 {
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii-id";
> +			};

ditto, &eth1.

> +			usb at 50000 {
> +				status = "okay";
> +			};

Again, no node label, yet.

> +			i2c at 11000 {
> +				compatible = "marvell,mv64xxx-i2c";
> +				clock-frequency = <100000>;
> +				status = "okay";
> +			};

&i2c0, so please move.

> +			nand at d0000 {

Again, no node label, yet.

I guess there will be a cleanup patch set adding proper labels to
armada-370-xp.dtsi some day.

> +				status = "okay";
> +				num-cs = <1>;

I stumbled upon this on ix4-300d already while adding support for
pxa3xx nfc on barebox bootloader for the armada370/xp type of nfc
controller.

It is most likely the flash is connected to cs0 just because it is one
selected if boot source is NAND.

It could be that current barebox and Linux nfc driver deal with
the property differently, I haven't really checked yet.

> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;

Do you know the ECC scheme used?

If so, please add corresponding nand-ecc-strength and
nand-ecc-step-size properties.

> +				partition at 0 {
> +					label = "u-boot";
> +					/* 1.0 MiB */
> +					reg = <0x0000000 0x100000>;
> +					read-only;
> +				};
> +
> +				partition at 100000 {
> +					label = "u-boot-env";
> +					/* 128 KiB */
> +					reg = <0x100000 0x20000>;
> +					read-only;
> +				};
> +
> +				partition at 120000 {
> +					label = "uImage";
> +					/* 7 MiB */
> +					reg = <0x120000 0x700000>;
> +				};
> +
> +				partition at 820000 {
> +					label = "ubifs";
> +					/* ~ 84 MiB */
> +					reg = <0x820000 0x54e0000>;
> +				};
> +
> +				/* Hardwired into stock bootloader */

I don't get the comment above.

> +				partition at 800000 {

partition at 5d00000

> +					label = "failsafe-uImage";
> +					/* 5 MiB */
> +					reg = <0x5d00000 0x500000>;
> +				};
> +
> +				partition at 6200000 {
> +					label = "failsafe-fs";
> +					/* 29 MiB */
> +					reg = <0x6200000 0x1d00000>;
> +				};
> +
> +				partition at 7f00000 {
> +					label = "bbt";
> +					/* 1 MiB for BBT */
> +					reg = <0x7f00000 0x100000>;
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <
> +			&backup_button_pin
> +			&power_button_pin>;
> +		pinctrl-names = "default";
> +
> +		power-button {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		backup-button {
> +			label = "Backup Button";
> +			linux,code = <KEY_COPY>;

Hmm, is KEY_COPY the best option?

> +			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		reset-button {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +		};
> +
> +

Double empty lines above.

> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <
> +			&sata_l_amber_pin
> +			&sata_r_amber_pin
> +			&backup_led_pin>;
> +
> +		pinctrl-names = "default";
> +
> +		sata-r-amber-pin {
> +			label = "dns327l:amber:sata-r";
> +			gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> +		default-state = "keep";

Wrong indention.

> +		};
> +
> +		sata-l-amber-pin {
> +			label = "dns327l:amber:sata-l";
> +			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
> +		default-state = "keep";
> +		};
> +
> +		backup-led-pin {
> +			label = "dns327l:white:usb";
> +			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		default-state = "keep";
> +		};
> +

ditto for all gpio nodes above, and another empty line.

> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&xhci_pwr_pin
> +			&sata1_pwr_pin
> +			&sata2_pwr_pin>;
> +
> +		pinctrl-names = "default";
> +
> +	usb_power: regulator at 1 {

Wrong indention.

> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB3.0 Port Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-boot-on;
> +			regulator-always-on;
> +			gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +	sata1_power: regulator at 2 {

ditto.

> +			compatible = "regulator-fixed";
> +			reg = <1>;

reg = <2>;

> +			regulator-name = "SATA-1 Power";

Front HDD LEDs are actually labeled "L" and "R", can you evaluate
which 0/1 matches L/R and rename the regulator names accordingly?

> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +	sata2_power: regulator at 3 {

Wrong indention.

> +			compatible = "regulator-fixed";
> +			reg = <1>;

reg = <3>;

> +			regulator-name = "SATA-2 Power";

Same comment about the 0/1 vs L/R naming.

> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	sata1_white_pin: sata1-white-pin {
> +		marvell,pins = "mpp55";
> +		marvell,function = "sata1";
> +	};
> +
> +	sata_r_amber_pin: sata-r-amber-pin {
> +		marvell,pins = "mpp52";
> +		marvell,function = "gpio";
> +	};
> +
> +	sata2_white_pin: sata2-white-pin {
> +		marvell,pins = "mpp57";
> +		marvell,function = "sata0";
> +	};
> +
> +	sata_l_amber_pin: sata-l-amber-pin {
> +		marvell,pins = "mpp53";
> +		marvell,function = "gpio";
> +	};

If you find the 0/1, L/R mapping you should use it all over this file.

Sebastian

> +
> +	backup_led_pin: backup-led-pin {
> +		marvell,pins = "mpp61";
> +		marvell,function = "gpo";
> +	};
> +
> +	xhci_pwr_pin: xhci-pwr-pin {
> +		marvell,pins = "mpp13";
> +		marvell,function = "gpio";
> +	};
> +
> +	sata1_pwr_pin: sata1-pwr-pin {
> +		marvell,pins = "mpp54";
> +		marvell,function = "gpio";
> +	};
> +
> +	sata2_pwr_pin: sata2-pwr-pin {
> +		marvell,pins = "mpp56";
> +		marvell,function = "gpio";
> +	};
> +
> +	power_button_pin: power-button-pin {
> +		marvell,pins = "mpp65";
> +		marvell,function = "gpio";
> +	};
> +
> +	backup_button_pin: backup-button-pin {
> +		marvell,pins = "mpp63";
> +		marvell,function = "gpio";
> +	};
> +
> +	reset_button_pin: reset-button-pin {
> +		marvell,pins = "mpp64";
> +		marvell,function = "gpio";
> +	};
> +};
>
