From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 14:33:36 +0300
Subject: [RFC PATCH 06/20] coresight: etm3x: unlocking tracer in default
 arch init
In-Reply-To: <1442593594-10665-7-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-7-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87eghgjg4v.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Calling function 'smp_call_function_single()' to unlock the
> tracer and calling it right after to perform the default
> initialisation doesn't make sense.
>
> Moving 'etm_os_unlock()' just before making the default
> initialisation results in the same outcome while saving
> one call to 'smp_call_function_single()'.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index c6880c1ade55..a4c158df0fef 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -1867,6 +1867,11 @@ static void etm_init_arch_data(void *info)
>  	 * certain registers might be ignored.
>  	 */
>  	etm_clr_pwrdwn(drvdata);
> +
> +	/* Make sure all registers are accessible */
> +	etm_os_unlock(drvdata);

In case of co-processor register access, this will end up unlocking the
local ETM instead of the one on target cpu, by the looks of it. That's
why smp_function_call() was needed there. Or you might want a
etm_read_on_cpu() variant if it's really worth it.

> +	drvdata->os_unlock = true;
> +
>  	/*
>  	 * Set prog bit. It will be set from reset but this is included to
>  	 * ensure it is set
> @@ -1961,9 +1966,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	get_online_cpus();
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
> -	if (!smp_call_function_single(drvdata->cpu, etm_os_unlock, drvdata, 1))
> -		drvdata->os_unlock = true;
> -
>  	if (smp_call_function_single(drvdata->cpu,
>  				     etm_init_arch_data,  drvdata, 1))
>  		dev_err(dev, "ETM arch init failed\n");
> -- 
> 1.9.1

Regards,
--
Alex
