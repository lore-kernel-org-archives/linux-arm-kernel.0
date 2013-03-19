From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Mar 2013 22:16:07 +0100
Subject: [PATCHv2] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <87mwtzcgbl.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwtzcgbl.fsf@natisbad.org>
Message-ID: <20130319211607.GE21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 08:58:22PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Add support for NETGEAR ReadyNAS Duo v2 (Hardware specs available
> here: http://natisbad.org/NAS/).

Hi Arnaud

Thats a nice description of the hardware. There is another device
using the same power supply controller, the USI Topkick. A few of the
maintainers have these, so there would be the possibility of
cooperating on a driver. It does not seem that complex a device. The
topkick also seems to do Wake-on-LAN using this controller. There was
a patch added recently which may allow this to work, depending on the
PHY.

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

Keeping with alphabetic ordering, it should be one place higher....

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

Again, should be a bit earlier.

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

Yes, you can guess.... Where ever you have inserted something, make
sure it follows the given ordering. The issue here is merge
conflicts. If we get another device contributed that is also added at
the end, we get conflicts. If merges happening in the middle, the
likelihood of a conflict is much smaller. 

> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 2e73e9d..a29f2ee 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -144,6 +144,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("usi,topkick"))
>  		usi_topkick_init();
>  
> +	if (of_machine_is_compatible("netgear,readynas-duo-v2"))
> +		netgear_readynas_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
>  }
>  
> @@ -169,6 +172,7 @@ static const char * const kirkwood_dt_board_compat[] = {
>  	"plathome,openblocks-a6",
>  	"usi,topkick",
>  	"zyxel,nsa310",
> +	"netgear,readynas-duo-v2",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-readynas.c b/arch/arm/mach-kirkwood/board-readynas.c
> new file mode 100644
> index 0000000..47bc25e
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-readynas.c
> @@ -0,0 +1,30 @@
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

Now that the msleep() has gone, delay.h is probably not needed.  Maybe
also io.h is not needed any more with the regulator DT?

These are all minor issues. The code is good otherwise.

      Thanks
	Andrew
