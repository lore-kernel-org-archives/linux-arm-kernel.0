From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 13:18:04 +0200
Subject: [PATCH 25/29] ARM: orion5x: remove unneeded code for edmini_v2
In-Reply-To: <1397400006-4315-26-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-26-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BC3EC.5060202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:40 PM, Thomas Petazzoni wrote:
> The edmini_v2 platform is now fully converted to the Device Tree, so
> we can get rid of the old style board-file and the related Kconfig
> option.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I love code removal ;)

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/mach-orion5x/Kconfig           |  8 -----
>   arch/arm/mach-orion5x/Makefile          |  1 -
>   arch/arm/mach-orion5x/board-dt.c        |  3 --
>   arch/arm/mach-orion5x/common.h          |  7 -----
>   arch/arm/mach-orion5x/edmini_v2-setup.c | 53 ---------------------------------
>   5 files changed, 72 deletions(-)
>   delete mode 100644 arch/arm/mach-orion5x/edmini_v2-setup.c
>
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 3c69a3c..928f4cb 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -107,14 +107,6 @@ config MACH_MV2120
>   	  Say 'Y' here if you want your kernel to support the
>   	  HP Media Vault mv2120 or mv5100.
>
> -config MACH_EDMINI_V2_DT
> -	bool "LaCie Ethernet Disk mini V2 (Flattened Device Tree)"
> -	select I2C_BOARDINFO
> -	select ARCH_ORION5X_DT
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  LaCie Ethernet Disk mini V2 (Flattened Device Tree).
> -
>   config MACH_D2NET
>   	bool "LaCie d2 Network"
>   	select I2C_BOARDINFO
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
> index 45da805..e8fdbdd 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -23,4 +23,3 @@ obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
>   obj-$(CONFIG_MACH_LINKSTATION_LSCHL)	+= ls-chl-setup.o
>
>   obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
> -obj-$(CONFIG_MACH_EDMINI_V2_DT)	+= edmini_v2-setup.o
> diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
> index 38b54f1..c621f37 100644
> --- a/arch/arm/mach-orion5x/board-dt.c
> +++ b/arch/arm/mach-orion5x/board-dt.c
> @@ -66,9 +66,6 @@ static void __init orion5x_dt_init(void)
>   		cpu_idle_poll_ctrl(true);
>   	}
>
> -	if (of_machine_is_compatible("lacie,ethernet-disk-mini-v2"))
> -		edmini_v2_init();
> -
>   	of_platform_populate(NULL, of_default_bus_match_table,
>   			     orion5x_auxdata_lookup, NULL);
>   }
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index 7548db2..4470e31 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -64,13 +64,6 @@ int orion5x_pci_sys_setup(int nr, struct pci_sys_data *sys);
>   struct pci_bus *orion5x_pci_sys_scan_bus(int nr, struct pci_sys_data *sys);
>   int orion5x_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
>
> -/* board init functions for boards not fully converted to fdt */
> -#ifdef CONFIG_MACH_EDMINI_V2_DT
> -void edmini_v2_init(void);
> -#else
> -static inline void edmini_v2_init(void) {};
> -#endif
> -
>   struct meminfo;
>   struct tag;
>   extern void __init tag_fixup_mem32(struct tag *, char **, struct meminfo *);
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> deleted file mode 100644
> index 6bef2d5..0000000
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -/*
> - * arch/arm/mach-orion5x/edmini_v2-setup.c
> - *
> - * LaCie Ethernet Disk mini V2 Setup
> - *
> - * Copyright (C) 2008 Christopher Moore <moore@free.fr>
> - * Copyright (C) 2008 Albert Aribaud <albert.aribaud@free.fr>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -/*
> - * TODO: add Orion USB device port init when kernel.org support is added.
> - * TODO: add flash write support: see below.
> - * TODO: add power-off support.
> - * TODO: add I2C EEPROM support.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/mbus.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/gpio.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include <mach/orion5x.h>
> -#include "common.h"
> -#include "mpp.h"
> -
> -/*****************************************************************************
> - * EDMINI_V2 Info
> - ****************************************************************************/
> -
> -/*****************************************************************************
> - * General Setup
> - ****************************************************************************/
> -
> -void __init edmini_v2_init(void)
> -{
> -	pr_notice("edmini_v2: USB device port, flash write and power-off "
> -		  "are not yet supported.\n");
> -}
>
