From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 25 Jul 2012 16:28:14 +0800
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <201207250601.06866.arnd@arndb.de>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <201207241542.42198.arnd@arndb.de>
 <CAMj5Bkg_BRtVzSz20XvkWUB0TSeGieMAVKHUY85S2bEu7K7BfQ@mail.gmail.com>
 <201207250601.06866.arnd@arndb.de>
Message-ID: <CAMj5Bkh6XBBR1f99X4oKS5kbF2y7Lxpgp2jYB-6vv2q_8ej5Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >> +static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>> >>               unsigned long arg)
>> >> +{
>> >> +       struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
>> >> +       struct dma_slave_config *cfg = (void *)arg;
>> >> +       struct mmp_dma_slave_config *mmp_cfg;
>> >> +       unsigned long flags;
>> >> +       int ret = 0;
>> >> +       u32 maxburst = 0, addr = 0;
>> >> +       enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
>> >> +
>> >> +       if (!dchan)
>> >> +               return -EINVAL;
>> >> +       mmp_cfg = container_of(cfg, struct mmp_dma_slave_config, slave_config);
>> >
>> > Encapsulating the slave config like this requires that the slave driver
>> > knows what the master is, which is not how this is designed to be used.
>> > What is actually the data you encode in there?
>>
>> For peripheral dma, one special requirement of DMA_RCMRx
>> The register is used select which channel is mapped to the peripheral.
>> The channel can be alloc dynamically, but the register is constant to
>> specific peripheral.
>> For example, nand_dma, pxa910 use DRCMR97 (0x1184), what's worse,
>> pxa688 use DRCMR28 (0x170).
>>
>> There is no connection between channel number and drcmr, since channel
>> is dynamically allocated.
>> So we encapsulating the slave config parsing drcmr to dma-engine driver.
>
> Ah, so it is the request line. Now the current plan for this is to go
> into the "dmas" property of the child device using the dma engine binding.
>
> That way, the driver will end up asking for a channel that matches what
> is specified for the device, e.g.
>
>         nand {
>                 ...
>                 dmas = <&pdma 3 0x1184>;
>         };
>
> I believe this is normally set through the filter function when asking
> for a channel on other drivers, not through slave_config.

It is great that the request line is already been considered.
Still want to double confirm, it is dmaengine.c will parse out "the
request line",
Dma-engine driver will get request line from dmaengine.c, right?
So there is dependence.
Or dmaengine driver parse the request line itself from client driver?

Some client may require more than one dma channel,
such as camera, YUV three channels are required.

camera {
        ...
                dmas = <&pdma 1 0x1110 /* Y */
                &pdma 1 0x1114 /* U */
                &pmaa 1 0x1118>; /* V */
         };

Besides, we also have to consider how to parse "request line" if using pdata.

>
>> >> +static struct of_device_id mmp_pdma_dt_ids[] = {
>> >> +     { .compatible = "mrvl,mmp-pdma", .data = (void *)MMP_PDMA},
>> >> +     {}
>> >> +};
>> >> +MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
>> >
>> > You don't actually use the data field afaict, so that can be removed.
>>
>> We keep .data as type, for easy extension, in case future soc register
>> may be different.
>> It is fine to remove the data field, as well as mmp_pdma_id_table.
>
> Ok. Note that in many cases it's actually easier to point the .data
> field to a data structure rather than an integer, it's valid either
> way. Unfortunately the type is different between of_device_id and
> platform_device_id, but a pointer also works for both.

Yes, also find .data is different between of_device_id and platform_device_id.
So using strong conversion for simplification.
Will change to data structure if you think it is more professional.

>
> If you think that you will see different kinds of pdma that you need
> to distinguish here, I would recommend that you use a more specific
> "compatible" identifier, like
>
>         { .compatible = "marvell,pxa168-pdma", };
>
mmp-tdma.c have to take this, since register difference in pxa910 and pxa688.
mmp-pdma.c register keeps same since pxa3xx, we will remove the type.

>
>         Arnd
