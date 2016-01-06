From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 6 Jan 2016 14:51:07 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <20160106091323.GP2940@localhost>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
 <20160106091323.GP2940@localhost>
Message-ID: <CAFd313xhh_4OFP6W2yuApM8ppYMX20DUCCQHJ9YEtCMbzr6Hgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, Jan 6, 2016 at 2:43 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Dec 23, 2015 at 06:28:15PM +0530, Rameshswar Prasad Sahu wrote:
>> From: Rameshwar Prasad Sahu <rsahu@apm.com>
>>
>> For interrupt controller that doesn't support irq_disable and hardware
>> with level interrupt, an extra interrupt can be pending. This patch fixes
>> the issue by setting IRQ_DISABLE_UNLAZY flag for the interrupt line.
>>
>> Reference: http://git.kernel.org/tip/e9849777d0e27cdd2902805be51da73e7c79578c
>
> I seem to have got this patch thrice :(
Due to mail failure (some issue was in my email client) to some
email-id it was multiple times,
>
>>
>> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
>> ---
>>  drivers/dma/xgene-dma.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
>> index 9dfa2b0..6363e84 100644
>> --- a/drivers/dma/xgene-dma.c
>> +++ b/drivers/dma/xgene-dma.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/dmapool.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> +#include <linux/irq.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>
>> @@ -1610,6 +1611,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
>>       /* Register DMA channel rx irq */
>>       for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>>               chan = &pdma->chan[i];
>> +             irq_set_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>
> Why not use irq_settings_disable_unlazy(), at least read the reference you
> pointed out!

irq_settings_disable_unlazy() is helper function to test
IRQ_DISABLE_UNLAZY flag is set or not, it's not for setting this flag.
FYI...
+static inline bool irq_settings_disable_unlazy(struct irq_desc *desc)
+{
+ return desc->status_use_accessors & _IRQ_DISABLE_UNLAZY;
+}
>
>>               ret = devm_request_irq(chan->dev, chan->rx_irq,
>>                                      xgene_dma_chan_ring_isr,
>>                                      0, chan->name, chan);
>> @@ -1620,6 +1622,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
>>
>>                       for (j = 0; j < i; j++) {
>>                               chan = &pdma->chan[i];
>> +                             irq_clear_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>>                               devm_free_irq(chan->dev, chan->rx_irq, chan);
>>                       }
>>
>> @@ -1640,6 +1643,7 @@ static void xgene_dma_free_irqs(struct xgene_dma *pdma)
>>
>>       for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>>               chan = &pdma->chan[i];
>> +             irq_clear_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>>               devm_free_irq(chan->dev, chan->rx_irq, chan);
>>       }
>>  }
>> --
>> 1.7.1
>
> --
> ~Vinod
