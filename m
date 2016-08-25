From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 25 Aug 2016 09:42:26 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160824103044.GA11504@e104818-lin.cambridge.arm.com>
References: <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
 <577FC5AA.5010709@huawei.com>
 <20160708161347.GC22099@e104818-lin.cambridge.arm.com>
 <57839474.6030203@huawei.com>
 <20160712153535.GH22183@e104818-lin.cambridge.arm.com>
 <578EE603.9020206@huawei.com>
 <20160720091939.GA25890@e104818-lin.cambridge.arm.com>
 <57BA7D38.8030103@huawei.com>
 <20160823172852.GB16213@e104818-lin.cambridge.arm.com>
 <57BD6242.1080801@huawei.com>
 <20160824103044.GA11504@e104818-lin.cambridge.arm.com>
Message-ID: <57BE4D02.1040906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/24 18:30, Catalin Marinas wrote:
> On Wed, Aug 24, 2016 at 05:00:50PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2016/8/24 1:28, Catalin Marinas wrote:
>>> On Mon, Aug 22, 2016 at 12:19:04PM +0800, Leizhen (ThunderTown) wrote:
>>>> On 2016/7/20 17:19, Catalin Marinas wrote:
>>>>> On Wed, Jul 20, 2016 at 10:46:27AM +0800, Leizhen (ThunderTown) wrote:
>>>>>>>>>> On 2016/7/8 21:54, Catalin Marinas wrote:
>>>>>>>>>>> ------------8<----------------
>>>>>>>>>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
>>>>>>>>>>> index dbd12ea8ce68..c753fa804165 100644
>>>>>>>>>>> --- a/arch/arm64/mm/flush.c
>>>>>>>>>>> +++ b/arch/arm64/mm/flush.c
>>>>>>>>>>> @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>>>>>>>>>>>  	if (!page_mapping(page))
>>>>>>>>>>>  		return;
>>>>>>>>>>>  
>>>>>>>>>>> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>>>>>>>>>> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
>>>>>>>>>>> +	    PageDirty(page))
>>>>>>>>>>>  		sync_icache_aliases(page_address(page),
>>>>>>>>>>>  				    PAGE_SIZE << compound_order(page));
>>>>>>>>>>>  	else if (icache_is_aivivt())
>>>>>>>>>>> ----------------8<---------------------
>>>>>>
>>>>>> Do you plan to send this patch? My colleagues told me that if our
>>>>>> patches are quite different, it should be Signed-off-by you.
>>>>>
>>>>> The reason I'm not sending it is that I don't fully understand how it
>>>>> solves the problem for a shared file mmap(), not just hugetlbfs. As I
>>>>> said in an earlier email: after an msync() in user space we
>>>>> should flush the pages to disk via write_cache_pages(). This function
>>>> Hi Catalin:
>>>>    I'm so sorry for my fault. The previous small pages test result I actually ran on ramfs.
>>>> Today, I ran the case on harddisk fs, it worked well without this patch.
>>>>
>>>> Summarized as follows:
>>>> small pages on ramfs: need this patch
>>>> small pages on harddisk fs: no need this patch
>>>> hugetlbfs: need this patch
>>>
>>> I would add:
>>>
>>> small pages over nfs: fails with or without this patch
>>>
>>> (tested on Juno, Cortex-A57; seems to be fixed if I remove the
>>> PG_dcache_clean test altogether but, well, we end up over-flushing)
>>>
>>> I assume that when using a hard drive, it goes through the block I/O
>>> layer and we may have a flush_dcache_page() called when the kernel is
>>> about to read a page that has been mapped in user space. This would
>>> clear the PG_dcache_clean bit and subsequent __sync_icache_dcache()
>>> would perform cache maintenance.
>>>
>>> Could you try on your system the test case without the msync() call? I'm
>>
>> According to my test results: without msync, the test case may failed.
> 
> Thanks. Just to be clear, does the test generate a file on on a hard
> drive?
Yes. I checked that the intermediate file had been generated.

> 
>> 10-175-112-211:~ # ./tst_small_page_no_msync
>> Test is Failed: The result is 0x316b9, expect = 0x365a5
>> 10-175-112-211:~ # ./tst_small_page_no_msync
>> Test is Failed: The result is 0x31023, expect = 0x31efa
>> 10-175-112-211:~ # ./tst_small_page_no_msync
>> Test is Passed: The result is 0x31efa, expect = 0x31efa
>>
>> 10-175-112-211:~ # ./tst_small_page
>> Test is Passed: The result is 0x31eb7, expect = 0x31eb7
>> 10-175-112-211:~ # ./tst_small_page
>> Test is Passed: The result is 0x3111f, expect = 0x3111f
>> 10-175-112-211:~ # ./tst_small_page
>> Test is Passed: The result is 0x3111f, expect = 0x3111f
> 
> How many tests did you run for the "passed" case? With NFS it may
I ran ./tst_small_page_no_msync and ./tst_small_page 10 times for each.

> sometime take minutes before a failure (I use the "watch" command with a
> slightly modified test to return non-zero in case of value mismatch).
> 
> While we indeed see failures on multiple filesystem types, I wonder
> whether this test case is actually expected to work. If I modify the
> test to pass O_TRUNC to open(), I can no longer see failures. So any
> standard tool that copies/creates executable files (gcc, dpkg, cp, rsync
> etc.) wouldn't encounter such issues since they truncate the original
> file and old page cache pages would be removed.
> 
> Do you have a real use-case where a task mmap's an executable file,
> modifies it in place and expects another task to see the new
> instructions without user-space cache maintenance?
No, it's just a test case created by testers.

> 
