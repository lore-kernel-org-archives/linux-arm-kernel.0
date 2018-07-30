From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 30 Jul 2018 12:46:14 +0300
Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
In-Reply-To: <20180724111425.GK3219@vkoul-mobl>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
 <20180719092224.GK3219@vkoul-mobl>
 <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
 <20180724111425.GK3219@vkoul-mobl>
Message-ID: <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On 2018-07-24 14:14, Vinod wrote:
>>>> Clients must not mix the two way of handling the metadata.
>>>> The set_len() is intended to tell the DMA driver the client provided
>>>> metadata size (in MEM_TO_DEV case mostly).
>>>>
>>>> MEM_TO_DEV flow on client side:
>>>> get_ptr()
>>>> fill in the metadata to the pointer (not exceeding max_len)
>>>> set_len() to tell the DMA driver the amount of valid bytes written
>>>>
>>>> DEV_TO_MEM flow on client side:
>>>> In the completion callback, get_ptr()
>>>> the metadata is payload_len bytes and can be accessed in the return pointer.
>>>
>>> I would think to unify this..
>>
>> I have tried it, but the attach mode and the pointer mode is hard to
>> handle with a generic API.
>> I will try to find a way to unify things in a sane way.
> 
> Hmmm, looking from the description they will be for different methods,
> so lets make them orthogonal and not allow driver to register both.

I would allow DMA drivers to register both, but somehow enforce that
clients are not mixing the two distinct way of dealing with the metadata.

The reason for that is for example the attach mode is the simplest (I
implemented it first and I have a client using it), but if the pointer
mode is found to be more efficient and feasible for the DMA then the DMA
driver can implement that mode and the client can move as well w/o
breaking anything.

> 
>>
>> I have moved the metadata_ops to dma_async_tx_descriptor to emphasize
>> that it is per descriptor setting:
>> https://github.com/omap-audio/linux-audio/commit/02e095d1320a4bb3ae281ddb208ce82ead746f00#diff-92c0a79f414dc3be9dfc67a969c0dd71
>>
>>
>>>> BTW: The driver which is going to need this is now accessible in public:
>>>> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
>>>>
>>>> or in my wip tree:
>>>> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
>>>>
>>>> prefixed with k3-*
>>>>
>>
>> - P?ter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
