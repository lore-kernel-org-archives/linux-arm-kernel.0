From: stefan@agner.ch (Stefan Agner)
Date: Fri, 30 Jan 2015 14:05:45 +0100
Subject: [PATCH 2/2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1419928907-18053-3-git-send-email-jingchang.lu@freescale.com>
References: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
 <1419928907-18053-3-git-send-email-jingchang.lu@freescale.com>
Message-ID: <c6942c16d473173034df25b1bfa7f03c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-30 09:41, Jingchang Lu wrote:
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

What is the expectation of the suspend mode, are the registers and
descriptors cleared during suspend? So this makes sure we have all
descriptors disabled on wake-up, right?

> +		/* restore the channel slave id configuration */
> +		fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);

And here the channel gets muxed again.

But the user is expected to reconfigure a channel, e.g. using
dmaengine_slave_config and the dmaengine_prep*? Also and cyclic DMA
which has been paused before would be interrupted, is this correct?

I don't know what the common exception of the API is, I'm just asking so
I now what I can expect when using the DMA driver in other device
drivers...

--
Stefan

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
