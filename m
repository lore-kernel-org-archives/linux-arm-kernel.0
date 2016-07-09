From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Sat, 9 Jul 2016 08:36:05 +0000
Subject: [PATCH v12 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <20160708055328.GP12591@localhost>
References: <1467373026-27768-1-git-send-email-appanad@xilinx.com>
 <1467373026-27768-2-git-send-email-appanad@xilinx.com>
 <20160708055328.GP12591@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5BC756@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review...

> > +
> > +	chan->is_dmacoherent =  of_property_read_bool(node, "dma-
> coherent");
> > +	zdev->chan = chan;
> > +	tasklet_init(&chan->tasklet, zynqmp_dma_do_tasklet, (ulong)chan);
> 
> where is this killed?

This is killed in the zynqmp_dma_chan_remove() API.

> 
> > +	spin_lock_init(&chan->lock);
> > +	INIT_LIST_HEAD(&chan->active_list);
> > +	INIT_LIST_HEAD(&chan->pending_list);
> > +	INIT_LIST_HEAD(&chan->done_list);
> > +	INIT_LIST_HEAD(&chan->free_list);
> > +	zynqmp_dma_init(chan);
> > +	chan->irq = platform_get_irq(pdev, 0);
> > +	if (chan->irq < 0)
> > +		return -ENXIO;
> > +	err = devm_request_irq(&pdev->dev, chan->irq,
> zynqmp_dma_irq_handler, 0,
> > +			       "zynqmp-dma", chan);
> 
> this needs to be freed/diabled in remove, dont see that

It is freed in the zynqmp_dma_chan_remove() API.

Regards,
Kedar.
