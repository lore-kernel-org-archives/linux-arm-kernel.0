From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 12:58:11 +0300
Subject: [RFC PATCH 01/20] coresight: etm3x: splitting 'etm_enable_hw()'
 operations
In-Reply-To: <1442593594-10665-2-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87r3lgjkjw.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> -static void etm_enable_hw(void *info)
> +static void etm_power_up_cpu(void *info)
>  {
> -	int i;
> -	u32 etmcr;
> -	struct etm_drvdata *drvdata = info;
> +	struct coresight_device *csdev = info;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	WARN_ON(drvdata->cpu != smp_processor_id());

Maybe WARN_ON_ONCE() is sufficient here (and other similar places).

> +static void etm_power_down_cpu(void *info)
> +{
> +	struct coresight_device *csdev = info;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	WARN_ON(drvdata->cpu != smp_processor_id());

Likewise.

> +/**
> + * etm_configure_cpu - configure ETM registers
> + * @csdev - the etm that needs to be configure.
> + *
> + * Applies a configuration set to the ETM registers _without_ enabling the
> + * tracer.  This function needs to be executed on the CPU who's tracer is
> + * being configured.
> + */
> +static void etm_configure_cpu(void *info)
> +{
> +	int i;
> +	u32 etmcr;
> +	struct coresight_device *csdev = info;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	WARN_ON(drvdata->cpu != smp_processor_id());

Likewise.

> +
> +	CS_UNLOCK(drvdata->base);
>  	etm_set_prog(drvdata);
>  
>  	etmcr = etm_readl(drvdata, ETMCR);
> -	etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
>  	etmcr |= drvdata->port_size;
>  	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
>  	etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);

Most of these things can also be bypassed, as at least initially perf
events won't be using trigger/sequencer configurations, so we could
simply clear all these things out when a first perf event is created
(which would also disallow any sysfs poking around the etm/etb) and not
worry about them in the pmu callbacks.

Regards,
--
Alex
