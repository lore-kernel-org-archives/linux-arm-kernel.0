From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 27 May 2014 15:45:42 +0200
Subject: [PATCH v2 02/11] sched: remove a wake_affine condition
In-Reply-To: <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140527134542.GB11074@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:52:56PM +0200, Vincent Guittot wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9587ed1..30240ab 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4238,7 +4238,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
>  {
>  	s64 this_load, load;
>  	int idx, this_cpu, prev_cpu;
> -	unsigned long tl_per_task;
>  	struct task_group *tg;
>  	unsigned long weight;
>  	int balanced;
> @@ -4296,32 +4295,22 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p, int sync)
>  		balanced = this_eff_load <= prev_eff_load;
>  	} else
>  		balanced = true;
> +	schedstat_inc(p, se.statistics.nr_wakeups_affine_attempts);
>  
> +	if (!balanced)
> +		return 0;
>  	/*
>  	 * If the currently running task will sleep within
>  	 * a reasonable amount of time then attract this newly
>  	 * woken task:
>  	 */
> +	if (sync)
>  		return 1;
>  
> +	schedstat_inc(sd, ttwu_move_affine);
> +	schedstat_inc(p, se.statistics.nr_wakeups_affine);
>  
> +	return 1;
>  }

So I'm not usually one for schedstat nitpicking, but should we fix it in
the sync case? That is, for sync we return 1 but do no inc
nr_wakeups_affine, even though its going to be an affine wakeup.
