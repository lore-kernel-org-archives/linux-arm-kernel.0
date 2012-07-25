From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 25 Jul 2012 12:48:50 +0800
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <201207241542.42198.arnd@arndb.de>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
 <201207241542.42198.arnd@arndb.de>
Message-ID: <CAMj5Bkg_BRtVzSz20XvkWUB0TSeGieMAVKHUY85S2bEu7K7BfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 11:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:

Thanks Arnd for taking look at this patch in this busy merge window time :)

> On Friday 20 July 2012, Zhangfei Gao wrote:
>
>> diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
>> new file mode 100644
>> index 0000000..42cd134
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
>> @@ -0,0 +1,30 @@
>> +* MARVELL MMP DMA controller
>> +
>> +For driver/dma/mmp-pdma.c
>
> The binding document should normally not refer to a Linux device driver,
> but rather to a specific hardware, because the binding is OS-independent.
> Better list here which chips have this specific hardware.

Got it, will modify accordingly.
Besides, we would like to write both pdma and tdma desc to the same mmp-dma.txt
>
>> +Required properties:
>> +- compatible: Should be "mrvl,mmp-pdma"
>
> We have recently changed all the Marvell strings to "marvel," instead
> of "mrvl,". We used to have a mix of both, but it's better to use
> just one.

Got it, will use "marvel"

>
>> +- reg: Should contain DMA registers location and length.
>> +- interrupts: Either contain all of the per-channel DMA interrupts
>> +             or one irq for pdma device
>> +- chancnt: Should be channel number in the soc
>
> There is ongoing work to specify the generic dma engine bindings.
> The current proposal is to use
>
>     - #dma-channels: Number of DMA channels supported by the controller.
>     - #dma-requests: Number of DMA requests signals supported by the controller.
>
> instead of the chancnt. You can provide just one or both, depending
> on what you need.

mmp-pdma use only dma-channels is fine.

Some confusion
a. dma-channels & dma-requests only standardize name and dma-engine driver
takes responsibility to parse these vectors in probe function like mmp_pdma.c.
b. dma-channels & dma-requests not only standardize name but only parse these
flags to dmaengine.c, dmaengine.c will parse these flags while
dma-engine driver will get these flags from dmaengine.c via some API.

While one is correct, my understand is a, mmp_pdma.c probe function
will get these flags.

>
> It is not entirely clear what the difference between having one IRQ
> or lots of them is:
>
>> +/* One irq for all channels */
>> +pdma: dma-controller at d4000000 {
>> +           compatible = "mrvl,mmp-pdma";
>> +           reg = <0xd4000000 0x10000>;
>> +           interrupts = <47>;
>> +           chancnt = <16>;
>> +      };
>> +
>
> Would this be the same as saying
>
>                 interrupts = <47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47>;
>
> with 16 channels?

Sorry for confusion, they are different,
1. Only one IRQ, then dma engine driver will parse internal register
to check channel in irq.
For example, arch/arm/plat-pxa/dma.c parse DINT in dma_irq_handler.

2, Each irq for each channel
ICU could directly parse which channel is irq directly from ICU register.
While DMA controller do not have such register to check which channel
irq happens.
For example, pxa688 icu register 0x128, bit 0~15 is PDMA channel irq,
18~21 is ADMA irq
Using this method, interrupt-parent is required to parse specific channel irq.

>
>
>> +static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>>               unsigned long arg)
>> +{
>> +       struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
>> +       struct dma_slave_config *cfg = (void *)arg;
>> +       struct mmp_dma_slave_config *mmp_cfg;
>> +       unsigned long flags;
>> +       int ret = 0;
>> +       u32 maxburst = 0, addr = 0;
>> +       enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
>> +
>> +       if (!dchan)
>> +               return -EINVAL;
>> +       mmp_cfg = container_of(cfg, struct mmp_dma_slave_config, slave_config);
>
> Encapsulating the slave config like this requires that the slave driver
> knows what the master is, which is not how this is designed to be used.
> What is actually the data you encode in there?

For peripheral dma, one special requirement of DMA_RCMRx
The register is used select which channel is mapped to the peripheral.
The channel can be alloc dynamically, but the register is constant to
specific peripheral.
For example, nand_dma, pxa910 use DRCMR97 (0x1184), what's worse,
pxa688 use DRCMR28 (0x170).

There is no connection between channel number and drcmr, since channel
is dynamically allocated.
So we encapsulating the slave config parsing drcmr to dma-engine driver.

>
>> +static struct of_device_id mmp_pdma_dt_ids[] = {
>> +     { .compatible = "mrvl,mmp-pdma", .data = (void *)MMP_PDMA},
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
>
> You don't actually use the data field afaict, so that can be removed.

We keep .data as type, for easy extension, in case future soc register
may be different.
It is fine to remove the data field, as well as mmp_pdma_id_table.

>
>> +     of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
>> +     if (of_id)
>
> It is already matched here, so just do
>
>         if (pdev->dev->of_node)
>
>> +
>> +struct mmp_dma_platdata {
>> +     int chancnt;
>> +};
>
> It this actually necessary?
>
> I think it would be better in the long run to only provide the DT based
> configuration interface here. There are no in-tree users of the
> platform-data, and I would hope that we can avoid adding them. Any
> board files that are kept out of tree can of course add support for this
> back. If you can make a reasonable argument for keeping it, you can
> probably convince me otherwise in this case, but generally I would
> prefer new stuff to be DT-only.

We may have to keep pdata currently.
The final purpose is replacing arch/arm/plat-pxa/dma.c, which is
widely used pxa3xx system.
There are lots of work in replacing pdma on pxa3xx system, which not
support dt yet.
If pdma only support DT, the replacing work may become impossible.

>
>         Arnd


>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
