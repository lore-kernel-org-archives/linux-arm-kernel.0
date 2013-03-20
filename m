From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Mar 2013 20:42:15 +0100
Subject: [PATCHv3] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <87ppyvautl.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwtzcgbl.fsf@natisbad.org> <20130319211607.GE21478@lunn.ch>
 <87ppyvautl.fsf@natisbad.org>
Message-ID: <20130320194215.GG21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:28:06PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Add support for NETGEAR ReadyNAS Duo v2 (Hardware specs available
> here: http://natisbad.org/NAS/). Almost everything is supported via
> provided .dts. A board-readynas.c file is nonetheless required for
> device not only converted to DT (Gbit controller).
> 
> FWIW, the most noticeable lack regarding hardware support is the fan
> controller (GMT G762) for which nothing is currently available
> upstream.
> 
> Changes since v2:
>  - tried and respect alphabetical order where possible in additions
>  - removed useless inclusion of io.h and delay.h in board-readynas.c
> 
> Changes since v1:
>  - More specific compatible string in dts
>  - Moved declaration to keep dts Makefile in alphabetical order
>  - Removed unneeded mdelay() for USB power on
>  - Switched to fixed regulator in .dts for USB power on
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> Tested-By: Arnaud Ebalard <arno@natisbad.org>
> ---

Looks good

Acked-by: Andrew Lunn <andrew@lunn.ch>

> 
> A previous version of the patch has been tested against 3.8.3 and the
> one below against current arm tree (current head of rmk/for-next).
> 
>  arch/arm/boot/dts/Makefile                         |    1 +
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  180 ++++++++++++++++++++
>  arch/arm/configs/kirkwood_defconfig                |    1 +
>  arch/arm/mach-kirkwood/Kconfig                     |    9 +
>  arch/arm/mach-kirkwood/Makefile                    |    1 +
>  arch/arm/mach-kirkwood/board-dt.c                  |    4 +
>  arch/arm/mach-kirkwood/board-readynas.c            |   28 +++
>  arch/arm/mach-kirkwood/common.h                    |    6 +
>  8 files changed, 230 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-readynas.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..125211d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -65,6 +65,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>  	kirkwood-lschlv2.dtb \
>  	kirkwood-lsxhl.dtb \
>  	kirkwood-mplcec4.dtb \
> +	kirkwood-netgear_readynas_duo_v2.dtb \
>  	kirkwood-ns2.dtb \
>  	kirkwood-ns2lite.dtb \
>  	kirkwood-ns2max.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> new file mode 100644
> index 0000000..3756e5c
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> @@ -0,0 +1,180 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6282.dtsi"
> +
> +/ {
> +	model = "NETGEAR ReadyNAS Duo v2";
> +	compatible = "netgear,readynas-duo-v2", "netgear,readynas", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory { /* 256 MB */
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +
> +			pinctrl-0 = < &pmx_uart0
> +				      &pmx_button_power
> +				      &pmx_button_backup
> +				      &pmx_button_reset
> +				      &pmx_led_blue_power
> +				      &pmx_led_blue_activity
> +				      &pmx_led_blue_disk1
> +				      &pmx_led_blue_disk2
> +				      &pmx_led_blue_backup >;
> +			pinctrl-names = "default";
> +
> +			pmx_button_power: pmx-button-power {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_backup: pmx-button-backup {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_reset: pmx-button-reset {
> +				marvell,pins = "mpp13";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue_power: pmx-led-blue-power {
> +				marvell,pins = "mpp31";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue_activity: pmx-led-blue-activity {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue_disk1: pmx-led-blue-disk1 {
> +				marvell,pins = "mpp23";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue_disk2: pmx-led-blue-disk2 {
> +				marvell,pins = "mpp22";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_blue_backup: pmx-led-blue-backup {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			rs5c372a: rs5c372a at 32 {
> +				compatible = "ricoh,rs5c372a";
> +				reg = <0x32>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};
> +
> +		nand at 3000000 {
> +			status = "okay";
> +
> +			partition at 0 {
> +				label = "u-boot";
> +				reg = <0x0000000 0x180000>;
> +				read-only;
> +			};
> +
> +			partition at 180000 {
> +				label = "u-boot-env";
> +				reg = <0x180000 0x20000>;
> +			};
> +
> +			partition at 200000 {
> +				label = "uImage";
> +				reg = <0x0200000 0x600000>;
> +			};
> +
> +			partition at 800000 {
> +				label = "minirootfs";
> +				reg = <0x0800000 0x1000000>;
> +			};
> +
> +			partition at 1800000 {
> +				label = "jffs2";
> +				reg = <0x1800000 0x6800000>;
> +			};
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		power_led {
> +			label = "status:blue:power_led";
> +			gpios = <&gpio0 31 1>;   /* GPIO 31 Active Low */
> +			linux,default-trigger = "default-on";
> +		};
> +		activity_led {
> +			label = "status:blue:activity_led";
> +			gpios = <&gpio1 6 1>;    /* GPIO 38 Active Low */
> +		};
> +		disk1_led {
> +			label = "status:blue:disk1_led";
> +			gpios = <&gpio0 23 1>;   /* GPIO 23 Active Low */
> +		};
> +		disk2_led {
> +			label = "status:blue:disk2_led";
> +			gpios = <&gpio0 22 1>;   /* GPIO 22 Active Low */
> +		};
> +		backup_led {
> +			label = "status:blue:backup_led";
> +			gpios = <&gpio0 29 1>;   /* GPIO 29 Active Low*/
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = <116>;     /* KEY_POWER */
> +			gpios = <&gpio1 15 1>;
> +		};
> +		button at 2 {
> +			label = "Reset Button";
> +			linux,code = <0x198>;   /* KEY_RESTART */
> +			gpios = <&gpio0 13 1>;
> +		};
> +		button at 3 {
> +			label = "Backup Button";
> +			linux,code = <133>;     /* KEY_COPY */
> +			gpios = <&gpio1 13 1>;
> +		};
> +	};
> +
> +        regulators {
> +                compatible = "simple-bus";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                usb_power: regulator at 1 {
> +                        compatible = "regulator-fixed";
> +                        reg = <1>;
> +                        regulator-name = "USB 3.0 Power";
> +                        regulator-min-microvolt = <5000000>;
> +                        regulator-max-microvolt = <5000000>;
> +                        enable-active-high;
> +                        regulator-always-on;
> +                        regulator-boot-on;
> +                        gpio = <&gpio1 14 0>;
> +                };
> +        };
> +};
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 13482ea..9eb9f48 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -34,6 +34,7 @@ CONFIG_MACH_NETSPACE_MAX_V2_DT=y
>  CONFIG_MACH_NETSPACE_LITE_V2_DT=y
>  CONFIG_MACH_NETSPACE_MINI_V2_DT=y
>  CONFIG_MACH_OPENBLOCKS_A6_DT=y
> +CONFIG_MACH_READYNAS_DT=y
>  CONFIG_MACH_TOPKICK_DT=y
>  CONFIG_MACH_TS219=y
>  CONFIG_MACH_TS41X=y
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 7b6a64b..3fd07eb 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -194,6 +194,15 @@ config MACH_OPENBLOCKS_A6_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Plat'Home OpenBlocks A6 (Flattened Device Tree).
>  
> +config MACH_READYNAS_DT
> +	bool "NETGEAR ReadyNAS Duo v2 (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	select ARM_APPENDED_DTB
> +	select ARM_ATAG_DTB_COMPAT
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  NETGEAR ReadyNAS Duo v2 using Fattened Device Tree.
> +
>  config MACH_TOPKICK_DT
>  	bool "USI Topkick (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 4cc4bee..ff0f3cb 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -39,4 +39,5 @@ obj-$(CONFIG_MACH_NETSPACE_LITE_V2_DT)	+= board-ns2.o
>  obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
>  obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
>  obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
> +obj-$(CONFIG_MACH_READYNAS_DT)		+= board-readynas.o
>  obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 2e73e9d..42ade1f 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -138,6 +138,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("mpl,cec4"))
>  		mplcec4_init();
>  
> +	if (of_machine_is_compatible("netgear,readynas-duo-v2"))
> +		netgear_readynas_init();
> +
>  	if (of_machine_is_compatible("plathome,openblocks-a6"))
>  		openblocks_a6_init();
>  
> @@ -166,6 +169,7 @@ static const char * const kirkwood_dt_board_compat[] = {
>  	"lacie,netspace_lite_v2",
>  	"lacie,netspace_mini_v2",
>  	"mpl,cec4",
> +	"netgear,readynas-duo-v2",
>  	"plathome,openblocks-a6",
>  	"usi,topkick",
>  	"zyxel,nsa310",
> diff --git a/arch/arm/mach-kirkwood/board-readynas.c b/arch/arm/mach-kirkwood/board-readynas.c
> new file mode 100644
> index 0000000..fb42c20
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-readynas.c
> @@ -0,0 +1,28 @@
> +/*
> + * NETGEAR ReadyNAS Duo v2 Board setup for drivers not already
> + * converted to DT.
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mv643xx_eth.h>
> +#include <mach/kirkwood.h>
> +#include "common.h"
> +
> +static struct mv643xx_eth_platform_data netgear_readynas_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +void __init netgear_readynas_init(void)
> +{
> +	kirkwood_ge00_init(&netgear_readynas_ge00_data);
> +	kirkwood_pcie_init(KW_PCIE0);
> +}
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 5ed7056..7ee8670 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -141,6 +141,12 @@ void openblocks_a6_init(void);
>  static inline void openblocks_a6_init(void) {};
>  #endif
>  
> +#ifdef CONFIG_MACH_READYNAS_DT
> +void netgear_readynas_init(void);
> +#else
> +static inline void netgear_readynas_init(void) {};
> +#endif
> +
>  #ifdef CONFIG_MACH_TOPKICK_DT
>  void usi_topkick_init(void);
>  #else
> -- 
> 1.7.10.4
> 
