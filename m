From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 23 Apr 2014 09:14:33 +0200
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
In-Reply-To: <20140422141650.7f43d5ba@gandalf.local.home>
References: <534C3606.7010206@meduna.org>	<534C731F.1050406@meduna.org>	<534DADF1.6060608@meduna.org>	<20140422115439.GA20669@linutronix.de>	<20140422094657.5b6ca1e2@gandalf.local.home>	<53569E05.8010600@linutronix.de>	<20140422134802.73fc1fa4@gandalf.local.home>
 <20140422141650.7f43d5ba@gandalf.local.home>
Message-ID: <53576859.8060706@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 08:16 PM, Steven Rostedt wrote:
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1447,6 +1447,12 @@ static void run_timer_softirq(struct softirq_action *h)
>  		__run_timers(base);
>  }
>  
> +#ifdef CONFIG_SMP
> +#define timer_should_raise_softirq(lock)	!spin_do_trylock(lock)
> +#else
> +#define timer_should_raise_softirq(lock)	1
> +#endif
> +

No. The lock may be taken but it also may be available no matter if UP
or not. With this patch applied the lockdep splat will go away but the
FULL_NO_HZ people will come back because the timer softirq is scheduled
even if no timer has expired.

Sebastian
