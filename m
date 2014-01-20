From: agross@codeaurora.org (Andy Gross)
Date: Mon, 20 Jan 2014 16:52:45 -0600
Subject: [PATCH v2 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <201401172349.28229.arnd@arndb.de>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
 <1389380874-22753-2-git-send-email-agross@codeaurora.org>
 <201401172349.28229.arnd@arndb.de>
Message-ID: <20140120225245.GA3530@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 11:49:27PM +0100, Arnd Bergmann wrote:
> On Friday 10 January 2014, Andy Gross wrote:
> 
> > +static bool bam_dma_filter(struct dma_chan *chan, void *data)
> > +{
> > +	struct bam_filter_args *args = data;
> > +	struct bam_chan *bchan = to_bam_chan(chan);
> > +
> > +	if (args->dev == chan->device &&
> > +		args->id == bchan->id) {
> > +
> > +		/* we found the channel, so lets set the EE and dir */
> > +		bchan->ee = args->ee;
> > +		bchan->slave.direction = args->dir ?
> > +				DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> A filter function should no longer be needed.
> 

Ok, will remove.

> > +static struct dma_chan *bam_dma_xlate(struct of_phandle_args *dma_spec,
> > +		struct of_dma *of)
> > +{
> > +	struct bam_filter_args args;
> > +	dma_cap_mask_t cap;
> > +
> > +	if (dma_spec->args_count != 3)
> > +		return NULL;
> > +
> > +	args.dev = of->of_dma_data;
> > +	args.id = dma_spec->args[0];
> > +	args.ee = dma_spec->args[1];
> > +	args.dir = dma_spec->args[2];
> > +
> > +	dma_cap_zero(cap);
> > +	dma_cap_set(DMA_SLAVE, cap);
> > +
> > +	return dma_request_channel(cap, bam_dma_filter, &args);
> > +}
> 
> Instead, call dma_get_slave_channel() with the right channel that you already know
> here.
> 

Agreed.

> > +	if (pdev->dev.of_node) {
> > +		ret = of_dma_controller_register(pdev->dev.of_node,
> > +				bam_dma_xlate, &bdev->common);
> > +
> > +		if (ret) {
> > +			dev_err(bdev->dev, "failed to register of_dma\n");
> > +			goto err_unregister_dma;
> > +		}
> > +	}
> 
> No need to check for pdev->dev.of_node when that is the only mode of probing.
> 

Good point. I'll remove extraneous check.

> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id bam_of_match[] = {
> > +	{ .compatible = "qcom,bam-v1.4.0", },
> > +	{ .compatible = "qcom,bam-v1.4.1", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, bam_of_match);
> > +#endif
> 
> Also, you can remove the #ifdef here and the of_match_ptr() below.
> 

If this is removed, then I'll have to add the OF dependency in the Kconfig,
correct?

> > +
> > +static struct platform_driver bam_dma_driver = {
> > +	.probe = bam_dma_probe,
> > +	.remove = bam_dma_remove,
> > +	.driver = {
> > +		.name = "bam-dma-engine",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = of_match_ptr(bam_of_match),
> > +	},
> > +};
> > +
> > +static int __init bam_dma_init(void)
> > +{
> > +	return platform_driver_register(&bam_dma_driver);
> > +}
> > +
> > +static void __exit bam_dma_exit(void)
> > +{
> > +	return platform_driver_unregister(&bam_dma_driver);
> > +}
> > +
> 
> module_platform_driver()
> 

Will fix.

> > diff --git a/drivers/dma/qcom_bam_dma.h b/drivers/dma/qcom_bam_dma.h
> > new file mode 100644
> > index 0000000..2cb3b5f
> > --- /dev/null
> > +++ b/drivers/dma/qcom_bam_dma.h
> > @@ -0,0 +1,268 @@
> > +#ifndef __QCOM_BAM_DMA_H__
> > +#define __QCOM_BAM_DMA_H__
> > +
> > +#include <linux/dmaengine.h>
> > +#include "virt-dma.h"
> > +
> > +enum bam_channel_dir {
> > +	BAM_PIPE_CONSUMER = 0,	/* channel reads from data-fifo or memory */
> > +	BAM_PIPE_PRODUCER,	/* channel writes to data-fifo or memory */
> > +};
> 
> Since the header does not serve as an interface, just move all the contents
> into the driver directly.
> 

OK.  SBoyd made the same comment.  I'll go ahead and collapse both down to 1
file.

> > +struct bam_desc_hw {
> > +	u32 addr;		/* Buffer physical address */
> > +	u16 size;		/* Buffer size in bytes */
> > +	u16 flags;
> > +} __packed;
> 
> Remove __packed here, it only makes the access less efficient but does not change
> the layout, which is already packed.

Ok.  Will fix.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
