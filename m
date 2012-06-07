From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 7 Jun 2012 18:39:14 +0800
Subject: [alsa-devel] [PATCH v1 1/5] dmaengine: mmp_tdma: add mmp tdma
 support
In-Reply-To: <1339060961.1927.60.camel@vkoul-udesk3>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-2-git-send-email-zhangfei.gao@marvell.com>
 <1339060961.1927.60.camel@vkoul-udesk3>
Message-ID: <CAMj5BkhLTm1TwR=xDf831jjj9oh32fgiigmxKudZjWLvkmSw1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 5:22 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-06-04 at 14:37 +0800, Zhangfei Gao wrote:
>> Add support for two-channel dma under dmaengine
>> support: mmp-adma and pxa910-squ
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Signed-off-by: Leo Yan <leoy@marvell.com>
>> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
>
>
>> +
>> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
>> +{
>> + ? ? u32 reg = readl(tdmac->reg_base + TDISR);
>> +
>> + ? ? if (reg & TDISR_COMP) {
>> + ? ? ? ? ? ? /* clear irq */
>> + ? ? ? ? ? ? reg &= ~TDISR_COMP;
>> + ? ? ? ? ? ? writel(reg, tdmac->reg_base + TDISR);
>> +
>> + ? ? ? ? ? ? return 1;
> hrmm.?
This is local function used to check whether this channel has irq then return 1.
Used by chan_handler.

>> + ? ? }
>> + ? ? return 0;
>> +}
>> +
>> +static irqreturn_t mmp_tdma_chan_handler(int irq, void *dev_id)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = dev_id;
>> +
>> + ? ? if (mmp_tdma_clear_chan_irq(tdmac)) {
>> + ? ? ? ? ? ? tdmac->pos = (tdmac->pos + tdmac->period_len) % tdmac->buf_len;
>> + ? ? ? ? ? ? tasklet_schedule(&tdmac->tasklet);
>> + ? ? ? ? ? ? return IRQ_HANDLED;
>> + ? ? } else
>> + ? ? ? ? ? ? return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
>> +{
>> + ? ? struct mmp_tdma_device *tdev = dev_id;
>> + ? ? int i, ret;
>> + ? ? int irq_num = 0;
>> +
>> + ? ? for (i = 0; i < TDMA_CHANNEL_NUM; i++) {
>> + ? ? ? ? ? ? struct mmp_tdma_chan *tdmac = tdev->tdmac[i];
>> +
>> + ? ? ? ? ? ? ret = mmp_tdma_chan_handler(irq, tdmac);
>> + ? ? ? ? ? ? if (ret == IRQ_HANDLED)
>> + ? ? ? ? ? ? ? ? ? ? irq_num++;
>> + ? ? }
>> +
>> + ? ? if (irq_num)
>> + ? ? ? ? ? ? return IRQ_HANDLED;
>> + ? ? else
>> + ? ? ? ? ? ? return IRQ_NONE;
>> +}
>> +
>> +static void dma_do_tasklet(unsigned long data)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = (struct mmp_tdma_chan *)data;
>> +
>> + ? ? if (tdmac->desc.callback)
>> + ? ? ? ? ? ? tdmac->desc.callback(tdmac->desc.callback_param);
>> +
>> +}
>> +
>> +static void mmp_tdma_free_descriptor(struct mmp_tdma_chan *tdmac)
>> +{
>> + ? ? struct gen_pool *gpool;
>> + ? ? int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
>> +
>> + ? ? gpool = sram_get_gpool("asram");
>> + ? ? if (tdmac->desc_arr)
>> + ? ? ? ? ? ? gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? size);
>> + ? ? tdmac->desc_arr = NULL;
>> +
>> + ? ? return;
>> +}
>> +
>> +static dma_cookie_t mmp_tdma_tx_submit(struct dma_async_tx_descriptor *tx)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(tx->chan);
>> +
>> + ? ? mmp_tdma_chan_set_desc(tdmac, tdmac->desc_arr_phys);
> This seems odd. In submit you are supposed to move this to your pending
> list. Btw where is the .issue_pending handler?

The driver is specifically for audio.
So we make it simple, only support cylic method and no pending list at all.
Only support sync mode.
tx_submit will directly write dma address with single descriptor chain.
.issue_pending will directly start the dma.
When dma started, it will keep process data from/to user.

>> +
>> + ? ? return 0;
>> +}
>> +
>> +static int mmp_tdma_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
>> + ? ? int ret;
>> +
>> + ? ? dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> +
>> + ? ? dma_async_tx_descriptor_init(&tdmac->desc, chan);
>> + ? ? tdmac->desc.tx_submit = mmp_tdma_tx_submit;
>> +
>> + ? ? if (tdmac->irq) {
>> + ? ? ? ? ? ? ret = devm_request_irq(tdmac->dev, tdmac->irq,
>> + ? ? ? ? ? ? ? ? ? ? mmp_tdma_chan_handler, IRQF_DISABLED, "tdma", tdmac);
>> + ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? goto err_request_irq;
>> + ? ? }
>> +
>> + ? ? return 0;
> NO. This is supposed to return the number of descriptors allocated.
Thanks for remainder.


>> +static void mmp_tdma_free_chan_resources(struct dma_chan *chan)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
>> +
>> + ? ? dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> +
>> + ? ? if (tdmac->irq)
>> + ? ? ? ? ? ? devm_free_irq(tdmac->dev, tdmac->irq, tdmac);
>> + ? ? mmp_tdma_disable_chan(tdmac);
> channel should be already disabled, why do you need this here?

Is there case directly call dma_put_channel without DMA_TERMINATE_ALL?

