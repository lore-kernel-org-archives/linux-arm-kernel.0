From: agross@codeaurora.org (Andy Gross)
Date: Mon, 20 Jan 2014 17:31:54 -0600
Subject: [PATCH v2 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1389609060.1871.312.camel@smile>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
 <1389380874-22753-2-git-send-email-agross@codeaurora.org>
 <1389609060.1871.312.camel@smile>
Message-ID: <20140120233154.GC3530@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 10:31:01AM +0000, Shevchenko, Andriy wrote:
> On Fri, 2014-01-10 at 13:07 -0600, Andy Gross wrote:
> > Add the DMA engine driver for the QCOM Bus Access Manager (BAM) DMA controller
> > found in the MSM 8x74 platforms.
> > 
> > Each BAM DMA device is associated with a specific on-chip peripheral.  Each
> > channel provides a uni-directional data transfer engine that is capable of
> > transferring data between the peripheral and system memory (System mode), or
> > between two peripherals (BAM2BAM).
> > 
> > The initial release of this driver only supports slave transfers between
> > peripherals and system memory.
> > 
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> > ---
> >  drivers/dma/Kconfig        |   9 +
> >  drivers/dma/Makefile       |   1 +
> >  drivers/dma/qcom_bam_dma.c | 843 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dma/qcom_bam_dma.h | 268 ++++++++++++++
> >  4 files changed, 1121 insertions(+)
> >  create mode 100644 drivers/dma/qcom_bam_dma.c
> >  create mode 100644 drivers/dma/qcom_bam_dma.h
> > 
[...]
> > + * bam_tx_status - returns status of transaction
> > + * @chan: dma channel
> > + * @cookie: transaction cookie
> > + * @txstate: DMA transaction state
> > + *
> > + * Return status of dma transaction
> > + */
> > +static enum dma_status bam_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> > +		struct dma_tx_state *txstate)
> > +{
> > +	struct bam_chan *bchan = to_bam_chan(chan);
> > +	struct virt_dma_desc *vd;
> > +	int ret;
> > +	size_t residue = 0;
> > +	unsigned int i;
> > +	unsigned long flags;
> > +
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +
> 
> Redundant empty line.
> 

Will remove.

> > +	if (ret == DMA_COMPLETE)
> > +		return ret;
> > +
> > +	if (!txstate)
> > +		return bchan->paused ? DMA_PAUSED : ret;
> > +
> > +	spin_lock_irqsave(&bchan->vc.lock, flags);
> > +	vd = vchan_find_desc(&bchan->vc, cookie);
> > +	if (vd)
> > +		residue = container_of(vd, struct bam_async_desc, vd)->length;
> > +	else if (bchan->curr_txd && bchan->curr_txd->vd.tx.cookie == cookie)
> > +		for (i = 0; i < bchan->curr_txd->num_desc; i++)
> > +			residue += bchan->curr_txd->curr_desc[i].size;
> > +
> > +	dma_set_residue(txstate, residue);
> 
> I'm pretty sure you could do this outside of spin lock.
> 

Yes, I'll move it.

> > +
> > +	spin_unlock_irqrestore(&bchan->vc.lock, flags);
> > +
> > +	if (ret == DMA_IN_PROGRESS && bchan->paused)
> > +		ret = DMA_PAUSED;
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * bam_start_dma - start next transaction
> > + * @bchan - bam dma channel
> > + *
> > + * Note: must hold bam dma channel vc.lock
> > + */
> > +static void bam_start_dma(struct bam_chan *bchan)
> > +{
> > +	struct virt_dma_desc *vd = vchan_next_desc(&bchan->vc);
> > +	struct bam_device *bdev = bchan->bdev;
> > +	struct bam_async_desc *async_desc;
> > +	struct bam_desc_hw *desc;
> > +	struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
> > +				sizeof(struct bam_desc_hw));
> 
> > +
> > +	if (!vd)
> > +		return;
> > +
> > +	list_del(&vd->node);
> > +
> > +	async_desc = container_of(vd, struct bam_async_desc, vd);
> > +	bchan->curr_txd = async_desc;
> > +
> > +	desc = bchan->curr_txd->curr_desc;
> > +
> > +	if (async_desc->num_desc > MAX_DESCRIPTORS)
> > +		async_desc->xfer_len = MAX_DESCRIPTORS;
> > +	else
> > +		async_desc->xfer_len = async_desc->num_desc;
> > +
> > +	/* set INT on last descriptor */
> > +	desc[async_desc->xfer_len - 1].flags |= DESC_FLAG_INT;
> > +
> > +	if (bchan->tail + async_desc->xfer_len > MAX_DESCRIPTORS) {
> > +		u32 partial = MAX_DESCRIPTORS - bchan->tail;
> > +
> > +		memcpy(&fifo[bchan->tail], desc,
> > +				partial * sizeof(struct bam_desc_hw));
> > +		memcpy(fifo, &desc[partial], (async_desc->xfer_len - partial) *
> > +				sizeof(struct bam_desc_hw));
> 
> I'm just curious if you could avoid memcpys at all somehow.
> 

Unfortunately not.  The descriptors have to be copied into the FIFO memory that
is being used by the dma controller for this channel.  Due to the way the FIFO
works, I have to copy into the FIFO during either the issue_pending or when I
start the next transaction.  Either way, it means copying from the txd to the
FIFO.

> > +	} else
> 
> Keep style
> 

OK.

> } else {
> ...
> }
> 
> Have you run checkpatch.pl?
> 

