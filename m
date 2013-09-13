From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Sep 2013 17:16:55 +0100
Subject: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
In-Reply-To: <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130913161654.GA5408@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 11:06:40AM +0100, Gregory CLEMENT wrote:

[...]

> +#define ARMADA_370_XP_MAX_STATES       3
> +
> +enum mv_pm_states {
> +       WFI = 0,
> +       MV_CPU_IDLE,
> +       MV_CPU_DEEP_IDLE,
> +};
> +
> +extern void v7_flush_dcache_all(void);
> +
> +/* Functions defined in suspend-armada-370-xp.S */
> +int armada_370_xp_cpu_resume(unsigned long);
> +int armada_370_xp_cpu_suspend(unsigned long);
> +
> +static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv,
> +                               int index)
> +{
> +       bool deepidle = false;
> +       unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> +
> +       armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume, hw_cpu);
> +
> +       if (index == MV_CPU_DEEP_IDLE)
> +               deepidle = true;
> +
> +       cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
> +
> +       cpu_init();

I do not think cpu_init() is needed. Either core resumes through
cpu_resume, and there cpu_init() is called for you, or there is no
reason to call cpu_init() since CPU was not shutdown.

> +
> +       armada_370_xp_pmsu_idle_restore();
> +
> +       return index;
> +}
> +
> +static struct cpuidle_driver armada_370_xp_idle_driver = {
> +       .name                   = "armada_370_xp_idle",
> +       .states[0]              = ARM_CPUIDLE_WFI_STATE,
> +       .states[1]              = {
> +               .enter                  = armada_370_xp_enter_idle,
> +               .exit_latency           = 10,
> +               .power_usage            = 50,
> +               .target_residency       = 100,
> +               .flags                  = CPUIDLE_FLAG_TIME_VALID,
> +               .name                   = "MV CPU IDLE",
> +               .desc                   = "CPU power down",
> +       },
> +       .states[2]              = {
> +               .enter                  = armada_370_xp_enter_idle,
> +               .exit_latency           = 100,
> +               .power_usage            = 5,
> +               .target_residency       = 1000,
> +               .flags                  = CPUIDLE_FLAG_TIME_VALID,
> +               .name                   = "MV CPU DEEP IDLE",
> +               .desc                   = "CPU and L2 Fabric power down",
> +       },
> +       .state_count = ARMADA_370_XP_MAX_STATES,
> +};
> +
> +static int __init armada_370_xp_cpuidle_init(void)
> +{
> +       if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
> +               return -ENODEV;
> +
> +       if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
> +               return -ENODEV;
> +
> +       pr_info("Initializing Armada-XP CPU power management ");
> +
> +       armada_370_xp_pmsu_enable_l2_powerdown_onidle();
> +
> +       return cpuidle_register(&armada_370_xp_idle_driver, NULL);
> +}
> +
> +module_init(armada_370_xp_cpuidle_init);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/cpuidle/suspend-armada-370-xp.S b/drivers/cpuidle/suspend-armada-370-xp.S
> new file mode 100644
> index 0000000..490bb9b
> --- /dev/null
> +++ b/drivers/cpuidle/suspend-armada-370-xp.S
> @@ -0,0 +1,91 @@
> +/*
> + * CPU idle low level implementation for Marvell Armada 370 and Armada XP SoCs
> + *
> + * Copyright (C) 2013 Marvell
> + *
> + * Nadav Haklai <nadavh@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + */
> +#include <linux/linkage.h>
> +
> +
> +/*
> +* armadaxp_cpu_suspend: enter cpu deepIdle state
> +* input:
> +*/
> +ENTRY(armada_370_xp_cpu_suspend)
> +/* Save ARM registers */
> +       stmfd   sp!, {r4 - r11, lr}     @ save registers on stack
> +
> +       bl armada_370_xp_pmsu_idle_prepare
> +       /*
> +        * Invalidate L1 data cache. Even though only invalidate is
> +        * necessary exported flush API is used here. Doing clean
> +        * on already clean cache would be almost NOP.
> +        */
> +       bl v7_flush_dcache_all
> +
> +       /*
> +        * Clear the SCTLR.C bit to prevent further data cache
> +        * allocation. Clearing SCTLR.C would make all the data accesses
> +        * strongly ordered and would not hit the cache.
> +        */
> +       mrc     p15, 0, r0, c1, c0, 0
> +       bic     r0, r0, #(1 << 2)       @ Disable the C bit
> +       mcr     p15, 0, r0, c1, c0, 0
> +       isb
> +
> +       bl v7_flush_dcache_all
> +

This code looks familiar and the first cache flush is not needed.

look at arch/arm/mach-vexpress/tc2_pm.c -> tc2_pm_down()

I know that probably the SMP bit in ACTLR is managed differently in this
architecture but still, cache flushing should still apply and the TC2
sequence is the proper one, unless you explain to me why that does not
work on this chipset.

> +       /* Data memory barrier and Data sync barrier */
> +       dsb
> +       dmb
> +
> +       bl armada_370_xp_disable_snoop_ena
> +
> +       dsb                             @ Data Synchronization Barrier
> +
> +/*
> + * ===================================
> + * == WFI instruction => Enter idle ==
> + * ===================================
> + */
> +
> +       wfi                             @ wait for interrupt

Here core is running out of coherency and I do not see any tlb invalidation in
the resume path from non-OFF mode. Please can you elaborate on this ?

> +/*
> + * ===================================
> + * == Resume path for non-OFF modes ==
> + * ===================================
> + */
> +
> +/* Enable SnoopEna - Exclusive */
> +       mov     r0, #1                  @ r0!=0 means use virtual address
> +       mov     r1, #0                  @ Do not add CPU to SMP group
> +       bl ll_set_cpu_coherent
> +
> +/* Re-enable C-bit if needed */
> +       mrc     p15, 0, r0, c1, c0, 0
> +       tst     r0, #(1 << 2)           @ Check C bit enabled?
> +       orreq   r0, r0, #(1 << 2)       @ Enable the C bit if cleared
> +       mcreq   p15, 0, r0, c1, c0, 0
> +       isb
> +
> +       ldmfd   sp!, {r4 - r11, pc}     @ restore regs and return
> +ENDPROC(armada_370_xp_cpu_suspend)
> +
> +/*
> +* armada_370_xp_cpu_resume: exit cpu deepIdle state
> +*/
> +ENTRY(armada_370_xp_cpu_resume)
> +       mov     r0, #0                  @ r0==0 means use physical address
> +       mov     r1, #1                  @ Add CPU to SMP group
> +       bl ll_set_cpu_coherent
> +
> +       /* Now branch to the common CPU resume function */
> +       b       cpu_resume
> +
> +ENDPROC(armada_370_xp_cpu_resume)

I have further comments on the set (in particular on the inner workings
of coherency and how CPUs get in and out of idle - ie how this is
managed by the power controller) but I will keep them for next version,
when the first set of review comments is addressed.

Thanks a lot,
Lorenzo
