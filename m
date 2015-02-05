From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 Feb 2015 12:00:58 +0100
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150205105035.GL8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
Message-ID: <1423134058.25197.9.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2015-02-05 at 10:50 +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 05, 2015 at 11:14:30AM +0100, Krzysztof Kozlowski wrote:
> > The complete() should not be used on offlined CPU. Rewrite the
> > wait-complete mechanism with wait_on_bit_timeout().
> 
> Yuck.
> 
> I think that the IPI idea would be far better, and a much smaller patch.
> We can continue using the completions, but instead of running the
> completion on the dying CPU, the dying CPU triggers an IPI which does
> the completion on the requesting CPU.
> 
> You're modifying arch/arm/kernel/smp.c, so you just hook it directly
> into the IPI mechanism without any registration required.
> 
> We can also kill the second cache flush by the dying CPU - as we're
> not writing to memory anymore by calling complete() after the first
> cache flush, so this will probably make CPU hotplug fractionally faster
> too.
> 
> (You'll get some fuzz with this patch as I have the NMI backtrace stuff
> in my kernel.)
> 
> Something like this - only build tested so far (waiting for the compile
> to finish...):

I am looking into IPI also. Maybe just smp_call_function_any() would be
enough?

Do you want to continue with the IPI version patch?

Best regards,
Krzysztof

> 
>  arch/arm/kernel/smp.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 194df2f1aa87..c623e27a9c85 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -73,6 +73,9 @@ enum ipi_msg_type {
>  	IPI_IRQ_WORK,
>  	IPI_COMPLETION,
>  	IPI_CPU_BACKTRACE,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	IPI_CPU_DEAD,
> +#endif
>  };
>  
>  /* For reliability, we're prepared to waste bits here. */
> @@ -88,6 +91,14 @@ void __init smp_set_ops(struct smp_operations *ops)
>  		smp_ops = *ops;
>  };
>  
> +static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
> +
> +void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
> +{
> +	if (!__smp_cross_call)
> +		__smp_cross_call = fn;
> +}
> +
>  static unsigned long get_arch_pgd(pgd_t *pgd)
>  {
>  	phys_addr_t pgdir = virt_to_idmap(pgd);
> @@ -267,19 +278,13 @@ void __ref cpu_die(void)
>  	flush_cache_louis();
>  
>  	/*
> -	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
> -	 * this returns, power and/or clocks can be removed at any point
> +	 * Tell __cpu_die() that this CPU is now safe to dispose of.  We
> +	 * do this via an IPI to any online CPU - it doesn't matter, we
> +	 * just need another CPU to run the completion.  Once this IPI
> +	 * has been sent, power and/or clocks can be removed at any point
>  	 * from this CPU and its cache by platform_cpu_kill().
>  	 */
> -	complete(&cpu_died);
> -
> -	/*
> -	 * Ensure that the cache lines associated with that completion are
> -	 * written out.  This covers the case where _this_ CPU is doing the
> -	 * powering down, to ensure that the completion is visible to the
> -	 * CPU waiting for this one.
> -	 */
> -	flush_cache_louis();
> +	__smp_cross_call(cpumask_of(cpumask_any(cpu_online_mask)), IPI_CPU_DEAD);
>  
>  	/*
>  	 * The actual CPU shutdown procedure is at least platform (if not
> @@ -442,14 +447,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> -static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
> -
> -void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
> -{
> -	if (!__smp_cross_call)
> -		__smp_cross_call = fn;
> -}
> -
>  static const char *ipi_types[NR_IPI] __tracepoint_string = {
>  #define S(x,s)	[x] = s
>  	S(IPI_WAKEUP, "CPU wakeup interrupts"),
> @@ -648,6 +645,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		irq_exit();
>  		break;
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +	case IPI_CPU_DEAD:
> +		irq_enter();
> +		complete(&cpu_died);
> +		irq_exit();
> +		break;
> +#endif
> +
>  	default:
>  		pr_crit("CPU%u: Unknown IPI message 0x%x\n",
>  		        cpu, ipinr);
> 
