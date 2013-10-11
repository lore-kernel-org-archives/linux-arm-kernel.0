From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 11 Oct 2013 15:24:28 -0700
Subject: [PATCHv4 4/6] arm64: add CPU_HOTPLUG infrastructure
In-Reply-To: <1381515846-1684-5-git-send-email-mark.rutland@arm.com>
References: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
 <1381515846-1684-5-git-send-email-mark.rutland@arm.com>
Message-ID: <52587A9C.9070503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/13 11:24, Mark Rutland wrote:
> diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
> index 1720be6..f4a11a3 100644
> --- a/arch/arm64/include/asm/cpu_ops.h
> +++ b/arch/arm64/include/asm/cpu_ops.h
> @@ -34,6 +34,11 @@ struct device_node;
>   * @cpu_boot:	Boots a cpu into the kernel.
>   * @cpu_postboot: Optionally, perform any post-boot cleanup or necesary
>   *		synchronisation. Called from the cpu being booted.
> + * @cpu_disable: Prepares a cpu to die. May fail for some mechanism-specific
> + * 		reason, which will cause the hot unplug to be aborted. Called
> + * 		from the cpu to be killed.
> + * @cpu_die:	Makes the a leave the kernel. Must not fail. Called from the

Makes the cpu? Makes a cpu?

> + *		cpu being killed.
>   */
>  struct cpu_operations {
>  	const char	*name;
> @@ -41,6 +46,10 @@ struct cpu_operations {
>  	int		(*cpu_prepare)(unsigned int);
>  	int		(*cpu_boot)(unsigned int);
>  	void		(*cpu_postboot)(void);
> +#ifdef CONFIG_HOTPLUG_CPU
> +	int		(*cpu_disable)(unsigned int cpu);
> +	void		(*cpu_die)(unsigned int cpu);
> +#endif
>  };
>  
>  extern const struct cpu_operations *cpu_ops[NR_CPUS];
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 6806bc4..888776e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
[snip]
> +
> +/*
> + * Called from the idle thread for the CPU which has been shutdown.
> + *
> + * Note that we disable IRQs here, but do not re-enable them
> + * before returning to the caller. This is also the behaviour
> + * of the other hotplug-cpu capable cores, so presumably coming
> + * out of idle fixes this.
> + */
> +void __ref cpu_die(void)

__ref is unnecessary now that __cpuinit is gone. I see arm32 needs the
same treatment.

> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	idle_task_exit();
> +
> +	local_irq_disable();
> +	mb();

Can you please comment this mb().

> +
> +	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> +	complete(&cpu_died);
> +
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
