From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 26 May 2016 19:46:11 +0800
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <20160525105022.GC5996@e104818-lin.cambridge.arm.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
 <20160524130255.GU4892@e104818-lin.cambridge.arm.com>
 <5744FDD0.8060504@huawei.com> <57451DC6.7080106@huawei.com>
 <20160525105022.GC5996@e104818-lin.cambridge.arm.com>
Message-ID: <5746E203.4000906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/25 18:50, Catalin Marinas wrote:
> On Wed, May 25, 2016 at 11:36:38AM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/5/25 9:20, Leizhen (ThunderTown) wrote:
>>> On 2016/5/24 21:02, Catalin Marinas wrote:
>>>> On Tue, May 24, 2016 at 08:19:05PM +0800, Leizhen (ThunderTown) wrote:
>>>>> On 2016/5/24 19:37, Mark Rutland wrote:
>>>>>> It looks like the test may be missing I-cache maintenance regardless of
>>>>>> the semantics of mprotect in this case.
>>>>>>
>>>>>> I have not yet devled into flush_cache_range and how it is called.
>>>>>
>>>>> SYSCALL_DEFINE3(mprotect ---> mprotect_fixup ---> change_protection ---> change_protection_range --> flush_cache_range
>>>>
>>>> The change_protection() shouldn't need to flush the caches in
>>>> flush_cache_range(). The change_pte_range() function eventually ends up
>>>> calling set_pte_at() which calls __sync_icache_dcache() if the mapping
>>>> is executable.
>>>
>>> OK, I see.
>>> But I'm afraid it entered the "if (pte_present(oldpte))" branch in
>>> function change_pte_range. Because the test case called mmap to
>>> create pte first, then called pte_modify. I will check it later.
>>
>> I have checked that it entered "if (pte_present(oldpte))" branch.
> 
> This path eventually calls set_pte_at() via ptep_modify_prot_commit().
> 
>> But I don't known why I add flush_icache_range is OK, but add
>> __sync_icache_dcache have no effect.
> 
> Do you mean you modified set_pte_at() to use flush_icache_range()
> instead of __sync_icache_dcache() and it works?
> 
> What happens is that __sync_icache_dcache() only takes care of the first
> time a page is mapped in user space and flushes the caches, marking it
> as "clean" (PG_dcache_clean) afterwards. Subsequent changes to this

Hi,
As my tracing, it is returned by "if (!page_mapping(page))", because "mmap" are anonymous pages. I commented below code lines, it works well.
	
	/* no flushing needed for anonymous pages */
	if (!page_mapping(page))
		return;


I printed the page information three times, as below:
page->mapping=ffff8017baf36961, page->flags=0x1000000000040048
page->mapping=ffff8017b265bf51, page->flags=0x1000000000040048
page->mapping=ffff8017b94fc5a1, page->flags=0x1000000000040048

PG_slab=7, PG_arch_1=9, PG_swapcache=15

> mapping or writes to it are entirely the responsibility of the user. So
> if the user plans to execute instructions, it better explicitly flush
> the caches (as Mark Rutland already stated in a previous reply).
> 
> I ran our internal LTP version yesterday and it was fine but didn't
> realise that we actually patched mprotect04.c to include:
> 
> 	__clear_cache((char *)func, (char *)func + page_sz);
> 
> just after memcpy().
> 
> (we still need to investigate whether the I-cache invalidation is
> actually needed in flush_cache_range() or it's just something we forgot
> to remove)
> 
