From: joelf@ti.com (Joel Fernandes)
Date: Fri, 18 Apr 2014 11:22:28 -0500
Subject: [patch 6/6] dma: edma: Provide granular accounting
In-Reply-To: <alpine.DEB.2.02.1404180844330.22697@ionos.tec.linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417143250.066998289@linutronix.de> <535075A9.9040904@ti.com>
 <alpine.DEB.2.02.1404180844330.22697@ionos.tec.linutronix.de>
Message-ID: <53515144.3070905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 04/18/2014 02:03 AM, Thomas Gleixner wrote:
[..]
>>> @@ -645,7 +652,17 @@ static void edma_callback(unsigned ch_nu
>>>  				vchan_cookie_complete(&edesc->vdesc);
>>>  				edma_execute(echan);
>>>  			} else {
>>> +				int i, n;
>>> +
>>>  				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
>>> +
>>> +				/* Update statistics for tx_status */
>>> +				n = edesc->processed;
>>> +				for (i = edesc->processed_stat; i < n; i++)
>>> +					edesc->residue -= edesc->pset[i].len;
>>> +				edesc->processed_stat = n;
>>> +				edesc->residue_stat = edesc->residue;
>>> +
>>
>> This is a bit of a NAK since it is O(n) on every intermediate transfer
>> completion. I'm not sure of a better way to do it but I certainly don't
>> want the IRQ slowed down anymore... Is there a way to pre-calculate the
>> size of the intermediate transfer and store it somewhere for accounting?
> 
> Yeah, I can do that. Adds an extra field to edma_pset, but that
> shouldnt hurt.

Sure, I guess without adding any more space than you initially did
(added a note on len element in the structure below)

then do something like:
 edma_pset[edesc->processed_stat].sum - edema_pset[edesc->proccessed].sum

and subtract that from the residue in O(1).

len element in pset can be got rid off as the same sum can be used to
find it in tx_status by len = pset[i].sum - pset[i-1].sum.

>> Also another thing is I don't think processed_stat is required at all,
>> because I think you introduced it for the possibility that there might
>> be delays in processing interrupts for intermediate transfers. That is
> 
> No, I introduced it to not walk the full list of psets in every
> tx_status() call. It's keeping track of the already finished slots.

Ah, ok. cool.

>> actually an impossibility because such a scenario would result in
>> catastrophic failure anyway. Because for intermediate transfer
>> interrupts shouldn't be missed, so in this case you can just do:
>>
>> for (i = 1; i <= MAX_NR_SG; i++) {
>> 	edesc->residue -= edesc->pset[edesc->processed - i].len;
>> }
>>
>> I think that'll work.
> 
> No. The point is:
> 
> submit()
> 
> tx_status()
> 	
>   We dont want to iterate through all psets when we are polling in a
>   loop. So we progress processed_stat when we see a finished slot.
>   And thereby we adjust edesc->residue.

Ah ok, that's certainly fast to skip all progressive updates and jump to
the current.


>>> +
>>> +		/* Otherwise mark it done and update residue[_stat]. */
>>> +		edesc->processed_stat++;
>>> +		edesc->residue -= pset->len;
>>> +		edesc->residue_stat = edesc->residue;
>>> +	}
>>
>>
>> Also, just curious - doesn't calling status too aggressively result in
>> any slowness for you? Since vchan lock spinlock will be held during the
>> duration of this processing, and interrupts would be disabled causing
>> edma_callback interrupt delays possibly. I'm not saying you introduced
>> the lock or anything because status would previously also hold the lock.
>> I just haven't played status enough to know how it will behave when
>> happening concurrently with DMA transfers.
> 
> Well, in the case I'm looking at (cyclic transfer) I do not care about
> the interrupt at all. I get a notification for the first incoming
> packet via the peripheral and go from there.
> 
> But yes, it might cause slight delays for the interrupt in the SG
> case. Though the irq disabled region is small if you actively poll as
> we keep track of the processed slots and therefor only have one or two
> readouts to process.
> 
> But as Russell pointed out, this should be rewritten by updating the
> chain on the fly and not waiting until MAX_SG has been processed.

Ok, sounds good. Thanks.

regards,
  -Joel
