From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 20:39:45 -0500
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
Message-ID: <20130124013945.GX1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:34:24PM +0000, Jason Cooper wrote:
> replace a lot of unneeded code and files with a lookup table.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/mach-kirkwood/Kconfig               | 101 ------------------------
>  arch/arm/mach-kirkwood/Makefile              |  14 ----
>  arch/arm/mach-kirkwood/board-dnskw.c         |   7 --
>  arch/arm/mach-kirkwood/board-dockstar.c      |  32 --------
>  arch/arm/mach-kirkwood/board-dreamplug.c     |  35 --------
>  arch/arm/mach-kirkwood/board-dt.c            | 114 +++++++++++++++++++--------
>  arch/arm/mach-kirkwood/board-goflexnet.c     |  34 --------
>  arch/arm/mach-kirkwood/board-ib62x0.c        |  29 -------
>  arch/arm/mach-kirkwood/board-iconnect.c      |  23 ------
>  arch/arm/mach-kirkwood/board-lsxl.c          |  36 ---------
>  arch/arm/mach-kirkwood/board-mplcec4.c       |  35 --------
>  arch/arm/mach-kirkwood/board-ns2.c           |  34 --------
>  arch/arm/mach-kirkwood/board-openblocks_a6.c |  26 ------
>  arch/arm/mach-kirkwood/board-usi_topkick.c   |  29 -------
>  arch/arm/mach-kirkwood/common.h              |  63 ---------------
>  15 files changed, 81 insertions(+), 531 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-goflexnet.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-iconnect.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-ns2.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
>  delete mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 432bee0..188651b 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -58,19 +58,6 @@ config ARCH_KIRKWOOD_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell Kirkwood using flattened device tree.
>  
> -config MACH_DREAMPLUG_DT
> -	bool "Marvell DreamPlug (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Marvell DreamPlug (Flattened Device Tree).
> -
> -config MACH_ICONNECT_DT
> -	bool "Iomega Iconnect (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here to enable Iomega Iconnect support.
> -
>  config MACH_DLINK_KIRKWOOD_DT
>  	bool "D-Link Kirkwood-based NAS (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> @@ -79,14 +66,6 @@ config MACH_DLINK_KIRKWOOD_DT
>  	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
>  	  using Flattened Device Tree.
>  
> -config MACH_IB62X0_DT
> -	bool "RaidSonic IB-NAS6210, IB-NAS6220 (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  RaidSonic IB-NAS6210 & IB-NAS6220 devices, using
> -	  Flattened Device Tree.
> -
>  config MACH_TS219_DT
>  	bool "Device Tree for QNAP TS-11X, TS-21X NAS"
>  	select ARCH_KIRKWOOD_DT
> @@ -102,29 +81,6 @@ config MACH_TS219_DT
>  	  or MV6282. If you have the wrong one, the buttons will not
>  	  work.
>  
> -config MACH_DOCKSTAR_DT
> -	bool "Seagate FreeAgent Dockstar (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Seagate FreeAgent Dockstar (Flattened Device Tree).
> -
> -config MACH_GOFLEXNET_DT
> -	bool "Seagate GoFlex Net (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Seagate GoFlex Net (Flattened Device Tree).
> -
> -config MACH_LSXL_DT
> -	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	select POWER_RESET_RESTART
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
> -	  Flattened Device Tree.
> -
>  config MACH_IOMEGA_IX2_200_DT
>  	bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> @@ -139,63 +95,6 @@ config MACH_KM_KIRKWOOD_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
>  
> -config MACH_INETSPACE_V2_DT
> -	bool "LaCie Internet Space v2 NAS (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the LaCie
> -	  Internet Space v2 NAS, using Flattened Device Tree.
> -
> -config MACH_MPLCEC4_DT
> -	bool "MPL CEC4 (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  MPL CEC4 (Flattened Device Tree).
> -
> -config MACH_NETSPACE_V2_DT
> -	bool "LaCie Network Space v2 NAS (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the LaCie
> -	  Network Space v2 NAS, using Flattened Device Tree.
> -
> -config MACH_NETSPACE_MAX_V2_DT
> -	bool "LaCie Network Space Max v2 NAS (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the LaCie
> -	  Network Space Max v2 NAS, using Flattened Device Tree.
> -
> -config MACH_NETSPACE_LITE_V2_DT
> -	bool "LaCie Network Space Lite v2 NAS (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the LaCie
> -	  Network Space Lite v2 NAS, using Flattened Device Tree.
> -
> -config MACH_NETSPACE_MINI_V2_DT
> -	bool "LaCie Network Space Mini v2 NAS (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the LaCie
> -	  Network Space Mini v2 NAS (aka SafeBox), using Flattened
> -	  Device Tree.
> -
> -config MACH_OPENBLOCKS_A6_DT
> -	bool "Plat'Home OpenBlocks A6 (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Plat'Home OpenBlocks A6 (Flattened Device Tree).
> -
> -config MACH_TOPKICK_DT
> -	bool "USI Topkick (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  USI Topkick, using Flattened Device Tree
> -
>  config MACH_TS219
>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index ee3aa77..ab739b0 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -20,21 +20,7 @@ obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
>  obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
>  
>  obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
> -obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
> -obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
>  obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
> -obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
>  obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
> -obj-$(CONFIG_MACH_DOCKSTAR_DT)		+= board-dockstar.o
> -obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
> -obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
>  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
>  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> -obj-$(CONFIG_MACH_INETSPACE_V2_DT)	+= board-ns2.o
> -obj-$(CONFIG_MACH_MPLCEC4_DT)		+= board-mplcec4.o
> -obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
> -obj-$(CONFIG_MACH_NETSPACE_MAX_V2_DT)	+= board-ns2.o
> -obj-$(CONFIG_MACH_NETSPACE_LITE_V2_DT)	+= board-ns2.o
> -obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
> -obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
> -obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
> diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
> index a1aa87f..2af7a95 100644
> --- a/arch/arm/mach-kirkwood/board-dnskw.c
> +++ b/arch/arm/mach-kirkwood/board-dnskw.c
> @@ -14,14 +14,9 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mv643xx_eth.h>
>  #include <linux/gpio.h>
>  #include "common.h"
>  
> -static struct mv643xx_eth_platform_data dnskw_ge00_data = {
> -	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> -};
> -
>  /* Register any GPIO for output and set the value */
>  static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
>  {
> @@ -36,8 +31,6 @@ static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
>  
>  void __init dnskw_init(void)
>  {
> -	kirkwood_ge00_init(&dnskw_ge00_data);
> -
>  	/* Set NAS to turn back on after a power failure */
>  	dnskw_gpio_register(37, "dnskw:power:recover", 1);
>  }
> diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
> deleted file mode 100644
> index d7196db..0000000
> --- a/arch/arm/mach-kirkwood/board-dockstar.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/*
> - * arch/arm/mach-kirkwood/board-dockstar.c
> - *
> - * Seagate FreeAgent Dockstar Board Init for drivers not converted to
> - * flattened device tree yet.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - *
> - * Copied and modified for Seagate GoFlex Net support by
> - * Joshua Coombs <josh.coombs@gmail.com> based on ArchLinux ARM's
> - * GoFlex kernel patches.
> - *
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/mv643xx_eth.h>
> -#include "common.h"
> -
> -static struct mv643xx_eth_platform_data dockstar_ge00_data = {
> -	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> -};
> -
> -void __init dockstar_dt_init(void)
> -{
> -	/*
> -	 * Basic setup. Needs to be called early.
> -	 */
> -	kirkwood_ge00_init(&dockstar_ge00_data);
> -}
> diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
> deleted file mode 100644
> index 0903242..0000000
> --- a/arch/arm/mach-kirkwood/board-dreamplug.c
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
> - *
> - * arch/arm/mach-kirkwood/board-dreamplug.c
> - *
> - * Marvell DreamPlug Reference Board Init for drivers not converted to
> - * flattened device tree yet.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/gpio.h>
> -#include "common.h"
> -
> -static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
> -	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> -};
> -
> -static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
> -	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
> -};
> -
> -void __init dreamplug_init(void)
> -{
> -	/*
> -	 * Basic setup. Needs to be called early.
> -	 */
> -	kirkwood_ge00_init(&dreamplug_ge00_data);
> -	kirkwood_ge01_init(&dreamplug_ge01_data);
> -}
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 73b76e4..f5bd640 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -93,6 +93,86 @@ static int __init kirkwood_pcie_dt_init(void)
>  }
>  subsys_initcall(kirkwood_pcie_dt_init);
>  
> +struct kirkwood_dt_gige {
> +	const char *compatible;
> +	int phy_addr00;
> +	int phy_addr01;
> +};
> +
> +static struct kirkwood_dt_gige kw_dt_gige[] = {
> +	{ .compatible = "buffalo,lsxl",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_ADDR(8) },
> +	{ .compatible = "dlink,dns-kirkwood",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(8),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "globalscale,dreamplug",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_ADDR(1) },
> +	{ .compatible = "iom,iconnect",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(11),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "lacie,inetspace_v2",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(8),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "lacie,netspace_v2",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(8),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "lacie,netspace_max_v2",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(8),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "lacie,netspace_lite_v2",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "lacie,netspace_mini_v2",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "mpl,cec4",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(1),
> +	  .phy_addr01 = MV643XX_ETH_PHY_ADDR(2) },
> +	{ .compatible = "plathome,openblocks-a6",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "raidsonic,ib-nas62x0",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(8),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "seagate,dockstar",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "seagate,goflexnet",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ .compatible = "usi,topkick",
> +	  .phy_addr00 = MV643XX_ETH_PHY_ADDR(0),
> +	  .phy_addr01 = MV643XX_ETH_PHY_NONE },
> +	{ NULL, MV643XX_ETH_PHY_NONE, MV643XX_ETH_PHY_NONE },
> +};
> +
> +static void kirkwood_gige_dt_init(void) {
> +	int i;
> +
> +	for (i = 0; kw_dt_gige[i].compatible != NULL; i++) {
> +		if (of_machine_is_compatible(kw_dt_gige[i].compatible)) {
> +
> +			if (kw_dt_gige[i].phy_addr00 != MV643XX_ETH_PHY_NONE) {
> +				struct mv643xx_eth_platform_data d = {
> +					.phy_addr = kw_dt_gige[i].phy_addr00,
> +				};
> +				kirkwood_ge00_init(&d);
> +			}
> +
> +			if (kw_dt_gige[i].phy_addr01 != MV643XX_ETH_PHY_NONE) {
> +				struct mv643xx_eth_platform_data d = {
> +					.phy_addr = kw_dt_gige[i].phy_addr01,
> +				};
> +				kirkwood_ge01_init(&d);
> +			}
> +
> +			break;
> +		}

meh, hindsight is 50/50 :-)  Much more readable this way, I think:

		if (of_machine_is_compatible(kw_dt_gige[i].compatible)) {
			struct mv643xx_eth_platform_data d;

			if (kw_dt_gige[i].phy_addr00 != MV643XX_ETH_PHY_NONE) {
				d.phy_addr = kw_dt_gige[i].phy_addr00,
				kirkwood_ge00_init(&d);
			}

			if (kw_dt_gige[i].phy_addr01 != MV643XX_ETH_PHY_NONE) {
				d.phy_addr = kw_dt_gige[i].phy_addr01,
				kirkwood_ge01_init(&d);
			}

			break;
		}

thx,

Jason.
