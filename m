From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 Jul 2018 13:06:50 +0300
Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
In-Reply-To: <20180710055230.GB3219@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
Message-ID: <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 2018-07-10 08:52, Vinod wrote:
> 
> Hey Peter,
> 
> Sorry for late response on this..

No problem, I was away myself also...

> On 01-06-18, 13:24, Peter Ujfalusi wrote:
>> If the DMA supports per descriptor metadata it can implement the attach,
>> get_ptr/set_len callbacks.
>>
>> Client drivers must only use either attach or get_ptr/set_len to avoid
>> miss configuration.
>>
>> Wrappers are also added for the metadata_ops:
>> dmaengine_desc_attach_metadata()
>> dmaengine_desc_get_metadata_ptr()
>> dmaengine_desc_set_metadata_len()
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> since attachments are bouncing back, I send the patch separately
>>
>> Regards,
>> Peter
>>
>>  include/linux/dmaengine.h | 50 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 51fbb861e84b..ac42ace36aa3 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
>>  	dma_addr_t addr[0];
>>  };
>>  
>> +struct dma_async_tx_descriptor;
>> +
>> +struct dma_descriptor_metadata_ops {
>> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
>> +		      size_t len);
> 
> How does one detach?

I have not thought about detach, but clients can just attach NULL I guess.

> When should the client free up the memory, IOW when
> does dma driver drop ref to data.

The metadata is for the descriptor so the DMA driver might want to
access to it while the descriptor is valid.

Typically clients can free up their metadata storage after the dma
completion callback. On DEV_TO_MEM the metadata is going to be placed in
the provided buffer when the transfer is completed.

> 
>> +
>> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
>> +			 size_t *payload_len, size_t *max_len);
> 
> so what is this supposed to do..?

My issue with the attach in general is that it will need additional
memcpy to move the metadata from/to the client buffer to it's place.

With get_ptr the client can get the pointer to the actual place where
the metadata resides and modify/read it in place w/o memcpy.

I know, I know... We need to trust the clients, but with high throughput
peripherals the memcpy is taxing.

> 
>> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
>> +		       size_t payload_len);
> 
> attach already has length, so how does this help?

So, DMA drivers can implement either or both:
1. attach()
2. get_ptr() / set_len()

Clients must not mix the two way of handling the metadata.
The set_len() is intended to tell the DMA driver the client provided
metadata size (in MEM_TO_DEV case mostly).

MEM_TO_DEV flow on client side:
get_ptr()
fill in the metadata to the pointer (not exceeding max_len)
set_len() to tell the DMA driver the amount of valid bytes written

DEV_TO_MEM flow on client side:
In the completion callback, get_ptr()
the metadata is payload_len bytes and can be accessed in the return pointer.


BTW: The driver which is going to need this is now accessible in public:
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti

or in my wip tree:
https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti

prefixed with k3-*

> 
>> +};
>> +
>>  /**
>>   * struct dma_async_tx_descriptor - async transaction descriptor
>>   * ---dma generic offload fields---
>> @@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
>>  	dma_async_tx_callback_result callback_result;
>>  	void *callback_param;
>>  	struct dmaengine_unmap_data *unmap;
>> +	struct dma_descriptor_metadata_ops *metadata_ops;
>>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>  	struct dma_async_tx_descriptor *next;
>>  	struct dma_async_tx_descriptor *parent;
>> @@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>>  						    len, flags);
>>  }
>>  
>> +static inline int dmaengine_desc_attach_metadata(
>> +		struct dma_async_tx_descriptor *desc, void *data, size_t len)
>> +{
>> +	if (!desc)
>> +		return 0;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->attach(desc, data, len);
>> +}
>> +
>> +static inline void *dmaengine_desc_get_metadata_ptr(
>> +		struct dma_async_tx_descriptor *desc, size_t *payload_len,
>> +		size_t *max_len)
>> +{
>> +	if (!desc)
>> +		return NULL;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
>> +		return ERR_PTR(-ENOTSUPP);
>> +
>> +	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
>> +}
>> +
>> +static inline int dmaengine_desc_set_metadata_len(
>> +		struct dma_async_tx_descriptor *desc, size_t payload_len)
>> +{
>> +	if (!desc)
>> +		return 0;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->set_len(desc, payload_len);
>> +}
>> +
>>  /**
>>   * dmaengine_terminate_all() - Terminate all active DMA transfers
>>   * @chan: The channel for which to terminate the transfers
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
