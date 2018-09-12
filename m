From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 12 Sep 2018 12:01:33 +0900
Subject: [PATCH v2 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
In-Reply-To: <20180911070003.GI2634@vkoul-mobl>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
 <20180911070003.GI2634@vkoul-mobl>
Message-ID: <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,


2018-09-11 16:00 GMT+09:00 Vinod <vkoul@kernel.org>:
> On 24-08-18, 10:41, Masahiro Yamada wrote:
>
>> +/* mc->vc.lock must be held by caller */
>> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
>> +{
>> +     u32 residue = 0;
>> +     int i;
>> +
>> +     for (i = md->sg_cur; i < md->sg_len; i++)
>> +             residue += sg_dma_len(&md->sgl[i]);
>
> so if the descriptor is submitted to hardware, we return the descriptor
> length, which is not correct.
>
> Two cases are required to be handled:
> 1. Descriptor is in queue (IMO above logic is fine for that, but it can
> be calculated at descriptor submit and looked up here)

Where do you want it to be calculated?

This hardware provides only simple registers (address and size)
for one-shot transfer instead of descriptors.

So, I used sgl as-is because I did not see a good reason
to transform sgl to another data structure.




> 2. Descriptor is running (interesting case), you need to read current
> register and offset that from descriptor length and return


OK, I will read out the register value
to retrieve the residue from the on-flight transfer.


>> +static struct dma_async_tx_descriptor *uniphier_mdmac_prep_slave_sg(
>> +                                     struct dma_chan *chan,
>> +                                     struct scatterlist *sgl,
>> +                                     unsigned int sg_len,
>> +                                     enum dma_transfer_direction direction,
>> +                                     unsigned long flags, void *context)
>> +{
>> +     struct virt_dma_chan *vc = to_virt_chan(chan);
>> +     struct uniphier_mdmac_desc *md;
>> +
>> +     if (!is_slave_direction(direction))
>> +             return NULL;
>> +
>> +     md = kzalloc(sizeof(*md), GFP_KERNEL);
>
> _prep calls can be invoked from atomic context, so this should be
> GFP_NOWAIT, see Documentation/driver-api/dmaengine/provider.rst

Will fix.


>> +     if (!md)
>> +             return NULL;
>> +
>> +     md->sgl = sgl;
>> +     md->sg_len = sg_len;
>> +     md->dir = direction;
>> +
>> +     return vchan_tx_prep(vc, &md->vd, flags);
>
> this seems missing stuff. Where do you do register calculation for the
> descriptor and where is slave_config here, how do you know where to
> send/receive data form/to (peripheral)


This dmac is really simple, and un-flexible.

The peripheral address to send/receive data from/to is hard-weird.
cfg->{src_addr,dst_addr} is not configurable.

Look at __uniphier_mdmac_handle().
'dest_addr' and 'src_addr' must be set to 0 for the peripheral.




>> +static enum dma_status uniphier_mdmac_tx_status(struct dma_chan *chan,
>> +                                             dma_cookie_t cookie,
>> +                                             struct dma_tx_state *txstate)
>> +{
>> +     struct virt_dma_chan *vc;
>> +     struct virt_dma_desc *vd;
>> +     struct uniphier_mdmac_chan *mc;
>> +     struct uniphier_mdmac_desc *md = NULL;
>> +     enum dma_status stat;
>> +     unsigned long flags;
>> +
>> +     stat = dma_cookie_status(chan, cookie, txstate);
>> +     if (stat == DMA_COMPLETE)
>> +             return stat;
>> +
>> +     vc = to_virt_chan(chan);
>> +
>> +     spin_lock_irqsave(&vc->lock, flags);
>> +
>> +     mc = to_uniphier_mdmac_chan(vc);
>> +
>> +     if (mc->md && mc->md->vd.tx.cookie == cookie)
>> +             md = mc->md;
>> +
>> +     if (!md) {
>> +             vd = vchan_find_desc(vc, cookie);
>> +             if (vd)
>> +                     md = to_uniphier_mdmac_desc(vd);
>> +     }
>> +
>> +     if (md)
>> +             txstate->residue = __uniphier_mdmac_get_residue(md);
>
> txstate can be NULL and should be checked...

Will fix.


>> +static int uniphier_mdmac_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct uniphier_mdmac_device *mdev;
>> +     struct dma_device *ddev;
>> +     struct resource *res;
>> +     int nr_chans, ret, i;
>> +
>> +     nr_chans = platform_irq_count(pdev);
>> +     if (nr_chans < 0)
>> +             return nr_chans;
>> +
>> +     ret = dma_set_mask(dev, DMA_BIT_MASK(32));
>> +     if (ret)
>> +             return ret;
>> +
>> +     mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
>> +                         GFP_KERNEL);
>
> kcalloc variant?


No.

I allocate here
sizeof(*mdev) + nr_chans * sizeof(struct uniphier_mdmac_chan)

kcalloc does not cater to it.

You should check struct_size() helper macro.




>> +     if (!mdev)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     mdev->reg_base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(mdev->reg_base))
>> +             return PTR_ERR(mdev->reg_base);
>> +
>> +     mdev->clk = devm_clk_get(dev, NULL);
>> +     if (IS_ERR(mdev->clk)) {
>> +             dev_err(dev, "failed to get clock\n");
>> +             return PTR_ERR(mdev->clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(mdev->clk);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ddev = &mdev->ddev;
>> +     ddev->dev = dev;
>> +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
>> +     ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
>> +     ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
>> +     ddev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>> +     ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
>> +     ddev->device_prep_slave_sg = uniphier_mdmac_prep_slave_sg;
>> +     ddev->device_terminate_all = uniphier_mdmac_terminate_all;
>> +     ddev->device_synchronize = uniphier_mdmac_synchronize;
>> +     ddev->device_tx_status = uniphier_mdmac_tx_status;
>> +     ddev->device_issue_pending = uniphier_mdmac_issue_pending;
>
> No device_config?


As I mentioned above, this hardware has no room for configuration.
Nothing in struct dma_slave_config except 'direction' is configurable
for this hardware.

The 'direction' is deprecated.


If an empty device_config hook is OK,
I will add it.


-- 
Best Regards
Masahiro Yamada
