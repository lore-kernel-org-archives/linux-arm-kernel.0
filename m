From: rsahu@apm.com (Rameshwar Sahu)
Date: Wed, 6 Jan 2016 15:02:02 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <20160106093121.GB11778@localhost>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
 <20160106091323.GP2940@localhost>
 <CAFd313xhh_4OFP6W2yuApM8ppYMX20DUCCQHJ9YEtCMbzr6Hgg@mail.gmail.com>
 <20160106093121.GB11778@localhost>
Message-ID: <CAFd313z6gvBhLVAopbBfd68-w6_e6+SB+s6sf=FgT7YB0LP+cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 6, 2016 at 3:01 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Jan 06, 2016 at 02:51:07PM +0530, Rameshwar Sahu wrote:
>> Hi Vinod,
>>
>> On Wed, Jan 6, 2016 at 2:43 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Wed, Dec 23, 2015 at 06:28:15PM +0530, Rameshswar Prasad Sahu wrote:
>> >> From: Rameshwar Prasad Sahu <rsahu@apm.com>
>> >>
>> >> For interrupt controller that doesn't support irq_disable and hardware
>> >> with level interrupt, an extra interrupt can be pending. This patch fixes
>> >> the issue by setting IRQ_DISABLE_UNLAZY flag for the interrupt line.
>> >>
>> >> Reference: http://git.kernel.org/tip/e9849777d0e27cdd2902805be51da73e7c79578c
>> >
>> > I seem to have got this patch thrice :(
>> Due to mail failure (some issue was in my email client) to some
>> email-id it was multiple times,
>
> git send-email ?
Yes, was not able to send Arnd Bergmann.
>
>> >
>> >>
>> >> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
>> >> ---
>> >>  drivers/dma/xgene-dma.c |    4 ++++
>> >>  1 files changed, 4 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
>> >> index 9dfa2b0..6363e84 100644
>> >> --- a/drivers/dma/xgene-dma.c
>> >> +++ b/drivers/dma/xgene-dma.c
>> >> @@ -29,6 +29,7 @@
>> >>  #include <linux/dmapool.h>
>> >>  #include <linux/interrupt.h>
>> >>  #include <linux/io.h>
>> >> +#include <linux/irq.h>
>> >>  #include <linux/module.h>
>> >>  #include <linux/of_device.h>
>> >>
>> >> @@ -1610,6 +1611,7 @@ static int xgene_dma_request_irqs(struct xgene_dma *pdma)
>> >>       /* Register DMA channel rx irq */
>> >>       for (i = 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>> >>               chan = &pdma->chan[i];
>> >> +             irq_set_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>> >
>> > Why not use irq_settings_disable_unlazy(), at least read the reference you
>> > pointed out!
>>
>> irq_settings_disable_unlazy() is helper function to test
>> IRQ_DISABLE_UNLAZY flag is set or not, it's not for setting this flag.
>> FYI...
>> +static inline bool irq_settings_disable_unlazy(struct irq_desc *desc)
>> +{
>> + return desc->status_use_accessors & _IRQ_DISABLE_UNLAZY;
>> +}
>
> Ah yes, I saw clear API and assumed there would be set. Then I think we
> should add a set helper as well as the usage is intended for drivers to
> set this flag
>
> Thomas,
>
> Any reason why you didn't add a set helper, only test and clear?
>
> --
> ~Vinod
