From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 06:01:06 +0000
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <CAMj5Bkg_BRtVzSz20XvkWUB0TSeGieMAVKHUY85S2bEu7K7BfQ@mail.gmail.com>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <201207241542.42198.arnd@arndb.de>
 <CAMj5Bkg_BRtVzSz20XvkWUB0TSeGieMAVKHUY85S2bEu7K7BfQ@mail.gmail.com>
Message-ID: <201207250601.06866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, zhangfei gao wrote:
> On Tue, Jul 24, 2012 at 11:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > The binding document should normally not refer to a Linux device driver,
> > but rather to a specific hardware, because the binding is OS-independent.
> > Better list here which chips have this specific hardware.
> 
> Got it, will modify accordingly.
> Besides, we would like to write both pdma and tdma desc to the same mmp-dma.txt

ok, good idea.

> Some confusion
> a. dma-channels & dma-requests only standardize name and dma-engine driver
> takes responsibility to parse these vectors in probe function like mmp_pdma.c.
> b. dma-channels & dma-requests not only standardize name but only parse these
> flags to dmaengine.c, dmaengine.c will parse these flags while
> dma-engine driver will get these flags from dmaengine.c via some API.
> 
> While one is correct, my understand is a, mmp_pdma.c probe function
> will get these flags.

We have not fully worked out these in the generic binding. Right now, the
important part is that you use the standard identifiers so we are free
to parse them in the common code if we decide to do that later.

> > It is not entirely clear what the difference between having one IRQ
> > or lots of them is:
> >
> >> +/* One irq for all channels */
> >> +pdma: dma-controller at d4000000 {
> >> +           compatible = "mrvl,mmp-pdma";
> >> +           reg = <0xd4000000 0x10000>;
> >> +           interrupts = <47>;
> >> +           chancnt = <16>;
> >> +      };
> >> +
> >
> > Would this be the same as saying
> >
> >                 interrupts = <47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47>;
> >
> > with 16 channels?
> 
> Sorry for confusion, they are different,
> 1. Only one IRQ, then dma engine driver will parse internal register
> to check channel in irq.
> For example, arch/arm/plat-pxa/dma.c parse DINT in dma_irq_handler.
> 
> 2, Each irq for each channel
> ICU could directly parse which channel is irq directly from ICU register.
> While DMA controller do not have such register to check which channel
> irq happens.
> For example, pxa688 icu register 0x128, bit 0~15 is PDMA channel irq,
> 18~21 is ADMA irq
> Using this method, interrupt-parent is required to parse specific channel irq.

ok, got it. Maybe add this text or a shorter version to the binding.

> >> +static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
> >>               unsigned long arg)
> >> +{
> >> +       struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
> >> +       struct dma_slave_config *cfg = (void *)arg;
> >> +       struct mmp_dma_slave_config *mmp_cfg;
> >> +       unsigned long flags;
> >> +       int ret = 0;
> >> +       u32 maxburst = 0, addr = 0;
> >> +       enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> >> +
> >> +       if (!dchan)
> >> +               return -EINVAL;
> >> +       mmp_cfg = container_of(cfg, struct mmp_dma_slave_config, slave_config);
> >
> > Encapsulating the slave config like this requires that the slave driver
> > knows what the master is, which is not how this is designed to be used.
> > What is actually the data you encode in there?
> 
> For peripheral dma, one special requirement of DMA_RCMRx
> The register is used select which channel is mapped to the peripheral.
> The channel can be alloc dynamically, but the register is constant to
> specific peripheral.
> For example, nand_dma, pxa910 use DRCMR97 (0x1184), what's worse,
> pxa688 use DRCMR28 (0x170).
> 
> There is no connection between channel number and drcmr, since channel
> is dynamically allocated.
> So we encapsulating the slave config parsing drcmr to dma-engine driver.

Ah, so it is the request line. Now the current plan for this is to go
into the "dmas" property of the child device using the dma engine binding.

That way, the driver will end up asking for a channel that matches what
is specified for the device, e.g.

	nand {
		...
		dmas = <&pdma 3 0x1184>;
	};

I believe this is normally set through the filter function when asking
for a channel on other drivers, not through slave_config.

> >> +static struct of_device_id mmp_pdma_dt_ids[] = {
> >> +     { .compatible = "mrvl,mmp-pdma", .data = (void *)MMP_PDMA},
> >> +     {}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
> >
> > You don't actually use the data field afaict, so that can be removed.
> 
> We keep .data as type, for easy extension, in case future soc register
> may be different.
> It is fine to remove the data field, as well as mmp_pdma_id_table.

Ok. Note that in many cases it's actually easier to point the .data
field to a data structure rather than an integer, it's valid either
way. Unfortunately the type is different between of_device_id and
platform_device_id, but a pointer also works for both.

If you think that you will see different kinds of pdma that you need
to distinguish here, I would recommend that you use a more specific
"compatible" identifier, like

	{ .compatible = "marvell,pxa168-pdma", };

> >> +     of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
> >> +     if (of_id)
> >
> > It is already matched here, so just do
> >
> >         if (pdev->dev->of_node)
> >
> >> +
> >> +struct mmp_dma_platdata {
> >> +     int chancnt;
> >> +};
> >
> > It this actually necessary?
> >
> > I think it would be better in the long run to only provide the DT based
> > configuration interface here. There are no in-tree users of the
> > platform-data, and I would hope that we can avoid adding them. Any
> > board files that are kept out of tree can of course add support for this
> > back. If you can make a reasonable argument for keeping it, you can
> > probably convince me otherwise in this case, but generally I would
> > prefer new stuff to be DT-only.
> 
> We may have to keep pdata currently.
> The final purpose is replacing arch/arm/plat-pxa/dma.c, which is
> widely used pxa3xx system.
> There are lots of work in replacing pdma on pxa3xx system, which not
> support dt yet.
> If pdma only support DT, the replacing work may become impossible.

Ok, makes sense. Please keep it for now.

	Arnd
