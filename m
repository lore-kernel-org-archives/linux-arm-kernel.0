From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 25 Jun 2013 13:34:02 +0800
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <20130621104036.GF23141@intel.com>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <20130621104036.GF23141@intel.com>
Message-ID: <CAMj5BkiV47b1-gUNhpyJrnDK0QdNNwAi_GnZiTwaGR1UQseWog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 6:40 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Jun 17, 2013 at 12:54:32PM +0800, Zhangfei Gao wrote:
>> Add dmaengine driver for hisilicon k3 platform based on virt_dma
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Kai Yang <jean.yangkai@huawei.com>
>> ---
> [snip]
>
>> +#define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
>> +
>> +static struct k3_dma_chan *to_k3_chan(struct dma_chan *chan)
>> +{
>> +     return container_of(chan, struct k3_dma_chan, vc.chan);
>> +}
>> +
>> +static void terminate_chan(struct k3_dma_phy *phy, struct k3_dma_dev *d)
> namespace pls

Thanks Vinod for careful review, will add namespace in v2.

>> +static void k3_dma_tasklet(unsigned long arg)
>> +{
>> +     struct k3_dma_dev *d = (struct k3_dma_dev *)arg;
>> +     struct k3_dma_phy *p;
>> +     struct k3_dma_chan *c;
>> +     unsigned pch, pch_alloc = 0;
>> +
>> +     dev_dbg(d->slave.dev, "tasklet enter\n");
>> +
>> +     /* check new dma request of running channel in vc->desc_issued */
>> +     list_for_each_entry(c, &d->slave.channels, vc.chan.device_node) {
> this should use _safe, you might be adding a new txn while executing this
OK,

>> +static struct dma_async_tx_descriptor *k3_dma_prep_memcpy(
>> +     struct dma_chan *chan,  dma_addr_t dst, dma_addr_t src,
>> +     size_t len, unsigned long flags)
>> +{
>> +     struct k3_dma_chan *c = to_k3_chan(chan);
>> +     struct k3_dma_dev *d = to_k3_dma(chan->device);
>> +     struct k3_dma_desc_sw *ds;
>> +     size_t copy = 0;
>> +     int num_desc = 0;
>> +
>> +     if (!len)
>> +             return NULL;
>> +
>> +     ds = kzalloc(sizeof(struct k3_dma_desc_sw), GFP_NOWAIT);
> sizeof (* ds) would be a better approach
OK, thanks


>> +static int k3_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>> +     unsigned long arg)
>> +{
>> +     struct k3_dma_chan *c = to_k3_chan(chan);
>> +     struct k3_dma_dev *d = to_k3_dma(chan->device);
>> +     struct dma_slave_config *cfg = (void *)arg;
>> +     struct k3_dma_phy *p = NULL;
>> +     unsigned long flags;
>> +     u32 maxburst = 0, val = 0;
>> +     enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
>> +     LIST_HEAD(head);
>> +
>> +     switch (cmd) {
>> +     case DMA_SLAVE_CONFIG:
>> +             if (cfg == NULL)
>> +                     return -EINVAL;
>> +             c->dir = cfg->direction;
>> +             if (c->dir == DMA_DEV_TO_MEM) {
>> +                     c->ccfg = CCFG_DSTINCR;
>> +                     c->dev_addr = cfg->src_addr;
>> +                     maxburst = cfg->src_maxburst;
>> +                     width = cfg->src_addr_width;
>> +             } else if (c->dir == DMA_MEM_TO_DEV) {
>> +                     c->ccfg = CCFG_SRCINCR;
>> +                     c->dev_addr = cfg->dst_addr;
>> +                     maxburst = cfg->dst_maxburst;
>> +                     width = cfg->dst_addr_width;
>> +             }
> looks like this could use some empty line above
>> +
>> +             if (width == DMA_SLAVE_BUSWIDTH_1_BYTE)
>> +                     val = 0;
>> +             else if (width == DMA_SLAVE_BUSWIDTH_2_BYTES)
>> +                     val = 1;
>> +             else if (width == DMA_SLAVE_BUSWIDTH_4_BYTES)
>> +                     val = 2;
>> +             else if (width == DMA_SLAVE_BUSWIDTH_8_BYTES)
>> +                     val = 3;
> and perhpas a switch case here or better a get_width macro

Will use switch instead for efficiency.

>> +
>> +     INIT_LIST_HEAD(&d->slave.channels);
>> +     dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
>> +     dma_cap_set(DMA_MEMCPY, d->slave.cap_mask);
>> +     dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
> DMA_SLAVE set twice?
Thanks for point out
>
>> +     d->slave.dev = &op->dev;
>> +     d->slave.device_alloc_chan_resources = k3_dma_alloc_chan_resources;
>> +     d->slave.device_free_chan_resources = k3_dma_free_chan_resources;
>> +     d->slave.device_tx_status = k3_dma_tx_status;
>> +     d->slave.device_prep_dma_memcpy = k3_dma_prep_memcpy;
>> +     d->slave.device_prep_slave_sg = k3_dma_prep_slave_sg;
>> +     d->slave.device_issue_pending = k3_dma_issue_pending;
>> +     d->slave.device_control = k3_dma_control;
>> +     d->slave.copy_align = DMA_ALIGN;
>> +     d->slave.chancnt = dma_channels;
>> +
>> +     /* init virtual channel */
>> +     for (i = 0; i < dma_channels; i++) {
>> +             struct k3_dma_chan *c;
>> +
>> +             c = devm_kzalloc(&op->dev,
>> +                             sizeof(struct k3_dma_chan), GFP_KERNEL);
>> +             if (c == NULL)
>> +                     return -ENOMEM;
>> +
>> +             INIT_LIST_HEAD(&c->node);
>> +             c->vc.desc_free = k3_dma_free_desc;
>> +             vchan_init(&c->vc, &d->slave);
>> +     }
>> +
>> +     /* Enable clock before accessing registers */
>> +     ret = clk_prepare_enable(d->clk);
>> +     if (ret < 0) {
>> +             dev_err(&op->dev, "clk_prepare_enable failed: %d\n", ret);
>> +             return -EINVAL;
>> +     }
>> +
>> +     trigger_dma(d, true);
> is this turning on dma, if so why at probe?
Will change the confusing name to enable_dma

>> +#ifdef CONFIG_PM
> PM_SLEEP?
>
>> +static int k3_dma_suspend(struct device *dev)
>> +{
>> +     struct k3_dma_dev *d = dev_get_drvdata(dev);
>> +     u32 stat = 0;
>> +
>> +     stat = get_chan_stat(d);
>> +     if (stat) {
>> +             dev_warn(d->slave.dev,
>> +                     "chan %d is running fail to suspend\n", stat);
>> +             return -1;
>> +     }
>> +     trigger_dma(d, false);
>> +     clk_disable_unprepare(d->clk);
>> +     return 0;
>> +}
>> +
>> +static int k3_dma_resume(struct device *dev)
>> +{
>> +     struct k3_dma_dev *d = dev_get_drvdata(dev);
>> +     int ret = 0;
>> +
>> +     ret = clk_prepare_enable(d->clk);
>> +     if (ret < 0) {
>> +             dev_err(d->slave.dev, "clk_prepare_enable failed: %d\n", ret);
>> +             return -EINVAL;
>> +     }
>> +     trigger_dma(d, true);
>> +     return 0;
>> +}
>> +#else
>> +#define k3_dma_suspend NULL
>> +#define k3_dma_resume NULL
>> +#endif
> you can use SET_SYSTEM_SLEEP_PM_OPS macro instead

Make sense.
