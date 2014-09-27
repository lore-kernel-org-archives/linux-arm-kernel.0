From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Sat, 27 Sep 2014 18:59:39 +0200
Subject: [PATCH] sched/nohz: add debugfs control over
 sched_tick_max_deferment
In-Reply-To: <1411760732-14102-1-git-send-email-khilman@kernel.org>
References: <1411760732-14102-1-git-send-email-khilman@kernel.org>
Message-ID: <20140927165938.GB21729@lerouge>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 12:45:32PM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@linaro.org>
> 
> Allow debugfs override of sched_tick_max_deferment in order to ease
> finding/fixing the remaining issues with full nohz.
> 
> The value to be written is in jiffies, and -1 means the max deferment
> is disabled (scheduler_tick_max_deferment() returns KTIME_MAX.)
> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

So, I'm worried that it becomes a hack that everybody uses to shutdown
the tick completely then nobody will come and fix the issue that prevents
from doing it properly.

I seriously doubt this will be used for development purpose to help
fixing the real problem. Quite the opposite. If developers want to do
testing, they can as well comment out the call to scheduler_max_tick_deferment().


> ---
>  kernel/sched/core.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bc1638b33449..dee044a5d447 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2514,6 +2514,8 @@ void scheduler_tick(void)
>  }
>  
>  #ifdef CONFIG_NO_HZ_FULL
> +static u32 sched_tick_max_deferment = HZ;
> +
>  /**
>   * scheduler_tick_max_deferment
>   *
> @@ -2532,13 +2534,25 @@ u64 scheduler_tick_max_deferment(void)
>  	struct rq *rq = this_rq();
>  	unsigned long next, now = ACCESS_ONCE(jiffies);
>  
> -	next = rq->last_sched_tick + HZ;
> +	if (sched_tick_max_deferment == -1)
> +		return KTIME_MAX;
> +
> +	next = rq->last_sched_tick + sched_tick_max_deferment;
>  
>  	if (time_before_eq(next, now))
>  		return 0;
>  
>  	return jiffies_to_nsecs(next - now);
>  }
> +
> +static __init int sched_nohz_full_init_debug(void)
> +{
> +	debugfs_create_u32("sched_tick_max_deferment", 0644, NULL,
> +			   &sched_tick_max_deferment);
> +
> +	return 0;
> +}
> +late_initcall(sched_nohz_full_init_debug);
>  #endif
>  
>  notrace unsigned long get_parent_ip(unsigned long addr)
> -- 
> 2.1.0
> 
