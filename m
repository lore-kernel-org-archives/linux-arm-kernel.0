From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 07 Jun 2012 14:52:41 +0530
Subject: [PATCH v1 1/5] dmaengine: mmp_tdma: add mmp tdma support
In-Reply-To: <1338791851-21038-2-git-send-email-zhangfei.gao@marvell.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1339060961.1927.60.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
> Add support for two-channel dma under dmaengine
> support: mmp-adma and pxa910-squ
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Leo Yan <leoy@marvell.com>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>


> +
> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
> +{
> +	u32 reg = readl(tdmac->reg_base + TDISR);
> +
> +	if (reg & TDISR_COMP) {
> +		/* clear irq */
> +		reg &= ~TDISR_COMP;
> +		writel(reg, tdmac->reg_base + TDISR);
> +
> +		return 1;
hrmm.?
> +	}
> +	return 0;
> +}
> +
> +static irqreturn_t mmp_tdma_chan_handler(int irq, void *dev_id)
> +{
> +	struct mmp_tdma_chan *tdmac = dev_id;
> +
> +	if (mmp_tdma_clear_chan_irq(tdmac)) {
> +		tdmac->pos = (tdmac->pos + tdmac->period_len) % tdmac->buf_len;
> +		tasklet_schedule(&tdmac->tasklet);
> +		return IRQ_HANDLED;
> +	} else
> +		return IRQ_NONE;
> +}
> +
> +static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
> +{
> +	struct mmp_tdma_device *tdev = dev_id;
> +	int i, ret;
> +	int irq_num = 0;
> +
> +	for (i = 0; i < TDMA_CHANNEL_NUM; i++) {
> +		struct mmp_tdma_chan *tdmac = tdev->tdmac[i];
> +
> +		ret = mmp_tdma_chan_handler(irq, tdmac);
> +		if (ret == IRQ_HANDLED)
> +			irq_num++;
> +	}
> +
> +	if (irq_num)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +
> +static void dma_do_tasklet(unsigned long data)
> +{
> +	struct mmp_tdma_chan *tdmac = (struct mmp_tdma_chan *)data;
> +
> +	if (tdmac->desc.callback)
> +		tdmac->desc.callback(tdmac->desc.callback_param);
> +
> +}
> +
> +static void mmp_tdma_free_descriptor(struct mmp_tdma_chan *tdmac)
> +{
> +	struct gen_pool *gpool;
> +	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
> +
> +	gpool = sram_get_gpool("asram");
> +	if (tdmac->desc_arr)
> +		gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
> +				size);
> +	tdmac->desc_arr = NULL;
> +
> +	return;
> +}
> +
> +static dma_cookie_t mmp_tdma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(tx->chan);
> +
> +	mmp_tdma_chan_set_desc(tdmac, tdmac->desc_arr_phys);
This seems odd. In submit you are supposed to move this to your pending
list. Btw where is the .issue_pending handler?
> +
> +	return 0;
> +}
> +
> +static int mmp_tdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +	int ret;
> +
> +	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
> +
> +	dma_async_tx_descriptor_init(&tdmac->desc, chan);
> +	tdmac->desc.tx_submit = mmp_tdma_tx_submit;
> +
> +	if (tdmac->irq) {
> +		ret = devm_request_irq(tdmac->dev, tdmac->irq,
> +			mmp_tdma_chan_handler, IRQF_DISABLED, "tdma", tdmac);
> +		if (ret)
> +			goto err_request_irq;
> +	}
> +
> +	return 0;
NO. This is supposed to return the number of descriptors allocated.
> +
> +err_request_irq:
> +	mmp_tdma_free_descriptor(tdmac);
> +	return ret;
> +}
> +
> +static void mmp_tdma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +
> +	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
> +
> +	if (tdmac->irq)
> +		devm_free_irq(tdmac->dev, tdmac->irq, tdmac);
> +	mmp_tdma_disable_chan(tdmac);
channel should be already disabled, why do you need this here?
> +	mmp_tdma_free_descriptor(tdmac);
> +	return;
> +}
> +
> +
> +static struct dma_async_tx_descriptor *mmp_tdma_prep_slave_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	/*
> +	 * This operation is not supported on the TDMA controller
> +	 *
> +	 * However, we need to provide the function pointer to allow the
> +	 * device_control() method to work.
> +	 */
> +	return NULL;
> +}
Pls remove if not supported
> +
> +static int mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
> +{
> +	struct gen_pool *gpool;
> +	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
> +
> +	dev_dbg(tdmac->dev, "%s: enter\n", __func__);
> +
> +	gpool = sram_get_gpool("asram");
> +	if (!gpool)
> +		return -ENOMEM;
> +
> +	tdmac->desc_arr = (void *)gen_pool_alloc(gpool, size);
> +	if (!tdmac->desc_arr)
> +		return -ENOMEM;
> +
> +	tdmac->desc_arr_phys = gen_pool_virt_to_phys(gpool,
> +			(unsigned long)tdmac->desc_arr);
> +
> +	return 0;
this needs fix
> +}
> +
> +static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
> +		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
> +		size_t period_len, enum dma_transfer_direction direction,
> +		void *context)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +	int num_periods = buf_len / period_len;
> +	int i = 0, buf = 0;
> +	int ret;
> +
> +	if (tdmac->status != DMA_SUCCESS)
> +		return NULL;
> +
> +	if (period_len > TDMA_MAX_XFER_BYTES) {
> +		dev_err(tdmac->dev,
> +				"maximum period size exceeded: %d > %d\n",
> +				period_len, TDMA_MAX_XFER_BYTES);
> +		goto err_out;
> +	}
> +
> +	tdmac->status = DMA_IN_PROGRESS;
???
> +	tdmac->desc_num = num_periods;
> +	ret = mmp_tdma_alloc_descriptor(tdmac);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	while (buf < buf_len) {
> +		struct mmp_tdma_desc *desc = &tdmac->desc_arr[i];
what if i call prepare twice on the same channel?
Better way would to manage a descriptor list, see other drivers for
examples.
> +
> +		if (i + 1 == num_periods)
> +			desc->nxt_desc = tdmac->desc_arr_phys;
> +		else
> +			desc->nxt_desc = tdmac->desc_arr_phys +
> +				sizeof(*desc) * (i + 1);
pls use kernel link list, it is provided to you so that you dont have to
do above.
> +
> +		if (direction == DMA_MEM_TO_DEV) {
> +			desc->src_addr = dma_addr;
> +			desc->dst_addr = tdmac->dev_addr;
> +		} else {
> +			desc->src_addr = tdmac->dev_addr;
> +			desc->dst_addr = dma_addr;
> +		}
> +		desc->byte_cnt = period_len;
> +		dma_addr += period_len;
> +		buf += period_len;
> +		i++;
> +	}
> +
> +	tdmac->buf_len = buf_len;
> +	tdmac->period_len = period_len;
> +	tdmac->pos = 0;
> +
> +	return &tdmac->desc;
> +
> +err_out:
> +	tdmac->status = DMA_ERROR;
> +	return NULL;
> +}
> +
> +static int mmp_tdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +		unsigned long arg)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +	struct dma_slave_config *dmaengine_cfg = (void *)arg;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		mmp_tdma_disable_chan(tdmac);
> +		break;
> +	case DMA_PAUSE:
> +		mmp_tdma_pause_chan(tdmac);
> +		break;
> +	case DMA_RESUME:
> +		mmp_tdma_resume_chan(tdmac);
> +		break;
> +	case DMA_SLAVE_CONFIG:
> +		if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
> +			tdmac->dev_addr = dmaengine_cfg->src_addr;
> +			tdmac->burst_sz = dmaengine_cfg->src_maxburst;
> +		} else {
> +			tdmac->dev_addr = dmaengine_cfg->dst_addr;
> +			tdmac->burst_sz = dmaengine_cfg->dst_maxburst;
> +		}
> +		tdmac->dir = dmaengine_cfg->direction;
> +		return mmp_tdma_config_chan(tdmac);
> +	default:
> +		ret = -ENOSYS;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum dma_status mmp_tdma_tx_status(struct dma_chan *chan,
> +			dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +
> +	dma_set_residue(txstate, tdmac->buf_len - tdmac->pos);
> +
> +	return tdmac->status;
> +}
> +
> +static void mmp_tdma_issue_pending(struct dma_chan *chan)
> +{
> +	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
> +
> +	mmp_tdma_enable_chan(tdmac);
can you queue the descriptors here? That was purpose to have separate
issue pending and submit.
> +}
> +
> +static int __devexit mmp_tdma_remove(struct platform_device *pdev)
> +{
> +	struct mmp_tdma_device *tdev = platform_get_drvdata(pdev);
> +
> +	dma_async_device_unregister(&tdev->device);
> +	return 0;
> +}
> +
> +static int __devinit mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
> +						int idx, int irq, int type)
> +{
> +	struct mmp_tdma_chan *tdmac;
> +
> +	if (idx >= TDMA_CHANNEL_NUM) {
> +		dev_err(tdev->dev, "too many channels for device!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* alloc channel */
> +	tdmac = devm_kzalloc(tdev->dev, sizeof(*tdmac), GFP_KERNEL);
> +	if (!tdmac) {
> +		dev_err(tdev->dev, "no free memory for DMA channels!\n");
> +		return -ENOMEM;
> +	}
> +	if (irq)
> +		tdmac->irq = irq + idx;
> +	tdmac->dev	   = tdev->dev;
> +	tdmac->chan.device = &tdev->device;
> +	tdmac->idx	   = idx;
> +	tdmac->type	   = type;
> +	tdmac->reg_base	   = (unsigned long)tdev->base + idx * 4;
> +	tdmac->status = DMA_SUCCESS;
> +	tdev->tdmac[tdmac->idx] = tdmac;
> +	tasklet_init(&tdmac->tasklet, dma_do_tasklet, (unsigned long)tdmac);
> +
> +	/* add the channel to tdma_chan list */
> +	list_add_tail(&tdmac->chan.device_node,
> +			&tdev->device.channels);
> +
> +	return 0;
> +}
> +
> +static int __devinit mmp_tdma_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	enum mmp_tdma_type type = id->driver_data;
> +	struct mmp_tdma_device *tdev;
> +	struct resource *iores;
> +	int i, ret;
> +	int irq = 0;
> +	int chan_num = TDMA_CHANNEL_NUM;
> +
> +	/* always have couple channels */
> +	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
> +	if (!tdev)
> +		return -ENOMEM;
> +
> +	tdev->dev = &pdev->dev;
> +	iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!iores)
> +		return -EINVAL;
> +
> +	if (resource_size(iores) != chan_num)
> +		tdev->irq = iores->start;
> +	else
> +		irq = iores->start;
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!iores)
> +		return -EINVAL;
> +
> +	tdev->base = devm_request_and_ioremap(&pdev->dev, iores);
> +	if (!tdev->base)
> +		return -EADDRNOTAVAIL;
> +
> +	if (tdev->irq) {
> +		ret = devm_request_irq(&pdev->dev, tdev->irq,
> +			mmp_tdma_int_handler, IRQF_DISABLED, "tdma", tdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
> +
> +	INIT_LIST_HEAD(&tdev->device.channels);
> +
> +	/* initialize channel parameters */
> +	for (i = 0; i < chan_num; i++) {
> +		ret = mmp_tdma_chan_init(tdev, i, irq, type);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	tdev->device.dev = &pdev->dev;
> +	tdev->device.device_alloc_chan_resources =
> +					mmp_tdma_alloc_chan_resources;
> +	tdev->device.device_free_chan_resources =
> +					mmp_tdma_free_chan_resources;
> +	tdev->device.device_prep_slave_sg = mmp_tdma_prep_slave_sg;
> +	tdev->device.device_prep_dma_cyclic = mmp_tdma_prep_dma_cyclic;
> +	tdev->device.device_tx_status = mmp_tdma_tx_status;
> +	tdev->device.device_issue_pending = mmp_tdma_issue_pending;
> +	tdev->device.device_control = mmp_tdma_control;
> +	tdev->device.copy_align = TDMA_ALIGNMENT;
> +
> +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	platform_set_drvdata(pdev, tdev);
> +
> +	ret = dma_async_device_register(&tdev->device);
> +	if (ret) {
> +		dev_err(tdev->device.dev, "unable to register\n");
> +		return ret;
> +	}
> +
> +	dev_info(tdev->device.dev, "initialized\n");
> +	return 0;
> +}
> +
> +static const struct platform_device_id mmp_tdma_id_table[] = {
> +	{ "mmp-adma",	MMP_AUD_TDMA },
> +	{ "pxa910-squ",	PXA910_SQU },
> +	{ },
> +};
> +
> +static struct platform_driver mmp_tdma_driver = {
> +	.driver		= {
> +		.name	= "mmp-tdma",
> +		.owner  = THIS_MODULE,
> +	},
> +	.id_table	= mmp_tdma_id_table,
> +	.probe		= mmp_tdma_probe,
> +	.remove		= __devexit_p(mmp_tdma_remove),
> +};
> +
> +module_platform_driver(mmp_tdma_driver);
> +
> +MODULE_DESCRIPTION("MMP Two-Channel DMA Driver");
> +MODULE_LICENSE("GPL");
AUTHOR, ALIAS too pls

> diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
> new file mode 100644
> index 0000000..4e21cf9
> --- /dev/null
> +++ b/include/linux/platform_data/mmp_dma.h
> @@ -0,0 +1,20 @@
> +/*
> + *  MMP Platform DMA Management
> + *
> + *  Copyright (c) 2011 Marvell Semiconductors Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef MMP_DMA_H
> +#define MMP_DMA_H
> +
> +struct mmp_tdma_data {
> +	u32 bus_size;
> +	u32 pack_mod;
> +};
> +
> +#endif /* MMP_DMA_H */
why do you need separate header for this?


-- 
~Vinod
