From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 3 Dec 2014 13:21:37 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
Message-ID: <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 10:17, Padma Venkat <padma.kvr@gmail.com> wrote:
> Hi Lars,
>
> [snip]
>>>> +
>>>> +   ret = dma_cookie_status(chan, cookie, txstate);
>>>> +   if (ret == DMA_COMPLETE || !txstate)
>>>> +           return ret;
>>>> +
>>>> +   used = txstate->used;
>>>> +
>>>> +   spin_lock_irqsave(&pch->lock, flags);
>>>> +   sar = readl(regs + SA(thrd->id));
>>>> +   dar = readl(regs + DA(thrd->id));
>>>> +
>>>> +   list_for_each_entry(desc, &pch->work_list, node) {
>>>> +           if (desc->status == BUSY) {
>>>> +                   current_c = desc->txd.cookie;
>>>> +                   if (first) {
>>>> +                           first_c = desc->txd.cookie;
>>>> +                           first = false;
>>>> +                   }
>>>> +
>>>> +                   if (first_c < current_c)
>>>> +                           residue += desc->px.bytes;
>>>> +                   else {
>>>> +                           if (desc->rqcfg.src_inc && pl330_src_addr_in_desc(desc, sar)) {
>>>> +                                   residue += desc->px.bytes;
>>>> +                                   residue -= sar - desc->px.src_addr;
>>>> +                           } else if (desc->rqcfg.dst_inc && pl330_dst_addr_in_desc(desc, dar))
>>>> {
>>>> +                                   residue += desc->px.bytes;
>>>> +                                   residue -= dar - desc->px.dst_addr;
>>>> +                           }
>>>> +                   }
>>>> +           } else if (desc->status == PREP)
>>>> +                   residue += desc->px.bytes;
>>>> +
>>>> +           if (desc->txd.cookie == used)
>>>> +                   break;
>>>> +   }
>>>> +   spin_unlock_irqrestore(&pch->lock, flags);
>>>> +   dma_set_residue(txstate, residue);
>>>> +   return ret;
>>>>   }
> [snip]
>>>
>>> Any comment on this patch?
>>
>> Well it doesn't break audio, but I don't think it has the correct haviour
>> for all cases yet.
>
> OK. Any way of testing other cases like scatter-gather and memcopy.  I
> verified memcopy in dmatest but it seems not doing anything with
> residue bytes.
>
>>
>> Again, the semantics are that it should return the progress of the transfer
>>
>> for which the allocation function returned the cookie that is passe to this
>
> May be my understanding is wrong. For clarification..In the
> snd_dmaengine_pcm_pointer it is subtracting the residue bytes from the
> total buffer bytes not from period bytes. So how it expects
> the progress of the transfer of the passed cookie which just holds period bytes?
>
>>
>> function. You have to consider that there might be multiple different
>> descriptors submitted and in the work list, not just the one we want to know
>
> Even though there are multiple descriptors in the work list, at a time
> only two descriptors are in busy state(as per the documentation in the
> driver) and all the descriptors cookie number is in incremental order.
> Not sure for other cases how it will be.
>
Yes.

Tracing the history ... I think we could have done without

04abf5daf7d  dma: pl330: Differentiate between submitted and issued descriptors

    The pl330 dmaengine driver currently does not differentiate
between submitted
    and issued descriptors. It won't start transferring a newly submitted
    descriptor until issue_pending() is called, but only if it is idle. If it is
    active and a new descriptor is submitted before it goes idle it will happily
    start the newly submitted descriptor once all earlier submitted
descriptors have
    been completed. This is not a 100% correct with regards to the dmaengine
    interface semantics. A descriptor is not supposed to be started
until the next
    issue_pending() call after the descriptor has been submitted.


because the reasoning above seems incorrect considering the following
documentation...

Documentation/crypto/async-tx-api.txt says
  " .... Once a driver-specific threshold is met the driver
automatically issues pending operations.  An application can force this
event by calling async_tx_issue_pending_all(). ...."

And

include/linux/dmaengine.h says
  dma_async_tx_descriptor.tx_submit(): set the prepared descriptor(s)
to be executed by the engine

so theoretically a driver, not starting transfer until
issue_pending(), is "broken".
At best the patch at 04abf5daf7d makes the driver slightly more
complicated and the reason behind confusion such as in this thread.

-jassi
