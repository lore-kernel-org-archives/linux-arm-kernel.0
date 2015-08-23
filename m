From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Sun, 23 Aug 2015 20:24:16 +0530
Subject: [PATCH v4 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <20150823140823.GA13546@localhost>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
 <1438831173-8761-2-git-send-email-punnaia@xilinx.com>
 <20150820061312.GA13546@localhost>
 <CAGnW=BaU__+B2uAK=qpV3QP60SqSUxx-kgJVs0t42K0fqTxL0g@mail.gmail.com>
 <20150823140823.GA13546@localhost>
Message-ID: <CAGnW=BYSS0kQuY+qYArgg5+Zrots+K9trui_PpJimzctkO-J0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2015 at 7:38 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Aug 20, 2015 at 12:01:27PM +0530, punnaiah choudary kalluri wrote:
>> On Thu, Aug 20, 2015 at 11:43 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Thu, Aug 06, 2015 at 08:49:33AM +0530, Punnaiah Choudary Kalluri wrote:
>> >
>> >> +     list_for_each_entry_safe(desc, next, &chan->done_list, node) {
>> >> +             dma_async_tx_callback callback;
>> >> +             void *callback_param;
>> >> +
>> >> +             list_del(&desc->node);
>> >> +
>> >> +             callback = desc->async_tx.callback;
>> >> +             callback_param = desc->async_tx.callback_param;
>> >> +             if (callback) {
>> >> +                     if (in_interrupt())
>> >> +                             spin_unlock_bh(&chan->lock);
>> >> +                     else
>> >> +                             spin_unlock(&chan->lock);
>> >
>> > This looks bad!
>> > Why would callback be called from different context. It should only be
>> > invoked from your tasklet
>>
>> During the terminate call, driver need to clean up the existing BDs so that time
>> this function will be called from the thread or process context in
>> addition to the
>> tasklet context.
>>
>> DO you have any suggestion here ?
>
> Yes you need to terminate but you don't need to invoke user for terminate
> flow. It is not expected.
> Terminate flow expect youu to clean the channels

Ok. Thanks. I will fix this and send v5 soon.

Regards,
Punnaiah
>
> --
> ~Vinod
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
