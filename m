From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Nov 2018 16:01:20 +0000
Subject: [PATCH 01/10] perf/core: Add macro to test for event exclusion
 flags
In-Reply-To: <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
Message-ID: <20181119160119.mp6oq6rt5k4fdrd5@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 10:24:04AM +0000, Andrew Murray wrote:
> Add a macro that tests if any of the perf event exclusion flags
> are set on a given event.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Aside from the s/macro/function, or s/macro/helper/, this looks sound to
me.

Assuming you fix that up here and in subsequent commit messages, for
this patch feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/perf_event.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..89ee7fa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
>  extern void
>  perf_log_lost_samples(struct perf_event *event, u64 lost);
>  
> +static inline bool event_has_exclude_flags(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +
> +	return attr->exclude_idle || attr->exclude_user ||
> +	       attr->exclude_kernel || attr->exclude_hv ||
> +	       attr->exclude_guest || attr->exclude_host;
> +}
> +
>  static inline bool is_sampling_event(struct perf_event *event)
>  {
>  	return event->attr.sample_period != 0;
> -- 
> 2.7.4
> 
