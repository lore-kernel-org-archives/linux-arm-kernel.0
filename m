From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 5 Mar 2015 16:11:08 +0530
Subject: [PATCH 2/2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1419928907-18053-3-git-send-email-jingchang.lu@freescale.com>
References: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
 <1419928907-18053-3-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20150305104108.GF2613@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 04:41:47PM +0800, Jingchang Lu wrote:
> This adds power management suspend/resume support for
> the fsl-edma driver.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/dma/fsl-edma.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index e0bd517..6a81699 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -1017,6 +1017,43 @@ static int fsl_edma_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int fsl_edma_pm_suspend(struct device *dev)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	struct fsl_edma_chan *fsl_chan;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +		fsl_edma_chan_mux(fsl_chan, 0, false);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_edma_pm_resume(struct device *dev)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	struct fsl_edma_chan *fsl_chan;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +		edma_writew(fsl_edma, 0x0, fsl_edma->membase + EDMA_TCD_CSR(i));
> +		/* restore the channel slave id configuration */
> +		fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
Wouldnt this be reconfigured? Should you do this for all channels or active
ones.
Also I dont see you pausing or suspending active channels or checking for
them?

-- 
~Vinod

> +	}
> +
> +	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA,
> +		    fsl_edma->membase + EDMA_CR);
> +
> +	return 0;
> +}
> +#endif
> +static
> +SIMPLE_DEV_PM_OPS(fsl_edma_pm_ops, fsl_edma_pm_suspend, fsl_edma_pm_resume);
> +
>  static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-edma", },
>  	{ /* sentinel */ }
> @@ -1027,6 +1064,7 @@ static struct platform_driver fsl_edma_driver = {
>  	.driver		= {
>  		.name	= "fsl-edma",
>  		.of_match_table = fsl_edma_dt_ids,
> +		.pm	= &fsl_edma_pm_ops,
>  	},
>  	.probe          = fsl_edma_probe,
>  	.remove		= fsl_edma_remove,
> -- 
> 1.8.0
> 

-- 
