From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Tue, 12 Nov 2013 07:35:55 +0000
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <20131112050226.GK8834@intel.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
 <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131112050226.GK8834@intel.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287E87B@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +static int fsl_sai_probe(struct platform_device *pdev) {
> > > [...]
> > > > +
> > > > +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> > > > +	sai->dma_params_rx.maxburst = 6;
> > > > +	index = of_property_match_string(np, "dma-names", "rx");
> > > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
> index,
> > > > +				&dma_args);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	sai->dma_params_rx.slave_id = dma_args.args[1];
> > > > +
> > > > +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> > > > +	sai->dma_params_tx.maxburst = 6;
> > > > +	index = of_property_match_string(np, "dma-names", "tx");
> > > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
> index,
> > > > +				&dma_args);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +	sai->dma_params_tx.slave_id = dma_args.args[1];
> > >
> > > The driver should not have to manually parse the dma devicetree
> > > properties, this is something that should be handled by the dma
> > > engine driver.
> > >
> >
> > What do you think about the DMA slave_id ?
> > I have been noticed by one colleague that this should be parsed here,
> > which is from your opinions ?
> Sure slave_id can be parsed here, but IMO it should be programmed via the
> dma_slave_confog into the respective channel
> 

Actually, these are parsed for cpu_dai->playback_dma_data and cpu_dai->capture_dma_data dynamically, whose type is struct dma_slave_config.

And now I must parse them here, because the platform eDMA driver's newest version will check and use the slave_ids to select and configure the eDMA channels via dma_device->device_control(). 

--
Xiubo
