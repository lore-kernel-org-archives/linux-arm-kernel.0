From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 13:51:09 -0400 (EDT)
Subject: [PATCHv3 2/5] arm64: factor out spin-table boot method
In-Reply-To: <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
Message-ID: <alpine.LFD.2.03.1308141348130.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Mark Rutland wrote:

> The arm64 kernel has an internal holding pen, which is necessary for
> some systems where we can't bring CPUs online individually and must hold
> multiple CPUs in a safe area until the kernel is able to handle them.
> The current SMP infrastructure for arm64 is closely coupled to this
> holding pen, and alternative boot methods must launch CPUs into the pen,
> where they sit before they are launched into the kernel proper.
> 
> With PSCI (and possibly other future boot methods), we can bring CPUs
> online individually, and need not perform the secondary_holding_pen
> dance. Instead, this patch factors the holding pen management code out
> to the spin-table boot method code, as it is the only boot method
> requiring the pen.
> 
> A new entry point for secondaries, secondary_entry is added for other
> boot methods to use, which bypasses the holding pen and its associated
> overhead when bringing CPUs online.

Excellent.

> The smp.pen.text section is also removed, as the pen can live in 
> head.text without problem.

Why was there a special section for the pen code initially?

> The smp_operations structure is extended with two new functions,
> cpu_boot and cpu_postboot, for bringing a cpu into the kernel and
> performing any post-boot cleanup required by a bootmethod (e.g.
> resetting the secondary_holding_pen_release to INVALID_HWID).
> Documentation is added for smp_operations.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm64/include/asm/smp.h       | 19 +++++++++-
>  arch/arm64/kernel/head.S           | 12 +++++-
>  arch/arm64/kernel/smp.c            | 67 +++-------------------------------
>  arch/arm64/kernel/smp_psci.c       | 16 ++++----
>  arch/arm64/kernel/smp_spin_table.c | 75 ++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S    |  1 -
>  6 files changed, 117 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 90626b6..831090a 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -60,18 +60,33 @@ struct secondary_data {
>  	void *stack;
>  };
>  extern struct secondary_data secondary_data;
> -extern void secondary_holding_pen(void);
> -extern volatile unsigned long secondary_holding_pen_release;
> +extern void secondary_entry(void);
>  
>  extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
>  
>  struct device_node;
>  
> +/**
> + * struct smp_operations - Callback operations for hotplugging CPUs.
> + *
> + * @name:	Name of the property as appears in a devicetree cpu node's
> + *		enable-method property.
> + * @cpu_init:	Reads any data necessary for a specific enable-method form the
> + *		devicetree, for a given cpu node and proposed logical id.
> + * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
> + *		mechanism for doing so, tests whether it is possible to boot
> + *		the given CPU.
> + * @cpu_boot:	Boots a cpu into the kernel.
> + * @cpu_postboot: Optionally, perform any post-boot cleanup or necesary
> + *		synchronisation. Called from the cpu being booted.
> + */
>  struct smp_operations {
>  	const char	*name;
>  	int		(*cpu_init)(struct device_node *, unsigned int);
>  	int		(*cpu_prepare)(unsigned int);
> +	int		(*cpu_boot)(unsigned int);
> +	void		(*cpu_postboot)(void);
>  };
>  
>  extern const struct smp_operations smp_spin_table_ops;
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 53dcae4..3532ca6 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -217,7 +217,6 @@ ENTRY(__boot_cpu_mode)
>  	.quad	PAGE_OFFSET
>  
>  #ifdef CONFIG_SMP
> -	.pushsection    .smp.pen.text, "ax"
>  	.align	3
>  1:	.quad	.
>  	.quad	secondary_holding_pen_release
> @@ -242,7 +241,16 @@ pen:	ldr	x4, [x3]
>  	wfe
>  	b	pen
>  ENDPROC(secondary_holding_pen)
> -	.popsection
> +
> +	/*
> +	 * Secondary entry point that jumps straight into the kernel. Only to
> +	 * be used where CPUs are brought online dynamically by the kernel.
> +	 */
> +ENTRY(secondary_entry)
> +	bl	__calc_phys_offset		// x2=phys offset
> +	bl	el2_setup			// Drop to EL1
> +	b	secondary_startup
> +ENDPROC(secondary_entry)
>  
>  ENTRY(secondary_startup)
>  	/*
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 533f405..72c2823 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -54,7 +54,6 @@
>   * where to place its SVC stack
>   */
>  struct secondary_data secondary_data;
> -volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
>  
>  enum ipi_msg_type {
>  	IPI_RESCHEDULE,
> @@ -63,22 +62,7 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  };
>  
> -static DEFINE_RAW_SPINLOCK(boot_lock);
> -
> -/*
> - * Write secondary_holding_pen_release in a way that is guaranteed to be
> - * visible to all observers, irrespective of whether they're taking part
> - * in coherency or not.  This is necessary for the hotplug code to work
> - * reliably.
> - */
> -static void write_pen_release(u64 val)
> -{
> -	void *start = (void *)&secondary_holding_pen_release;
> -	unsigned long size = sizeof(secondary_holding_pen_release);
> -
> -	secondary_holding_pen_release = val;
> -	__flush_dcache_area(start, size);
> -}
> +static const struct smp_operations *smp_ops[NR_CPUS];
>  
>  /*
>   * Boot a secondary CPU, and assign it the specified idle task.
> @@ -86,38 +70,10 @@ static void write_pen_release(u64 val)
>   */
>  static int boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	unsigned long timeout;
> -
> -	/*
> -	 * Set synchronisation state between this boot processor
> -	 * and the secondary one
> -	 */
> -	raw_spin_lock(&boot_lock);
> -
> -	/*
> -	 * Update the pen release flag.
> -	 */
> -	write_pen_release(cpu_logical_map(cpu));
> -
> -	/*
> -	 * Send an event, causing the secondaries to read pen_release.
> -	 */
> -	sev();
> -
> -	timeout = jiffies + (1 * HZ);
> -	while (time_before(jiffies, timeout)) {
> -		if (secondary_holding_pen_release == INVALID_HWID)
> -			break;
> -		udelay(10);
> -	}
> -
> -	/*
> -	 * Now the secondary core is starting up let it run its
> -	 * calibrations, then wait for it to finish
> -	 */
> -	raw_spin_unlock(&boot_lock);
> +	if (smp_ops[cpu]->cpu_boot)
> +		return smp_ops[cpu]->cpu_boot(cpu);
>  
> -	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
> +	return -EOPNOTSUPP;
>  }
>  
>  static DECLARE_COMPLETION(cpu_running);
> @@ -187,17 +143,8 @@ asmlinkage void secondary_start_kernel(void)
>  	preempt_disable();
>  	trace_hardirqs_off();
>  
> -	/*
> -	 * Let the primary processor know we're out of the
> -	 * pen, then head off into the C entry point
> -	 */
> -	write_pen_release(INVALID_HWID);
> -
> -	/*
> -	 * Synchronise with the boot thread.
> -	 */
> -	raw_spin_lock(&boot_lock);
> -	raw_spin_unlock(&boot_lock);
> +	if (smp_ops[cpu]->cpu_postboot)
> +		smp_ops[cpu]->cpu_postboot();
>  
>  	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
> @@ -242,8 +189,6 @@ static const struct smp_operations *supported_smp_ops[] __initconst = {
>  	NULL,
>  };
>  
> -static const struct smp_operations *smp_ops[NR_CPUS];
> -
>  static const struct smp_operations * __init smp_get_ops(const char *name)
>  {
>  	const struct smp_operations **ops = supported_smp_ops;
> diff --git a/arch/arm64/kernel/smp_psci.c b/arch/arm64/kernel/smp_psci.c
> index 2f0d3dd..20499bc 100644
> --- a/arch/arm64/kernel/smp_psci.c
> +++ b/arch/arm64/kernel/smp_psci.c
> @@ -30,24 +30,26 @@ static int smp_psci_cpu_init(struct device_node *dn, unsigned int cpu)
>  
>  static int smp_psci_cpu_prepare(unsigned int cpu)
>  {
> -	int err;
> -
>  	if (!psci_ops.cpu_on) {
>  		pr_err("psci: no cpu_on method, not booting CPU%d\n", cpu);
>  		return -ENODEV;
>  	}
>  
> -	err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_holding_pen));
> -	if (err) {
> +	return 0;
> +}
> +
> +static int smp_psci_cpu_boot(unsigned int cpu)
> +{
> +	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_entry));
> +	if (err)
>  		pr_err("psci: failed to boot CPU%d (%d)\n", cpu, err);
> -		return err;
> -	}
>  
> -	return 0;
> +	return err;
>  }
>  
>  const struct smp_operations smp_psci_ops = {
>  	.name		= "psci",
>  	.cpu_init	= smp_psci_cpu_init,
>  	.cpu_prepare	= smp_psci_cpu_prepare,
> +	.cpu_boot	= smp_psci_cpu_boot,
>  };
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index 5fecffc..87af6bb 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -16,13 +16,36 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
> +
> +extern void secondary_holding_pen(void);
> +volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
>  
>  static phys_addr_t cpu_release_addr[NR_CPUS];
> +static DEFINE_RAW_SPINLOCK(boot_lock);
> +
> +/*
> + * Write secondary_holding_pen_release in a way that is guaranteed to be
> + * visible to all observers, irrespective of whether they're taking part
> + * in coherency or not.  This is necessary for the hotplug code to work
> + * reliably.
> + */
> +static void write_pen_release(u64 val)
> +{
> +	void *start = (void *)&secondary_holding_pen_release;
> +	unsigned long size = sizeof(secondary_holding_pen_release);
> +
> +	secondary_holding_pen_release = val;
> +	__flush_dcache_area(start, size);
> +}
> +
>  
>  static int smp_spin_table_cpu_init(struct device_node *dn, unsigned int cpu)
>  {
> @@ -59,8 +82,60 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int smp_spin_table_cpu_boot(unsigned int cpu)
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
> +	write_pen_release(cpu_logical_map(cpu));
> +
> +	/*
> +	 * Send an event, causing the secondaries to read pen_release.
> +	 */
> +	sev();
> +
> +	timeout = jiffies + (1 * HZ);
> +	while (time_before(jiffies, timeout)) {
> +		if (secondary_holding_pen_release == INVALID_HWID)
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
> +	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
> +}
> +
> +void smp_spin_table_cpu_postboot(void)
> +{
> +	/*
> +	 * Let the primary processor know we're out of the pen.
> +	 */
> +	write_pen_release(INVALID_HWID);
> +
> +	/*
> +	 * Synchronise with the boot thread.
> +	 */
> +	raw_spin_lock(&boot_lock);
> +	raw_spin_unlock(&boot_lock);
> +}
> +
>  const struct smp_operations smp_spin_table_ops = {
>  	.name		= "spin-table",
>  	.cpu_init	= smp_spin_table_cpu_init,
>  	.cpu_prepare	= smp_spin_table_cpu_prepare,
> +	.cpu_boot	= smp_spin_table_cpu_boot,
> +	.cpu_postboot	= smp_spin_table_cpu_postboot,
>  };
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index f5e5574..d8ca8d9 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -54,7 +54,6 @@ SECTIONS
>  	}
>  	.text : {			/* Real text segment		*/
>  		_stext = .;		/* Text and read-only data	*/
> -			*(.smp.pen.text)
>  			__exception_text_start = .;
>  			*(.exception.text)
>  			__exception_text_end = .;
> -- 
> 1.8.1.1
> 
