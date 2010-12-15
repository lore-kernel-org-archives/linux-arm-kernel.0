From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 15 Dec 2010 19:24:12 +0100
Subject: [PATCH 1/2] sched: Fix the irqtime code to deal with u64 wraps
In-Reply-To: <AANLkTin86W-W69fGpj+5LCP7L-KQfA_tn506o+RZ_UED@mail.gmail.com>
References: <1292013506.13513.78.camel@laptop>
	<AANLkTi=vUvNET2peva7uzWbzk5eK5EsKUrEQQSwLkNwM@mail.gmail.com>
	<1292242433.6803.199.camel@twins>
	<AANLkTin86W-W69fGpj+5LCP7L-KQfA_tn506o+RZ_UED@mail.gmail.com>
Message-ID: <1292437452.2708.45.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-15 at 10:16 -0800, Venkatesh Pallipadi wrote:
> Peter,
> 
> This looks like something that happened while splitting this into two
> patches. I needed a trivial change like below before I could apply
> these two patches on linus-git.
> 
> Thanks,
> Venki
> ---
> @@ -641,17 +641,18 @@ static void sched_irq_time_avg_update(struct rq
> *rq, u64 irq_time);
> 
>  inline void update_rq_clock(struct rq *rq)
>  {
> -	if (!rq->skip_clock_update) {
> -		int cpu = cpu_of(rq);
> -		u64 irq_time;
> +	int cpu = cpu_of(rq);
> +	u64 irq_time;
> 
> -		rq->clock = sched_clock_cpu(cpu);
> -		irq_time = irq_time_cpu(cpu);
> -		if (rq->clock - irq_time > rq->clock_task)
> -			rq->clock_task = rq->clock - irq_time;
> +	if (rq->skip_clock_update)
> +		return;
> 
> -		sched_irq_time_avg_update(rq, irq_time);
> -	}
> +	rq->clock = sched_clock_cpu(cpu);
> +	irq_time = irq_time_cpu(cpu);
> +	if (rq->clock - irq_time > rq->clock_task)
> +		rq->clock_task = rq->clock - irq_time;
> +
> +	sched_irq_time_avg_update(rq, irq_time);
>  }
> 
>  /*


That's due another patch in tip/sched/urgent
