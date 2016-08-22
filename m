From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 22 Aug 2016 12:19:04 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160720091939.GA25890@e104818-lin.cambridge.arm.com>
References: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
 <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
 <577F1FD9.1040205@huawei.com>
 <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
 <577FC5AA.5010709@huawei.com>
 <20160708161347.GC22099@e104818-lin.cambridge.arm.com>
 <57839474.6030203@huawei.com>
 <20160712153535.GH22183@e104818-lin.cambridge.arm.com>
 <578EE603.9020206@huawei.com>
 <20160720091939.GA25890@e104818-lin.cambridge.arm.com>
Message-ID: <57BA7D38.8030103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/7/20 17:19, Catalin Marinas wrote:
> On Wed, Jul 20, 2016 at 10:46:27AM +0800, Leizhen (ThunderTown) wrote:
>>>>>> On 2016/7/8 21:54, Catalin Marinas wrote:
>>>>>>> ------------8<----------------
>>>>>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
>>>>>>> index dbd12ea8ce68..c753fa804165 100644
>>>>>>> --- a/arch/arm64/mm/flush.c
>>>>>>> +++ b/arch/arm64/mm/flush.c
>>>>>>> @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>>>>>>>  	if (!page_mapping(page))
>>>>>>>  		return;
>>>>>>>  
>>>>>>> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>>>>>> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
>>>>>>> +	    PageDirty(page))
>>>>>>>  		sync_icache_aliases(page_address(page),
>>>>>>>  				    PAGE_SIZE << compound_order(page));
>>>>>>>  	else if (icache_is_aivivt())
>>>>>>> ----------------8<---------------------
>>
>> Do you plan to send this patch? My colleagues told me that if our
>> patches are quite different, it should be Signed-off-by you.
> 
> The reason I'm not sending it is that I don't fully understand how it
> solves the problem for a shared file mmap(), not just hugetlbfs. As I
> said in an earlier email: after an msync() in user space we
> should flush the pages to disk via write_cache_pages(). This function
Hi Catalin:
   I'm so sorry for my fault. The previous small pages test result I actually ran on ramfs.
Today, I ran the case on harddisk fs, it worked well without this patch.

Summarized as follows:
small pages on ramfs: need this patch
small pages on harddisk fs: no need this patch
hugetlbfs: need this patch



> calls clear_page_dirty_for_io() after which PageDirty() is no longer
> true. I can't tell how a subsequent mmap() can see the written pages as
> dirty.
> 
>> I searched all Linux source code, __sync_icache_dcache is only called
>> by set_pte_at, and some check conditions(especially pte_exec) will
>> limit its impact.
>>
>> 	if (pte_user(pte) && pte_exec(pte) && !pte_special(pte))
>> 		__sync_icache_dcache(pte, addr);
> 
> Yes, and set_pte_at() would be called as a result of a page fault when
> accessing the mmap'ed file.
> 
