From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 04 Aug 2014 20:03:45 +0200
Subject: DMA engine API issue
In-Reply-To: <1621896.RqTTnmY7rK@avalon>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon> <20140801170744.GD8181@intel.com>
 <1621896.RqTTnmY7rK@avalon>
Message-ID: <53DFCB01.5050703@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2014 06:50 PM, Laurent Pinchart wrote:
[...]
>>>> from atomic context too.
>>>
>>> I'll take this opportunity to question why we have a separation between
>>> tx_submit and issue_pending. What's the rationale for that, especially
>>> given that dma_issue_pending_all() might kick in at any point and issue
>>> pending transfers for all devices. A driver could thus see its submitted
>>> but not issued transactions being issued before it explicitly calls
>>> dma_async_issue_pending().
>>
>> The  API states that you need to get a channel, then prepare a descriptor
>> and submit it back. Prepare can be in any order. The submit order is the one
>> which is run on dmaengine. The submit marks the descriptor as pending.
>> Typically you should have a pending_list which the descriptor should be
>> pushed to.
>>
>> And lastly invoke dma_async_issue_pending() to start the pending ones.
>>
>> You have the flexibility to prepare descriptors and issue in the order you
>> like. You can also attach the callback required for descriptors here.
>
> The question was why is there a dma_async_issue_pending() operation at all ?
> Why can't dmaengine_submit() triggers the transfer start ? The only
> explanation is a small comment in dmaengine.h that states
>
>   * This allows drivers to push copies to HW in batches,
>   * reducing MMIO writes where possible.
>
> I don't think that's applicable for DMA slave transfers. Is it still
> applicable for anything else ?
[...]

If the hardware has scatter gather support it allows the driver to chain the 
descriptors before submitting them, which reduces the latency between the 
transfers as well as the IO over overhead. The flaw with the current 
implementation is that there is only one global chain per channel instead of 
e.g. having the possibility to build up a chain in a driver and then submit and 
start the chain. Some drivers have virtual channels where each channel 
basically acts as the chain and once issue pending is called it is the chain is 
mapped to a real channel which then executes it.

- Lars
