From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Aug 2018 17:43:02 -0600
Subject: [PATCH 09/13] coresight: etmx: Claim devices before use
In-Reply-To: <1533562915-21558-10-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180814234302.GA8196@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 02:41:51PM +0100, Suzuki K Poulose wrote:
> Use the CLAIM tags to grab the device for self-hosted usage.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 18 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 15 ++++++++++++---
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 771691c..b810bbc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -357,7 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>  
>  static int etm_enable_hw(struct etm_drvdata *drvdata)
>  {
> -	int i;
> +	int i, rc;
>  	u32 etmcr;
>  	struct etm_config *config = &drvdata->config;
>  
> @@ -369,6 +369,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	etm_set_pwrup(drvdata);
>  	/* Make sure all registers are accessible */
>  	etm_os_unlock(drvdata);
> +	rc = coresight_claim_device_unlocked(drvdata->base);
> +	if (rc)
> +		goto done;
>  
>  	etm_set_prog(drvdata);
>  
> @@ -417,10 +420,15 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	etm_writel(drvdata, 0x0, ETMVMIDCVR);
>  
>  	etm_clr_prog(drvdata);
> +
> +done:
> +	if (rc)
> +		etm_set_pwrdwn(drvdata);
>  	CS_LOCK(drvdata->base);
>  
> -	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
> -	return 0;
> +	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> +		drvdata->cpu, rc);
> +	return rc;
>  }
>  
>  struct etm_enable_arg {
> @@ -561,6 +569,8 @@ static void etm_disable_hw(void *info)
>  	struct etm_config *config = &drvdata->config;
>  
>  	CS_UNLOCK(drvdata->base);
> +
> +

This is extra, please remove.

>  	etm_set_prog(drvdata);
>  
>  	/* Read back sequencer and counters for post trace analysis */
> @@ -569,6 +579,8 @@ static void etm_disable_hw(void *info)
>  	for (i = 0; i < drvdata->nr_cntr; i++)
>  		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +
>  	etm_set_pwrdwn(drvdata);
>  	CS_LOCK(drvdata->base);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 4f9e6bb..20d1015 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -84,13 +84,17 @@ struct etm4_enable_arg {
>  
>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
> -	int i;
> +	int i, rc;
>  	struct etmv4_config *config = &drvdata->config;
>  
>  	CS_UNLOCK(drvdata->base);
>  
>  	etm4_os_unlock(drvdata);
>  
> +	rc = coresight_claim_device_unlocked(drvdata->base);
> +	if (rc)
> +		goto done;
> +
>  	/* Disable the trace unit before programming trace registers */
>  	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
>  
> @@ -178,10 +182,12 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  		dev_err(drvdata->dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  
> +done:
>  	CS_LOCK(drvdata->base);
>  
> -	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
> -	return 0;
> +	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> +		drvdata->cpu, rc);
> +	return rc;
>  }
>  
>  static void etm4_enable_hw_smp_call(void *info)
> @@ -326,6 +332,7 @@ static void etm4_disable_hw(void *info)
>  
>  	CS_UNLOCK(drvdata->base);
>  
> +

Same here.

>  	/* power can be removed from the trace unit now */
>  	control = readl_relaxed(drvdata->base + TRCPDCR);
>  	control &= ~TRCPDCR_PU;
> @@ -341,6 +348,8 @@ static void etm4_disable_hw(void *info)
>  	isb();
>  	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +
>  	CS_LOCK(drvdata->base);
>  
>  	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
> -- 
> 2.7.4
> 
