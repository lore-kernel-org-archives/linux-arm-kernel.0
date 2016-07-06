From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Jul 2016 10:28:57 -0700
Subject: [PATCH v21 3/8] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20160706075226.27609-4-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-4-takahiro.akashi@linaro.org>
Message-ID: <1467826137.8880.35.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -136,6 +136,10 @@ static inline void cpu_panic_kernel(void)
>   */
>  bool cpus_are_stuck_in_kernel(void);
>  
> +#ifdef CONFIG_KEXEC_CORE
> +extern void smp_send_crash_stop(void);
> +#endif

It seems this could be simplified by removing these
conditionals, then move the conditionals that are
around the smp_send_crash_stop definition to inside
that definition.

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 62ff3c0..51e0b73 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -800,6 +803,28 @@ static void ipi_cpu_stop(unsigned int cpu)
>  > 	> 	> cpu_relax();
>  }
>  
> +#ifdef CONFIG_KEXEC_CORE
> +static atomic_t waiting_for_crash_ipi;
> +
> +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
> +{
> +> 	> crash_save_cpu(regs, cpu);
> +
> +> 	> atomic_dec(&waiting_for_crash_ipi);
> +
> +> 	> local_irq_disable();
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +> 	> if (cpu_ops[cpu]->cpu_die)
> +> 	> 	> cpu_ops[cpu]->cpu_die(cpu);
> +#endif
> +
> +> 	> /* just in case */
> +> 	> while (1)
> +> 	> 	> wfi();
> +}
> +#endif

 /*
>   * Main handler for inter-processor interrupts
>   */
> @@ -830,6 +855,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  > 	> 	> irq_exit();
>  > 	> 	> break;
>  
> +#ifdef CONFIG_KEXEC_CORE
> +> 	> case IPI_CPU_CRASH_STOP:
> +> 	> 	> irq_enter();
> +> 	> 	> ipi_cpu_crash_stop(cpu, regs);
> +
> +> 	> 	> unreachable();
> +#endif

It seems like you could simplifiy with something like:

	case IPI_CPU_CRASH_STOP:
		if (IS_ENABLED(CONFIG_KEXEC_CORE) {
			irq_enter();
			ipi_cpu_crash_stop(cpu, regs);
			unreachable();
		}

Then move the CONFIG_KEXEC_CORE conditional around
ipi_cpu_crash_stop to just around crash_save_cpu().

 -Geoff
