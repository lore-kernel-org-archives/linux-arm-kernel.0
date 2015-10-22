From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 22 Oct 2015 07:56:47 +0000
Subject: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
In-Reply-To: <20151005143713.GC13501@vkoul-mobl.iind.intel.com>
References: <1441950833-27684-1-git-send-email-yao.yuan@freescale.com>
 <20151005143713.GC13501@vkoul-mobl.iind.intel.com>
Message-ID: <BLUPR03MB1341F135C124C7A5F86037183270@BLUPR03MB134.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for your review, please see my comments inline.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, October 05, 2015 10:37 PM
> To: Yuan Yao-B46683 <yao.yuan@freescale.com>
> Cc: shawn.guo at linaro.org; dan.j.williams at intel.com;
> dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
> 
> On Fri, Sep 11, 2015 at 01:53:52PM +0800, Yuan Yao wrote:
> 
> > +Examples:
> > +
> > +	qdma: qdma at 8390000 {
> > +		compatible = "fsl,ls-qdma";
> > +		reg = <0x0 0x8380000 0x0 0x20000>;
> > +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-names = "qdma-tx", "qdma-err";
> > +		big-endian;
> > +		channels = <1>;
> > +	};
> 
> Binding should be a separate patch
[Yuan Yao] 
Ok, Thanks.

> 
> > +FREESCALE qDMA DRIVER
> > +M:     Yuan Yao <yao.yuan@freescale.com>
> > +L:     linux-arm-kernel at lists.infradead.org
> 
> not dmaengine ML ?
[Yuan Yao] Ok, Thanks.

> 
> 
> > +config FSL_QDMA
> > +	tristate "Freescale qDMA engine support"
> > +	select DMA_ENGINE
> > +	select DMA_VIRTUAL_CHANNELS
> 
> No depends on arch, can it work on x86?
[Yuan Yao] Ok, Thanks.

> 
> > +static int fsl_qdma_alloc_chan_resources(struct dma_chan *chan) {
> > +	struct fsl_qdma_chan *fsl_chan = to_fsl_qdma_chan(chan);
> > +
> > +	fsl_chan->desc = NULL;
> > +	return 0;
> > +}
> 
> why do you need this it seems to do nothing
[Yuan Yao] I will remove it.

> 
> > +static struct fsl_qdma_desc *fsl_qdma_alloc_desc(struct fsl_qdma_chan
> > +*fsl_chan) {
> > +	struct fsl_qdma_desc *fsl_desc;
> > +
> > +	fsl_desc = kzalloc(sizeof(*fsl_desc), GFP_NOWAIT);
> > +
> 
> empty line here is not required
> 
> > +	if (!fsl_desc)
> > +		return NULL;
> > +
> > +	fsl_desc->qchan = fsl_chan;
> > +
> > +	return fsl_desc;
> 
> why not return fsl_desc->qchan ;
> 
[Yuan Yao] 
I still need some data in fsl_desc. So I have to return fsl_desc  here.

> 
> > +	dma_cap_set(DMA_PRIVATE, fsl_qdma->dma_dev.cap_mask);
> > +	dma_cap_set(DMA_SLAVE, fsl_qdma->dma_dev.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, fsl_qdma->dma_dev.cap_mask);
> > +
> > +	fsl_qdma->dma_dev.dev = &pdev->dev;
> > +	fsl_qdma->dma_dev.device_alloc_chan_resources
> > +		= fsl_qdma_alloc_chan_resources;
> > +	fsl_qdma->dma_dev.device_free_chan_resources
> > +		= fsl_qdma_free_chan_resources;
> > +	fsl_qdma->dma_dev.device_tx_status = fsl_qdma_tx_status;
> > +	fsl_qdma->dma_dev.device_prep_dma_memcpy =
> fsl_qdma_prep_memcpy;
> > +	fsl_qdma->dma_dev.device_issue_pending =
> fsl_qdma_issue_pending;
> 
> You claim DMA_SLAVE but no prep_ for that?
> 
[Yuan Yao] It's a mistake. I will remove it.\

> > +
> > +static int __init fsl_qdma_init(void) {
> > +	return platform_driver_register(&fsl_qdma_driver);
> > +}
> > +subsys_initcall(fsl_qdma_init);
> why subsys_init?
> 
[Yuan Yao] For a preventive, some driver base on DMA, QDMA have to initialize earlier than them.
Even now there is no kernel driver base on QDMA, But I still think the subsys_init is better.

> --
> ~Vinod
