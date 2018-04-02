From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 2 Apr 2018 15:34:37 -0600
Subject: [PATCH v4 5/6] coresight: Set and clear sink device handler for
 kdump node
In-Reply-To: <1522379724-30648-6-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
 <1522379724-30648-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20180402213437.GE15452@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 11:15:23AM +0800, Leo Yan wrote:
> If Coresight path is enabled for specific CPU, the sink device handler
> need to be set to kdump node; on the other hand we also need to clear
> sink device handler when path is disabled.
> 
> This patch sets sink devices handler for kdump node for two separate
> Coresight enabling modes: CS_MODE_SYSFS and CS_MODE_PERF; and clear the
> handler when Coresight is disabled.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c |  5 +++++
>  drivers/hwtracing/coresight/coresight.c          | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 8a0ad77..f8b159c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -139,6 +139,8 @@ static void free_event_data(struct work_struct *work)
>  	for_each_cpu(cpu, mask) {
>  		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
>  			coresight_release_path(event_data->path[cpu]);
> +
> +		coresight_kdump_sink(cpu, NULL);
>  	}
>  
>  	kfree(event_data->path);
> @@ -238,6 +240,9 @@ static void *etm_setup_aux(int event_cpu, void **pages,
>  		event_data->path[cpu] = coresight_build_path(csdev, sink);
>  		if (IS_ERR(event_data->path[cpu]))
>  			goto err;
> +
> +		if (coresight_kdump_sink(cpu, sink))
> +			goto err;

I remember telling you to use free_event_data() and etm_setup_aux().  _Maybe_ it
made sense in the previous patchset but in this one it won't work.  We need to
reflect the current trace context, as such use etm_event_start() and
etm_event_stop().

In etm_event_start() call coresight_kdump_sink(cpu, sink) just before
source_ops(csdev)->enable().  Similarly call coresight_kdump_sink(cpu, NULL)
right after source_ops(csdev)->disable() in etm_event_stop().

Find me on IRC if you want more information on this.

>  	}
>  
>  	if (!sink_ops(sink)->alloc_buffer)
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 389c4ba..483a1f7 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -272,6 +272,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
>  static bool coresight_disable_source(struct coresight_device *csdev)
>  {
>  	if (atomic_dec_return(csdev->refcnt) == 0) {
> +

This newline shouldn't be part of this set.

>  		if (source_ops(csdev)->disable)
>  			source_ops(csdev)->disable(csdev, NULL);
>  		csdev->enable = false;
> @@ -612,6 +613,13 @@ int coresight_enable(struct coresight_device *csdev)
>  	if (ret)
>  		goto err_source;
>  
> +	cpu = source_ops(csdev)->cpu_id(csdev);
> +
> +	/* Set sink device handler into kdump node */
> +	ret = coresight_kdump_sink(cpu, sink);
> +	if (ret)
> +		goto err_kdump;
> +

Call coresight_kdump_sink() just before coresight_enable_source().  That way if
there is a dump just after coresight_enable_source() is called we get the chance
of getting some traces in the dump file. 

>  	switch (subtype) {
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>  		/*
> @@ -621,7 +629,6 @@ int coresight_enable(struct coresight_device *csdev)
>  		 * be a single session per tracer (when working from sysFS)
>  		 * a per-cpu variable will do just fine.
>  		 */
> -		cpu = source_ops(csdev)->cpu_id(csdev);
>  		per_cpu(tracer_path, cpu) = path;
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> @@ -636,6 +643,9 @@ int coresight_enable(struct coresight_device *csdev)
>  	mutex_unlock(&coresight_mutex);
>  	return ret;
>  
> +err_kdump:
> +	coresight_disable_source(csdev);
> +
>  err_source:
>  	coresight_disable_path(path);
>  
> @@ -659,9 +669,10 @@ void coresight_disable(struct coresight_device *csdev)
>  	if (!csdev->enable || !coresight_disable_source(csdev))
>  		goto out;
>  
> +	cpu = source_ops(csdev)->cpu_id(csdev);
> +
>  	switch (csdev->subtype.source_subtype) {
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		cpu = source_ops(csdev)->cpu_id(csdev);
>  		path = per_cpu(tracer_path, cpu);
>  		per_cpu(tracer_path, cpu) = NULL;
>  		break;
> @@ -674,6 +685,7 @@ void coresight_disable(struct coresight_device *csdev)
>  		break;
>  	}
>  
> +	coresight_kdump_sink(cpu, NULL);
>  	coresight_disable_path(path);
>  	coresight_release_path(path);
>  
> -- 
> 2.7.4
> 
