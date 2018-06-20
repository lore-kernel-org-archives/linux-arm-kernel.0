From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 16:57:05 +0200
Subject: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
In-Reply-To: <DM6PR02MB436181CD5544B0FA95318077C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-5-andrea.merello@gmail.com>
 <DM6PR02MB436181CD5544B0FA95318077C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
Message-ID: <CAN8YU5OMgOv6JUAA5PrMGihhVgPE3=c3KJk-LXJoO2Zt1WcKPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 4:43 PM, Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>> -----Original Message-----
>> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
>> owner at vger.kernel.org] On Behalf Of Andrea Merello
>> Sent: Wednesday, June 20, 2018 2:07 PM
>> To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
>> <michals@xilinx.com>; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; dmaengine at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> Andrea Merello <andrea.merello@gmail.com>
>> Subject: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
>> supports scatter-gather
>>
>> The HW can be either direct-access or scatter-gather version. These are
>> SW incompatible.
>>
>> The driver can handle both version: a DT property was used to
>> tell the driver whether to assume the HW is is scatter-gather mode.
>>
>> This patch makes the driver to autodetect this information. The DT
>> property is not required anymore.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index bdbc8ba9092a..8c6e818e596f 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -86,6 +86,7 @@
>>  #define XILINX_DMA_DMASR_DMA_DEC_ERR         BIT(6)
>>  #define XILINX_DMA_DMASR_DMA_SLAVE_ERR               BIT(5)
>>  #define XILINX_DMA_DMASR_DMA_INT_ERR         BIT(4)
>> +#define XILINX_DMA_DMASR_SG_MASK             BIT(3)
>>  #define XILINX_DMA_DMASR_IDLE                        BIT(1)
>>  #define XILINX_DMA_DMASR_HALTED              BIT(0)
>>  #define XILINX_DMA_DMASR_DELAY_MASK          GENMASK(31, 24)
>> @@ -407,7 +408,6 @@ struct xilinx_dma_config {
>>   * @dev: Device Structure
>>   * @common: DMA device structure
>>   * @chan: Driver specific DMA channel
>> - * @has_sg: Specifies whether Scatter-Gather is present or not
>>   * @mcdma: Specifies whether Multi-Channel is present or not
>>   * @flush_on_fsync: Flush on frame sync
>>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
>> @@ -426,7 +426,6 @@ struct xilinx_dma_device {
>>       struct device *dev;
>>       struct dma_device common;
>>       struct xilinx_dma_chan
>> *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
>> -     bool has_sg;
>>       bool mcdma;
>>       u32 flush_on_fsync;
>>       bool ext_addr;
>> @@ -2391,7 +2390,6 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>
>>       chan->dev = xdev->dev;
>>       chan->xdev = xdev;
>> -     chan->has_sg = xdev->has_sg;
>>       chan->desc_pendingcount = 0x0;
>>       chan->ext_addr = xdev->ext_addr;
>>       /* This variable ensures that descriptors are not
>> @@ -2488,6 +2486,13 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>               chan->stop_transfer = xilinx_dma_stop_transfer;
>>       }
>>
>> +     /* check if SG is enabled */
>> +     if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
>> +             XILINX_DMA_DMASR_SG_MASK)
> I think SGIncld mask is only applicable for AXI DMA and CDMA IP.
> For VDMA IP this bit is reserved.

OK. I can make it conditional wrt the IP type. As far as I can see
VDMA IP has not the two (SG vs no-SG) variant at all, so all should be
still OK.

> .
>> +             chan->has_sg = true;
>> +     dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
>> +             chan->has_sg ? "enabled" : "disabled");
>> +
>>       /* Initialize the tasklet */
>>       tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
>>                       (unsigned long)chan);
>> @@ -2626,7 +2631,6 @@ static int xilinx_dma_probe(struct platform_device
>> *pdev)
>>               return PTR_ERR(xdev->regs);
>>
>>       /* Retrieve the DMA engine properties from the device tree */
>> -
> Unrelated change

Oops.. Sorry.

>
>>       if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>>               xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
>>               err = of_property_read_u32(node, "xlnx,lengthregwidth",
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
