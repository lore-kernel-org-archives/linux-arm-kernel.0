From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 16:06:55 +0000
Subject: [PATCH V4 07/62] ST SPEAr13XX: Adding machine specific src files
In-Reply-To: <86b571fe06bdc264254a4125ec32195fdff46457.1295333958.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<86b571fe06bdc264254a4125ec32195fdff46457.1295333958.git.viresh.kumar@st.com>
Message-ID: <20110118160655.GD16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 12:41:35PM +0530, Viresh Kumar wrote:
> diff --git a/arch/arm/mach-spear13xx/headsmp.S b/arch/arm/mach-spear13xx/headsmp.S
> new file mode 100644
> index 0000000..30761d3
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/headsmp.S
> @@ -0,0 +1,96 @@
> +/*
> + * arch/arm/mach-spear13XX/headsmp.S
> + *
> + * Picked from realview
> + * Copyright (c) 2010 ST Microelectronics Limited
> + * Shiraz Hashim <shiraz.hashim@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +	__INIT

Is this ever called after the kernel text is thrown away?  What if we
add support in the generic code to start with secondary CPUs offline
as a power saving or boot time feature?

> +
> +/*
> + * This one is picked from Tegra :-
> + *
> + * The secondary kernel init calls v7_flush_dcache_all before it enables
> + * the L1; however, the L1 comes out of reset in an undefined state, so
> + * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
> + * of cache lines with uninitialized data and uninitialized tags to get
> + * written out to memory, which does really unpleasant things to the ain
> + * processor. We fix this by performing an invalidate, rather than a
> + * clean + invalidate, before jumping into the kernel.
> + */
> +ENTRY(v7_invalidate_l1)
> +	mov	r0, #0
> +	mcr	p15, 2, r0, c0, c0, 0
> +	mrc	p15, 1, r0, c0, c0, 0
> +
> +	ldr	r1, =0x7fff
> +	and	r2, r1, r0, lsr #13
> +
> +	ldr	r1, =0x3ff
> +
> +	and	r3, r1, r0, lsr #3	@ NumWays - 1
> +	add	r2, r2, #1	@ NumSets
> +
> +	and	r0, r0, #0x7
> +	add	r0, r0, #4	@ SetShift
> +
> +	clz	r1, r3		@ WayShift
> +	add	r4, r3, #1	@ NumWays
> +1:	sub	r2, r2, #1	@ NumSets--
> +	mov	r3, r4		@ Temp = NumWays
> +2:	subs	r3, r3, #1	@ Temp--
> +	mov	r5, r3, lsl r1
> +	mov	r6, r2, lsl r0
> +	orr	r5, r5, r6	@ Reg = Temp<<WayShift)|(NumSets<<SetShift)
> +	mcr	p15, 0, r5, c7, c6, 2
> +	bgt	2b
> +	cmp	r2, #0
> +	bgt	1b
> +	dsb
> +	isb
> +	mov	pc, lr
> +ENDPROC(v7_invalidate_l1)

This code appears to have its only caller commented out.  Should it be
removed?

> +
> +/*
> + * spear13xx specific entry point for secondary CPUs. This provides
> + * a "holding pen" into which all secondary cores are held until we're
> + * ready for them to initialise.
> + */
> +ENTRY(spear13xx_secondary_startup)
> +	/* If we don't do this then we have a crash */
> +
> +	/*
> +	 * Since now this is being called from xloader so removing it
> +	 * here
> +	 */
> +#if 0
> +	bl v7_invalidate_l1
> +#endif
> +
> +	mrc	p15, 0, r0, c0, c0, 5
> +	and	r0, r0, #15
> +	adr	r4, 1f
> +	ldmia	r4, {r5, r6}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +pen:	ldr	r7, [r6]
> +	cmp	r7, r0
> +	bne	pen
> +
> +	/*
> +	 * we've been released from the holding pen: secondary_stack
> +	 * should now contain the SVC stack for this core
> +	 */
> +	b	secondary_startup
> +
> +	.align
> +1:	.long	.
> +	.long	pen_release
...
> +volatile int __cpuinitdata pen_release = -1;
> +static DEFINE_SPINLOCK(boot_lock);
> +
> +/*
> + * Write pen_release in a way that is guaranteed to be visible to all
> + * observers, irrespective of whether they're taking part in coherency
> + * or not. This is necessary for the hotplug code to work reliably.
> + */
> +static void write_pen_release(int val)
> +{
> +	pen_release = val;
> +	smp_wmb();
> +	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> +	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> +}
> +
> +static void __iomem *scu_base_addr(void)
> +{
> +	return __io_address(SPEAR13XX_SCU_BASE);
> +}
> +
> +void __cpuinit platform_secondary_init(unsigned int cpu)
> +{
> +	/*
> +	 * if any interrupts are already enabled for the primary
> +	 * core (e.g. timer irq), then they will not have been enabled
> +	 * for us: do so
> +	 */
> +	gic_secondary_init(0);
> +
> +	/*
> +	 * let the primary processor know we're out of the
> +	 * pen, then head off into the C entry point
> +	 */
> +	write_pen_release(-1);
> +
> +	/*
> +	 * Synchronise with the boot thread.
> +	 */
> +	spin_lock(&boot_lock);
> +	spin_unlock(&boot_lock);
> +}
> +
> +int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	unsigned long timeout;
> +
> +	/*
> +	 * set synchronisation state between this boot processor
> +	 * and the secondary one
> +	 */
> +	spin_lock(&boot_lock);
> +
> +	/*
> +	 * The secondary processor is waiting to be released from
> +	 * the holding pen - release it, then wait for it to flag
> +	 * that it has been released by resetting pen_release.
> +	 *
> +	 * Note that "pen_release" is the hardware CPU ID, whereas
> +	 * "cpu" is Linux's internal ID.
> +	 */
> +	write_pen_release(cpu);
> +
> +	timeout = jiffies + (1 * HZ);
> +	while (time_before(jiffies, timeout)) {
> +		smp_rmb();
> +		if (pen_release == -1)
> +			break;
> +
> +		udelay(10);
> +	}
> +
> +	/*
> +	 * now the secondary core is starting up let it run its
> +	 * calibrations, then wait for it to finish
> +	 */
> +	spin_unlock(&boot_lock);
> +
> +	return pen_release != -1 ? -ENOSYS : 0;
> +}
> +
> +/*
> + * Initialise the CPU possible map early - this describes the CPUs
> + * which may be present or become present in the system.
> + */
> +void __init smp_init_cpus(void)
> +{
> +	void __iomem *scu_base = scu_base_addr();
> +	unsigned int i, ncores;
> +
> +	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> +
> +	for (i = 0; i < ncores; i++)
> +		set_cpu_possible(i, true);
> +}
> +
> +static void __init wakeup_secondary(void)
> +{
> +	/* nobody is to be released from the pen yet */
> +	pen_release = -1;

But pen_release starts off as -1, so is this really needed?

> +
> +	/*
> +	 * Write the address of secondary startup into the system-wide
> +	 * location (presently it is in SRAM). The BootMonitor waits
> +	 * for this register to become non-zero.
> +	 * We must also send an sev to wake it up
> +	 */
> +	__raw_writel(BSYM(virt_to_phys(spear13xx_secondary_startup)),
> +			__io_address(SPEAR13XX_SYS_LOCATION));
> +
> +	mb();

Do you really need to sync back to L2, or will a dsb() do here - and
as the spinlock code uses dsb() + sev() together, would it make sense
to combine the two?  (dsb() is required to ensure all previous writes
are visible prior to the sev() executing.)
