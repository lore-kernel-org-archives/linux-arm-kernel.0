From: zhangyanfei@cn.fujitsu.com (Zhang Yanfei)
Date: Thu, 12 Jun 2014 16:19:02 +0800
Subject: [PATCH v2 02/10] DMA, CMA: fix possible memory leak
In-Reply-To: <20140612060211.GC30128@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612052543.GE12415@bbox> <20140612060211.GC30128@js1304-P5Q-DELUXE>
Message-ID: <53996276.20906@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2014 02:02 PM, Joonsoo Kim wrote:
> On Thu, Jun 12, 2014 at 02:25:43PM +0900, Minchan Kim wrote:
>> On Thu, Jun 12, 2014 at 12:21:39PM +0900, Joonsoo Kim wrote:
>>> We should free memory for bitmap when we find zone mis-match,
>>> otherwise this memory will leak.
>>
>> Then, -stable stuff?
> 
> I don't think so. This is just possible leak candidate, so we don't
> need to push this to stable tree.
> 
>>
>>>
>>> Additionally, I copy code comment from ppc kvm's cma code to notify
>>> why we need to check zone mis-match.
>>>
>>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>
>>> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
>>> index bd0bb81..fb0cdce 100644
>>> --- a/drivers/base/dma-contiguous.c
>>> +++ b/drivers/base/dma-contiguous.c
>>> @@ -177,14 +177,24 @@ static int __init cma_activate_area(struct cma *cma)
>>>  		base_pfn = pfn;
>>>  		for (j = pageblock_nr_pages; j; --j, pfn++) {
>>>  			WARN_ON_ONCE(!pfn_valid(pfn));
>>> +			/*
>>> +			 * alloc_contig_range requires the pfn range
>>> +			 * specified to be in the same zone. Make this
>>> +			 * simple by forcing the entire CMA resv range
>>> +			 * to be in the same zone.
>>> +			 */
>>>  			if (page_zone(pfn_to_page(pfn)) != zone)
>>> -				return -EINVAL;
>>> +				goto err;
>>
>> At a first glance, I thought it would be better to handle such error
>> before activating.
>> So when I see the registration code(ie, dma_contiguous_revere_area),
>> I realized it is impossible because we didn't set up zone yet. :(
>>
>> If so, when we detect to fail here, it would be better to report more
>> meaningful error message like what was successful zone and what is
>> new zone and failed pfn number?
> 
> What I want to do in early phase of this patchset is to make cma code
> on DMA APIs similar to ppc kvm's cma code. ppc kvm's cma code already
> has this error handling logic, so I make this patch.
> 
> If we think that we need more things, we can do that on general cma code
> after merging this patchset.
> 

Yeah, I also like the idea. After all, this patchset aims to a general CMA
management, we could improve more after this patchset. So

Acked-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

-- 
Thanks.
Zhang Yanfei
