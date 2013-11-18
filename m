From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 18 Nov 2013 13:42:35 -0800
Subject: [PATCH 1/2] sched/nohz: add debugfs control over
 sched_tick_max_deferment
In-Reply-To: <1379371429-22214-1-git-send-email-khilman@linaro.org>
References: <1379371429-22214-1-git-send-email-khilman@linaro.org>
Message-ID: <CAGa+x86tj59F6n6cU=Anru2d8RHLuByHXqsrMFkUrNwhLbWXnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic,

On Mon, Sep 16, 2013 at 3:43 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Allow debugfs override of sched_tick_max_deferment in order to ease
> finding/fixing the remaining issues with full nohz.
>
> The value to be written is in jiffies, and -1 means the max deferment
> is disabled (scheduler_tick_max_deferment() returns KTIME_MAX.)
>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Any objections to this series for ease of debugging and tracking down
issues with the residual tick?

Kevin

> ---
>  kernel/sched/core.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ac63c9..4b1fe3e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2175,6 +2175,8 @@ void scheduler_tick(void)
>  }
>
>  #ifdef CONFIG_NO_HZ_FULL
> +static u32 sched_tick_max_deferment = HZ;
> +
>  /**
>   * scheduler_tick_max_deferment
>   *
> @@ -2193,13 +2195,25 @@ u64 scheduler_tick_max_deferment(void)
>         struct rq *rq = this_rq();
>         unsigned long next, now = ACCESS_ONCE(jiffies);
>
> -       next = rq->last_sched_tick + HZ;
> +       if (sched_tick_max_deferment == -1)
> +               return KTIME_MAX;
> +
> +       next = rq->last_sched_tick + sched_tick_max_deferment;
>
>         if (time_before_eq(next, now))
>                 return 0;
>
>         return jiffies_to_usecs(next - now) * NSEC_PER_USEC;
>  }
> +
> +static __init int sched_nohz_full_init_debug(void)
> +{
> +       debugfs_create_u32("sched_tick_max_deferment", 0644, NULL,
> +                          &sched_tick_max_deferment);
> +
> +       return 0;
> +}
> +late_initcall(sched_nohz_full_init_debug);
>  #endif
>
>  notrace unsigned long get_parent_ip(unsigned long addr)
> --
> 1.8.3
>
