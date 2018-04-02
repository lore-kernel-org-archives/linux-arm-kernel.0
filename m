From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 2 Apr 2018 14:36:04 -0600
Subject: [PATCH v4 4/6] coresight: tmc: Hook callback for panic kdump
In-Reply-To: <1522379724-30648-5-git-send-email-leo.yan@linaro.org>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
 <1522379724-30648-5-git-send-email-leo.yan@linaro.org>
Message-ID: <20180402203604.GD15452@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 11:15:22AM +0800, Leo Yan wrote:
> Since Coresight panic kdump functionality has been ready, this patch is
> to hook panic callback function for ETB/ETF driver.  The driver data
> structure has allocated a buffer when the session started, so simply
> save tracing data into this buffer when panic happens and update buffer
> related info for kdump.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 30 +++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index e2513b7..d20d546 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -504,6 +504,35 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
>  	CS_LOCK(drvdata->base);
>  }
>  
> +static void tmc_panic_cb(void *data)

I would call the function tmc_kdump_panic_cb()... That way there is absolutely
no confusion as to what it does.

> +{
> +	struct coresight_device *csdev = (struct coresight_device *)data;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
> +			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
> +		return;
> +
> +	if (drvdata->mode == CS_MODE_DISABLED)
> +		return;

This is racy - between the check and acquiring the spinlock someone may beat you
to it.

> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);

        if (drvdata->mode == CS_MODE_DISABLED)
                goto out;

        drvdata->mode = CS_MODE_DISABLED

> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	tmc_flush_and_stop(drvdata);
> +	tmc_etb_dump_hw(drvdata);
> +
> +	CS_LOCK(drvdata->base);
> +
> +	/* Update buffer info for panic dump */
> +	csdev->kdump_buf = drvdata->buf;
> +	csdev->kdump_buf_sz = drvdata->len;

out:
> +
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +}
> +
>  static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.enable		= tmc_enable_etf_sink,
>  	.disable	= tmc_disable_etf_sink,
> @@ -512,6 +541,7 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
>  	.set_buffer	= tmc_set_etf_buffer,
>  	.reset_buffer	= tmc_reset_etf_buffer,
>  	.update_buffer	= tmc_update_etf_buffer,
> +	.panic_cb	= tmc_panic_cb,
>  };
>  
>  static const struct coresight_ops_link tmc_etf_link_ops = {
> -- 
> 2.7.4
> 
