From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 Mar 2013 11:36:23 +0000
Subject: [patch 4/7] tick: Handle broadcast wakeup of multiple cpus
In-Reply-To: <20130306111537.492045206@linutronix.de>
References: <20130306111351.883117670@linutronix.de>
 <20130306111537.492045206@linutronix.de>
Message-ID: <20130313113623.GA6635@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Mar 06, 2013 at 11:18:35AM +0000, Thomas Gleixner wrote:
> Some brilliant hardware implementations wake multiple cores when the
> broadcast timer fires. This leads to the following interesting
> problem:
> 
> CPU0				CPU1
> wakeup from idle		wakeup from idle
> 
> leave broadcast mode		leave broadcast mode
>  restart per cpu timer		 restart per cpu timer
>  	     	 		go back to idle
> handle broadcast
>  (empty mask)			
> 				enter broadcast mode
> 				programm broadcast device
> enter broadcast mode
> programm broadcast device
> 
> So what happens is that due to the forced reprogramming of the cpu
> local timer, we need to set a event in the future. Now if we manage to
> go back to idle before the timer fires, we switch off the timer and
> arm the broadcast device with an already expired time (covered by
> forced mode). So in the worst case we repeat the above ping pong
> forever.
> 					
> Unfortunately we have no information about what caused the wakeup, but
> we can check current time against the expiry time of the local cpu. If
> the local event is already in the past, we know that the broadcast
> timer is about to fire and send an IPI. So we mark ourself as an IPI
> target even if we left broadcast mode and avoid the reprogramming of
> the local cpu timer.
> 
> This still leaves the possibility that a CPU which is not handling the
> broadcast interrupt is going to reach idle again before the IPI
> arrives. This can't be solved in the core code and will be handled in
> follow up patches.
> 
> Reported-by: Jason Liu <liu.h.jason@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/tick-broadcast.c |   59 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> Index: tip/kernel/time/tick-broadcast.c
> ===================================================================
> --- tip.orig/kernel/time/tick-broadcast.c
> +++ tip/kernel/time/tick-broadcast.c
> @@ -393,6 +393,7 @@ int tick_resume_broadcast(void)
>  
>  static cpumask_var_t tick_broadcast_oneshot_mask;
>  static cpumask_var_t tick_broadcast_pending_mask;
> +static cpumask_var_t tick_broadcast_force_mask;
>  
>  /*
>   * Exposed for debugging: see timer_list.c
> @@ -462,6 +463,10 @@ again:
>  		}
>  	}
>  
> +	/* Take care of enforced broadcast requests */
> +	cpumask_or(tmpmask, tmpmask, tick_broadcast_force_mask);
> +	cpumask_clear(tick_broadcast_force_mask);

I tested the set and it works fine on a dual cluster big.LITTLE testchip
using broadcast timer to manage deep idle cluster states.

Just asking a question: the force mask is cleared before sending the
timer IPI. Would not be better to clear it after the IPI is sent in

tick_do_broadcast(...) ?

Can you spot a regression if we do this ? The idle thread checks that
mask with irqs disabled, so it is possible that we clear the mask before
the CPU has a chance to get the IPI. If we clear the mask after sending
the IPI, we are increasing the chances for the idle thread to get it.

It is just a further optimization, just asking, thanks.

> +
>  	/*
>  	 * Wakeup the cpus which have an expired event.
>  	 */
> @@ -497,6 +502,7 @@ void tick_broadcast_oneshot_control(unsi
>  	struct clock_event_device *bc, *dev;
>  	struct tick_device *td;
>  	unsigned long flags;
> +	ktime_t now;
>  	int cpu;
>  
>  	/*
> @@ -524,7 +530,16 @@ void tick_broadcast_oneshot_control(unsi
>  		WARN_ON_ONCE(cpumask_test_cpu(cpu, tick_broadcast_pending_mask));
>  		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_oneshot_mask)) {
>  			clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
> -			if (dev->next_event.tv64 < bc->next_event.tv64)
> +			/*
> +			 * We only reprogram the broadcast timer if we
> +			 * did not mark ourself in the force mask and
> +			 * if the cpu local event is earlier than the
> +			 * broadcast event. If the current CPU is in
> +			 * the force mask, then we are going to be
> +			 * woken by the IPI right away.
> +			 */
> +			if (!cpumask_test_cpu(cpu, tick_broadcast_force_mask) &&
Is the test against tick_broadcast_force_mask necessary if we add the check
in the idle thread before entering idle ? It does not hurt, agreed, and we'd
better leave it there, it is just for my own understanding, thanks a lot.

Having said that, on the series:

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +			    dev->next_event.tv64 < bc->next_event.tv64)
>  				tick_broadcast_set_event(dev->next_event, 1);
>  		}
>  	} else {
> @@ -545,6 +560,47 @@ void tick_broadcast_oneshot_control(unsi
>  				       tick_broadcast_pending_mask))
>  				goto out;
>  
> +			/*
> +			 * If the pending bit is not set, then we are
> +			 * either the CPU handling the broadcast
> +			 * interrupt or we got woken by something else.
> +			 *
> +			 * We are not longer in the broadcast mask, so
> +			 * if the cpu local expiry time is already
> +			 * reached, we would reprogram the cpu local
> +			 * timer with an already expired event.
> +			 *
> +			 * This can lead to a ping-pong when we return
> +			 * to idle and therefor rearm the broadcast
> +			 * timer before the cpu local timer was able
> +			 * to fire. This happens because the forced
> +			 * reprogramming makes sure that the event
> +			 * will happen in the future and depending on
> +			 * the min_delta setting this might be far
> +			 * enough out that the ping-pong starts.
> +			 *
> +			 * If the cpu local next_event has expired
> +			 * then we know that the broadcast timer
> +			 * next_event has expired as well and
> +			 * broadcast is about to be handled. So we
> +			 * avoid reprogramming and enforce that the
> +			 * broadcast handler, which did not run yet,
> +			 * will invoke the cpu local handler.
> +			 *
> +			 * We cannot call the handler directly from
> +			 * here, because we might be in a NOHZ phase
> +			 * and we did not go through the irq_enter()
> +			 * nohz fixups.
> +			 */
> +			now = ktime_get();
> +			if (dev->next_event.tv64 <= now.tv64) {
> +				cpumask_set_cpu(cpu, tick_broadcast_force_mask);
> +				goto out;
> +			}
> +			/*
> +			 * We got woken by something else. Reprogram
> +			 * the cpu local timer device.
> +			 */
>  			tick_program_event(dev->next_event, 1);
>  		}
>  	}
> @@ -686,5 +742,6 @@ void tick_broadcast_init(void)
>  #ifdef CONFIG_TICK_ONESHOT
>  	alloc_cpumask_var(&tick_broadcast_oneshot_mask, GFP_NOWAIT);
>  	alloc_cpumask_var(&tick_broadcast_pending_mask, GFP_NOWAIT);
> +	alloc_cpumask_var(&tick_broadcast_force_mask, GFP_NOWAIT);
>  #endif
>  }
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
