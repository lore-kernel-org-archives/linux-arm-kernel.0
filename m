From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Apr 2013 22:25:35 +0900
Subject: [PATCH 2/2] ARM: shmobile: sh73a0: Suspend-to-RAM Power Off mode
In-Reply-To: <1363872697-11267-3-git-send-email-hechtb+renesas@gmail.com>
References: <1363872697-11267-1-git-send-email-hechtb+renesas@gmail.com>
 <1363872697-11267-3-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130409132534.GB21045@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  3? 21, 2013 at 02:31:37?? +0100, Bastian Hecht wrote:
> We add Power Off mode defined by the ARM architecture as our
> Suspend-to-RAM mechanism. Here the L2 cache keeps its power and we only
> take care to flush the L1. Different startup paths are added for the two
> CPUs, one leading to cpu_resume() and the other to secondary_startup().
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Bastian, could you please let me know about the status of this patch?
Is it awaiting review?

> ---
>  arch/arm/mach-shmobile/Makefile              |    2 +-
>  arch/arm/mach-shmobile/headsmp-sh73a0.S      |   72 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/pm-sh73a0.c           |   32 ++++++++++--
>  arch/arm/mach-shmobile/smp-sh73a0.c          |    9 +++-
>  5 files changed, 109 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S
> 
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index c621edf..1d33d89 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
>  
>  # SMP objects
>  smp-y				:= platsmp.o headsmp.o
> -smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
> +smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-sh73a0.o headsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
>  smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
>  
> diff --git a/arch/arm/mach-shmobile/headsmp-sh73a0.S b/arch/arm/mach-shmobile/headsmp-sh73a0.S
> new file mode 100644
> index 0000000..6ffed46
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/headsmp-sh73a0.S
> @@ -0,0 +1,72 @@
> +/*
> + * SMP support for SoC sh73a0
> + *
> + * Copyright (C) 2013 Bastian Hecht
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +#include <asm/memory.h>
> +
> +        __CPUINIT
> +
> +ENTRY(sh73a0_primary_resume)
> +        bl      v7_invalidate_l1
> +        b       cpu_resume
> +ENDPROC(sh73a0_primary_resume)
> +
> +ENTRY(sh73a0_secondary_startup)
> +        bl      v7_invalidate_l1
> +        b       secondary_startup
> +ENDPROC(sh73a0_primary_resume)
> +
> +/*
> + * Reset vector for both CPUs.
> + *
> + * This function will be mapped to address 0 by the SBAR register and is the
> + * general wakeup vector.
> + * For both CPUs we need to set the SCU power flag to Run Mode and invalidate
> + * the L1 cache so no random data get flushed out later.
> + * We can't use v7_invalidate_l1() directly as a normal branch is out of range
> + * here and so we need a long jump. We jump to the physical address as the
> + * MMU is still turned off.
> + *
> + * We do not need to worry about CPU1 running ahead of CPU0 as the secondary
> + * CPU of the sh73a0 needs to be woken using the WUPCR register. This is done
> + * in sh73a0_boot_secondary().
> + */
> +        .align  12
> +ENTRY(sh73a0_reset_vector)
> +        /* Retrieve the CPU ID and keep it in r4 */
> +        mrc     p15, 0, r4, c0, c0, 5   @ read MIPDR
> +        and     r4, r4, #3              @ mask out cpu ID
> +
> +        /*
> +         * We clear the SCU Power status flag to prepare for the
> +         * L1 coherency mode
> +         */
> +        mov     r0, r4                  @ copy CPU ID
> +        lsl     r0, r0, #3              @ we will shift by cpu_id * 8 bits
> +	ldr	r1, 3f
> +	ldr	r1, [r1]		@ SCU base address
> +        ldr     r2, [r1, #8]            @ SCU Power Status Register
> +        mov     r3, #3
> +        bic     r2, r2, r3, lsl r0      @ Clear bits of our CPU (Run Mode)
> +        str     r2, [r1, #8]            @ write back
> +
> +        /*
> +         * Depending on the CPU ID we either resume our primary core from
> +         * sleeping or bring up the secondary CPU
> +         */
> +        cmp     r4, #0                  @ if CPU0
> +        ldreq   pc, 1f                  @ jump to sh73a0_primary_resume
> +        ldr     pc, 2f                  @ jump to sh73a0_secondary_startup
> +
> +1:      .long   sh73a0_primary_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
> +2:      .long   sh73a0_secondary_startup - PAGE_OFFSET + PLAT_PHYS_OFFSET
> +3:      .long	shmobile_scu_base - PAGE_OFFSET + PLAT_PHYS_OFFSET
> +ENDPROC(sh73a0_reset_vector)
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index 03f73de..842bb35 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -45,6 +45,7 @@ extern void sh73a0_add_standard_devices_dt(void);
>  extern void sh73a0_clock_init(void);
>  extern void sh73a0_pinmux_init(void);
>  extern void sh73a0_pm_init(void);
> +extern void sh73a0_reset_vector(void);
>  extern struct clk sh73a0_extal1_clk;
>  extern struct clk sh73a0_extal2_clk;
>  extern struct clk sh73a0_extcki_clk;
> diff --git a/arch/arm/mach-shmobile/pm-sh73a0.c b/arch/arm/mach-shmobile/pm-sh73a0.c
> index 99086e9..7e8e0a1 100644
> --- a/arch/arm/mach-shmobile/pm-sh73a0.c
> +++ b/arch/arm/mach-shmobile/pm-sh73a0.c
> @@ -1,30 +1,54 @@
>  /*
>   * sh73a0 Power management support
>   *
> - *  Copyright (C) 2012 Bastian Hecht <hechtb+renesas@gmail.com>
> + *  Copyright (C) 2013 Bastian Hecht <hechtb+renesas@gmail.com>
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
>  
> +#include <linux/cpuidle.h>
> +#include <linux/module.h>
>  #include <linux/suspend.h>
> +#include <linux/io.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp_scu.h>
> +#include <asm/suspend.h>
>  #include <mach/common.h>
>  
>  #ifdef CONFIG_SUSPEND
> -static int sh73a0_enter_suspend(suspend_state_t suspend_state)
> +/*
> + * sh73a0_do_poweroff: Power off the main CPU
> + *
> + * The L2 cache doesn't loose power in Power Off mode - ignore it.
> + * After flushing the L1 cache we don't take care to disable it as we
> + * only work on temporary values in a UP environment and it gets invalidated
> + * on startup. Just straight take down the ARM core.
> + */
> +static int sh73a0_do_poweroff(unsigned long unused)
>  {
> +	flush_cache_all();
> +	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
>  	cpu_do_idle();
> +
> +	return 0;
> +}
> +
> +static int sh73a0_enter_poweroff_suspend(suspend_state_t suspend_state)
> +{
> +	cpu_suspend(0, sh73a0_do_poweroff);
> +
>  	return 0;
>  }
>  
>  static void sh73a0_suspend_init(void)
>  {
> -	shmobile_suspend_ops.enter = sh73a0_enter_suspend;
> +	shmobile_suspend_ops.enter = sh73a0_enter_poweroff_suspend;
>  }
>  #else
>  static void sh73a0_suspend_init(void) {}
> -#endif
> +#endif	/* CONFIG_SUSPEND */
>  
>  void __init sh73a0_pm_init(void)
>  {
> diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
> index 5ae502b..348714e 100644
> --- a/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ b/arch/arm/mach-shmobile/smp-sh73a0.c
> @@ -70,9 +70,14 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	scu_enable(shmobile_scu_base);
>  
> -	/* Map the reset vector (in headsmp-scu.S) */
> +	/*
> +	 * Map the general reset vector that is hit from multiple paths:
> +	 * - Primary CPU resume at wakeup time
> +	 * - Secondary startup at boot time
> +	 * - Secondary startup at wakeup time
> +	 */
>  	__raw_writel(0, APARMBAREA);      /* 4k */
> -	__raw_writel(__pa(shmobile_secondary_vector_scu), SBAR);
> +	__raw_writel(__pa(sh73a0_reset_vector), SBAR);
>  
>  	/* enable cache coherency on booting CPU */
>  	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
