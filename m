From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Feb 2015 12:29:00 +0000
Subject: [PATCH RFC] ARM: BCM5301X: Implement SMP support
In-Reply-To: <1423600375-18665-1-git-send-email-zajec5@gmail.com>
References: <1423600375-18665-1-git-send-email-zajec5@gmail.com>
Message-ID: <20150213122859.GA10496@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 08:32:55PM +0000, Rafa? Mi?ecki wrote:
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/boot/dts/bcm4708.dtsi       |   1 +
>  arch/arm/mach-bcm/Makefile           |   3 +
>  arch/arm/mach-bcm/bcm5301x_headsmp.S | 108 ++++++++++++++++++++
>  arch/arm/mach-bcm/bcm5301x_smp.c     | 185 +++++++++++++++++++++++++++++++++++
>  4 files changed, 297 insertions(+)
>  create mode 100644 arch/arm/mach-bcm/bcm5301x_headsmp.S
>  create mode 100644 arch/arm/mach-bcm/bcm5301x_smp.c
> 
> diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
> index 31141e8..ed4ddba 100644
> --- a/arch/arm/boot/dts/bcm4708.dtsi
> +++ b/arch/arm/boot/dts/bcm4708.dtsi
> @@ -15,6 +15,7 @@
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> +               enable-method = "brcm,bcm4708-smp";

This must be documented.

We really should be getting to the point where we have a small number of
standard(ish) enable methods rather than just adding a load of new IMP
DEF methods with pointless differences.

