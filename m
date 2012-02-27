From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 27 Feb 2012 11:12:15 +0100
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86
 and ARM
In-Reply-To: <1329717859-19378-1-git-send-email-dmitry.antipov@linaro.org>
References: <1329717859-19378-1-git-send-email-dmitry.antipov@linaro.org>
Message-ID: <1330337535.11248.45.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-20 at 10:04 +0400, Dmitry Antipov wrote:
> Generalize CONFIG_IRQ_TIME_ACCOUNTING  between X86 and
> ARM, move "noirqtime=" option to common debugging code.
> For a bit of backward compatibility, X86-specific option
> "tsc=noirqtime" is preserved, but issues a warning.
> 
> Suggested-by: Yong Zhang <yong.zhang0@gmail.com>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Suggested-by: Ingo Molnar <mingo@elte.hu>
> Acked-by: Venkatesh Pallipadi <venki@google.com>
> Signed-off-by: Dmitry Antipov <dmitry.antipov@linaro.org>

Thanks for Cc'ing me (maintainer) and Venki (original author of the
stuff) :-)


> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7d379a6..9b13f79 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1961,13 +1961,16 @@ extern void sched_clock_idle_wakeup_event(u64 delta_ns);
>  #endif
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -/*
> - * An i/f to runtime opt-in for irq time accounting based off of sched_clock.
> - * The reason for this explicit opt-in is not to have perf penalty with
> - * slow sched_clocks.
> - */
> -extern void enable_sched_clock_irqtime(void);
> -extern void disable_sched_clock_irqtime(void);
> +extern int sched_clock_irqtime;
> +static inline void enable_sched_clock_irqtime(void)
> +{
> +	if (sched_clock_irqtime == -1)
> +		sched_clock_irqtime = 1;
> +}
> +static inline void disable_sched_clock_irqtime(void)
> +{
> +	sched_clock_irqtime = 0;
> +}
>  #else
>  static inline void enable_sched_clock_irqtime(void) {}
>  static inline void disable_sched_clock_irqtime(void) {}

Please keep them out-of-line, its not a fast path and it avoids having
to expose the state variable.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5255c9d..4e7a197 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -757,18 +757,21 @@ static DEFINE_PER_CPU(u64, cpu_hardirq_time);
>  static DEFINE_PER_CPU(u64, cpu_softirq_time);
>  
>  static DEFINE_PER_CPU(u64, irq_start_time);
> -static int sched_clock_irqtime;
>  
> -void enable_sched_clock_irqtime(void)
> -{
> -	sched_clock_irqtime = 1;
> -}
> +/*
> + * -1 if not initialized, 0 if disabled with "noirqtime" kernel option
> + * or after unstable clock was detected, 1 if enabled and active.
> + */

You forgot to explain what you need the tri-state for.

> +__read_mostly int sched_clock_irqtime = -1;
>  
> -void disable_sched_clock_irqtime(void)
> +static int __init irqtime_setup(char *str)
>  {
>  	sched_clock_irqtime = 0;
> +	return 1;
>  }
>  
> +__setup("noirqtime", irqtime_setup);
> +
>  #ifndef CONFIG_64BIT
>  static DEFINE_PER_CPU(seqcount_t, irq_time_seq);

Other than that no real objections.. I guess.
