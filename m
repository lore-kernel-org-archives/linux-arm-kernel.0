From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 21 Jul 2016 12:35:43 +0300
Subject: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
In-Reply-To: <f18ced07-39e4-c336-b788-254c2c130f82@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com> <877fcg25c4.fsf@belgarion.home>
 <f18ced07-39e4-c336-b788-254c2c130f82@ti.com>
Message-ID: <ecc0ef95-bf14-488d-aa72-ae2c70a1b63c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/16 12:33, Peter Ujfalusi wrote:
> On 07/20/16 09:26, Robert Jarzmik wrote:
>> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>>
>>> On 07/18/16 13:34, Russell King - ARM Linux wrote:
>>>> On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
>>>>> Before looking for the next descriptor to start, complete the just finished
>>>>> cookie.
>>>>
>>>> This change will reduce performance as we no longer have an overlap
>>>> between the next request starting to be dealt with in the hardware
>>>> vs the previous request being completed.
>>>
>>> vchan_cookie_complete() will only mark the cookie completed, adds the vd to
>>> the desc_completed list (it was deleted from desc_issued list when it was
>>> started by omap_dma_start_desc) and schedule the tasklet to deal with the real
>>> completion later.
>>> Marking the just finished descriptor/cookie done first then looking for
>>> possible descriptors in the queue to start feels like a better sequence.
>>>
>>> After a quick grep in the kernel source: only omap-dma.c was starting the next
>>> transfer before marking the current completed descriptor/cookie done.
>>
>> Euh actually I think it's done in other drivers as well :
>>  - Documentation/dmaengine/pxa_dma.txt (chapter "Transfers hot-chaining)
>>  - drivers/dma/pxa_dma.c
>>    => look for pxad_try_hotchain() and it's impact on pxad_chan_handler() which
>>    will mark the completion while the next transfer is already pumped by the
>>    hardware.
> 
> The 'hot-chaining' is a bit different then what omap-dma is doing.

s/then/than

> If I got it
> right. When the DMA is running and a new request comes the driver will append
> the new transfer to the list used by the HW. This way there will be no stop
> and restart needed, the DMA is running w/o interruption.
> 
>> Speaking of which, from a purely design point of view, as long as you think
>> beforehand what is your sequence, ie. what is the sequence of your link
>> chaining, completion handling, etc ..., both marking before or after next tx
>> start should be fine IMHO.
> 
> Yes, it might be a bit better from performance point of view if we first start
> the pending descriptor (if there is one) then do the vchan_cookie_complete().
> On the other hand if we care more about latency and accuracy we should
> complete the transfer first then look for pending descriptors. But since
> virt_dma is using a tasklet for the real completion, the latency is always
> going to be when the tasklet is given the chance to execute.
> 
>> So in your quest for the "better sequence" the pxa driver's one might give you
>> some perspective :)
> 
> I did thought about similar 'hot-chaining' for TI's eDMA and sDMA. Especially
> eDMA would benefit from it, but so far I see too many race conditions to
> overcome to be brave enough to write something to test it. and I don't have
> time for it atm ;)
> 


-- 
P?ter
