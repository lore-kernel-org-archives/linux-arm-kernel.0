From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 10:41:32 +0000
Subject: [PATCH V5 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
References: <1353446150-10088-1-git-send-email-gregory.clement@free-electrons.com>
 <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121121104132.GD11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:15:49PM +0000, Gregory CLEMENT wrote:
> From: Yehuda Yitschak <yehuday@marvell.com>
> 
> 1. added smp init functions in platsmp.c
> 2. added secondary cpu entry point in headsmp.S
> 3. added hotplog initial support in hotplug.c

hotplug

> 4. added SMP support for PJ4B cpu

Again, I think the commit message could probably be improved from a numbered
list...

> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig    |    3 +
>  arch/arm/mach-mvebu/Kconfig         |    1 +
>  arch/arm/mach-mvebu/Makefile        |    2 +
>  arch/arm/mach-mvebu/armada-370-xp.c |    3 +
>  arch/arm/mach-mvebu/common.h        |    3 +
>  arch/arm/mach-mvebu/headsmp.S       |   50 +++++++++++++++
>  arch/arm/mach-mvebu/hotplug.c       |   30 +++++++++
>  arch/arm/mach-mvebu/platsmp.c       |  121 +++++++++++++++++++++++++++++++++++
>  8 files changed, 213 insertions(+)
>  create mode 100644 arch/arm/mach-mvebu/headsmp.S
>  create mode 100644 arch/arm/mach-mvebu/hotplug.c
>  create mode 100644 arch/arm/mach-mvebu/platsmp.c
> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 3458752..da598d3 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -12,6 +12,9 @@ CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_XP=y
>  # CONFIG_CACHE_L2X0 is not set
> +# CONFIG_SWP_EMULATE is not set
> +CONFIG_SMP=y
> +# CONFIG_LOCAL_TIMERS is not set
>  CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  # CONFIG_COMPACTION is not set
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index f4c3bf8..c934e1d 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -21,6 +21,7 @@ menu "Marvell SOC with device tree"
>  config MACH_ARMADA_370_XP
>  	bool
>  	select ARMADA_370_XP_TIMER
> +	select HAVE_SMP
>  	select CPU_PJ4B
>  
>  config MACH_ARMADA_370
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 2e3ec11..5dcb369 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -3,3 +3,5 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  
>  obj-y += system-controller.o
>  obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
> +obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
> +obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index 3292d6d..472e70f 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -23,6 +23,7 @@
>  #include <asm/mach/time.h>
>  #include "armada-370-xp.h"
>  #include "common.h"
> +#include "coherency.h"
>  
>  static struct map_desc armada_370_xp_io_desc[] __initdata = {
>  	{
> @@ -51,6 +52,7 @@ struct sys_timer armada_370_xp_timer = {
>  static void __init armada_370_xp_dt_init(void)
>  {
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	coherency_init();
>  }
>  
>  static const char * const armada_370_xp_dt_board_dt_compat[] = {
> @@ -60,6 +62,7 @@ static const char * const armada_370_xp_dt_board_dt_compat[] = {
>  };
>  
>  DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
> +	.smp		= smp_ops(armada_xp_smp_ops),
>  	.init_machine	= armada_370_xp_dt_init,
>  	.map_io		= armada_370_xp_map_io,
>  	.init_irq	= armada_370_xp_init_irq,
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index b5cd7e7..b711869 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -20,7 +20,10 @@ void mvebu_restart(char mode, const char *cmd);
>  void armada_370_xp_init_irq(void);
>  void armada_370_xp_handle_irq(struct pt_regs *regs);
>  
> +void armada_xp_cpu_die(unsigned int cpu);
>  
>  int armada_370_xp_coherency_init(void);
>  int armada_370_xp_pmsu_init(void);
> +void armada_xp_secondary_startup(void);
> +extern struct smp_operations armada_xp_smp_ops;
>  #endif
> diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
> new file mode 100644
> index 0000000..994eecc
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/headsmp.S
> @@ -0,0 +1,50 @@
> +/*
> + * SMP support: Entry point for secondary CPUs
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Yehuda Yitschak <yehuday@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * This file implements the assembly entry point for secondary CPUs in
> + * an SMP kernel. The only thing we need to do is to add the CPU to
> + * the coherency fabric by writing to 2 registers. Currently the base
> + * register addresses are hard coded due to the early initialisation
> + * problems.
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +/*
> + * At this stage the secondary CPUs don't have acces yet to the MMU, so
> + * we have to provide physical addresses
> + */
> +#define ARMADA_XP_CFB_BASE	     0xD0020200
> +
> +	__CPUINIT
> +
> +/*
> + * Armada XP specific entry point for secondary CPUs.
> + * We add the CPU to the coherency fabric and then jump to secondary
> + * startup
> + */
> +ENTRY(armada_xp_secondary_startup)
> +
> +	/* Read CPU id */
> + 	mrc     p15, 0, r1, c0, c0, 5
> +	and     r1, r1, #0xF
> +
> +	/* Add CPU to coherency fabric */
> +	ldr     r0, = ARMADA_XP_CFB_BASE
> +	mov	lr, pc
> +
> +	b	ll_set_cpu_coherent
> +	b	secondary_startup

Why didn't you use my adr suggestion here?

Will
