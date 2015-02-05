From: rsahu@apm.com (Rameshwar Sahu)
Date: Thu, 5 Feb 2015 17:29:06 +0530
Subject: [PATCH v5 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <20150205015031.GK4489@intel.com>
References: <1422968107-23125-1-git-send-email-rsahu@apm.com>
 <1422968107-23125-2-git-send-email-rsahu@apm.com>
 <20150205015031.GK4489@intel.com>
Message-ID: <CAFd313yBS3KOdtKbnaeTKehmC_f5ZaB-nx299QoLeMm279=Jsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for reviewing this patch.

Please see inline......


Thanks,
with regards,
Ram


On Thu, Feb 5, 2015 at 7:20 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Feb 03, 2015 at 06:25:05PM +0530, Rameshwar Prasad Sahu wrote:
>> +/* Applied Micro X-Gene SoC DMA engine Driver
>> + *
>> + * Copyright (c) 2014, Applied Micro Circuits Corporation
> not 2015?
>> + * Authors: Rameshwar Prasad Sahu <rsahu@apm.com>
>> + *       Loc Ho <lho@apm.com>
>> + *
>
>> +/* DMA ring csr registers and bit definations */
>> +#define RING_CONFIG          0x04
>> +#define RING_ENABLE          BIT(31)
>> +#define RING_ID                      0x08
>> +#define RING_ID_SETUP(v)     ((v) | BIT(31))
>> +#define RING_ID_BUF          0x0C
>> +#define RING_ID_BUF_SETUP(v) (((v) << 9) | BIT(21))
>> +#define RING_THRESLD0_SET1   0x30
>> +#define RING_THRESLD0_SET1_VAL       0X64
>> +#define RING_THRESLD1_SET1   0x34
>> +#define RING_THRESLD1_SET1_VAL       0xC8
>> +#define RING_HYSTERESIS              0x68
>> +#define RING_HYSTERESIS_VAL  0xFFFFFFFF
>> +#define RING_STATE           0x6C
>> +#define RING_STATE_WR_BASE   0x70
>> +#define RING_NE_INT_MODE     0x017C
>> +#define RING_NE_INT_MODE_SET(m, v)   \
>> +     ((m) = ((m) & ~BIT(31 - (v))) | BIT(31 - (v)))
>> +#define RING_NE_INT_MODE_RESET(m, v) \
>> +     ((m) &= (~BIT(31 - (v))))
>> +#define RING_CLKEN           0xC208
>> +#define RING_SRST            0xC200
>> +#define RING_MEM_RAM_SHUTDOWN        0xD070
>> +#define RING_BLK_MEM_RDY     0xD074
>> +#define RING_BLK_MEM_RDY_VAL 0xFFFFFFFF
>> +#define RING_ID_GET(owner, num)      (((owner) << 6) | (num))
>> +#define RING_DST_RING_ID(v)  ((1 << 10) | (v))
>> +#define RING_CMD_OFFSET(v)   (((v) << 6) + 0x2C)
>> +#define RING_COHERENT_SET(m) (((u32 *)(m))[2] |= BIT(4))
>> +#define RING_ADDRL_SET(m, v) (((u32 *)(m))[2] |= (((v) >> 8) << 5))
>> +#define RING_ADDRH_SET(m, v) (((u32 *)(m))[3] |= ((v) >> 35))
>> +#define RING_ACCEPTLERR_SET(m)       (((u32 *)(m))[3] |= BIT(19))
>> +#define RING_SIZE_SET(m, v)  (((u32 *)(m))[3] |= ((v) << 23))
>> +#define RING_RECOMBBUF_SET(m)        (((u32 *)(m))[3] |= BIT(27))
>> +#define RING_RECOMTIMEOUTL_SET(m)    \
>> +     (((u32 *)(m))[3] |= (0x7 << 28))
>> +#define RING_RECOMTIMEOUTH_SET(m)    \
>> +     (((u32 *)(m))[4] |= 0x3)
>> +#define RING_SELTHRSH_SET(m) (((u32 *)(m))[4] |= BIT(3))
>> +#define RING_TYPE_SET(m, v)  (((u32 *)(m))[4] |= ((v) << 19))a
> these defines and the ones which follow need to be namespace aptly
>

Okay..

>> +static void xgene_dma_cpu_to_le64(u64 *desc, int count)
> why is this endian specific?

Our cpu supports both little endian and big endian,
Our DMA hw engine is little endian, so DMA engine descriptor needs to
be in little endian format .
>
>> +
>> +static irqreturn_t xgene_dma_ring_isr(int irq, void *id)
>> +{
>> +     struct xgene_dma_chan *chan = (struct xgene_dma_chan *)id;
>> +
>> +     BUG_ON(!chan);
>> +
>> +     /* Disable DMA channel IRQ */
>> +     disable_irq_nosync(chan->rx_irq);
>> +
>> +     /* Schedule tasklet */
>> +     tasklet_schedule(&chan->rx_tasklet);
>> +
> Ideally you should submit next txn here, but...

Already we have pushed prepared descriptor to engine, so here this is
just rx path to get completion interrupt.

>
>> +
>> +static int xgene_dma_alloc_chan_resources(struct dma_chan *channel)
>> +{
>> +     struct xgene_dma_chan *chan = to_xgene_dma_chan(channel);
>> +     int i;
>> +
>> +     /* Check if we have already allcated resources */
>> +     if (chan->slots)
>> +             return DMA_SLOT_PER_CHANNEL;
>> +
>> +     spin_lock_bh(&chan->lock);
>> +
>> +     chan->slots = devm_kzalloc(chan->pdma->dev,
>> +                                sizeof(struct xgene_dma_slot) *
>> +                                DMA_SLOT_PER_CHANNEL, GFP_ATOMIC);
> GFP_NOWAIT pls
Okay GFP_KERNEL should also be ok ?
>
>> +
>> +static enum dma_status xgene_dma_tx_status(struct dma_chan *channel,
>> +                                        dma_cookie_t cookie,
>> +                                        struct dma_tx_state *txstate)
>> +{
>> +     return dma_cookie_status(channel, cookie, txstate);
> why no residue calculation

We don't have way to pause, resume or stop DMA operation in DMA engine
hw once we have submitted descriptor to engine. While prep routine we
have prepared descriptor for whole requested length, so no need to
calculate residue.
>
>> +}
>> +
>> +static void xgene_dma_issue_pending(struct dma_chan *channel)
>> +{
>> +     /* Nothing to do */
>> +}
> What do you mean by nothing to do here
> See Documentation/dmaengine/client.txt Section 4 & 5
This docs is only applicable on slave DMA operations, we don't support
slave DMA, it's only master.
Our hw engine is designed in the way that there is no scope of
flushing pending transaction explicitly by sw.
We have circular ring descriptor dedicated to engine. In submit
callback  we are queuing descriptor and informing to engine, so after
this it's internal to hw to execute descriptor one by one.

>
>
>> +static dma_cookie_t xgene_dma_tx_memcpy_submit(
>> +     struct dma_async_tx_descriptor *tx)
>> +{
>> +     struct xgene_dma_chan *chan = to_xgene_dma_chan(tx->chan);
>> +     struct xgene_dma_slot *slot = to_xgene_dma_slot(tx);
>> +     dma_addr_t dst = slot->dst;
>> +     dma_addr_t src = slot->src;
>> +     size_t len = slot->len;
>> +     size_t copy;
>> +     dma_cookie_t cookie;
>> +
>> +     spin_lock_bh(&chan->lock);
>> +
>> +     chan->tx_cmd = 0;
>> +     slot->desc_cnt = 0;
>> +
>> +     /* Run until we are out of length */
>> +     do {
>> +             /* Create the largest transaction possible */
>> +             copy = min_t(size_t, len, DMA_MAX_64BDSC_BYTE_CNT);
>> +
>> +             /* Prepare DMA descriptor */
>> +             xgene_dma_prep_cpy_desc(chan, slot, dst, src, copy);
>> +
> This is wrong. The descriptor is supposed to be already prepared and now it
> has to be submitted to queue

Due to the race in tx_submit call from the client, need to serialize
the submission of H/W DMA descriptors.
 So we are making  shadow copy in prepare DMA  routine and  preparing
actual descriptor during tx_submit call.


>
>
>> +static struct dma_async_tx_descriptor *xgene_dma_prep_memcpy(
>> +     struct dma_chan *channel, dma_addr_t dst, dma_addr_t src,
>> +     size_t len, unsigned long flags)
>> +{
>> +     struct xgene_dma_chan *chan = to_xgene_dma_chan(channel);
>> +     struct xgene_dma_slot *slot;
>> +
>> +     /* Sanity check */
>> +     BUG_ON(len > DMA_MAX_MEMCPY_BYTE_CNT);
>> +
>> +     spin_lock_bh(&chan->lock);
>> +
>> +     slot = xgene_dma_get_channel_slot(chan);
>> +     if (!slot) {
>> +             spin_unlock_bh(&chan->lock);
>> +             return NULL;
>> +     }
>> +
>> +     dev_dbg(chan->pdma->dev,
>> +             "MEMCPY channel %d slot %d len 0x%zX dst 0x%llX src 0x%llX\n",
>> +             chan->index, slot->index, len, dst, src);
>> +
>> +     /* Setup slot variables */
>> +     slot->flags = FLAG_SLOT_IN_USE;
>> +     slot->txd.flags = flags;
>> +     slot->txd.tx_submit = xgene_dma_tx_memcpy_submit;
>> +
>> +     /*
>> +      * Due to the race in tx_submit call from the client,
>> +      * need to serialize the submission of H/W DMA descriptors.
>> +      * So make shadow copy to prepare DMA descriptor during
>> +      * tx_submit call.
>> +      */
>> +     slot->dst = dst;
>> +     slot->src = src;
>> +     slot->len = len;
>> +
>> +     spin_unlock_bh(&chan->lock);
>> +
>> +     return &slot->txd;
> Nope, you are supposed to allocate and populate a descriptor here
We have already allocated chan resources during alloc_chan_resource callback.
Can you please elaborate more what do you want.

>> +}
>> +
>> +static dma_cookie_t xgene_dma_tx_sgcpy_submit(
>> +     struct dma_async_tx_descriptor *tx)
>> +{
>> +     struct xgene_dma_chan *chan = to_xgene_dma_chan(tx->chan);
>> +     struct xgene_dma_slot *slot = to_xgene_dma_slot(tx);
>> +     struct scatterlist *dst_sg, *src_sg;
>> +     size_t dst_avail, src_avail;
>> +     dma_addr_t dst, src;
>> +     size_t len;
>> +     dma_cookie_t cookie;
>> +     size_t nbytes  = slot->len;
>> +
>> +     spin_lock_bh(&chan->lock);
>> +
>> +     dst_sg = slot->srcdst_list + slot->src_nents;
>> +     src_sg = slot->srcdst_list;
>> +
>> +     chan->tx_cmd = 0;
>> +     slot->desc_cnt = 0;
>> +
>> +     /* Get prepared for the loop */
>> +     dst_avail = sg_dma_len(dst_sg);
>> +     src_avail = sg_dma_len(src_sg);
>> +
>> +     /* Run until we are out of length */
>> +     do {
>> +             /* Create the largest transaction possible */
>> +             len = min_t(size_t, src_avail, dst_avail);
>> +             len = min_t(size_t, len, DMA_MAX_64BDSC_BYTE_CNT);
>> +             if (len == 0)
>> +                     goto fetch;
>> +
>> +             dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) - dst_avail;
>> +             src = sg_dma_address(src_sg) + sg_dma_len(src_sg) - src_avail;
>> +
>> +             /* Prepare DMA descriptor */
>> +             xgene_dma_prep_cpy_desc(chan, slot, dst, src, len);
> again this wrong, also you should ideally have single submit. Why does it
> have to be transfer type dependent.

Please refer my above shadowcopy comments.

>
>> +
>> +static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
>> +                            struct dma_device *dma_dev)
>> +{
>> +     /* Initialize DMA device capability mask */
>> +     dma_cap_zero(dma_dev->cap_mask);
>> +
>> +     /* Set DMA device capability */
>> +     dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>> +     dma_cap_set(DMA_SG, dma_dev->cap_mask);
>> +
>> +     /* Set base and prep routines */
>> +     dma_dev->dev = chan->pdma->dev;
>> +     dma_dev->device_alloc_chan_resources = xgene_dma_alloc_chan_resources;
>> +     dma_dev->device_free_chan_resources = xgene_dma_free_chan_resources;
>> +     dma_dev->device_issue_pending = xgene_dma_issue_pending;
>> +     dma_dev->device_tx_status = xgene_dma_tx_status;
>> +
>> +     if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask))
>> +             dma_dev->device_prep_dma_memcpy = xgene_dma_prep_memcpy;
>> +
>> +     if (dma_has_cap(DMA_SG, dma_dev->cap_mask))
>> +             dma_dev->device_prep_dma_sg = xgene_dma_prep_sg;
> these two if conditions dont make any sense

Okay..

>> +static int xgene_dma_runtime_resume(struct device *dev)
>> +{
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct xgene_dma *pdma = platform_get_drvdata(pdev);
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(pdma->dma_clk);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to enable clk %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
> This should be under runtime pm flag. people can run kernels with these
> disabled

Okay..
>
>> +
>> +static int xgene_dma_remove(struct platform_device *pdev)
>> +{
>> +     struct xgene_dma *pdma = platform_get_drvdata(pdev);
>> +     struct xgene_dma_chan *chan;
>> +     int i;
>> +
>> +     for (i = 0; i < DMA_MAX_CHANNEL; i++) {
>> +             chan = &pdma->channels[i];
>> +
>> +             /* Delete DMA ring descriptors */
>> +             xgene_dma_delete_chan_rings(chan);
>> +
>> +             /* Kill the DMA channel tasklet */
>> +             tasklet_kill(&chan->rx_tasklet);
>> +
> But your irq is still active and can be triggered!
Okay I will change accordingly

>
>> +             /* Unregister DMA device */
>> +             dma_async_device_unregister(&pdma->dma_dev[i]);
>> +     }
>> +
>> +     pm_runtime_disable(&pdev->dev);
>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>> +             xgene_dma_runtime_suspend(&pdev->dev);
>> +
>> +     return 0;
>> +}
> Okay we need some good work here. First cleanup the usage of dmaengine APIs.
> Second I would like to see cookie management and descriptor management
> cleaned by using helpers available

Yes sure, I will your follow your comments for further cleanup.
>
> --
> ~Vinod
>
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