Yes. And I fixed any discrepancies before sending this.

> > +		memcpy(&fifo[bchan->tail], desc,
> > +			async_desc->xfer_len * sizeof(struct bam_desc_hw));
> > +
> > +	bchan->tail += async_desc->xfer_len;
> > +	bchan->tail %= MAX_DESCRIPTORS;
> > +
> > +	/* ensure descriptor writes and dma start not reordered */
> > +	wmb();
> > +	writel_relaxed(bchan->tail * sizeof(struct bam_desc_hw),
> > +			bdev->regs + BAM_P_EVNT_REG(bchan->id));
> > +}
> > +
> > +/**
> > + * dma_tasklet - DMA IRQ tasklet
> > + * @data: tasklet argument (bam controller structure)
> > + *
> > + * Sets up next DMA operation and then processes all completed transactions
> > + */
> > +static void dma_tasklet(unsigned long data)
> > +{
> > +	struct bam_device *bdev = (struct bam_device *)data;
> > +	struct bam_chan *bchan;
> > +	unsigned long flags;
> > +	unsigned int i;
> > +
> > +	/* go through the channels and kick off transactions */
> > +	for (i = 0; i < bdev->num_channels; i++) {
> > +		bchan = &bdev->channels[i];
> > +		spin_lock_irqsave(&bchan->vc.lock, flags);
> > +
> > +		if (!list_empty(&bchan->vc.desc_issued) && !bchan->curr_txd)
> > +			bam_start_dma(bchan);
> > +		spin_unlock_irqrestore(&bchan->vc.lock, flags);
> > +	}
> > +}
> > +
> > +/**
> > + * bam_issue_pending - starts pending transactions
> > + * @chan: dma channel
> > + *
> > + * Calls tasklet directly which in turn starts any pending transactions
> > + */
> > +static void bam_issue_pending(struct dma_chan *chan)
> > +{
> > +	struct bam_chan *bchan = to_bam_chan(chan);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&bchan->vc.lock, flags);
> > +
> > +	/* if work pending and idle, start a transaction */
> > +	if (vchan_issue_pending(&bchan->vc) && !bchan->curr_txd)
> > +		bam_start_dma(bchan);
> > +
> > +	spin_unlock_irqrestore(&bchan->vc.lock, flags);
> > +}
> > +
> > +/**
> > + * bam_dma_free_desc - free descriptor memory
> > + * @vd: virtual descriptor
> > + *
> > + */
> > +static void bam_dma_free_desc(struct virt_dma_desc *vd)
> > +{
> > +	struct bam_async_desc *async_desc = container_of(vd,
> > +			struct bam_async_desc, vd);
> > +
> > +	kfree(async_desc);
> > +}
> > +
> > +struct bam_filter_args {
> > +	struct dma_device *dev;
> > +	u32 id;
> > +	u32 ee;
> > +	u32 dir;
> > +};
> > +
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
> > +
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
> > +
> > +/**
> > + * bam_init
> > + * @bdev: bam device
> > + *
> > + * Initialization helper for global bam registers
> > + */
> > +static void bam_init(struct bam_device *bdev)
> > +{
> > +	u32 val;
> > +
> > +	/* read versioning information */
> > +	val = readl_relaxed(bdev->regs + BAM_REVISION);
> > +	bdev->num_ees = val & NUM_EES_MASK;
> > +
> > +	val = readl_relaxed(bdev->regs + BAM_NUM_PIPES);
> > +	bdev->num_channels = val & BAM_NUM_PIPES_MASK;
> > +
> > +	/* s/w reset bam */
> > +	/* after reset all pipes are disabled and idle */
> > +	val = readl_relaxed(bdev->regs + BAM_CTRL);
> > +	val |= BAM_SW_RST;
> > +	writel_relaxed(val, bdev->regs + BAM_CTRL);
> > +	val &= ~BAM_SW_RST;
> > +	writel_relaxed(val, bdev->regs + BAM_CTRL);
> > +
> > +	/* make sure previous stores are visible before enabling BAM */
> > +	wmb();
> > +
> > +	/* enable bam */
> > +	val |= BAM_EN;
> > +	writel_relaxed(val, bdev->regs + BAM_CTRL);
> > +
> > +	/* set descriptor threshhold, start with 4 bytes */
> > +	writel_relaxed(DEFAULT_CNT_THRSHLD, bdev->regs + BAM_DESC_CNT_TRSHLD);
> > +
> > +	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
> > +	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bdev->regs + BAM_CNFG_BITS);
> > +
> > +	/* enable irqs for errors */
> > +	writel_relaxed(BAM_ERROR_EN | BAM_HRESP_ERR_EN,
> > +				bdev->regs + BAM_IRQ_EN);
> > +}
> > +
> > +static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
> > +	u32 index)
> > +{
> > +	bchan->id = index;
> > +	bchan->bdev = bdev;
> > +
> > +	vchan_init(&bchan->vc, &bdev->common);
> > +	bchan->vc.desc_free = bam_dma_free_desc;
> > +
> > +	bam_reset_channel(bdev, bchan->id);
> > +}
> > +
> > +static int bam_dma_probe(struct platform_device *pdev)
> > +{
> > +	struct bam_device *bdev;
> > +	struct resource *iores, *irq_res;
> > +	int ret, i;
> > +
> > +	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
> > +	if (!bdev)
> > +		return -ENOMEM;
> > +
> > +	bdev->dev = &pdev->dev;
> > +
> > +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!iores) {
> > +		dev_err(bdev->dev, "register resource is missing\n");
> > +		return -EINVAL;
> > +	}
> 
> Useless check and messaging, devm_ioremap_resource will do this for you.
> 

