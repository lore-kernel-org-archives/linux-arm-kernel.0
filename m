From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 03 Jul 2012 17:47:57 +0200
Subject: [PATCH v2 08/12] Kirkwood: Add basic device tree support for QNAP
 TS219.
In-Reply-To: <1341325365-21393-9-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-9-git-send-email-andrew@lunn.ch>
Message-ID: <5219791.0WtDlTNBEQ@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tuesday 03 July 2012 16:22:41 Andrew Lunn wrote:
> The two different variants of QNAP TS devices, varying by SoC, put the
> GPIO keys on different GPIO lines. Hence we need two different DT
> board descriptions, which share the same board-ts219.c file.

Why don't you reorder this patch to be after patch 11/12 so that you do not 
need to update this file in patch 11/12?

> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
[snip]
>  
> +config MACH_TS219_DT
> +	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, 
TS-219P and TS-219P+ Turbo NAS"

This looks too long, how about just "Device Tree for QNAP TS-11x, TS-21x NAS" 
for instance?

> +	select ARCH_KIRKWOOD_DT
> +	select ARM_APPENDED_DTB
> +	select ARM_ATAG_DTB_COMPAT
> +	help
> +	  Say 'Y' here if you want your kernel to support the QNAP
> +	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
> +	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
> +	  There are two different Device Tree descriptions, depending
> +	  on if the device is based on an if the board uses the MV6281
> +	  or MV6282. If you have the wrong one, the buttons will not
> +	  work.
> +
>  config MACH_TS219
>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and 
TS-219P+ Turbo NAS"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index d2b0590..0468b23 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
>  obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
>  obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
>  obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
> +obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o
> diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-
kirkwood/Makefile.boot
> index 02edbdf..4a1f66a 100644
> --- a/arch/arm/mach-kirkwood/Makefile.boot
> +++ b/arch/arm/mach-kirkwood/Makefile.boot
> @@ -7,3 +7,4 @@ dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
>  dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
>  dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
>  dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
> +dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-
kirkwood/board-dt.c
> index 24c8fdd..b7cd6d2 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -76,6 +76,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
>  		ib62x0_init();
>  
> +	if (of_machine_is_compatible("qnap,ts219"))
> +		qnap_dt_ts219_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table,
>  			     kirkwood_auxdata_lookup, NULL);
>  }
> @@ -86,6 +89,7 @@ static const char *kirkwood_dt_board_compat[] = {
>  	"dlink,dns-325",
>  	"iom,iconnect",
>  	"raidsonic,ib-nas62x0",
> +	"qnap,ts219",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-
kirkwood/board-ts219.c
> new file mode 100644
> index 0000000..00b79ea
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-ts219.c
> @@ -0,0 +1,87 @@
> +/*
> + *
> + * QNAP TS-11x/TS-21x Turbo NAS Board Setup via DT
> + *
> + * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
> + *
> + * Based on the board file ts219-setup.c:
> + *
> + * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
> + * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
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
> +#include <linux/ata_platform.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/kirkwood.h>
> +#include "common.h"
> +#include "mpp.h"
> +#include "tsx1x-common.h"
> +
> +static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> +};
> +
> +static struct mv_sata_platform_data qnap_ts219_sata_data = {
> +	.n_ports	= 2,
> +};
> +
> +static unsigned int qnap_ts219_mpp_config[] __initdata = {
> +	MPP0_SPI_SCn,
> +	MPP1_SPI_MOSI,
> +	MPP2_SPI_SCK,
> +	MPP3_SPI_MISO,
> +	MPP4_SATA1_ACTn,
> +	MPP5_SATA0_ACTn,
> +	MPP8_TW0_SDA,
> +	MPP9_TW0_SCK,
> +	MPP10_UART0_TXD,
> +	MPP11_UART0_RXD,
> +	MPP13_UART1_TXD,	/* PIC controller */
> +	MPP14_UART1_RXD,	/* PIC controller */
> +	MPP15_GPIO,		/* USB Copy button (on devices with 88F6281) */
> +	MPP16_GPIO,		/* Reset button (on devices with 88F6281) */
> +	MPP36_GPIO,		/* RAM: 0: 256 MB, 1: 512 MB */
> +	MPP37_GPIO,		/* Reset button (on devices with 88F6282) */
> +	MPP43_GPIO,		/* USB Copy button (on devices with 88F6282) */
> +	MPP44_GPIO,		/* Board ID: 0: TS-11x, 1: TS-21x */
> +	0
> +};
> +
> +void __init qnap_dt_ts219_init(void)
> +{
> +	u32 dev, rev;
> +
> +	kirkwood_mpp_conf(qnap_ts219_mpp_config);
> +
> +	kirkwood_pcie_id(&dev, &rev);
> +	if (dev == MV88F6282_DEV_ID)
> +		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
> +
> +	kirkwood_ge00_init(&qnap_ts219_ge00_data);
> +	kirkwood_sata_init(&qnap_ts219_sata_data);
> +	kirkwood_ehci_init();
> +
> +	pm_power_off = qnap_tsx1x_power_off;
> +}
> +
> +/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
> +static int __init ts219_pci_init(void)
> +{
> +	if (machine_is_ts219())
> +		kirkwood_pcie_init(KW_PCIE0);
> +
> +	return 0;
> +}
> +subsys_initcall(ts219_pci_init);
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-
kirkwood/common.h
> index 9248fa2..e0c2324 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -58,6 +58,11 @@ void dreamplug_init(void);
>  #else
>  static inline void dreamplug_init(void) {};
>  #endif
> +#ifdef CONFIG_MACH_TS219_DT
> +void qnap_dt_ts219_init(void);
> +#else
> +static inline void qnap_dt_ts219_init(void) {};
> +#endif
>  
>  #ifdef CONFIG_MACH_DLINK_KIRKWOOD_DT
>  void dnskw_init(void);
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
