From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 11 Jun 2012 20:23:49 -0700
Subject: [PATCH][RFC] mm: Don't put CMA pages on per-cpu lists
In-Reply-To: <039901cd47aa$7e846270$7b8d2750$%szyprowski@samsung.com>
References: <1338924421-7942-1-git-send-email-lauraa@codeaurora.org>
 <039901cd47aa$7e846270$7b8d2750$%szyprowski@samsung.com>
Message-ID: <4FD6B645.1020602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2012 1:16 AM, Marek Szyprowski wrote:
> Hi Laura,
>
> On Tuesday, June 05, 2012 9:27 PM Laura Abbott wrote:
>
>> Currently, when freeing 0 order pages, CMA pages are treated
>> the same as regular movable pages, which means they end up
>> on the per-cpu page list. This means that the CMA pages are
>> likely to be allocated for something other than contigous
>> memory. This increases the chance that the next alloc_contig_range
>> will fail because pages can't be migrated.
>>
>> Given the size of the CMA region is typically limited, it is best to
>> optimize for success of alloc_contig_range as much as possible.
>> Do this by freeing CMA pages directly instead of putting them
>> on the per-cpu page lists.
>>
>> Signed-off-by: Laura Abbott<lauraa@codeaurora.org>
>> ---
>>   mm/page_alloc.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0e1c6f5..c9a6483 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1310,7 +1310,8 @@ void free_hot_cold_page(struct page *page, int cold)
>>   	 * excessively into the page allocator
>>   	 */
>>   	if (migratetype>= MIGRATE_PCPTYPES) {
>> -		if (unlikely(migratetype == MIGRATE_ISOLATE)) {
>> +		if (unlikely(migratetype == MIGRATE_ISOLATE)
>> +		   || is_migrate_cma(migratetype)) {
>>   			free_one_page(zone, page, 0, migratetype);
>>   			goto out;
>>   		}
>> --
>
> Well this patch has some side effects, in some cases it might force kernel to consume regular
> movable pages which should be left as a fallback for critical non-movable allocations. Do you
> have any statistics for the change introduced by this patch?
>

I don't have any statistics right now for fallback cases. What I do have 
is statistics for repeated invocations of CMA where I've observed high 
allocation failure rates.

I'm allocating CMA blocks through Ion, based on patches posted by 
Benjamin Gaignard [1]. In a userspace program, the entire region is 
allocated (40MB for my testing) in 1MB chunks and freed again in a loop. 
in pseudocode:

Loop forever:
	allocate each 1MB chunk
	map each 1MB chunk
	write data to 1MB chunk
	unmap each 1MB chunk
	free each 1MB chunk

This test is combined with something to put stress on the filesystem 
(adb push/pull for this).

During the course of one hour of running, the program goes through
~8500 alloc/map/write/unmap/free cycles. During that time without the 
patch, there are ~420 times when dma_alloc_coherent failed for a 1MB 
chunk. This seems unacceptably high to me.

In every case of failure during this test, the pages cannot be migrated 
because the pages contain buffers and the buffers cannot be dropped. 
(move_to_new_page -> fallback_migrate_page -> try_to_release_page -> 
try_to_free_buffers -> drop_buffers -> buffer_busy)

My goal is to minimize the number of allocation failures seen during a 
normal memory use case. I saw zero failures over a 24 hour period with 
this patch and the same test case. It's still not clear whether this is 
actually the right approach, hence the RFC.

I'll try and get some better statistics on how this affects the system.

> Best regards

Thanks,
Laura

[1] http://lists.linaro.org/pipermail/linaro-mm-sig/2012-March/001430.html
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
