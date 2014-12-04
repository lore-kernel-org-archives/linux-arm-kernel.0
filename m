From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 04 Dec 2014 21:15:09 +0100
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>	<CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>	<547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
Message-ID: <5480C0CD.8050207@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2014 05:47 AM, Padma Venkat wrote:
> Hi Lars,
>
> [snip]
>>>> +
>>>> +	ret = dma_cookie_status(chan, cookie, txstate);
>>>> +	if (ret == DMA_COMPLETE || !txstate)
>>>> +		return ret;
>>>> +
>>>> +	used = txstate->used;
>>>> +
>>>> +	spin_lock_irqsave(&pch->lock, flags);
>>>> +	sar = readl(regs + SA(thrd->id));
>>>> +	dar = readl(regs + DA(thrd->id));
>>>> +
>>>> +	list_for_each_entry(desc, &pch->work_list, node) {
>>>> +		if (desc->status == BUSY) {
>>>> +			current_c = desc->txd.cookie;
>>>> +			if (first) {
>>>> +				first_c = desc->txd.cookie;
>>>> +				first = false;
>>>> +			}
>>>> +
>>>> +			if (first_c < current_c)
>>>> +				residue += desc->px.bytes;
>>>> +			else {
>>>> +				if (desc->rqcfg.src_inc && pl330_src_addr_in_desc(desc, sar)) {
>>>> +					residue += desc->px.bytes;
>>>> +					residue -= sar - desc->px.src_addr;
>>>> +				} else if (desc->rqcfg.dst_inc && pl330_dst_addr_in_desc(desc, dar))
>>>> {
>>>> +					residue += desc->px.bytes;
>>>> +					residue -= dar - desc->px.dst_addr;
>>>> +				}
>>>> +			}
>>>> +		} else if (desc->status == PREP)
>>>> +			residue += desc->px.bytes;
>>>> +
>>>> +		if (desc->txd.cookie == used)
>>>> +			break;
>>>> +	}
>>>> +	spin_unlock_irqrestore(&pch->lock, flags);
>>>> +	dma_set_residue(txstate, residue);
>>>> +	return ret;
>>>>    }
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

E.g. I think your current patch fails if more than one transfer has been 
submitted. In that case you'll count the bytes for all of them rather than 
just the one requested.

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

The issue that makes implementing this correctly for the pl330 driver 
complicated is that the driver allocates one cookie per segment/period, but 
the external API works with one cookie per transfer. All those cookies that 
are assigned to the segments/periods that are not the first in a transfer 
are not externally visible.

dmaengine_prep_slave_sg() and friends create a transfer and return 
descriptor for this transfer with a single cookie. If that cookie is passed 
to dmaengine_tx_status() the function is supposed to report the progress on 
that one transfer that was previously allocated and returned that cookie 
number. residue is the total number of bytes that are still left to to be 
processed for that transfer.

I've started reworking the pl330 driver to only have a single cookie per 
transfer, instead of one per period/segment. This makes implementing the 
residue reporting a lot easier. I never finished that work though, but I can 
try to see if I can revive it next week.

- Lars
