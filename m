From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 22 Nov 2018 12:21:43 +0000
Subject: [PATCH 00/10] perf/core: Generalise event exclusion checking
In-Reply-To: <20181119130800.GE9761@hirez.programming.kicks-ass.net>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <20181119130800.GE9761@hirez.programming.kicks-ass.net>
Message-ID: <20181122122142.GI42987@e119886-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 02:08:00PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 16, 2018 at 10:24:03AM +0000, Andrew Murray wrote:
> > Many PMU drivers do not have the capability to exclude counting events
> > that occur in specific contexts such as idle, kernel, guest, etc. These
> > drivers indicate this by returning an error in their event_init upon
> > testing the events attribute flags.
> > 
> > However this approach requires that each time a new event modifier is
> > added to perf, all the perf drivers need to be modified to indicate that
> > they don't support the attribute. This results in additional boiler-plate
> > code common to many drivers that needs to be maintained. An example of
> > this is the addition of exclude_host and exclude_guest in 2011 yet many
> > PMU drivers do not support this or indicate an error on events that make
> > use of it.
> > 
> > This patch generalises the test for exclusion and updates PMU drivers to
> > use it. This is a functional change as some PMU drivers will now correctly
> > report that they don't support certain events whereas they previously did.
> 
> Right, I like that idea, and yes, there's a lot of fail around there :/
> 
> > A longer term approach may instead be for PMU's to advertise their
> > capabilities on registration.
> 
> This I think is the better approach. We already have the
> PERF_PMU_CAP_flags that can be used to advertise various PMU
> capabilities.

OK I'll respin my series to take this approach.

> 
> Something along these lines I suppose; then every PMU that actually
> checks the flags, needs to set the flag, otherwise it'll fail.
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..de15723ea52a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -244,6 +244,7 @@ struct perf_event;
>  #define PERF_PMU_CAP_EXCLUSIVE			0x10
>  #define PERF_PMU_CAP_ITRACE			0x20
>  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
> +#define PERF_PMU_CAP_EXCLUDE			0x80
>  
>  /**
>   * struct pmu - generic performance monitoring unit
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 84530ab358c3..d76b724177b9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9772,6 +9772,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>  	if (ctx)
>  		perf_event_ctx_unlock(event->group_leader, ctx);
>  
> +	if (!ret) {
> +		if ((pmu->capabilities & PERF_PMU_CAP_EXCLUDE) ||
> +		    event_has_exclude_flags(event)) {
> +			event->destroy(event);
> +			ret = -EINVAL;
> +		}
> +	}
> +

I don't quite follow this logic. Should that not have been:

if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
     event_has_exclude_flags(event)) {

Meaning that if an event has any exclude flags but the pmu doesn't
have the capability to handle them then error.

If you're happy with my proposed logic, then would it also make
sense to move this before the call to the pmu->event_init ?

Thanks,

Andrew Murray

>  	if (ret)
>  		module_put(pmu->module);
>  
> 
