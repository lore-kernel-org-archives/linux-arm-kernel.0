From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 15 Jul 2015 09:29:42 +0000
Subject: [PATCH 2/2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <BL2PR03MB33868673832B44DD03ED841839B0@BL2PR03MB338.namprd03.prod.outlook.com>
References: <BL2PR03MB33868673832B44DD03ED841839B0@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <BL2PR03MB3383F459B7A2E5E15A0E641839A0@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for your review, now I will take over the eDMA.
I have some different in understanding with PM suspend/resume support. And I will send a patch for RFC later.
Also please check my comment in line for this patch.
I hope you can help to review it for me.

Thanks.

Best Regards,
Yuan Yao

On 2015-5-5 18:35, Vinod Koul wrote:
> On 2014-12-30 09:41, Jingchang Lu wrote:
> > This adds power management suspend/resume support for the fsl-edma
> > driver.
> >
> > Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> > ---
> >  drivers/dma/fsl-edma.c | 38
> ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c index
> > e0bd517..6a81699 100644
> > --- a/drivers/dma/fsl-edma.c
> > +++ b/drivers/dma/fsl-edma.c
> > @@ -1017,6 +1017,43 @@ static int fsl_edma_remove(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int fsl_edma_pm_suspend(struct device *dev) {
> > +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> > +	struct fsl_edma_chan *fsl_chan;
> > +	int i;
> > +
> > +	for (i = 0; i < fsl_edma->n_chans; i++) {
> > +		fsl_chan = &fsl_edma->chans[i];
> > +		fsl_edma_chan_mux(fsl_chan, 0, false);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_edma_pm_resume(struct device *dev) {
> > +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> > +	struct fsl_edma_chan *fsl_chan;
> > +	int i;
> > +
> > +	for (i = 0; i < fsl_edma->n_chans; i++) {
> > +		fsl_chan = &fsl_edma->chans[i];
> > +		edma_writew(fsl_edma, 0x0, fsl_edma->membase +
> EDMA_TCD_CSR(i));
> 
> What is the expectation of the suspend mode, are the registers and descriptors
> cleared during suspend? So this makes sure we have all descriptors disabled on
> wake-up, right?
Yes, suspend mode will power down the eDMA controller.

> 
> > +		/* restore the channel slave id configuration */
> > +		fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
> 
> And here the channel gets muxed again.
> 
> But the user is expected to reconfigure a channel, e.g. using
> dmaengine_slave_config and the dmaengine_prep*? Also and cyclic DMA
> which has been paused before would be interrupted, is this correct?

No, In fact the channel in eDMA is a little different form the other channel. Every IP just have only one channel. The IP should get his corresponding channel when boot up and release it until power down or IP removed.

> I don't know what the common exception of the API is, I'm just asking so I now
> what I can expect when using the DMA driver in other device drivers...
> 
> --
> Stefan
> 
> > +	}
> > +
> > +	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA,
> > +		    fsl_edma->membase + EDMA_CR);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +static
> > +SIMPLE_DEV_PM_OPS(fsl_edma_pm_ops, fsl_edma_pm_suspend,
> > +fsl_edma_pm_resume);
> > +
> >  static const struct of_device_id fsl_edma_dt_ids[] = {
> >  	{ .compatible = "fsl,vf610-edma", },
> >  	{ /* sentinel */ }
> > @@ -1027,6 +1064,7 @@ static struct platform_driver fsl_edma_driver = {
> >  	.driver		= {
> >  		.name	= "fsl-edma",
> >  		.of_match_table = fsl_edma_dt_ids,
> > +		.pm	= &fsl_edma_pm_ops,
> >  	},
> >  	.probe          = fsl_edma_probe,
> >  	.remove		= fsl_edma_remove,
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