Will fix this along with the other resource comment.

> > +
> > +	bdev->regs = devm_ioremap_resource(&pdev->dev, iores);
> > +	if (IS_ERR(bdev->regs))
> > +		return PTR_ERR(bdev->regs);
> > +
> > +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (!irq_res) {
> > +		dev_err(bdev->dev, "irq resource is missing\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
> > +	if (IS_ERR(bdev->bamclk))
> > +		return PTR_ERR(bdev->bamclk);
> > +
> > +	ret = clk_prepare_enable(bdev->bamclk);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "failed to prepare/enable clock");
> > +		return ret;
> > +	}
> > +
> > +	bam_init(bdev);
> > +
> > +	tasklet_init(&bdev->task, dma_tasklet, (unsigned long)bdev);
> > +
> > +	bdev->channels = devm_kzalloc(bdev->dev,
> 
> devm_kcalloc.
> 

Will fix.

> > +				sizeof(*bdev->channels) * bdev->num_channels,
> > +				GFP_KERNEL);
> > +
> > +	if (!bdev->channels) {
> > +		ret = -ENOMEM;
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	/* allocate and initialize channels */
> > +	INIT_LIST_HEAD(&bdev->common.channels);
> > +
> > +	for (i = 0; i < bdev->num_channels; i++)
> > +		bam_channel_init(bdev, &bdev->channels[i], i);
> > +
> > +	ret = devm_request_irq(bdev->dev, irq_res->start, bam_dma_irq,
> > +			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "cannot register IRQ\n");
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	/* set max dma segment size */
> > +	bdev->common.dev = bdev->dev;
> > +	bdev->common.dev->dma_parms = &bdev->dma_parms;
> > +	ret = dma_set_max_seg_size(bdev->common.dev, BAM_MAX_DATA_SIZE);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "cannot set maximum segment size\n");
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, bdev);
> > +
> > +	/* set capabilities */
> > +	dma_cap_zero(bdev->common.cap_mask);
> > +	dma_cap_set(DMA_SLAVE, bdev->common.cap_mask);
> > +
> > +	/* initialize dmaengine apis */
> > +	bdev->common.device_alloc_chan_resources = bam_alloc_chan;
> > +	bdev->common.device_free_chan_resources = bam_free_chan;
> > +	bdev->common.device_prep_slave_sg = bam_prep_slave_sg;
> > +	bdev->common.device_control = bam_control;
> > +	bdev->common.device_issue_pending = bam_issue_pending;
> > +	bdev->common.device_tx_status = bam_tx_status;
> > +	bdev->common.dev = bdev->dev;
> > +
> > +	ret = dma_async_device_register(&bdev->common);
> > +	if (ret) {
> > +		dev_err(bdev->dev, "failed to register dma async device\n");
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	if (pdev->dev.of_node) {
> > +		ret = of_dma_controller_register(pdev->dev.of_node,
> > +				bam_dma_xlate, &bdev->common);
> > +
> > +		if (ret) {
> > +			dev_err(bdev->dev, "failed to register of_dma\n");
> > +			goto err_unregister_dma;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +err_unregister_dma:
> > +	dma_async_device_unregister(&bdev->common);
> > +err_disable_clk:
> > +	clk_disable_unprepare(bdev->bamclk);
> 
> 
> 
> > +	return ret;
> > +}
> > +
> > +static int bam_dma_remove(struct platform_device *pdev)
> > +{
> > +	struct bam_device *bdev = platform_get_drvdata(pdev);
> > +
> > +	dma_async_device_unregister(&bdev->common);
> > +
> > +	if (pdev->dev.of_node)
> > +		of_dma_controller_free(pdev->dev.of_node);
> > +
> > +	clk_disable_unprepare(bdev->bamclk);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id bam_of_match[] = {
> > +	{ .compatible = "qcom,bam-v1.4.0", },
> > +	{ .compatible = "qcom,bam-v1.4.1", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, bam_of_match);
> > +#endif
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
> > +module_init(bam_dma_init);
> > +module_exit(bam_dma_exit);
> 
> module_platform_driver() ?
> 

Will fix.

> > +
> > +MODULE_AUTHOR("Andy Gross <agross@codeaurora.org>");
> > +MODULE_DESCRIPTION("QCOM BAM DMA engine driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/dma/qcom_bam_dma.h b/drivers/dma/qcom_bam_dma.h
> > new file mode 100644
> > index 0000000..2cb3b5f
> > --- /dev/null
> > +++ b/drivers/dma/qcom_bam_dma.h
> > @@ -0,0 +1,268 @@
> > +/*
> > + * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> 
> 2014 ?
> 

Should probably be 2013-2014 since development has spanned the change in year.

> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
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
> > +
> > +struct bam_desc_hw {
> > +	u32 addr;		/* Buffer physical address */
> > +	u16 size;		/* Buffer size in bytes */
> > +	u16 flags;
> > +} __packed;
> > +
> > +#define DESC_FLAG_INT	BIT(15)
> > +#define DESC_FLAG_EOT	BIT(14)
> > +#define DESC_FLAG_EOB	BIT(13)
> > +
> > +struct bam_async_desc {
> > +	struct virt_dma_desc vd;
> > +
> > +	u32 num_desc;
> > +	u32 xfer_len;
> > +	struct bam_desc_hw *curr_desc;
> > +
> > +	enum bam_channel_dir dir;
> > +	size_t length;
> > +	struct bam_desc_hw desc[0];
> > +};
> > +
> > +#define BAM_CTRL			0x0000
> > +#define BAM_REVISION			0x0004
> > +#define BAM_SW_REVISION			0x0080
> > +#define BAM_NUM_PIPES			0x003C
> > +#define BAM_TIMER			0x0040
> > +#define BAM_TIMER_CTRL			0x0044
> > +#define BAM_DESC_CNT_TRSHLD		0x0008
> > +#define BAM_IRQ_SRCS			0x000C
> > +#define BAM_IRQ_SRCS_MSK		0x0010
> > +#define BAM_IRQ_SRCS_UNMASKED		0x0030
> > +#define BAM_IRQ_STTS			0x0014
> > +#define BAM_IRQ_CLR			0x0018
> > +#define BAM_IRQ_EN			0x001C
> > +#define BAM_CNFG_BITS			0x007C
> > +#define BAM_IRQ_SRCS_EE(pipe)		(0x0800 + ((pipe) * 0x80))
> > +#define BAM_IRQ_SRCS_MSK_EE(pipe)	(0x0804 + ((pipe) * 0x80))
> > +#define BAM_P_CTRL(pipe)		(0x1000 + ((pipe) * 0x1000))
> > +#define BAM_P_RST(pipe)			(0x1004 + ((pipe) * 0x1000))
> > +#define BAM_P_HALT(pipe)		(0x1008 + ((pipe) * 0x1000))
> > +#define BAM_P_IRQ_STTS(pipe)		(0x1010 + ((pipe) * 0x1000))
> > +#define BAM_P_IRQ_CLR(pipe)		(0x1014 + ((pipe) * 0x1000))
> > +#define BAM_P_IRQ_EN(pipe)		(0x1018 + ((pipe) * 0x1000))
> > +#define BAM_P_EVNT_DEST_ADDR(pipe)	(0x182C + ((pipe) * 0x1000))
> > +#define BAM_P_EVNT_REG(pipe)		(0x1818 + ((pipe) * 0x1000))
> > +#define BAM_P_SW_OFSTS(pipe)		(0x1800 + ((pipe) * 0x1000))
> > +#define BAM_P_DATA_FIFO_ADDR(pipe)	(0x1824 + ((pipe) * 0x1000))
> > +#define BAM_P_DESC_FIFO_ADDR(pipe)	(0x181C + ((pipe) * 0x1000))
> > +#define BAM_P_EVNT_TRSHLD(pipe)		(0x1828 + ((pipe) * 0x1000))
> > +#define BAM_P_FIFO_SIZES(pipe)		(0x1820 + ((pipe) * 0x1000))
> > +
> > +/* BAM CTRL */
> > +#define BAM_SW_RST			BIT(0)
> > +#define BAM_EN				BIT(1)
> > +#define BAM_EN_ACCUM			BIT(4)
> > +#define BAM_TESTBUS_SEL_SHIFT		5
> > +#define BAM_TESTBUS_SEL_MASK		0x3F
> > +#define BAM_DESC_CACHE_SEL_SHIFT	13
> > +#define BAM_DESC_CACHE_SEL_MASK		0x3
> > +#define BAM_CACHED_DESC_STORE		BIT(15)
> > +#define IBC_DISABLE			BIT(16)
> > +
> > +/* BAM REVISION */
> > +#define REVISION_SHIFT		0
> > +#define REVISION_MASK		0xFF
> > +#define NUM_EES_SHIFT		8
> > +#define NUM_EES_MASK		0xF
> > +#define CE_BUFFER_SIZE		BIT(13)
> > +#define AXI_ACTIVE		BIT(14)
> > +#define USE_VMIDMT		BIT(15)
> > +#define SECURED			BIT(16)
> > +#define BAM_HAS_NO_BYPASS	BIT(17)
> > +#define HIGH_FREQUENCY_BAM	BIT(18)
> > +#define INACTIV_TMRS_EXST	BIT(19)
> > +#define NUM_INACTIV_TMRS	BIT(20)
> > +#define DESC_CACHE_DEPTH_SHIFT	21
> > +#define DESC_CACHE_DEPTH_1	(0 << DESC_CACHE_DEPTH_SHIFT)
> > +#define DESC_CACHE_DEPTH_2	(1 << DESC_CACHE_DEPTH_SHIFT)
> > +#define DESC_CACHE_DEPTH_3	(2 << DESC_CACHE_DEPTH_SHIFT)
> > +#define DESC_CACHE_DEPTH_4	(3 << DESC_CACHE_DEPTH_SHIFT)
> > +#define CMD_DESC_EN		BIT(23)
> > +#define INACTIV_TMR_BASE_SHIFT	24
> > +#define INACTIV_TMR_BASE_MASK	0xFF
> > +
> > +/* BAM NUM PIPES */
> > +#define BAM_NUM_PIPES_SHIFT		0
> > +#define BAM_NUM_PIPES_MASK		0xFF
> > +#define PERIPH_NON_PIPE_GRP_SHIFT	16
> > +#define PERIPH_NON_PIP_GRP_MASK		0xFF
> > +#define BAM_NON_PIPE_GRP_SHIFT		24
> > +#define BAM_NON_PIPE_GRP_MASK		0xFF
> > +
> > +/* BAM CNFG BITS */
> > +#define BAM_PIPE_CNFG		BIT(2)
> > +#define BAM_FULL_PIPE		BIT(11)
> > +#define BAM_NO_EXT_P_RST	BIT(12)
> > +#define BAM_IBC_DISABLE		BIT(13)
> > +#define BAM_SB_CLK_REQ		BIT(14)
> > +#define BAM_PSM_CSW_REQ		BIT(15)
> > +#define BAM_PSM_P_RES		BIT(16)
> > +#define BAM_AU_P_RES		BIT(17)
> > +#define BAM_SI_P_RES		BIT(18)
> > +#define BAM_WB_P_RES		BIT(19)
> > +#define BAM_WB_BLK_CSW		BIT(20)
> > +#define BAM_WB_CSW_ACK_IDL	BIT(21)
> > +#define BAM_WB_RETR_SVPNT	BIT(22)
> > +#define BAM_WB_DSC_AVL_P_RST	BIT(23)
> > +#define BAM_REG_P_EN		BIT(24)
> > +#define BAM_PSM_P_HD_DATA	BIT(25)
> > +#define BAM_AU_ACCUMED		BIT(26)
> > +#define BAM_CMD_ENABLE		BIT(27)
> > +
> > +#define BAM_CNFG_BITS_DEFAULT	(BAM_PIPE_CNFG |	\
> > +			BAM_NO_EXT_P_RST |		\
> > +			BAM_IBC_DISABLE |		\
> > +			BAM_SB_CLK_REQ |		\
> > +			BAM_PSM_CSW_REQ |		\
> > +			BAM_PSM_P_RES |			\
> > +			BAM_AU_P_RES |			\
> > +			BAM_SI_P_RES |			\
> > +			BAM_WB_P_RES |			\
> > +			BAM_WB_BLK_CSW |		\
> > +			BAM_WB_CSW_ACK_IDL |		\
> > +			BAM_WB_RETR_SVPNT |		\
> > +			BAM_WB_DSC_AVL_P_RST |		\
> > +			BAM_REG_P_EN |			\
> > +			BAM_PSM_P_HD_DATA |		\
> > +			BAM_AU_ACCUMED |		\
> > +			BAM_CMD_ENABLE)
> > +
> > +/* PIPE CTRL */
> > +#define	P_EN			BIT(1)
> > +#define P_DIRECTION		BIT(3)
> > +#define P_SYS_STRM		BIT(4)
> > +#define P_SYS_MODE		BIT(5)
> > +#define P_AUTO_EOB		BIT(6)
> > +#define P_AUTO_EOB_SEL_SHIFT	7
> > +#define P_AUTO_EOB_SEL_512	(0 << P_AUTO_EOB_SEL_SHIFT)
> > +#define P_AUTO_EOB_SEL_256	(1 << P_AUTO_EOB_SEL_SHIFT)
> > +#define P_AUTO_EOB_SEL_128	(2 << P_AUTO_EOB_SEL_SHIFT)
> > +#define P_AUTO_EOB_SEL_64	(3 << P_AUTO_EOB_SEL_SHIFT)
> > +#define P_PREFETCH_LIMIT_SHIFT	9
> > +#define P_PREFETCH_LIMIT_32	(0 << P_PREFETCH_LIMIT_SHIFT)
> > +#define P_PREFETCH_LIMIT_16	(1 << P_PREFETCH_LIMIT_SHIFT)
> > +#define P_PREFETCH_LIMIT_4	(2 << P_PREFETCH_LIMIT_SHIFT)
> > +#define P_WRITE_NWD		BIT(11)
> > +#define P_LOCK_GROUP_SHIFT	16
> > +#define P_LOCK_GROUP_MASK	0x1F
> > +
> > +/* BAM_DESC_CNT_TRSHLD */
> > +#define CNT_TRSHLD		0xffff
> > +#define DEFAULT_CNT_THRSHLD	0x4
> > +
> > +/* BAM_IRQ_SRCS */
> > +#define BAM_IRQ			BIT(31)
> > +#define P_IRQ			0x7fffffff
> > +
> > +/* BAM_IRQ_SRCS_MSK */
> > +#define BAM_IRQ_MSK		BAM_IRQ
> > +#define P_IRQ_MSK		P_IRQ
> > +
> > +/* BAM_IRQ_STTS */
> > +#define BAM_TIMER_IRQ		BIT(4)
> > +#define BAM_EMPTY_IRQ		BIT(3)
> > +#define BAM_ERROR_IRQ		BIT(2)
> > +#define BAM_HRESP_ERR_IRQ	BIT(1)
> > +
> > +/* BAM_IRQ_CLR */
> > +#define BAM_TIMER_CLR		BIT(4)
> > +#define BAM_EMPTY_CLR		BIT(3)
> > +#define BAM_ERROR_CLR		BIT(2)
> > +#define BAM_HRESP_ERR_CLR	BIT(1)
> > +
> > +/* BAM_IRQ_EN */
> > +#define BAM_TIMER_EN		BIT(4)
> > +#define BAM_EMPTY_EN		BIT(3)
> > +#define BAM_ERROR_EN		BIT(2)
> > +#define BAM_HRESP_ERR_EN	BIT(1)
> > +
> > +/* BAM_P_IRQ_EN */
> > +#define P_PRCSD_DESC_EN		BIT(0)
> > +#define P_TIMER_EN		BIT(1)
> > +#define P_WAKE_EN		BIT(2)
> > +#define P_OUT_OF_DESC_EN	BIT(3)
> > +#define P_ERR_EN		BIT(4)
> > +#define P_TRNSFR_END_EN		BIT(5)
> > +#define P_DEFAULT_IRQS_EN	(P_PRCSD_DESC_EN | P_ERR_EN | P_TRNSFR_END_EN)
> > +
> > +/* BAM_P_SW_OFSTS */
> > +#define P_SW_OFSTS_MASK		0xffff
> > +
> > +#define BAM_DESC_FIFO_SIZE	SZ_32K
> > +#define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
> > +#define BAM_MAX_DATA_SIZE	(SZ_32K - 8)
> > +
> > +struct bam_chan {
> > +	struct virt_dma_chan vc;
> > +
> > +	struct bam_device *bdev;
> > +
> > +	/* configuration from device tree */
> > +	u32 id;
> > +	u32 ee;
> > +
> > +	struct bam_async_desc *curr_txd;	/* current running dma */
> > +
> > +	/* runtime configuration */
> > +	struct dma_slave_config slave;
> > +
> > +	/* fifo storage */
> > +	struct bam_desc_hw *fifo_virt;
> > +	dma_addr_t fifo_phys;
> > +
> > +	/* fifo markers */
> > +	unsigned short head;		/* start of active descriptor entries */
> > +	unsigned short tail;		/* end of active descriptor entries */
> > +
> > +	unsigned int paused;		/* is the channel paused? */
> > +
> > +	struct list_head node;
> > +};
> > +
> > +static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> > +{
> > +	return container_of(common, struct bam_chan, vc.chan);
> > +}
> > +
> > +struct bam_device {
> > +	void __iomem *regs;
> > +	struct device *dev;
> > +	struct dma_device common;
> > +	struct device_dma_parameters dma_parms;
> > +	struct bam_chan *channels;
> > +	u32 num_channels;
> > +	u32 num_ees;
> > +	unsigned long enabled_ees;
> > +	int irq;
> > +	struct clk *bamclk;
> > +
> > +	/* dma start transaction tasklet */
> > +	struct tasklet_struct task;
> > +};
> > +
> > +#endif /* __QCOM_BAM_DMA_H__ */
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy
> ---------------------------------------------------------------------
> Intel Finland Oy
> Registered Address: PL 281, 00181 Helsinki 
> Business Identity Code: 0357606 - 4 
> Domiciled in Helsinki 
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
