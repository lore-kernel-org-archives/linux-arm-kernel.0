From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 2 Dec 2015 14:04:05 -0500
Subject: [PATCH V7 3/3] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <565E0E1D.1040505@codeaurora.org>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-4-git-send-email-okaya@codeaurora.org>
 <20151130085948.GC3901@localhost> <565CAC4C.7080909@codeaurora.org>
 <20151201113458.GL3901@localhost> <565E0E1D.1040505@codeaurora.org>
Message-ID: <565F40A5.2040701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/1/2015 4:16 PM, Sinan Kaya wrote:
>>>> >>>
>>>>> >>>> +static enum dma_status hidma_tx_status(struct dma_chan *dmach,
>>>>> >>>> +			dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>>> >>>> +{
>>>>> >>>> +	struct hidma_chan *mchan = to_hidma_chan(dmach);
>>>>> >>>> +	enum dma_status ret;
>>>>> >>>> +
>>>>> >>>> +	if (mchan->paused)
>>>>> >>>> +		ret = DMA_PAUSED;
>>>> >>>
>>>> >>> This is not quite right. The status query is for a descriptor and NOT for
>>>> >>> channel. Here if the descriptor queried was running then it would be paused
>>>> >>> for the rest pending txn, it would be DMA_IN_PROGRESS.
>>> >>
>>> >> The channel can be paused by the hypervisor. If it is paused, then no
>>> >> other transaction will go through including the pending requests. That's
>>> >> why, I'm checking the state first.
>> > 
>> > You are missing the point. Channel can be paused, yes but the descriptor
>> > is in queue and is not paused. The descriptor running is paused, yes.
>> > There is subtle difference between these
> I'll follow your recommendation. PAUSE for the currently active
> descriptor and DMA_IN_PROGRESS for the rest.
> 

I'm now confused.

I looked at several DMA driver implementations.

1. They call dma_cookie_status function to see if the job is done.
2. If done, they return right ahead.
3. Otherwise, dma_cookie_status returns DMA_IN_PROGRESS.
4. Next the code checks if the channel is paused and return value is
DMA_IN_PROGRESS. The code changes return code to DMA_PAUSED.

Whereas, I was returning paused first before even checking if the
descriptor is done. Are you OK with the sequence 1..4 above?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
