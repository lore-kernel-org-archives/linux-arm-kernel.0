From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 20 Jul 2016 16:34:07 +0100
Subject: [PATCH 01/10] coresight: etm-perf: pass struct perf_event to
 source::enable/disable()
In-Reply-To: <1468871491-10997-2-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
 <1468871491-10997-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <a06945bb-9af4-f2a5-0f5d-62b165ba07f1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/16 20:51, Mathieu Poirier wrote:
> With this commit [1] address range filter information is now found
> in the struct hw_perf_event::addr_filters.  As such pass the event
> itself to the coresight_source::enable/disable() functions so that
> both event attribute and filter can be accessible for configuration.
>
> [1] 'commit 375637bc5249 ("perf/core: Introduce address range filtering")'

> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 385d62e64abb..2a5982c37dfb 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -232,8 +232,9 @@ struct coresight_ops_source {
>  	int (*cpu_id)(struct coresight_device *csdev);
>  	int (*trace_id)(struct coresight_device *csdev);
>  	int (*enable)(struct coresight_device *csdev,
> -		      struct perf_event_attr *attr,  u32 mode);
> -	void (*disable)(struct coresight_device *csdev);
> +		      struct perf_event *event,  u32 mode);
> +	void (*disable)(struct coresight_device *csdev,
> +			struct perf_event *event);

nit:

Should we make this a a bit more generic API rather than hard coding
the perf stuff in there ? i.e,

how about :

int (*enable)(struct coresight_device *csdev, void *data, u32 mode)

void (*disable)(struct coresight_device *csdev, void *data, u32 mode)

where data is specific to the mode of operation. That way the API is
cleaner and each mode could pass their own data (even though sysfs
doesn't use any at the moment).

Suzuki
