From: rsahu@apm.com (Rameshwar Sahu)
Date: Fri, 2 Jan 2015 14:35:43 +0530
Subject: [PATCH v1 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 driver
In-Reply-To: <1847119.mDQlkgqzsR@wuerfel>
References: <1420026134-17857-1-git-send-email-rsahu@apm.com>
 <1847119.mDQlkgqzsR@wuerfel>
Message-ID: <CAFd313zXsoWjDVEKSQpMKMxuP7U8oRmo=sEo8P3iHysDnJDvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

See inline...

Thanks,
with regards,
Ram


On Wed, Dec 31, 2014 at 8:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 31 December 2014 17:12:14 Rameshwar Prasad Sahu wrote:
>> This patch implements the APM X-Gene SoC DMA driver. The APM X-Gene
>> SoC DMA engine consists of 4 DMA channels for performing DMA operations.
>> These DMA operations include memory copy and scatter gathering offload.
>
> Is the dma engine capable of slave DMA in theory and you just don't use
> that, or does it not do that at all?

This DMA engine is not capable of slave DMA.


>
>> +static int xgene_dma_init_mem(struct xgene_dma *pdma)
>> +{
>> +     int timeout = 1000;
>> +
>> +     writel(0x0, pdma->csr_dma + DMA_MEM_RAM_SHUTDOWN);
>> +
>> +     /* Force a barrier */
>> +     readl(pdma->csr_dma + DMA_MEM_RAM_SHUTDOWN);
>> +
>> +     do {
>> +             if (readl(pdma->csr_dma + DMA_BLK_MEM_RDY)
>> +                     == DMA_BLK_MEM_RDY_DEFAULT)
>> +                     break;
>> +             udelay(1);
>> +     } while (--timeout);
>> +
>> +     if (timeout <= 0) {
>> +             dev_err(pdma->dev,
>> +                     "Failed to release memory from shutdown\n");
>> +             return -ENODEV;
>> +     }
>> +     return 0;
>> +}
>
> That's a long busy-loop. Can you use a sleeping function instead?

Okay I will do this.

>
>> +     /* Set DMA mask and coherent mask */
>> +     ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to set DMA mask\n");
>> +             goto err_pm_enable;
>> +     }
>
> Never use dma_coerce_mask_and_coherent in new drivers. Instead, make
> sure that the information in the device tree is correct in the first
> place so the driver doesn't need to override it.
>
>         Arnd
>

Okay I will use function for DMA masking that other driver uses.
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
