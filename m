From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 19 Aug 2011 14:43:57 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <1313526898-19920-3-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110819064356.GC12527@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds basic support for the Calxeda Highbank platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig                                  |   17 ++
>  arch/arm/Makefile                                 |    1 +
>  arch/arm/mach-highbank/Makefile                   |    1 +
>  arch/arm/mach-highbank/Makefile.boot              |    1 +
>  arch/arm/mach-highbank/clock.c                    |   63 ++++++++
>  arch/arm/mach-highbank/core.h                     |    3 +
>  arch/arm/mach-highbank/highbank.c                 |  164 +++++++++++++++++++++
>  arch/arm/mach-highbank/include/mach/debug-macro.S |   20 +++
>  arch/arm/mach-highbank/include/mach/entry-macro.S |    9 +
>  arch/arm/mach-highbank/include/mach/gpio.h        |    1 +
>  arch/arm/mach-highbank/include/mach/io.h          |    8 +
>  arch/arm/mach-highbank/include/mach/irqs.h        |    6 +
>  arch/arm/mach-highbank/include/mach/memory.h      |    1 +
>  arch/arm/mach-highbank/include/mach/system.h      |   26 ++++
>  arch/arm/mach-highbank/include/mach/timex.h       |    6 +
>  arch/arm/mach-highbank/include/mach/uncompress.h  |    9 +
>  arch/arm/mach-highbank/include/mach/vmalloc.h     |    6 +
>  arch/arm/mach-highbank/sysregs.h                  |   30 ++++
>  arch/arm/mach-highbank/system.c                   |   33 ++++
>  arch/arm/mm/Kconfig                               |    2 +-
>  20 files changed, 406 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-highbank/Makefile
>  create mode 100644 arch/arm/mach-highbank/Makefile.boot
>  create mode 100644 arch/arm/mach-highbank/clock.c
>  create mode 100644 arch/arm/mach-highbank/core.h
>  create mode 100644 arch/arm/mach-highbank/highbank.c
>  create mode 100644 arch/arm/mach-highbank/include/mach/debug-macro.S
>  create mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
>  create mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/io.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/memory.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/system.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/timex.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/vmalloc.h
>  create mode 100644 arch/arm/mach-highbank/sysregs.h
>  create mode 100644 arch/arm/mach-highbank/system.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d9..eecee3d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -318,6 +318,23 @@ config ARCH_BCMRING
>  	help
>  	  Support for Broadcom's BCMRing platform.
>  
> +config ARCH_HIGHBANK
> +	bool "Calxeda Highbank-based"
> +	select CPU_V7
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
> +	select ARM_GIC
> +	select HAVE_ARM_SCU
> +	select ARM_AMBA
> +	select ARM_TIMER_SP804
> +	select PL330
> +	select CLKDEV_LOOKUP
> +	select GENERIC_CLOCKEVENTS
> +	select USE_OF
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	help
> +	  Support for the Calxeda Highbank SoC based boards.
> +
>  config ARCH_CLPS711X
>  	bool "Cirrus Logic CLPS711x/EP721x-based"
>  	select CPU_ARM720T
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 70c424e..451097e 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -141,6 +141,7 @@ machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
>  machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
>  machine-$(CONFIG_ARCH_GEMINI)		:= gemini
>  machine-$(CONFIG_ARCH_H720X)		:= h720x
> +machine-$(CONFIG_ARCH_HIGHBANK)		:= highbank
>  machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
>  machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
>  machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
> diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
> new file mode 100644
> index 0000000..b5de3b9
> --- /dev/null
> +++ b/arch/arm/mach-highbank/Makefile
> @@ -0,0 +1 @@
> +obj-y					:= clock.o highbank.o system.o
> diff --git a/arch/arm/mach-highbank/Makefile.boot b/arch/arm/mach-highbank/Makefile.boot
> new file mode 100644
> index 0000000..dae9661
> --- /dev/null
> +++ b/arch/arm/mach-highbank/Makefile.boot
> @@ -0,0 +1 @@
> +zreladdr-y	:= 0x00008000
> diff --git a/arch/arm/mach-highbank/clock.c b/arch/arm/mach-highbank/clock.c
> new file mode 100644
> index 0000000..8464e14
> --- /dev/null
> +++ b/arch/arm/mach-highbank/clock.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright 2011 Calxeda, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +
> +
> +struct clk {
> +	unsigned long rate;
> +};
> +
> +int clk_enable(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +void clk_disable(struct clk *clk)
> +{}
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	return clk->rate;
> +}
> +
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	return clk->rate;
> +}
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	return 0;
> +}
> +
> +static struct clk eclk = { .rate = 200000000 };
> +static struct clk pclk = { .rate = 150000000 };
> +
> +static struct clk_lookup lookups[] = {
> +	{ .clk = &pclk, .con_id = "apb_pclk", },
> +	{ .clk = &pclk, .dev_id = "sp804", },
> +	{ .clk = &eclk, .dev_id = "ffe0e000.sdhci", },
> +	{ .clk = &pclk, .dev_id = "fff36000.serial", },
> +};
> +
> +void __init highbank_clocks_init(void)
> +{
> +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> +}
> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> new file mode 100644
> index 0000000..b5aa45f
> --- /dev/null
> +++ b/arch/arm/mach-highbank/core.h
> @@ -0,0 +1,3 @@
> +extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
> +extern void __iomem *a9_base_addr;
> +extern void highbank_clocks_init(void);
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> new file mode 100644
> index 0000000..49bbd13
> --- /dev/null
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -0,0 +1,164 @@
> +/*
> + * Copyright 2010-2011 Calxeda, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/unified.h>
> +#include <asm/smp_scu.h>
> +#include <asm/hardware/arm_timer.h>
> +#include <asm/hardware/timer-sp.h>
> +#include <asm/hardware/gic.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/time.h>
> +#include <mach/irqs.h>
> +
> +#include "core.h"
> +#include "sysregs.h"
> +
> +#define HB_DEBUG_LL_PHYS_BASE	0xfff36000
> +
> +/* Static virtual mappings */
> +#define HB_DEBUG_LL_VIRT_BASE	0xfee36000
> +#define HB_MPIC_VIRT_BASE	0xfee00000
> +
> +void __iomem *a9_base_addr = ((void __iomem *)(HB_MPIC_VIRT_BASE));
> +void __iomem *sregs_base;
> +
> +static struct map_desc highbank_io_desc[] __initdata = {
> +	{
> +		.virtual	= HB_MPIC_VIRT_BASE,
> +		.pfn		= 0, /* run-time */
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +#ifdef CONFIG_DEBUG_LL
> +	{
> +		.virtual	= HB_DEBUG_LL_VIRT_BASE,
> +		.pfn		= __phys_to_pfn(HB_DEBUG_LL_PHYS_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +#endif
> +};
> +
> +static void __init highbank_map_io(void)
> +{
> +	unsigned long base;
> +
> +	/* Get SCU base */
> +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> +
> +	highbank_io_desc[0].pfn = __phys_to_pfn(base);
> +	iotable_init(highbank_io_desc, ARRAY_SIZE(highbank_io_desc));
> +}
> +
It's a great demo that we can get this base address from CA9 itself.
However I'm wondering if we have to do so, since this address should
be known for given SoC.  Can we put this known base into device tree
and map it when needed?  In that case, we can save another static
mapping.

-- 
Regards,
Shawn
