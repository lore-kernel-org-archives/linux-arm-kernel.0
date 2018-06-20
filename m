From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 15:15:11 +0200
Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
 misalignments
In-Reply-To: <DM6PR02MB4361458180616B591C6742E2C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <DM6PR02MB4361458180616B591C6742E2C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
Message-ID: <CAN8YU5N8en1dtUShuK=0KCtLk3v4kVqm-TcM4J0=XBZo0=Sh-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 1:37 PM, Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>> -----Original Message-----
>> From: dmaengine-owner at vger.kernel.org [mailto:dmaengine-
>> owner at vger.kernel.org] On Behalf Of Andrea Merello
>> Sent: Wednesday, June 20, 2018 2:07 PM
>> To: vkoul at kernel.org; dan.j.williams at intel.com; Michal Simek
>> <michals@xilinx.com>; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; dmaengine at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> Andrea Merello <andrea.merello@gmail.com>
>> Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
>> misalignments
>
> We should rephrase commit message to something like "In axidma
> slave_sg and dma_cylic mode align split descriptors"

OK

>>
>> Whenever a single or cyclic transaction is prepared, the driver
>> could eventually split it over several SG descriptors in order
>> to deal with the HW maximum transfer length.
>>
>> This could end up in DMA operations starting from a misaligned
>> address. This seems fatal for the HW.
> This seems fatal for the HW if DRE is not enabled.

OK

>>
>> This patch eventually adjusts the transfer size in order to make sure
>> all operations start from an aligned address.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 27 ++++++++++++++++++++-------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 27b523530c4a..a516e7ffef21 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -376,6 +376,7 @@ struct xilinx_dma_chan {
>>       void (*start_transfer)(struct xilinx_dma_chan *chan);
>>       int (*stop_transfer)(struct xilinx_dma_chan *chan);
>>       u16 tdest;
>> +     u32 copy_mask;
> We can reuse copy_align itself.  See below.

OK

>>  };
>>
>>  /**
>> @@ -1789,10 +1790,14 @@ static struct dma_async_tx_descriptor
>> *xilinx_dma_prep_slave_sg(
>>
>>                       /*
>>                        * Calculate the maximum number of bytes to transfer,
>> -                      * making sure it is less than the hw limit
>> +                      * making sure it is less than the hw limit and that
>> +                      * the next chuck start address is aligned
>
> /s/chuck/chunk

OK

>>                        */
>> -                     copy = min_t(size_t, sg_dma_len(sg) - sg_used,
>> -                                  XILINX_DMA_MAX_TRANS_LEN);
>> +                     copy = sg_dma_len(sg) - sg_used;
>> +                     if (copy > XILINX_DMA_MAX_TRANS_LEN)
>> +                             copy = XILINX_DMA_MAX_TRANS_LEN &
>> +                                     chan->copy_mask;
>> +
>
>
> In below implementation, we can reuse copy_align.
> Same for dma_cyclic.
>
> if ((copy + sg_used  < sg_dma_len(sg)) &&
>         chan->xdev->common.copy_align) {
>         /* If this is not the last descriptor, make sure
>           * the next one will be properly aligned
>          */
>         copy = rounddown(copy,
>                (1 << chan->xdev->common.copy_align));
>      }

OK for the general idea. But to me it seems a bit more complicated than needed:
What's the point in setting 'copy' with min_t, performing also the
subtraction sg_dma_len(sg) - sg_used, and then add sg_used again? What
about something like:


-                       copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-                                    XILINX_DMA_MAX_TRANS_LEN);
+                       copy = sg_dma_len(sg) - sg_used;
+                       if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+                           chan->xdev->common.copy_align)
+                               copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+                                        (1 << chan->xdev->common.copy_align));
+


>>                       hw = &segment->hw;
>>
>>                       /* Fill in the descriptor */
>> @@ -1894,10 +1899,14 @@ static struct dma_async_tx_descriptor
>> *xilinx_dma_prep_dma_cyclic(
>>
>>                       /*
>>                        * Calculate the maximum number of bytes to transfer,
>> -                      * making sure it is less than the hw limit
>> +                      * making sure it is less than the hw limit and that
>> +                      * the next chuck start address is aligned
>>                        */
>> -                     copy = min_t(size_t, period_len - sg_used,
>> -                                  XILINX_DMA_MAX_TRANS_LEN);
>> +                     copy = period_len - sg_used;
>> +                     if (copy > XILINX_DMA_MAX_TRANS_LEN)
>> +                             copy = XILINX_DMA_MAX_TRANS_LEN &
>> +                                     chan->copy_mask;
>> +
>>                       hw = &segment->hw;
>>                       xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>>                                         period_len * i);
>> @@ -2402,8 +2411,12 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>       if (width > 8)
>>               has_dre = false;
>>
>> -     if (!has_dre)
>> +     if (has_dre) {
>> +             chan->copy_mask = ~0;
>> +     } else {
>>               xdev->common.copy_align = fls(width - 1);
>> +             chan->copy_mask = ~(width - 1);
>> +     }
>
> As mentioned above we don't need this additional field.

OK

>>
>>       if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
>>           of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
