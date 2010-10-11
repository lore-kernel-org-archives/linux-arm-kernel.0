From: robert.richter@amd.com (Robert Richter)
Date: Mon, 11 Oct 2010 11:18:10 +0200
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
Message-ID: <20101011091809.GQ13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.10 20:46:17, Matt Fleming wrote:
> Introduce perf_pmu_name() helper function that returns the name of the
> pmu. This gives us a generic way to get the name of a pmu regardless of
> how an architecture identifies it internally.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Peter, I need your ack here.

Thanks,

-Robert

> ---
>  arch/sh/kernel/perf_event.c |    9 +++++++++
>  include/linux/perf_event.h  |    1 +
>  kernel/perf_event.c         |    5 +++++
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
> index 2cb9ad5..55fe89b 100644
> --- a/arch/sh/kernel/perf_event.c
> +++ b/arch/sh/kernel/perf_event.c
> @@ -59,6 +59,15 @@ static inline int sh_pmu_initialized(void)
>  	return !!sh_pmu;
>  }
>  
> +const char *perf_pmu_name(void)
> +{
> +	if (!sh_pmu)
> +		return NULL;
> +
> +	return sh_pmu->name;
> +}
> +EXPORT_SYMBOL_GPL(perf_pmu_name);
> +
>  int perf_num_counters(void)
>  {
>  	if (!sh_pmu)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a02192..33f08da 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -850,6 +850,7 @@ extern int perf_max_events;
>  extern const struct pmu *hw_perf_event_init(struct perf_event *event);
>  
>  extern int perf_num_counters(void);
> +extern const char *perf_pmu_name(void);
>  extern void perf_event_task_sched_in(struct task_struct *task);
>  extern void perf_event_task_sched_out(struct task_struct *task, struct task_struct *next);
>  extern void perf_event_task_tick(struct task_struct *task);
> diff --git a/kernel/perf_event.c b/kernel/perf_event.c
> index db5b560..fc51268 100644
> --- a/kernel/perf_event.c
> +++ b/kernel/perf_event.c
> @@ -85,6 +85,11 @@ void __weak hw_perf_enable(void)		{ barrier(); }
>  
>  void __weak perf_event_print_debug(void)	{ }
>  
> +extern __weak const char *perf_pmu_name(void)
> +{
> +	return "pmu";
> +}
> +
>  static DEFINE_PER_CPU(int, perf_disable_count);
>  
>  void perf_disable(void)
> -- 
> 1.7.1
> 
> 

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