> 
>                 cpu at 0 {
>                         device_type = "cpu";
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 4c38674..ca12727 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -36,6 +36,9 @@ obj-$(CONFIG_ARCH_BCM2835)    += board_bcm2835.o
> 
>  # BCM5301X
>  obj-$(CONFIG_ARCH_BCM_5301X)   += bcm_5301x.o
> +ifeq ($(CONFIG_SMP),y)
> +obj-$(CONFIG_ARCH_BCM_5301X)   += bcm5301x_smp.o bcm5301x_headsmp.o
> +endif
> 
>  # BCM63XXx
>  obj-$(CONFIG_ARCH_BCM_63XX)    := bcm63xx.o
> diff --git a/arch/arm/mach-bcm/bcm5301x_headsmp.S b/arch/arm/mach-bcm/bcm5301x_headsmp.S
> new file mode 100644
> index 0000000..e8df65f
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm5301x_headsmp.S
> @@ -0,0 +1,108 @@
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + *
> + * Copyright 2003 - 2008 Broadcom Corporation
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +#include <asm/memory.h>
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +#define __virt_to_phys(x)      ((x) - PAGE_OFFSET)

This does not looks like something there should be a custom
implementation of.

> +
> +/*
> + * v7_l1_cache_invalidate
> + *
> + * Invalidate contents of L1 cache without flushing its contents
> + * into outer cache and memory. This is needed when the contents
> + * of the cache are unpredictable after power-up.
> + *
> + * corrupts r0-r6
> + */
> +ENTRY(v7_l1_cache_invalidate)
> +       mov     r0, #0
> +       mcr     p15, 2, r0, c0, c0, 0   @ set cache level to 1
> +       mrc     p15, 1, r0, c0, c0, 0   @ read CLIDR

Isn't that the CCSIDR, not the CLIDR?

You need an ISB between CSSELR writes and CCSIDR reads.

> +
> +       ldr     r1, =0x7fff
> +       and     r2, r1, r0, lsr #13     @ get max # of index size
> +
> +       ldr     r1, =0x3ff
> +       and     r3, r1, r0, lsr #3      @ NumWays - 1
> +       add     r2, r2, #1              @ NumSets
> +
> +       and     r0, r0, #0x7
> +       add     r0, r0, #4              @ SetShift
> +
> +       clz     r1, r3                  @ WayShift
> +       add     r4, r3, #1              @ NumWays
> +1:     sub     r2, r2, #1              @ NumSets--
> +       mov     r3, r4                  @ Temp = NumWays
> +2:     subs    r3, r3, #1              @ Temp--
> +       mov     r5, r3, lsl r1
> +       mov     r6, r2, lsl r0
> +       orr     r5, r5, r6              @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
> +       mcr     p15, 0, r5, c7, c6, 2   @ Invalidate line
> +       bgt     2b
> +       cmp     r2, #0
> +       bgt     1b
> +       dsb
> +       mov     r0,#0
> +       mcr     p15,0,r0,c7,c5,0        /* Invalidate icache */
> +       isb

SUrely you're missing a dsb after the i-cache maintenance?

> +       mov     pc, lr
> +ENDPROC(v7_l1_cache_invalidate)

This looks like a total mess. If you _really_ need this, factor it out
of the existing cache flush infrastructure. We don't need more broken
copies.

Do you have a guarantee that the CPU won't write back any of this
naturally before the invalidate is complete?

Is the CPU coherent at this point?

> +
> +/*
> + * Platform specific entry point for secondary CPUs.  This
> + * provides a "holding pen" into which all secondary cores are held
> + * until we're ready for them to initialise.
> + */
> +       __CPUINIT
> +ENTRY(bcm5301x_secondary_startup)
> +       /*
> +        * Get hardware CPU id of ours
> +        */
> +       mrc     p15, 0, r0, c0, c0, 5
> +       and     r0, r0, #15

Test all of the MPIDR.Aff* bits, please.

> +       /*
> +        * Wait on <pen_release> variable by physical address
> +        * to contain our hardware CPU id
> +        */
> +#ifdef CONFIG_SPARSEMEM
> +       ldr     r2, =(PAGE_OFFSET+SZ_128M)
> +       ldr     r1, =pen_release
> +       cmp     r1, r2
> +       bge     1f
> +       ldr     r2, =PAGE_OFFSET
> +       sub     r6, r1, r2
> +       b       2f
> +1:
> +       sub     r1, r1, r2
> +       ldr     r2, =PHYS_OFFSET2
> +       add     r6, r1, r2
> +2:

Huh? We really shouldn't have to care about SPARSEMEM in this kind of
code. I assume the fundamental issue here is your custom __virt_to_phys
implementation.

> +#else
> +       ldr     r6, =__virt_to_phys(pen_release)
> +#endif
> +pen:   ldr     r7, [r6]
> +       cmp     r7, r0
> +       bne     pen
> +       nop

Pointless nop?

> +       /*
> +        * In case L1 cache has unpredictable contents at power-up
> +        * clean its contents without flushing.
> +        */
> +       bl      v7_l1_cache_invalidate
> +       nop

Another pointless nop?

> +       /*
> +        * we've been released from the holding pen: secondary_stack
> +        * should now contain the SVC stack for this core
> +        */
> +       b       secondary_startup
> +
> +ENDPROC(bcm5301x_secondary_startup)
> +       .ltorg
> diff --git a/arch/arm/mach-bcm/bcm5301x_smp.c b/arch/arm/mach-bcm/bcm5301x_smp.c
> new file mode 100644
> index 0000000..1a173ec
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm5301x_smp.c
> @@ -0,0 +1,185 @@
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + *
> + * Copyright (C) 2002 ARM Ltd.
> + * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +#include <asm/cacheflush.h>
> +#include <asm/delay.h>
> +#include <asm/smp_scu.h>
> +
> +#include <linux/clockchips.h>
> +
> +/*
> + * There is a 1KB LUT located at 0xFFFF0400-0xFFFFFFFF, and its first entry
> + * is where the secondary entry point needs to be written
> +*/
> +#define SOC_ROM_BASE_PA                0xffff0000
> +#define SOC_ROM_LUT_OFF                0x400

We shouldn't be hard-coding physical addresses; those should come from
the DT.

> +
> +/* ENTRY in bcm5301x_headsmp.S */
> +extern void bcm5301x_secondary_startup(void);
> +
> +static DEFINE_SPINLOCK(boot_lock);
> +
> +static void __cpuinit write_pen_release(int val)
> +{
> +       pen_release = val;
> +       /* Make sure this store is visible to other CPUs */
> +       smp_wmb();
> +       __cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> +       outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));

