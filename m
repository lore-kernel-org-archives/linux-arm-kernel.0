From: robherring2@gmail.com (Rob Herring)
Date: Mon, 03 Dec 2012 15:55:35 -0600
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <1354557160-20144-3-git-send-email-will.deacon@arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
Message-ID: <50BD1FD7.9040000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 11:52 AM, Will Deacon wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> This patch adds support for SMP to mach-virt.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mach-virt/Makefile  |   1 +
>  arch/arm/mach-virt/headsmp.S |  38 ++++++++
>  arch/arm/mach-virt/platsmp.c | 205 +++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-virt/virt.c    |   6 ++
>  4 files changed, 250 insertions(+)
>  create mode 100644 arch/arm/mach-virt/headsmp.S
>  create mode 100644 arch/arm/mach-virt/platsmp.c
> 
> diff --git a/arch/arm/mach-virt/Makefile b/arch/arm/mach-virt/Makefile
> index 7ddbfa6..9ce8a28 100644
> --- a/arch/arm/mach-virt/Makefile
> +++ b/arch/arm/mach-virt/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-y					:= virt.o
> +obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
> diff --git a/arch/arm/mach-virt/headsmp.S b/arch/arm/mach-virt/headsmp.S
> new file mode 100644
> index 0000000..e27afb0
> --- /dev/null
> +++ b/arch/arm/mach-virt/headsmp.S
> @@ -0,0 +1,38 @@
> +/*
> + *  Copyright (c) 2012 ARM Limited
> + *  All Rights Reserved
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +	__INIT
> +
> +/*
> + * This provides a "holding pen" into which all secondary cores are held
> + * until we're ready for them to initialise.
> + */
> +ENTRY(virt_secondary_startup)
> +	mrc	p15, 0, r0, c0, c0, 5
> +	and	r0, r0, #15
> +	adr	r4, 1f
> +	ldmia	r4, {r5, r6}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +pen:	ldr	r7, [r6]
> +	cmp	r7, r0
> +	bne	pen

