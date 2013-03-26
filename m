From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 26 Mar 2013 13:26:22 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1364300782.5053.6.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-22 at 13:25 +0100, Vincent Guittot wrote:
> +static bool is_buddy_busy(int cpu)
> +{
> +       struct rq *rq = cpu_rq(cpu);
> +
> +       /*
> +        * A busy buddy is a CPU with a high load or a small load with
> a lot of
> +        * running tasks.
> +        */
> +       return (rq->avg.runnable_avg_sum >
> +                       (rq->avg.runnable_avg_period / (rq->nr_running
> + 2)));
> +}

Why does the comment talk about load but we don't see it in the
equation. Also, why does nr_running matter at all? I thought we'd
simply bother with utilization, if fully utilized we're done etc..
