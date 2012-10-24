From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Oct 2012 20:51:17 +0530
Subject: [RFC 4/6] sched: secure access to other CPU statistics
In-Reply-To: <1349595838-31274-5-git-send-email-vincent.guittot@linaro.org>
References: <1349595838-31274-1-git-send-email-vincent.guittot@linaro.org>
 <1349595838-31274-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <5088076D.6080208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$subject is bit confusing here.

On Sunday 07 October 2012 01:13 PM, Vincent Guittot wrote:
> The atomic update of runnable_avg_sum and runnable_avg_period are ensured
> by their size and the toolchain. But we must ensure to not read an old value
> for one field and a newly updated value for the other field. As we don't
> want to lock other CPU while reading these fields, we read twice each fields
> and check that no change have occured in the middle.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c |   19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8c9d3ed..6df53b5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3133,13 +3133,28 @@ static int select_idle_sibling(struct task_struct *p, int target)
>   static inline bool is_buddy_busy(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
> +	volatile u32 *psum = &rq->avg.runnable_avg_sum;
> +	volatile u32 *pperiod = &rq->avg.runnable_avg_period;
> +	u32 sum, new_sum, period, new_period;
> +	int timeout = 10;
So it can be 2 times read or more as well.
> +
> +	while (timeout) {
> +		sum = *psum;
> +		period = *pperiod;
> +		new_sum = *psum;
> +		new_period = *pperiod;
> +
> +		if ((sum == new_sum) && (period == new_period))
> +			break;
> +
> +		timeout--;
> +	}
>
Seems like you did notice incorrect pair getting read
for rq runnable_avg_sum and runnable_avg_period. Seems
like the fix is to update them together under some lock
to avoid such issues.

Regards
Santosh
