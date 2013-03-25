From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 25 Mar 2013 17:49:59 -0400 (EDT)
Subject: [PATCH] ARM: delay: use private ticks_per_jiffy field for
 timer-based delay ops
In-Reply-To: <1364235499-17797-1-git-send-email-will.deacon@arm.com>
References: <1364235499-17797-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1303251749120.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Mar 2013, Will Deacon wrote:

> Commit 70264367a243 ("ARM: 7653/2: do not scale loops_per_jiffy when
> using a constant delay clock") fixed a problem with our timer-based
> delay loop, where loops_per_jiffy is scaled by cpufreq yet used directly
> by the timer delay ops.
> 
> This patch fixes the problem in a more elegant way by keeping a private
> ticks_per_jiffy field in the delay ops, independent of loops_per_jiffy
> and therefore not subject to scaling. The loop-based delay continues to
> use loops_per_jiffy directly, as it should.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/delay.h | 2 +-
>  arch/arm/kernel/smp.c        | 3 ---
>  arch/arm/lib/delay.c         | 8 +++++---
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index 720799f..dff714d 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -24,7 +24,7 @@ extern struct arm_delay_ops {
>  	void (*delay)(unsigned long);
>  	void (*const_udelay)(unsigned long);
>  	void (*udelay)(unsigned long);
> -	bool const_clock;
> +	unsigned long ticks_per_jiffy;
>  } arm_delay_ops;
>  
>  #define __delay(n)		arm_delay_ops.delay(n)
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 79078ed..1f2cccc 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -673,9 +673,6 @@ static int cpufreq_callback(struct notifier_block *nb,
>  	if (freq->flags & CPUFREQ_CONST_LOOPS)
>  		return NOTIFY_OK;
>  
> -	if (arm_delay_ops.const_clock)
> -		return NOTIFY_OK;
> -
>  	if (!per_cpu(l_p_j_ref, cpu)) {
>  		per_cpu(l_p_j_ref, cpu) =
>  			per_cpu(cpu_data, cpu).loops_per_jiffy;
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 6b93f6a..64dbfa5 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -58,7 +58,7 @@ static void __timer_delay(unsigned long cycles)
>  static void __timer_const_udelay(unsigned long xloops)
>  {
>  	unsigned long long loops = xloops;
> -	loops *= loops_per_jiffy;
> +	loops *= arm_delay_ops.ticks_per_jiffy;
>  	__timer_delay(loops >> UDELAY_SHIFT);
>  }
>  
> @@ -73,11 +73,13 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
>  		pr_info("Switching to timer-based delay loop\n");
>  		delay_timer			= timer;
>  		lpj_fine			= timer->freq / HZ;
> -		loops_per_jiffy			= lpj_fine;
> +
> +		/* cpufreq may scale loops_per_jiffy, so keep a private copy */
> +		arm_delay_ops.ticks_per_jiffy	= lpj_fine;
>  		arm_delay_ops.delay		= __timer_delay;
>  		arm_delay_ops.const_udelay	= __timer_const_udelay;
>  		arm_delay_ops.udelay		= __timer_udelay;
> -		arm_delay_ops.const_clock	= true;
> +
>  		delay_calibrated		= true;
>  	} else {
>  		pr_info("Ignoring duplicate/late registration of read_current_timer delay\n");
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
