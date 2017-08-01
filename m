From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 1 Aug 2017 10:18:17 +0200
Subject: [PATCH v3 1/5] hw_breakpoint: Add step_needed event attribute
In-Reply-To: <1d7ca935857f93bd09c82a2ff57a53e373211b7e.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
 <1d7ca935857f93bd09c82a2ff57a53e373211b7e.1501496603.git.panand@redhat.com>
Message-ID: <20170801081817.GG6524@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 04:10:29PM +0530, Pratyush Anand wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 24a635887f28..7da951f94b47 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -233,6 +233,12 @@ struct hw_perf_event {
>  	 */
>  	u64				freq_time_stamp;
>  	u64				freq_count_stamp;
> +	/*
> +	 * A HW breakpoint user can either have it's own step handling
> +	 * mechanism or it can use default step handling meachanism defined
> +	 * by arch code. Set step_needed to use default mechanism.
> +	 */
> +	int				step_needed;

You'll note that there is an anonymous structure inside the anonymous
union specifically dedicated to hardware breakpoint state. Why not put
it there?

>  #endif
>  };
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6c4e523dc1e2..66ce5574e778 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9444,9 +9444,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	} else if (is_write_backward(event)){
>  		event->overflow_handler = perf_event_output_backward;
>  		event->overflow_handler_context = NULL;
> +		event->hw.step_needed = 1;
>  	} else {
>  		event->overflow_handler = perf_event_output_forward;
>  		event->overflow_handler_context = NULL;
> +		event->hw.step_needed = 1;
>  	}

These here need a comment, because even if I'd know now why the heck we
need that = 1 here, I'd sure as hell won't know tomorrow.
