From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 9 Nov 2013 14:07:41 -0500
Subject: [PATCH 14/24] mm/lib/swiotlb: Use memblock apis for early memory
 allocations
In-Reply-To: <6314f039-a40e-4250-9d62-6bb6ac7c6bec@email.android.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <1383954120-24368-15-git-send-email-santosh.shilimkar@ti.com>
 <6314f039-a40e-4250-9d62-6bb6ac7c6bec@email.android.com>
Message-ID: <527E87FD.1040800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 November 2013 11:55 AM, Konrad Rzeszutek Wilk wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> Switch to memblock interfaces for early memory allocator instead of
>> bootmem allocator. No functional change in beahvior than what it is
>> in current code from bootmem users points of view.
>>
>> Archs already converted to NO_BOOTMEM now directly use memblock
>> interfaces instead of bootmem wrappers build on top of memblock. And
>> the
>> archs which still uses bootmem, these new apis just fallback to exiting
>> bootmem APIs.
>>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> lib/swiotlb.c |   36 +++++++++++++++++++++---------------
>> 1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>> index 4e8686c..78ac01a 100644
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -169,8 +169,9 @@ int __init swiotlb_init_with_tbl(char *tlb,
>> unsigned long nslabs, int verbose)
>> 	/*
>> 	 * Get the overflow emergency buffer
>> 	 */
>> -	v_overflow_buffer = alloc_bootmem_low_pages_nopanic(
>> -						PAGE_ALIGN(io_tlb_overflow));
>> +	v_overflow_buffer = memblock_virt_alloc_align_nopanic(
>> +						PAGE_ALIGN(io_tlb_overflow),
>> +						PAGE_SIZE);
> 
> Does this guarantee that the pages will be allocated below 4GB?
> 
Yes. The memblock layer still allocates memory from lowmem. As I
mentioned, there is no change in the behavior than what is today
apart from just the interface change.

Regards,
Santosh
