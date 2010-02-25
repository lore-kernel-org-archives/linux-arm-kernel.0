From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 25 Feb 2010 12:31:45 +0000
Subject: [PATCH] ARM: perf-events: request PMU interrupts with
	IRQF_NOBALANCING
In-Reply-To: <1267099938-5555-1-git-send-email-will.deacon@arm.com>
References: <1267099938-5555-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100225123145.GA4453@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 12:12:18PM +0000, Will Deacon wrote:
> If IRQ balancing is used on a multicore ARM system, PMU interrupt
> lines may be relocated onto CPUs other than the one causing the
> counter overflow. This can result in misattribution of events to
> the wrong core and, in the case that the CPU handling the interrupt
> has not experience counter overflow, the interrupt can be disabled
> because the handler returns IRQ_NONE.
> 
> This patch adds the IRQF_NOBALANCING flag to the request_irq call
> in perf_events.c.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/perf_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index c54ceb3..b44d159 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -332,7 +332,8 @@ armpmu_reserve_hardware(void)
>  
>  	for (i = 0; i < pmu_irqs->num_irqs; ++i) {
>  		err = request_irq(pmu_irqs->irqs[i], armpmu->handle_irq,
> -				  IRQF_DISABLED, "armpmu", NULL);
> +				  IRQF_DISABLED | IRQF_NOBALANCING,
> +				  "armpmu", NULL);
>  		if (err) {
>  			pr_warning("unable to request IRQ%d for ARM "
>  				   "perf counters\n", pmu_irqs->irqs[i]);
> -- 
> 1.6.3.3
Hi Will,

Looks good to me.

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
