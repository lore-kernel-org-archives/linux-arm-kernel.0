From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 27 Oct 2015 11:00:36 +0900
Subject: [PATCH v3] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1445243465-7727-1-git-send-email-yao.yuan@freescale.com>
References: <1445243465-7727-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20151027020035.GC11691@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:31:05PM +0800, Yuan Yao wrote:

The patch overall looks fine, but
>  
> +static int fsl_edma_suspend_late(struct device *dev)

This needs protection and will have build failure when CONFIG_PM is not
defined

> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	struct fsl_edma_chan *fsl_chan;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
> +		/* Make sure chan is idle or will force disable. */
> +		if (unlikely(!fsl_chan->idle)) {
> +			dev_warn(dev, "WARN: There is non-idle channel.");
> +			fsl_edma_disable_request(fsl_chan);
> +			fsl_edma_chan_mux(fsl_chan, 0, false);
> +		}
> +
> +		fsl_chan->pm_state = SUSPENDED;
> +		spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_edma_resume_early(struct device *dev)
> +{
> +	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
> +	struct fsl_edma_chan *fsl_chan;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +		fsl_chan->pm_state = RUNNING;
> +		edma_writew(fsl_edma, 0x0, fsl_edma->membase + EDMA_TCD_CSR(i));
> +		if (fsl_chan->slave_id != 0)
> +			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
> +	}
> +
> +	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA,
> +			fsl_edma->membase + EDMA_CR);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops fsl_edma_pm_ops = {
> +	.suspend_late   = fsl_edma_suspend_late,
> +	.resume_early   = fsl_edma_resume_early,
> +};

This one too, also why use late and early, pls add the note here

>  static const struct of_device_id fsl_edma_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-edma", },
>  	{ /* sentinel */ }
> @@ -969,6 +1042,7 @@ static struct platform_driver fsl_edma_driver = {
>  	.driver		= {
>  		.name	= "fsl-edma",
>  		.of_match_table = fsl_edma_dt_ids,
> +		.pm     = &fsl_edma_pm_ops,
This will fail too if CONFIG_PM is not defined

-- 
~Vinod
