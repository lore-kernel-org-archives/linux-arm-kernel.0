From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 9 Jul 2014 09:50:43 +0200
Subject: [PATCH v3 06/12] sched: add per rq cpu_power_orig
In-Reply-To: <1404144343-18720-7-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <CAP245DXYvhD1EinAuRUCzY2wH=jJggV1dtAXwPJZN35jOU_bwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 6:05 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> This new field cpu_power_orig reflects the available capacity of a CPUs unlike
> the cpu_power which reflects the current capacity that can be altered by
> frequency and rt tasks.
>

s/cpu_power/cpu_capacity

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c  | 2 +-
>  kernel/sched/fair.c  | 1 +
>  kernel/sched/sched.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 54f5722..92dd6d1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6964,7 +6964,7 @@ void __init sched_init(void)
>  #ifdef CONFIG_SMP
>                 rq->sd = NULL;
>                 rq->rd = NULL;
> -               rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +               rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>                 rq->post_schedule = 0;
>                 rq->active_balance = 0;
>                 rq->next_balance = jiffies;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f0bba5f..7dff578 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5671,6 +5671,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>
>         capacity >>= SCHED_CAPACITY_SHIFT;
>
> +       cpu_rq(cpu)->cpu_capacity_orig = capacity;
>         sdg->sgc->capacity_orig = capacity;
>
>         if (sched_feat(ARCH_CAPACITY))
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2f86361..7b311de 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -568,6 +568,7 @@ struct rq {
>         struct sched_domain *sd;
>
>         unsigned long cpu_capacity;
> +       unsigned long cpu_capacity_orig;
>
>         unsigned char idle_balance;
>         /* For active balancing */
> --
> 1.9.1
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
