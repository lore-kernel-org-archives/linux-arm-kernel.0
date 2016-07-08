From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 Jul 2016 11:23:29 +0530
Subject: [PATCH v12 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <1467373026-27768-2-git-send-email-appanad@xilinx.com>
References: <1467373026-27768-1-git-send-email-appanad@xilinx.com>
 <1467373026-27768-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160708055328.GP12591@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 05:07:06PM +0530, Kedareswara rao Appana wrote:
> +static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
> +			   struct platform_device *pdev)
> +{
> +	struct zynqmp_dma_chan *chan;
> +	struct resource *res;
> +	struct device_node *node = pdev->dev.of_node;
> +	int err;
> +
> +	chan = devm_kzalloc(zdev->dev, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +	chan->dev = zdev->dev;
> +	chan->zdev = zdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	chan->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(chan->regs))
> +		return PTR_ERR(chan->regs);
> +
> +	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
> +	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
> +	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
> +	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
> +	if ((err < 0) && ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
> +			  (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128))) {
> +		dev_err(zdev->dev, "invalid bus-width value");
> +		return err;
> +	}
> +
> +	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
> +	zdev->chan = chan;
> +	tasklet_init(&chan->tasklet, zynqmp_dma_do_tasklet, (ulong)chan);

where is this killed?

> +	spin_lock_init(&chan->lock);
> +	INIT_LIST_HEAD(&chan->active_list);
> +	INIT_LIST_HEAD(&chan->pending_list);
> +	INIT_LIST_HEAD(&chan->done_list);
> +	INIT_LIST_HEAD(&chan->free_list);
> +
> +	dma_cookie_init(&chan->common);
> +	chan->common.device = &zdev->common;
> +	list_add_tail(&chan->common.device_node, &zdev->common.channels);
> +
> +	zynqmp_dma_init(chan);
> +	chan->irq = platform_get_irq(pdev, 0);
> +	if (chan->irq < 0)
> +		return -ENXIO;
> +	err = devm_request_irq(&pdev->dev, chan->irq, zynqmp_dma_irq_handler, 0,
> +			       "zynqmp-dma", chan);

this needs to be freed/diabled in remove, dont see that

-- 
~Vinod
