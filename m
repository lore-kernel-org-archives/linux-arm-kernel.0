From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 20 Jul 2018 21:33:55 +0800
Subject: [SPAM]Re: [PATCH] net: mediatek: use dma_zalloc_coherent instead
 of allocator/memset
In-Reply-To: <20180720081334.GO17271@n2100.armlinux.org.uk>
References: <20180719140955.19444-1-yuehaibing@huawei.com>
 <20180719141723.GM17271@n2100.armlinux.org.uk>
 <1532019744.8953.248.camel@mtkswgap22>
 <9a4cdfc6-7487-5908-b584-f3bf6158c4d4@huawei.com>
 <20180720081334.GO17271@n2100.armlinux.org.uk>
Message-ID: <a8dfe467-9649-ca48-20e9-38041de6a404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/7/20 16:13, Russell King - ARM Linux wrote:
> On Fri, Jul 20, 2018 at 02:30:53PM +0800, YueHaibing wrote:
>> On 2018/7/20 1:02, Sean Wang wrote:
>>> On Thu, 2018-07-19 at 15:17 +0100, Russell King - ARM Linux wrote:
>>>> On Thu, Jul 19, 2018 at 10:09:55PM +0800, YueHaibing wrote:
>>>>> Use dma_zalloc_coherent instead of dma_alloc_coherent
>>>>> followed by memset 0.
>>>>>
>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>> ---
>>>>>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
>>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>> index d8ebf0a..fbdb3e3 100644
>>>>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>> @@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
>>>>>  	if (!ring->buf)
>>>>>  		goto no_tx_mem;
>>>>>  
>>>>> -	ring->dma = dma_alloc_coherent(eth->dev,
>>>>> -					  MTK_DMA_SIZE * sz,
>>>>> -					  &ring->phys,
>>>>> -					  GFP_ATOMIC | __GFP_ZERO);
>>>>> +	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
>>>>> +					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
>>>>>  	if (!ring->dma)
>>>>>  		goto no_tx_mem;
>>>>>  
>>>>> -	memset(ring->dma, 0, MTK_DMA_SIZE * sz);
>>>>
>>>> I have to wonder whether this code needs two forms of zeroing... in
>>>> the original code, __GFP_ZERO _and_ a call to memset() just in case
>>>> __GFP_ZERO failed to do its job, and in the replacement code, just
>>>> in case dma_zalloc_coherent() hasn't got the idea...
>>>>
>>>> I think you can drop the __GFP_ZERO. ;)
>>>>
>>>
>>> Just now I did an experiment on 4.14.56 on armv7. I found that
>>> dma_zalloc_coherent does not guarantee that the buffer we get
>>> is all filled with 0.
>>>
>>>
>>> I really think it's a little bit weird OR what was I missing something
>>> for enabling dma_zalloc_coherent ? The result seems to tell that we
>>> can't remove freely the memset with 0 at this moment until we get a
>>> cause.
>>>
>>
>> That means dma_zalloc_coherent doesn't work as expect on armv7?
> 
> Can someone work out which underlying allocator is being used - the
> possibilities are:
> 
> - dma_alloc_from_dev_coherent
> - cma
> - simple
> - remap
> - pool
> 
> Looking at the code, I'd guess it's the pool allocator, as I don't see
> anything which zeros memory there, and it doesn't honor the __GFP_ZERO
> flag.  This is definitely an allocator bug.
> 

Sean,

can you test bellow patch?


diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index be0fa7e..52029bb 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -564,6 +564,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)

*ret_page = phys_to_page(phys);
ptr = (void *)val;
+ memset(ptr, 0, size);
}