Why is the pen is needed? It should only be needed for hotplug on
systems that can't reset their cores. I'd hope you could design good
virtual h/w.

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
> +ENDPROC(virt_secondary_startup)
> diff --git a/arch/arm/mach-virt/platsmp.c b/arch/arm/mach-virt/platsmp.c
> new file mode 100644
> index 0000000..fe02f51
> --- /dev/null
> +++ b/arch/arm/mach-virt/platsmp.c
> @@ -0,0 +1,205 @@
> +/*
> + * Dummy Virtual Machine - does what it says on the tin.
> + *
> + * SMP operations, shamelessly stolen from:
> + * arch/arm64/kernel/smp.c
> + *
> + * Copyright (C) 2012 ARM Ltd
> + * Author: Catalin Marinas <catalin.marinas@arm.com>
> + * Author: Will Deacon <will.deacon@arm.com>
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/smp.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/jiffies.h>
> +#include <linux/of.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +#include <asm/hardware/gic.h>
> +
> +extern void virt_secondary_startup(void);
> +
> +static DEFINE_RAW_SPINLOCK(boot_lock);
> +static phys_addr_t cpu_release_addr[NR_CPUS];
> +
> +/*
> + * Write secondary_holding_pen_release in a way that is guaranteed to be
> + * visible to all observers, irrespective of whether they're taking part
> + * in coherency or not.  This is necessary for the hotplug code to work
> + * reliably.
> + */
> +static void __cpuinit write_pen_release(int val)
> +{
> +	void *start = (void *)&pen_release;
> +	unsigned long size = sizeof(pen_release);
> +
> +	pen_release = val;
> +	smp_wmb();
> +	__cpuc_flush_dcache_area(start, size);
> +	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> +}
> +
> +/*
> + * Enumerate the possible CPU set from the device tree.
> + */
> +static void __init virt_smp_init_cpus(void)
> +{
> +	const char *enable_method;
> +	struct device_node *dn = NULL;
> +	int cpu = 0;
> +	u32 release_addr;
> +
> +	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> +		if (cpu >= NR_CPUS)
> +			goto next;
> +
> +		/*
> +		 * We currently support only the "spin-table" enable-method.
> +		 */
> +		enable_method = of_get_property(dn, "enable-method", NULL);
> +		if (!enable_method || strcmp(enable_method, "spin-table")) {

Are these documented?

> +			pr_err("CPU %d: missing or invalid enable-method property: %s\n",
> +			       cpu, enable_method);
> +			goto next;
> +		}
> +
> +		/*
> +		 * Determine the address from which the CPU is polling.
> +		 */
> +		if (of_property_read_u32(dn, "cpu-release-addr", &release_addr)) {
> +			pr_err("CPU %d: missing or invalid cpu-release-addr property\n",
> +			       cpu);
> +			goto next;
> +		}
> +
> +		cpu_release_addr[cpu] = release_addr;
> +		set_cpu_possible(cpu, true);
> +next:
> +		cpu++;
> +	}
> +
> +	/* sanity check */
> +	if (cpu > NR_CPUS)
> +		pr_warning("no. of cores (%d) greater than configured maximum of %d - clipping\n",
> +			   cpu, NR_CPUS);
> +
> +	set_smp_cross_call(gic_raise_softirq);
> +}
> +
> +static void __init virt_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	int cpu;
> +	void **release_addr;
> +	unsigned int ncores = num_possible_cpus();
> +
> +	/*
> +	 * are we trying to boot more cores than exist?
> +	 */
> +	if (max_cpus > ncores)
> +		max_cpus = ncores;
> +
> +	/*
> +	 * Initialise the present map (which describes the set of CPUs
> +	 * actually populated at the present time) and release the
> +	 * secondaries from the bootloader.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		if (max_cpus == 0)
> +			break;
> +
> +		if (!cpu_release_addr[cpu])
> +			continue;
> +
> +		release_addr = __va(cpu_release_addr[cpu]);
> +		release_addr[0] = (void *)__pa(virt_secondary_startup);
> +		smp_wmb();
> +		__cpuc_flush_dcache_area(release_addr, sizeof(release_addr[0]));
> +		outer_clean_range(__pa(release_addr), __pa(release_addr+1));
> +
> +		set_cpu_present(cpu, true);
> +		max_cpus--;
> +	}
> +}
> +
> +static int __cpuinit virt_boot_secondary(unsigned int cpu,
> +					 struct task_struct *idle)
> +{
> +	unsigned long timeout;
> +
> +	/*
> +	 * Set synchronisation state between this boot processor
> +	 * and the secondary one
> +	 */
> +	raw_spin_lock(&boot_lock);
> +
> +	/*
> +	 * Update the pen release flag.
> +	 */
> +	write_pen_release(cpu);
> +
> +	/*
> +	 * Send the secondary CPU a soft interrupt, causing the
> +	 * secondaries to read pen_release.
> +	 */
> +	gic_raise_softirq(cpumask_of(cpu), 0);
> +
> +	timeout = jiffies + (1 * HZ);
> +	while (time_before(jiffies, timeout)) {
> +		if (pen_release == -1UL)
> +			break;
> +		udelay(10);
> +	}
> +
> +	/*
> +	 * Now the secondary core is starting up let it run its
> +	 * calibrations, then wait for it to finish
> +	 */
> +	raw_spin_unlock(&boot_lock);
> +
> +	return pen_release != -1 ? -ENOSYS : 0;
> +}
> +
> +static void __cpuinit virt_secondary_init(unsigned int cpu)
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
> +	raw_spin_lock(&boot_lock);
> +	raw_spin_unlock(&boot_lock);
> +}
> +
> +struct smp_operations __initdata virt_smp_ops = {
> +	.smp_init_cpus		= virt_smp_init_cpus,
> +	.smp_prepare_cpus	= virt_smp_prepare_cpus,
> +	.smp_secondary_init	= virt_secondary_init,
> +	.smp_boot_secondary	= virt_boot_secondary,
> +};
> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
> index 174b9da..d764835 100644
> --- a/arch/arm/mach-virt/virt.c
> +++ b/arch/arm/mach-virt/virt.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/smp.h>
>  
>  #include <asm/arch_timer.h>
>  #include <asm/hardware/gic.h>
> @@ -56,10 +57,15 @@ static struct sys_timer virt_timer = {
>  	.init = virt_timer_init,
>  };
>  
> +#ifdef CONFIG_SMP
> +extern struct smp_operations virt_smp_ops;
> +#endif
> +
>  DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
>  	.init_irq	= gic_init_irq,
>  	.handle_irq     = gic_handle_irq,
>  	.timer		= &virt_timer,
>  	.init_machine	= virt_init,
> +	.smp		= smp_ops(virt_smp_ops),
>  	.dt_compat	= virt_dt_match,
>  MACHINE_END
> 
