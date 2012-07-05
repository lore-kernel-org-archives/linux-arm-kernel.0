From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 05 Jul 2012 22:06:13 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <1340991231-17682-3-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
Message-ID: <4FF59145.2020009@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/30/2012 2:33 AM, Will Deacon wrote:
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index dbbeec4..675cee0 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -32,6 +32,8 @@ static int arch_timer_ppi2;
>  
>  static struct clock_event_device __percpu **arch_timer_evt;
>  
> +extern void init_current_timer_delay(unsigned long freq);
> +

This is needed for all users of the new timer-baed delay routine.
How about moving this extern declaration to more generic place, in
<asm/timex.h>?

>  /*
>   * Architected system timer support.
>   */
> @@ -304,6 +306,7 @@ static int __init arch_timer_register(void)
>  	if (err)
>  		goto out_free_irq;
>  
> +	init_current_timer_delay(arch_timer_rate);
>  	return 0;
>  
>  out_free_irq:

This is arch_timer-land change.  I'd prefer to see general part changes
first, followed by arch_timer ones making use of them.

> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> new file mode 100644
> index 0000000..e1030e1
> --- /dev/null
> +++ b/arch/arm/lib/delay.c
> @@ -0,0 +1,66 @@
[...]
> +void __init init_current_timer_delay(unsigned long freq)
> +{
> +	pr_info("Switching to timer-based delay loop\n");
> +	lpj_fine			= freq / HZ;

I've been preparing for lpj_fine with rounding it up by HZ like this:

        lpj_fine = (freq + (HZ/2)) / HZ;

It's not necessarily required, but just in case.

> +	arm_delay_ops.delay		= __timer_delay;
> +	arm_delay_ops.const_udelay	= __timer_const_udelay;
> +	arm_delay_ops.udelay		= __timer_udelay;
> +}
> +#endif

I modified pr_info() at the end of function to print (lpj=%lu),

+	pr_info("Switching to timer-based delay loop (lpj=%lu)\n", lpj_fine);

but turned out to be printed twice, no-so-great:

sched_clock: 32 bits at 13MHz, resolution 76ns, wraps every 330382ms
cmt: CMCLKE e6131000 mapped to e6131000
sh_cmt.11 at 0xe6130100 probed with CMCLKE
sh_cmt.12 at 0xe6130200 probed with CMCLKE
sh_cmt.11 used for periodic clock events
sh_cmt.11 used for clock events
Switching to timer-based delay loop (lpj=101562) <<<
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 26.04 BogoMIPS (lpj=101562) <<<

Anyway,

Tested-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Thank for the work, hope this to be merged soon!


  Shinya
