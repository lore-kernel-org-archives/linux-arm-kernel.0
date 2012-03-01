From: bill4carson@gmail.com (bill4carson)
Date: Thu, 01 Mar 2012 16:44:13 +0800
Subject: [PATCH 7/7] Minor compiling fix
In-Reply-To: <201202291235.04113.arnd@arndb.de>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-8-git-send-email-bill4carson@gmail.com>
 <201202291235.04113.arnd@arndb.de>
Message-ID: <4F4F36DD.3020005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?29? 20:35, Arnd Bergmann wrote:
> On Monday 13 February 2012, Bill Carson wrote:
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -152,9 +152,6 @@ static struct arm_vmregion_head consistent_head = {
>>          .vm_end         = CONSISTENT_END,
>>   };
>>
>> -#ifdef CONFIG_HUGETLB_PAGE
>> -#error ARM Coherent DMA allocator does not (yet) support huge TLB
>> -#endif
>
> This one needs an explanation, too. What has changed that now allows
> dma_alloc_coherent to work with CONFIG_HUGETLB_PAGE set that did not
> work before?
>

AFAIK, __dma_alloc has the finest granularity at 4k page size even when
user requests 1M bytes memory.

but current hugetlb low level set_hugepte_at *ONLY*/*MUST* support 2M 
page mapping, so it can't be used to create huge dma mapping in a more
general way.

comments this error out doesn't mean that it could support huge page dma
mapping now with this patch, just shut up gcc when compiling.

Adding a single low level hook to create 1M page mapping can satisfy
the needs, but apparently that's out of hugetlb scope.
And it's on my TODO list :)



> In general, please add a description with each patch you send, following
> the instructions in Documentation/SubmittingPatches.
>

Thanks, I will follow the rules.

> 	Arnd
>

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
