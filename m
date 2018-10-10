From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:49:19 +0100
Subject: livelock with hrtimer cpu_base->lock
In-Reply-To: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
References: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
Message-ID: <20181010164919.GA16512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasad,

On Tue, Oct 09, 2018 at 01:56:14PM -0700, Sodagudi Prasad wrote:
> This is regarding - thread "try to fix contention between expire_timers and
> try_to_del_timer_sync".
> https://lkml.org/lkml/2017/7/28/172
> 
> I think this live lockup issue was discussed earlier but the final set of
> changes were not concluded.

Well we basically need a way to pick a value for CPU_RELAX_WFE_THRESHOLD.
Do you have any ideas? It could be determined at runtime if necessary.

> I would like to check whether you have new updates on this issue or not.
> This problem is observed with 4.14 .64 stable kernel too.
> We see this problem 2 times in overnight testing.
> 
> I have to add the following code to avoid live lock. I am thinking that
> fixing this at the cpu_relax() level.
> 
> +++ b/kernel/time/hrtimer.c
> @@ -52,6 +52,7 @@
>  #include <linux/timer.h>
>  #include <linux/freezer.h>
>  #include <linux/compat.h>
> +#include <linux/delay.h>
> 
>  #include <linux/uaccess.h>
> 
> @@ -152,6 +153,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const
> struct hrtimer *timer,
> raw_spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
>                 }
>                 cpu_relax();
> +               udelay(1);
>         }
>  }
> 
> @@ -1067,6 +1069,7 @@ int hrtimer_cancel(struct hrtimer *timer)
>                 if (ret >= 0)
>                         return ret;
>                 cpu_relax();
> +               udelay(1);
>         }
>  }
>  EXPORT_SYMBOL_GPL(hrtimer_cancel);

This is just another bodge and likely to hurt in places where 1us is
excessive because there isn't contention.

Will
