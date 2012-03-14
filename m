From: kumarrav@codeaurora.org (Ravi Kumar V)
Date: Wed, 14 Mar 2012 14:48:40 +0530
Subject: [PATCH v3 1/2] dmaengine: Add support for per xfer specific
 privatedata
In-Reply-To: <1331569796.1727.9.camel@vkoul-udesk3>
References: <1331548336-27802-1-git-send-email-kumarrav@codeaurora.org>
 <1331569796.1727.9.camel@vkoul-udesk3>
Message-ID: <4F606270.1020709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/12/2012 9:59 PM, Vinod Koul wrote:
> On Mon, 2012-03-12 at 16:02 +0530, Ravi Kumar V wrote:
>> Add new argument to DMA SG and Interleave mode for passing
>> per transfer specific private data, using this it enables the
>> dma devices which needs to pass the parameters which changes per
>> each transfer.
>>
>> Signed-off-by: Ravi Kumar V<kumarrav@codeaurora.org>
>> ---
>>   include/linux/dmaengine.h |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 679b349..b8f0495 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -570,7 +570,7 @@ struct dma_device {
>>   		struct dma_chan *chan,
>>   		struct scatterlist *dst_sg, unsigned int dst_nents,
>>   		struct scatterlist *src_sg, unsigned int src_nents,
>> -		unsigned long flags);
>> +		unsigned long flags, void *context);
> Please follow the related discussion we had. Alexandre had already
> posted updated and this needs to follow.
> Also this way you break the existing drivers which use this API, not
> sure why you posted without fixing them?
>
I have gone through the discussion in
https://lkml.org/lkml/2012/2/6/300
As per my understanding
1.we need to add new transaction types DMA_SG_EXT & DMA_INTERLEAVE_EXT.
2.Add context parameter to existing API's.
3.Typecast the context parameter with architecture specific structure 
there by restricting client drivers to pass only arch specific parameter.
4.Fix existing code and client drivers for using new API.

My suggestion is instead of adding context parameter in existing API's, 
how it would be if we can add a new API for each DMA transaction types 
available in dmaengine for passing transaction specific parameter?
so that existing clients and dma drivers will not be disturbed.

>>   	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>>   		struct dma_chan *chan, struct scatterlist *sgl,
>> @@ -581,7 +581,7 @@ struct dma_device {
>>   		size_t period_len, enum dma_transfer_direction direction);
>>   	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
>>   		struct dma_chan *chan, struct dma_interleaved_template *xt,
>> -		unsigned long flags);
>> +		unsigned long flags, void *context);
>>   	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>>   		unsigned long arg);
>>
>
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
