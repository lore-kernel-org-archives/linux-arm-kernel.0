From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 16:40:34 -0400
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <8738vt3h11.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org>
Message-ID: <20130317204034.GC13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

Thanks for contribution!

On Sun, Mar 17, 2013 at 09:31:06PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Add support for the NETGEAR ReadyNAS Duo v2 (Hardware specs available
> here: http://natisbad.org/NAS/). Almost everything is supported via
> provided .dts. A board-readynas.c file is nonetheless required for
> devices not only converted (Gbit controller) and USB 3.0 controller
> power on.

Yes, we're working on that.

> FWIW, the most noticeable lack regarding hardware support is the fan
> controller (GMT G762) for which nothing is currently available
> upstream. 


> 
> A previous version of the patch has been tested against 3.8.3 and the
> one below has been tested against current arm tree.
> 
> Cheers,
> 
> a+

Could you put the above comment two lines below:

> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---

here?

>  arch/arm/boot/dts/Makefile                      |    1 +
>  arch/arm/boot/dts/kirkwood-netgear_readynas.dts |  169 +++++++++++++++++++++++
>  arch/arm/configs/kirkwood_defconfig             |    1 +
>  arch/arm/mach-kirkwood/Kconfig                  |    9 ++
>  arch/arm/mach-kirkwood/Makefile                 |    1 +
>  arch/arm/mach-kirkwood/board-dt.c               |    4 +
>  arch/arm/mach-kirkwood/board-readynas.c         |   39 ++++++
>  arch/arm/mach-kirkwood/common.h                 |    6 +
>  8 files changed, 230 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-readynas.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..99122ba 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>  	kirkwood-ns2mini.dtb \
>  	kirkwood-nsa310.dtb \
>  	kirkwood-topkick.dtb \
> +	kirkwood-netgear_readynas.dtb \

please keep in alphabetical order.  It simplifies merge conflicts for
us.

>  	kirkwood-ts219-6281.dtb \
>  	kirkwood-ts219-6282.dtb \
>  	kirkwood-openblocks_a6.dtb
> diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas.dts
> new file mode 100644
> index 0000000..d89d436
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-netgear_readynas.dts
> @@ -0,0 +1,169 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6282.dtsi"
> +
> +/ {
> +	model = "NETGEAR ReadyNAS Duo v2";
> +	compatible = "netgear,readynas", "marvell,kirkwood-88f6282", "marvell,kirkwood";

Please add a more specific compatible string here, eg
"netgear,readynas-duo-v2", "netgear,readynas", ...

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
> +				      &pmx_button_power
> +				      &pmx_led_power
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
> +			pmx_led_power: pmx-led-power {
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
> +		thermal at 10078 {
> +			compatible = "marvell,kirkwood-thermal";
> +			reg = <0x10078 0x4>;
> +			status = "okay";
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
> +			linux,default-trigger = "timer";
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
> +};
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 13482ea..511cd7d 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -35,6 +35,7 @@ CONFIG_MACH_NETSPACE_LITE_V2_DT=y
>  CONFIG_MACH_NETSPACE_MINI_V2_DT=y
>  CONFIG_MACH_OPENBLOCKS_A6_DT=y
>  CONFIG_MACH_TOPKICK_DT=y
> +CONFIG_MACH_READYNAS_DT=y
>  CONFIG_MACH_TS219=y
>  CONFIG_MACH_TS41X=y
>  CONFIG_MACH_DOCKSTAR=y
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 7b6a64b..94df386 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -108,6 +108,15 @@ config MACH_TS219_DT
>  	  or MV6282. If you have the wrong one, the buttons will not
>  	  work.
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
>  config MACH_DOCKSTAR_DT
>  	bool "Seagate FreeAgent Dockstar (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 4cc4bee..b9108ea 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
>  obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
>  obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
>  obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
> +obj-$(CONFIG_MACH_READYNAS_DT)		+= board-readynas.o
>  obj-$(CONFIG_MACH_DOCKSTAR_DT)		+= board-dockstar.o
>  obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
>  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 2e73e9d..7418e03 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -144,6 +144,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("usi,topkick"))
>  		usi_topkick_init();
>  
> +	if (of_machine_is_compatible("netgear,readynas"))
> +		netgear_readynas_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
>  }
>  
> @@ -169,6 +172,7 @@ static const char * const kirkwood_dt_board_compat[] = {
>  	"plathome,openblocks-a6",
>  	"usi,topkick",
>  	"zyxel,nsa310",
> +	"netgear,readynas",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-readynas.c b/arch/arm/mach-kirkwood/board-readynas.c
> new file mode 100644
> index 0000000..1d0a6a0
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-readynas.c
> @@ -0,0 +1,39 @@
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
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <mach/kirkwood.h>
> +#include "common.h"
> +
> +static struct mv643xx_eth_platform_data netgear_readynas_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +void __init netgear_readynas_init(void)
> +{
> +	u32 val;
> +
> +	kirkwood_ge00_init(&netgear_readynas_ge00_data);
> +	kirkwood_pcie_init(KW_PCIE0);
> +
> +	/* USB 3.0 controller power on */
> +	mdelay(3000);
> +	val = readl(GPIO_HIGH_VIRT_BASE + 0x4);
> +	writel(val & ~(0x1 << 14), GPIO_HIGH_VIRT_BASE + 0x4);
> +	val = readl(GPIO_HIGH_VIRT_BASE);
> +	writel(val | (0x1 << 14), GPIO_HIGH_VIRT_BASE);

Please look@kirkwood-topkick.dts regulators block to see if perhaps
that will fit here.

thx,

Jason.

> +}
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 5ed7056..ed9a4bd 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -147,6 +147,12 @@ void usi_topkick_init(void);
>  static inline void usi_topkick_init(void) {};
>  #endif
>  
> +#ifdef CONFIG_MACH_READYNAS_DT
> +void netgear_readynas_init(void);
> +#else
> +static inline void netgear_readynas_init(void) {};
> +#endif
> +
>  /* early init functions not converted to fdt yet */
>  char *kirkwood_id(void);
>  void kirkwood_l2_init(void);
> -- 
> 1.7.10.4
> 
