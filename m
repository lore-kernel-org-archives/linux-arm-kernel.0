From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 25 Aug 2016 19:27:47 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160825093054.GB20748@e104818-lin.cambridge.arm.com>
References: <20160708161347.GC22099@e104818-lin.cambridge.arm.com>
 <57839474.6030203@huawei.com>
 <20160712153535.GH22183@e104818-lin.cambridge.arm.com>
 <578EE603.9020206@huawei.com>
 <20160720091939.GA25890@e104818-lin.cambridge.arm.com>
 <57BA7D38.8030103@huawei.com>
 <20160823172852.GB16213@e104818-lin.cambridge.arm.com>
 <57BD6242.1080801@huawei.com>
 <20160824103044.GA11504@e104818-lin.cambridge.arm.com>
 <57BE4D02.1040906@huawei.com>
 <20160825093054.GB20748@e104818-lin.cambridge.arm.com>
Message-ID: <57BED633.1060802@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/25 17:30, Catalin Marinas wrote:
> On Thu, Aug 25, 2016 at 09:42:26AM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/8/24 18:30, Catalin Marinas wrote:
>>>>>>>>>>>> On 2016/7/8 21:54, Catalin Marinas wrote:
>>>>>>>>>>>>> ------------8<----------------
>>>>>>>>>>>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
>>>>>>>>>>>>> index dbd12ea8ce68..c753fa804165 100644
>>>>>>>>>>>>> --- a/arch/arm64/mm/flush.c
>>>>>>>>>>>>> +++ b/arch/arm64/mm/flush.c
>>>>>>>>>>>>> @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>>>>>>>>>>>>>  	if (!page_mapping(page))
>>>>>>>>>>>>>  		return;
>>>>>>>>>>>>>  
>>>>>>>>>>>>> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>>>>>>>>>>>> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
>>>>>>>>>>>>> +	    PageDirty(page))
>>>>>>>>>>>>>  		sync_icache_aliases(page_address(page),
>>>>>>>>>>>>>  				    PAGE_SIZE << compound_order(page));
>>>>>>>>>>>>>  	else if (icache_is_aivivt())
>>>>>>>>>>>>> ----------------8<---------------------
> [...]
>>> While we indeed see failures on multiple filesystem types, I wonder
>>> whether this test case is actually expected to work. If I modify the
>>> test to pass O_TRUNC to open(), I can no longer see failures. So any
>>> standard tool that copies/creates executable files (gcc, dpkg, cp, rsync
>>> etc.) wouldn't encounter such issues since they truncate the original
>>> file and old page cache pages would be removed.
>>>
>>> Do you have a real use-case where a task mmap's an executable file,
>>> modifies it in place and expects another task to see the new
>>> instructions without user-space cache maintenance?
>>
>> No, it's just a test case created by testers.
> 
> In this case I propose we ignore this patch and you adjust the test to
> use O_TRUNC, at least until we find a real scenario where this would
> matter.
OK, thanks. We currently add __clear_cache in user space.

> 
