From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 15 Jul 2015 09:23:33 +0000
Subject: [PATCH 2/2] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <BL2PR03MB3383F18A5096A989DF7DE8F839B0@BL2PR03MB338.namprd03.prod.outlook.com>
References: <BL2PR03MB3383F18A5096A989DF7DE8F839B0@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <BL2PR03MB338405EB3506D758CECF786839A0@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Thanks for your review, now I will take over the eDMA.
I have some different in understanding with PM suspend/resume support. And I will send a patch for RFC later.
Also please check my comment in line for this patch.
I hope you can help to review it for me.

Thanks.

Best Regards,
Yuan Yao

On 2015-1-30 21:01,  Stefan Agner wrote:
> On Tue, Dec 30, 2014 at 04:41:47PM +0800, Jingchang Lu wrote:
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
> > +		/* restore the channel slave id configuration */
> > +		fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
> Wouldnt this be reconfigured? Should you do this for all channels or active ones.
> Also I dont see you pausing or suspending active channels or checking for them?
> 
No, here is no need more reconfigured. I will send a new patch for what your consideration.
Thanks.

> --
> ~Vinod
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
> > --
> > 1.8.0
> >
> 
> --
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
