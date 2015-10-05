From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 5 Oct 2015 15:37:14 +0100
Subject: [PATCH 1/2] dma: Add Freescale qDMA engine driver support
In-Reply-To: <1441950833-27684-1-git-send-email-yao.yuan@freescale.com>
References: <1441950833-27684-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20151005143713.GC13501@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 01:53:52PM +0800, Yuan Yao wrote:

> +Examples:
> +
> +	qdma: qdma at 8390000 {
> +		compatible = "fsl,ls-qdma";
> +		reg = <0x0 0x8380000 0x0 0x20000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "qdma-tx", "qdma-err";
> +		big-endian;
> +		channels = <1>;
> +	};

Binding should be a separate patch

> +FREESCALE qDMA DRIVER
> +M:     Yuan Yao <yao.yuan@freescale.com>
> +L:     linux-arm-kernel at lists.infradead.org

not dmaengine ML ?


> +config FSL_QDMA
> +	tristate "Freescale qDMA engine support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS

No depends on arch, can it work on x86?

> +static int fsl_qdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct fsl_qdma_chan *fsl_chan = to_fsl_qdma_chan(chan);
> +
> +	fsl_chan->desc = NULL;
> +	return 0;
> +}

why do you need this it seems to do nothing

> +static struct fsl_qdma_desc *fsl_qdma_alloc_desc(struct fsl_qdma_chan *fsl_chan)
> +{
> +	struct fsl_qdma_desc *fsl_desc;
> +
> +	fsl_desc = kzalloc(sizeof(*fsl_desc), GFP_NOWAIT);
> +

empty line here is not required

> +	if (!fsl_desc)
> +		return NULL;
> +
> +	fsl_desc->qchan = fsl_chan;
> +
> +	return fsl_desc;

why not return fsl_desc->qchan ;


> +	dma_cap_set(DMA_PRIVATE, fsl_qdma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_SLAVE, fsl_qdma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, fsl_qdma->dma_dev.cap_mask);
> +
> +	fsl_qdma->dma_dev.dev = &pdev->dev;
> +	fsl_qdma->dma_dev.device_alloc_chan_resources
> +		= fsl_qdma_alloc_chan_resources;
> +	fsl_qdma->dma_dev.device_free_chan_resources
> +		= fsl_qdma_free_chan_resources;
> +	fsl_qdma->dma_dev.device_tx_status = fsl_qdma_tx_status;
> +	fsl_qdma->dma_dev.device_prep_dma_memcpy = fsl_qdma_prep_memcpy;
> +	fsl_qdma->dma_dev.device_issue_pending = fsl_qdma_issue_pending;

You claim DMA_SLAVE but no prep_ for that?

> +
> +static int __init fsl_qdma_init(void)
> +{
> +	return platform_driver_register(&fsl_qdma_driver);
> +}
> +subsys_initcall(fsl_qdma_init);
why subsys_init?

-- 
~Vinod
