From: horms@verge.net.au (Simon Horman)
Date: Thu, 7 May 2015 22:25:43 +0900
Subject: Possible regression due to "hrtimer: Get rid of hrtimer softirq"
In-Reply-To: <alpine.DEB.2.11.1505071425520.4225@nanos>
References: <20150507111711.GA17448@verge.net.au>
 <alpine.DEB.2.11.1505071425520.4225@nanos>
Message-ID: <20150507132543.GA14889@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, May 07, 2015 at 02:35:59PM +0200, Thomas Gleixner wrote:
> On Thu, 7 May 2015, Simon Horman wrote:
> > ------------[ cut here ]------------
> > kernel BUG at kernel/irq_work.c:135!
> 
>   BUG_ON(!irqs_disabled());
> 
> So something enables interrupts in the periodic tick handling
> machinery. Seems you have high resolution timers disabled, but nohz
> enabled. And that code path has a local_irq_disable/enable pair which
> causes havoc. Patch below.

Thanks for your quick response. I have been able to confirm that
when applied on top of next-20150507 the problem I observed no longer
manifests. I have successfully tested it on all the boards
where I previously observed a problem.

If you are planning to formally submit the patch below feel free to add:

Tested-by: Simon Horman <horms+renesas@verge.net.au>

> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 753c211f6195..812f7a3b9898 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -967,11 +967,9 @@ static void tick_nohz_switch_to_nohz(void)
>  	if (!tick_nohz_enabled)
>  		return;
>  
> -	local_irq_disable();
> -	if (tick_switch_to_oneshot(tick_nohz_handler)) {
> -		local_irq_enable();
> +	if (tick_switch_to_oneshot(tick_nohz_handler))
>  		return;
> -	}
> +
>  	tick_nohz_active = 1;
>  	ts->nohz_mode = NOHZ_MODE_LOWRES;
>  
> @@ -986,7 +984,6 @@ static void tick_nohz_switch_to_nohz(void)
>  	hrtimer_forward_now(&ts->sched_timer, tick_period);
>  	hrtimer_set_expires(&ts->sched_timer, next);
>  	tick_program_event(next, 1);
> -	local_irq_enable();
>  }
>  
>  /*
> @@ -1171,7 +1168,7 @@ void tick_oneshot_notify(void)
>   * Called cyclic from the hrtimer softirq (driven by the timer
>   * softirq) allow_nohz signals, that we can switch into low-res nohz
>   * mode, because high resolution timers are disabled (either compile
> - * or runtime).
> + * or runtime). Called with interrupts disabled.
>   */
>  int tick_check_oneshot_change(int allow_nohz)
>  {
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
