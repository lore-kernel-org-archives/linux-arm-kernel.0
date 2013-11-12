From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Nov 2013 10:32:26 +0530
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
 <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131112050226.GK8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 05:58:42AM +0000, Xiubo Li-B47053 wrote:
> Hi Dan, Vinod,
> 
> 
> > > +static int fsl_sai_probe(struct platform_device *pdev) {
> > [...]
> > > +
> > > +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> > > +	sai->dma_params_rx.maxburst = 6;
> > > +	index = of_property_match_string(np, "dma-names", "rx");
> > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > > +				&dma_args);
> > > +	if (ret)
> > > +		return ret;
> > > +	sai->dma_params_rx.slave_id = dma_args.args[1];
> > > +
> > > +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> > > +	sai->dma_params_tx.maxburst = 6;
> > > +	index = of_property_match_string(np, "dma-names", "tx");
> > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > > +				&dma_args);
> > > +	if (ret)
> > > +		return ret;
> > > +	sai->dma_params_tx.slave_id = dma_args.args[1];
> > 
> > The driver should not have to manually parse the dma devicetree
> > properties, this is something that should be handled by the dma engine
> > driver.
> > 
> 
> What do you think about the DMA slave_id ?
> I have been noticed by one colleague that this should be parsed here, which
> is from your opinions ?
Sure slave_id can be parsed here, but IMO it should be programmed via the
dma_slave_confog into the respective channel

--
~Vinod
> 
> 
> > > +
> > > +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> > > +			&fsl_sai_dai, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = fsl_pcm_dma_init(pdev);
> > > +	if (ret)
> > > +		goto out;
> 
> 

-- 
