From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 05 Sep 2014 16:15:36 +0100
Subject: [PATCH FYI 3/4] ARM: add basic support for on-demand backtrace
 of other CPUs
In-Reply-To: <E1XPq1S-0000RP-FR@rmk-PC.arm.linux.org.uk>
References: <20140905094056.GD30401@n2100.arm.linux.org.uk>
 <E1XPq1S-0000RP-FR@rmk-PC.arm.linux.org.uk>
Message-ID: <5409D398.5000705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/14 10:41, Russell King wrote:
> Add basic infrastructure for triggering a backtrace of other CPUs
> via an IPI, preferably at FIQ level.  It is intended that this shall
> be used for cases where we have detected that something has already
> failed in the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/irq.h |  5 ++++
>  arch/arm/kernel/smp.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> index 53c15dec7af6..be1d07d59ee9 100644
> --- a/arch/arm/include/asm/irq.h
> +++ b/arch/arm/include/asm/irq.h
> @@ -35,6 +35,11 @@ extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  #endif
>  
> +#ifdef CONFIG_SMP
> +extern void arch_trigger_all_cpu_backtrace(bool);
> +#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
> +#endif
> +
>  #endif
>  
>  #endif
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9388a3d479e1..94959f977b82 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -72,8 +72,12 @@ enum ipi_msg_type {
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
> +	IPI_CPU_BACKTRACE,
>  };
>  
> +/* For reliability, we're prepared to waste bits here. */
> +static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
> +
>  static DECLARE_COMPLETION(cpu_running);
>  
>  static struct smp_operations smp_ops;
> @@ -539,6 +543,21 @@ static void ipi_cpu_stop(unsigned int cpu)
>  		cpu_relax();
>  }
>  
> +static void ipi_cpu_backtrace(struct pt_regs *regs)
> +{
> +	int cpu = smp_processor_id();
> +
> +	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
> +		static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +
> +		arch_spin_lock(&lock);
> +		printk(KERN_WARNING "FIQ backtrace for cpu %d\n", cpu);
> +		show_regs(regs);
> +		arch_spin_unlock(&lock);
> +		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
> +	}
> +}
> +
>  static DEFINE_PER_CPU(struct completion *, cpu_completion);
>  
>  int register_ipi_completion(struct completion *completion, int cpu)
> @@ -618,6 +637,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		irq_exit();
>  		break;
>  
> +	case IPI_CPU_BACKTRACE:
> +		irq_enter();
> +		ipi_cpu_backtrace(regs);
> +		irq_exit();
> +		break;
> +
>  	default:
>  		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
>  		       cpu, ipinr);
> @@ -712,3 +737,40 @@ static int __init register_cpufreq_notifier(void)
>  core_initcall(register_cpufreq_notifier);
>  
>  #endif
> +
> +void arch_trigger_all_cpu_backtrace(bool include_self)
> +{
> +	static unsigned long backtrace_flag;
> +	int i, cpu = get_cpu();
> +
> +	if (test_and_set_bit(0, &backtrace_flag)) {
> +		/*
> +		 * If there is already a trigger_all_cpu_backtrace() in progress
> +		 * (backtrace_flag == 1), don't output double cpu dump infos.
> +		 */
> +		put_cpu();
> +		return;
> +	}
> +
> +	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
> +	if (!include_self)
> +		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
> +
> +	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
> +		pr_info("Sending FIQ to %s CPUs:\n",
> +			(include_self ? "all" : "other"));
> +		smp_cross_call(to_cpumask(backtrace_mask), IPI_CPU_BACKTRACE);
> +	}
> +
> +	/* Wait for up to 10 seconds for all CPUs to do the backtrace */
> +	for (i = 0; i < 10 * 1000; i++) {
> +		if (cpumask_empty(to_cpumask(backtrace_mask)))
> +			break;
> +
> +		mdelay(1);
> +	}


I am seeing timeout problems when I test using SysRq-l to call
arch_trigger_all_cpu_backtrace() with FIQ support *disabled* (i.e. in
secure mode).

I've not investigated yet but it feels like interrupts are masked (which
makes sense given the calling context will be the UART ISR). Basically
the console locks up and the backtrace for CPU-0 is delayed for 10 seconds.

Once the backtrace does come out things return to normal...


Daniel.

> +
> +	clear_bit(0, &backtrace_flag);
> +	smp_mb__after_atomic();
> +	put_cpu();
> +}
> 
