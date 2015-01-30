From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 30 Jan 2015 09:54:17 +0100
Subject: CMA related memory questions
In-Reply-To: <54CB132F.60604@samsung.com>
References: <CABymUCNMjM2KHXXB-LM=x+FTcJL6S5_jhG3GbP7VRi2vBoW49g@mail.gmail.com>
 <CABymUCO+xaify95bUqfbCLsEjkLzEC0yT_fgkhV+qzC36JNgoA@mail.gmail.com>
 <CABymUCPgEh93QsBtRyg0S+FyE0FHwjAF75qk+NWh5TS8ehWuew@mail.gmail.com>
 <54CAF314.4070301@linaro.org> <54CAF9A4.1040606@samsung.com>
 <54CAFDC4.5070408@linaro.org> <54CB132F.60604@samsung.com>
Message-ID: <54CB46B9.2040604@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC some usual CMA suspects]

On 01/30/2015 06:14 AM, Heesub Shin wrote:
> 
> 
> On 01/30/2015 12:43 PM, Jun Nie wrote:
>> On 2015?01?30? 11:25, Heesub Shin wrote:
>>>
>>>
>>> On 01/30/2015 11:57 AM, Jun Nie wrote:
>>>> On 2015?01?30? 10:36, Jun Nie wrote:
>>>>> Hi Marek & Arnd,
>>>>>
>>>>> Did you ever know issue that free CMA memory is high, but system is
>>>>> hungry for memory and page cache is very low? I am enabling CMA in
>>>>> Android on my board with 512MB memory and see FreeMem in /proc/meminfo
>>>>> increase a lot with CMA comparing the reservation solution on boot. But
>>>>> I find system is not borrowing memory from CMA pool when running 3dmark
>>>>> (high webkit workload at start). Because the FreeMem size is high, but
>>>>> cache size decreasing significantly to several MB during benchmark run,
>>>>> I suppose system is trying to reclaim memory from pagecache for new
>>>>> allocation. My question is that what API that page cache and webkit
>>>>> related functionality are using to allocate memory. Maybe page cache
>>>>> require memory that is not movable/reclaimable memory, where we may
>>>>> have
>>>>> optimization to go thru dma_alloc_xxx to borrow CMA memory? I suppose
>>>>> app level memory allocation shall be movable/reclaimable memory and can
>>>>> borrow from CMA pool, but not sure whether the flag match the
>>>>> movable/reclaimable memory and go thru the right path.
>>>>>
>>>>> Could you help share your experience/thoughts on this? Thanks!
>>>
>>> CC'ed linux-mm at kvack.org
>>>
>>> __zone_watermark_ok() assumes that free pages from CMA pageblock are not
>>> free when ALLOC_CMA is not set on alloc_flags. The main goal was to
>>> force core mm to keep some non-CMA always free and thus let kernel to
>>> allocate a few unmovable pages from any context (including atomic, irq,
>>> etc.). However, this behavior may cause excessive page reclamation as it
>>> is sometimes very hard to satisfy the high wmark + balance_gap with only
>>> non-CMA pages and reclaiming CMA pages does not help at all.
>> Seems it is tricky to tune it. Could you help share some experience on
>> this, how to change the parameters, what's pro/con? Thanks!
> 
> AFAIK, unfortunately there's no other way rather than reducing the 
> number of CMA pageblocks which are making anomalies. Selectively 
> ignoring CMA pages when we isolate pages from LRU could be an 
> alternative, but it has another side effect. I also want to know how to 
> handle this problem nicely.

Well maybe zone_balanced() could check watermarks with passing ALLOC_CMA in
alloc_flags instead of 0? This would mean that high watermark will be satisfied
for movable allocations, which pass ALLOC_CMA. That should fix your too-depleted
page cache problem, I think? But in that case it should probably also check low
watermark without ALLOC_CMA, to make sure unmovable/reclaimable allocations
won't stall.

There might however still be some side effects. IIRC unmovable allocations are
already treated badly due to CMA, and it could make it worse. And we should also
check if direct reclaim paths use watermark checking with proper alloc_flags and
classzone_idx. IIRC they don't always do, which can also result in mismatched
decisions on compaction.

But maybe this is all moot if the plan for moving CMA to a different zone works
out...

>>>
>>> It is observed that page cache pages are excessively reclaimed and
>>> entire system falls into thrashing even though the amount of free pages
>>> are much higer than the high wmark. In this case, majority of the free
>>> pages were from CMA page block (and about 30% pages in highmem zone were
>>> from CMA pageblock). Therefore, kswapd kept running and reclaiming too
>>> many pages. Although it is relatively rare and only observed on a
>>> specific workload, the device gets in an unresponsive state for a while
>>> (up to 10 secs), once it happens.
>>>
>> I am in this situation. kswapd is busy and most FreeMem is from CMA
>> because I have 192MB CMA memblock and most of them are free.
>>> regards,
>>> heesub
>>>
>>>>>
>>>>>
>>>>> B.R.
>>>>> Jun
>>>>
>>>> Add more people.
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> --
>> To unsubscribe, send a message with 'unsubscribe linux-mm' in
>> the body to majordomo at kvack.org.  For more info on Linux MM,
>> see: http://www.linux-mm.org/ .
>> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
>>
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
> 
