From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 20 Jul 2016 10:46:27 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160712153535.GH22183@e104818-lin.cambridge.arm.com>
References: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
 <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
 <577F1FD9.1040205@huawei.com>
 <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
 <577FC5AA.5010709@huawei.com>
 <20160708161347.GC22099@e104818-lin.cambridge.arm.com>
 <57839474.6030203@huawei.com>
 <20160712153535.GH22183@e104818-lin.cambridge.arm.com>
Message-ID: <578EE603.9020206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/7/12 23:35, Catalin Marinas wrote:
> On Mon, Jul 11, 2016 at 08:43:32PM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/7/9 0:13, Catalin Marinas wrote:
>>> On Fri, Jul 08, 2016 at 11:24:26PM +0800, Leizhen (ThunderTown) wrote:
>>>> On 2016/7/8 21:54, Catalin Marinas wrote:
>>>>> ------------8<----------------
>>>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
>>>>> index dbd12ea8ce68..c753fa804165 100644
>>>>> --- a/arch/arm64/mm/flush.c
>>>>> +++ b/arch/arm64/mm/flush.c
>>>>> @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>>>>>  	if (!page_mapping(page))
>>>>>  		return;
>>>>>  
>>>>> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>>>> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
>>>>> +	    PageDirty(page))
>>>>>  		sync_icache_aliases(page_address(page),
>>>>>  				    PAGE_SIZE << compound_order(page));
>>>>>  	else if (icache_is_aivivt())
>>>>> ----------------8<---------------------
Hi, Catalin:
  Do you plan to send this patch? My colleagues told me that if our patches are quite
different, it should be Signed-off-by you.

  I searched all Linux source code, __sync_icache_dcache is only called by set_pte_at,
and some check conditions(especially pte_exec) will limit its impact.

	if (pte_user(pte) && pte_exec(pte) && !pte_special(pte))
		__sync_icache_dcache(pte, addr);

>>>>>
>>>>> BTW, can you make your tests (source) available somewhere?
>>>>
>>>> Both cases worked well with this patch.
>>>
>>> Now I'm even more confused ;). IIUC, after an msync() in user space we
>>> should flush the pages to disk via write_cache_pages(). This function
>>> calls clear_page_dirty_for_io() after which PageDirty() is no longer
>>> true. I can't tell how a subsequent mmap() can see the written pages as
>>> dirty.
>>
>> As my tracing, both cases invoked empty function.
>>
>> int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
>> 	......
>> 	return file->f_op->fsync(file, start, end, datasync);
>> }
>>
>> const struct file_operations hugetlbfs_file_operations = {
>> 	.fsync			= noop_fsync,
>>
>> static const struct file_operations shmem_file_operations = {
>> 	.mmap		= shmem_mmap,
>> #ifdef CONFIG_TMPFS
>> 	.fsync		= noop_fsync,
> 
> I was referring to standard filesystem (e.g. ext4) writes where, IIUC,
> the PageDirty() status is cleared after I/O but it's not necessarily
> removed from the page cache.
> 