>> + ? ? mmp_tdma_free_descriptor(tdmac);
>> + ? ? return;
>> +}
>> +
>> +
>> +static struct dma_async_tx_descriptor *mmp_tdma_prep_slave_sg(
>> + ? ? ? ? ? ? struct dma_chan *chan, struct scatterlist *sgl,
>> + ? ? ? ? ? ? unsigned int sg_len, enum dma_transfer_direction direction,
>> + ? ? ? ? ? ? unsigned long flags, void *context)
>> +{
>> + ? ? /*
>> + ? ? ?* This operation is not supported on the TDMA controller
>> + ? ? ?*
>> + ? ? ?* However, we need to provide the function pointer to allow the
>> + ? ? ?* device_control() method to work.
>> + ? ? ?*/
>> + ? ? return NULL;
>> +}
> Pls remove if not supported

Got it, my mistake,
confused by
BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
                !device->device_control);

>> +
>> +static int mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
>> +{
>> + ? ? struct gen_pool *gpool;
>> + ? ? int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);
>> +
>> + ? ? dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> +
>> + ? ? gpool = sram_get_gpool("asram");
>> + ? ? if (!gpool)
>> + ? ? ? ? ? ? return -ENOMEM;
>> +
>> + ? ? tdmac->desc_arr = (void *)gen_pool_alloc(gpool, size);
>> + ? ? if (!tdmac->desc_arr)
>> + ? ? ? ? ? ? return -ENOMEM;
>> +
>> + ? ? tdmac->desc_arr_phys = gen_pool_virt_to_phys(gpool,
>> + ? ? ? ? ? ? ? ? ? ? (unsigned long)tdmac->desc_arr);
>> +
>> + ? ? return 0;
> this needs fix
Could you give more hints?

>> +}
>> +
>> +static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
>> + ? ? ? ? ? ? struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
>> + ? ? ? ? ? ? size_t period_len, enum dma_transfer_direction direction,
>> + ? ? ? ? ? ? void *context)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
>> + ? ? int num_periods = buf_len / period_len;
>> + ? ? int i = 0, buf = 0;
>> + ? ? int ret;
>> +
>> + ? ? if (tdmac->status != DMA_SUCCESS)
>> + ? ? ? ? ? ? return NULL;
>> +
>> + ? ? if (period_len > TDMA_MAX_XFER_BYTES) {
>> + ? ? ? ? ? ? dev_err(tdmac->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "maximum period size exceeded: %d > %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? period_len, TDMA_MAX_XFER_BYTES);
>> + ? ? ? ? ? ? goto err_out;
>> + ? ? }
>> +
>> + ? ? tdmac->status = DMA_IN_PROGRESS;
> ???
>> + ? ? tdmac->desc_num = num_periods;
>> + ? ? ret = mmp_tdma_alloc_descriptor(tdmac);
>> + ? ? if (ret < 0)
>> + ? ? ? ? ? ? goto err_out;
>> +
>> + ? ? while (buf < buf_len) {
>> + ? ? ? ? ? ? struct mmp_tdma_desc *desc = &tdmac->desc_arr[i];
> what if i call prepare twice on the same channel?

We use  tdmac->status to prevent calling again during transfering
except the resource is freed.
Usually once cyclic dma is build, only data comming and out, without
rebuild dma chain.
Here dma chain is simple, does not support asyn mode.

> Better way would to manage a descriptor list, see other drivers for
> examples.
>> +
>> + ? ? ? ? ? ? if (i + 1 == num_periods)
>> + ? ? ? ? ? ? ? ? ? ? desc->nxt_desc = tdmac->desc_arr_phys;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? desc->nxt_desc = tdmac->desc_arr_phys +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(*desc) * (i + 1);
> pls use kernel link list, it is provided to you so that you dont have to
> do above.

We have limitation for hardware.
SRAM has to be used for both dma buffer and dma descriptor.
While SRAM is very very limited on some platform,
as a result link node may not able to be allocated.
So we simply organize descriptor physically one by one.


>> +
>> +static void mmp_tdma_issue_pending(struct dma_chan *chan)
>> +{
>> + ? ? struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
>> +
>> + ? ? mmp_tdma_enable_chan(tdmac);
> can you queue the descriptors here? That was purpose to have separate
> issue pending and submit.

Since the SRAM is limited, I am afraid it can not allocate memory for queue.
And to make it simple, we just arrange descriptor one by one.


>> +
>> +module_platform_driver(mmp_tdma_driver);
>> +
>> +MODULE_DESCRIPTION("MMP Two-Channel DMA Driver");
>> +MODULE_LICENSE("GPL");
> AUTHOR, ALIAS too pls
Thanks, got it.

>
>> diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
>> new file mode 100644
>> index 0000000..4e21cf9
>> --- /dev/null
>> +++ b/include/linux/platform_data/mmp_dma.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * ?MMP Platform DMA Management
>> + *
>> + * ?Copyright (c) 2011 Marvell Semiconductors Inc.
>> + *
>> + * ?This program is free software; you can redistribute it and/or modify
>> + * ?it under the terms of the GNU General Public License version 2 as
>> + * ?published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#ifndef MMP_DMA_H
>> +#define MMP_DMA_H
>> +
>> +struct mmp_tdma_data {
>> + ? ? u32 bus_size;
>> + ? ? u32 pack_mod;
>> +};
>> +
>> +#endif /* MMP_DMA_H */
> why do you need separate header for this?

The structure is sharing private config between dma driver and pcm
driver under sound.
The header file will be expanded for other dma driver.

>
>
> --
> ~Vinod
>