Surely we have some common infrastructure to perform this sort of
maintenance?

> +}
> +
> +static void __init bcm5301x_smp_secondary_set_entry(void (*entry_point)(void))
> +{
> +       void __iomem *rombase = NULL;
> +       phys_addr_t lut_pa;
> +       u32 offset, mask;
> +       u32 val;
> +
> +       mask = (1UL << PAGE_SHIFT) - 1;
> +
> +       lut_pa = SOC_ROM_BASE_PA & ~mask;
> +       offset = SOC_ROM_BASE_PA &  mask;
> +       offset += SOC_ROM_LUT_OFF;
> +
> +       rombase = ioremap(lut_pa, PAGE_SIZE);
> +       if (!rombase)
> +               return;
> +       val = virt_to_phys(entry_point);
> +
> +       writel(val, rombase + offset);
> +
> +       smp_wmb();      /* probably not needed - io regs are not cached */

Surely the following DSB is sufficient?

> +       dsb_sev();      /* Exit WFI */
> +       mb();

What's the mb for?

> +
> +       iounmap(rombase);
> +}
> +
> +static void __init bcm5301x_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +       void __iomem *scu_base;
> +       unsigned int ncores;
> +
> +       if (!scu_a9_has_base()) {
> +               pr_warn("Unknown SCU base\n");
> +               return;
> +       }
> +
> +       scu_base = ioremap((phys_addr_t)scu_a9_get_base(), SZ_256);
> +       if (!scu_base) {
> +               pr_err("Failed to remap SCU\n");
> +               return;
> +       }
> +
> +       ncores = scu_get_core_count(scu_base);

Just read this from the DT as we do elsewhere.

> +       if (max_cpus > ncores) {
> +               unsigned int i;
> +
> +               pr_warn("Possible CPU mask exceeds available cores, reducing to %u\n",
> +                       ncores);
> +               for (i = ncores - 1; i < max_cpus; i++)
> +                       set_cpu_present(i, false);
> +               max_cpus = ncores;
> +       }
> +
> +       if (max_cpus > 1) {
> +               /* nobody is to be released from the pen yet */
> +               pen_release = -1;
> +
> +               /* Initialise the SCU */
> +               scu_enable(scu_base);
> +
> +               /* Let CPUs know where to start */
> +               bcm5301x_smp_secondary_set_entry(bcm5301x_secondary_startup);
> +       }
> +
> +       iounmap(scu_base);
> +}

[...]

> +static int __cpuinit bcm5301x_smp_boot_secondary(unsigned int cpu,
> +                                                struct task_struct *idle)
> +{
> +       unsigned long timeout;
> +
> +       /*
> +        * set synchronisation state between this boot processor
> +        * and the secondary one
> +        */
> +       spin_lock(&boot_lock);
> +
> +       /*
> +        * The secondary processor is waiting to be released from
> +        * the holding pen - release it, then wait for it to flag
> +        * that it has been released by resetting pen_release.
> +        *
> +        * Note that "pen_release" is the hardware CPU ID, whereas
> +        * "cpu" is Linux's internal ID.
> +        */
> +       write_pen_release(cpu);

As far as I can tell you're relying on the logical ID being equivalent
to MPDR.Aff0, which isn't necessarily true. Either use the physical ID
or use the actual logical ID.

> +
> +       dsb_sev();
> +
> +       /*
> +        * Timeout set on purpose in jiffies so that on slow processors
> +        * that must also have low HZ it will wait longer.
> +        */
> +       timeout = jiffies + (HZ * 10);
> +
> +       udelay(100);
> +
> +       /*
> +        * If the secondary CPU was waiting on WFE, it should
> +        * be already watching <pen_release>, or it could be
> +        * waiting in WFI, send it an IPI to be sure it wakes.
> +        */
> +       if (pen_release != -1)
> +               tick_broadcast(cpumask_of(cpu));

NAK. This is not what tick_broadcast is intended for.

If you need an IPI then send an IPI, don't piggyback on the timekeeping
infrastructure.

Mark.
