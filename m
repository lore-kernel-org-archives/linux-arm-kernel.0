From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 02 Sep 2010 10:09:17 -0700
Subject: [PATCH v2] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <1283281015-28360-1-git-send-email-michael.williamson@criticallink.com>
	(Michael Williamson's message of "Tue, 31 Aug 2010 14:56:55 -0400")
References: <1283281015-28360-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <87d3sw9io2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
> on the da850 davinci CPU architecture.  Information on these SOMs may be
> found at http://www.mitydsp.com.
>
> Basic support for the console UART, NAND, and EMAC (MII interface) is
> included in this patch.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

Looks good, one comple very minor things left...

> ---
> Changes since v1:
>    1) Split out defconfig changes to separate patch.
>    2) Split out console init changes to DA8XX EVMS to separate patch.
>    3) Change a pr_info() to a pr_debug().
>
>  arch/arm/mach-davinci/Kconfig                   |    9 +
>  arch/arm/mach-davinci/Makefile                  |    1 +
>  arch/arm/mach-davinci/board-mityomapl138.c      |  220 +++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
>  4 files changed, 231 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-davinci/board-mityomapl138.c
>
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index 2bf03e9..633eccb 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -185,6 +185,15 @@ config MACH_TNETV107X
>  	help
>  	  Say Y here to select the TI TNETV107X Evaluation Module.
>  
> +config MACH_MITYOMAPL138
> +	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
> +	default ARCH_DAVINCI_DA850

We have a (admittedly arbitrary) policy of only enabling the official
EVM boards in the Kconfig.  However, feel free to enable your board
by default in da8xx_omapl_defconfig.

> +	depends on ARCH_DAVINCI_DA850
> +	help
> +	  Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
> +	  System on Module.  Information on this SoM may be found at
> +	  http://www.mitydsp.com
> +
>  config DAVINCI_MUX
>  	bool "DAVINCI multiplexing support"
>  	depends on ARCH_DAVINCI
> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
> index eab4c0f..3e966e8 100644
> --- a/arch/arm/mach-davinci/Makefile
> +++ b/arch/arm/mach-davinci/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)	+= board-dm365-evm.o
>  obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
>  obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
>  obj-$(CONFIG_MACH_TNETV107X)		+= board-tnetv107x-evm.o
> +obj-$(CONFIG_MACH_MITYOMAPL138)		+= board-mityomapl138.o
>  
>  # Power Management
>  obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> new file mode 100644
> index 0000000..f95cd9c
> --- /dev/null
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -0,0 +1,220 @@
> +/*
> + * Critical Link MityOMAP-L138 SoM
> + *
> + * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of
> + * any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/common.h>
> +#include <mach/cp_intc.h>
> +#include <mach/da8xx.h>
> +#include <mach/nand.h>
> +#include <mach/mux.h>
> +
> +#define MITYOMAPL138_PHY_MASK		0x08 /* hardcoded for now */
> +#define MITYOMAPL138_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
> +
> +/*
> + * MityDSP-L138 includes a 256 MByte large-page NAND flash
> + * (128K blocks).
> + */
> +struct mtd_partition mityomapl138_nandflash_partition[] = {
> +	{
> +		.name		= "rootfs",
> +		.offset		= 0,
> +		.size		= SZ_128M,
> +		.mask_flags	= 0, /* MTD_WRITEABLE, */
> +	},
> +	{
> +		.name		= "homefs",
> +		.offset		= MTDPART_OFS_APPEND,
> +		.size		= MTDPART_SIZ_FULL,
> +		.mask_flags	= 0,
> +	},
> +};
> +
> +static struct davinci_nand_pdata mityomapl138_nandflash_data = {
> +	.parts		= mityomapl138_nandflash_partition,
> +	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
> +	.ecc_mode	= NAND_ECC_HW,
> +	.options	= NAND_USE_FLASH_BBT | NAND_BUSWIDTH_16,
> +	.ecc_bits   = 1, /* 4 bit mode is not supported with 16 bit NAND */

Missing a tab in this list line for alignment.

[...]

Kevin
