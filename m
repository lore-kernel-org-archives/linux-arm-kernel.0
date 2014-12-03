From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 3 Dec 2014 10:17:54 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <547DF61D.3010909@metafoo.de>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
Message-ID: <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

[snip]
>>> +
>>> +	ret = dma_cookie_status(chan, cookie, txstate);
>>> +	if (ret == DMA_COMPLETE || !txstate)
>>> +		return ret;
>>> +
>>> +	used = txstate->used;
>>> +
>>> +	spin_lock_irqsave(&pch->lock, flags);
>>> +	sar = readl(regs + SA(thrd->id));
>>> +	dar = readl(regs + DA(thrd->id));
>>> +
>>> +	list_for_each_entry(desc, &pch->work_list, node) {
>>> +		if (desc->status == BUSY) {
>>> +			current_c = desc->txd.cookie;
>>> +			if (first) {
>>> +				first_c = desc->txd.cookie;
>>> +				first = false;
>>> +			}
>>> +
>>> +			if (first_c < current_c)
>>> +				residue += desc->px.bytes;
>>> +			else {
>>> +				if (desc->rqcfg.src_inc && pl330_src_addr_in_desc(desc, sar)) {
>>> +					residue += desc->px.bytes;
>>> +					residue -= sar - desc->px.src_addr;
>>> +				} else if (desc->rqcfg.dst_inc && pl330_dst_addr_in_desc(desc, dar))
>>> {
>>> +					residue += desc->px.bytes;
>>> +					residue -= dar - desc->px.dst_addr;
>>> +				}
>>> +			}
>>> +		} else if (desc->status == PREP)
>>> +			residue += desc->px.bytes;
>>> +
>>> +		if (desc->txd.cookie == used)
>>> +			break;
>>> +	}
>>> +	spin_unlock_irqrestore(&pch->lock, flags);
>>> +	dma_set_residue(txstate, residue);
>>> +	return ret;
>>>   }
[snip]
>>
>> Any comment on this patch?
>
> Well it doesn't break audio, but I don't think it has the correct haviour
> for all cases yet.

OK. Any way of testing other cases like scatter-gather and memcopy.  I
verified memcopy in dmatest but it seems not doing anything with
residue bytes.

>
> Again, the semantics are that it should return the progress of the transfer
>
> for which the allocation function returned the cookie that is passe to this

May be my understanding is wrong. For clarification..In the
snd_dmaengine_pcm_pointer it is subtracting the residue bytes from the
total buffer bytes not from period bytes. So how it expects
the progress of the transfer of the passed cookie which just holds period bytes?

>
> function. You have to consider that there might be multiple different
> descriptors submitted and in the work list, not just the one we want to know

Even though there are multiple descriptors in the work list, at a time
only two descriptors are in busy state(as per the documentation in the
driver) and all the descriptors cookie number is in incremental order.
Not sure for other cases how it will be.

>
> the status of. The big problem with the pl330 driver is that the current
> structure of the driver makes it not so easy to implement the residue
> reporting correctly.
>
> - Lars

Thanks
Padma
>
>
