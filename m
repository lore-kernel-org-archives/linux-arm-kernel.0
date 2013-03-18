From: liuj97@gmail.com (Jiang Liu)
Date: Tue, 19 Mar 2013 01:21:50 +0800
Subject: [PATCH v2, part3 02/12] mm/ARM64: kill poison_init_mem()
In-Reply-To: <20130317214642.GA20875@mudshark.cambridge.arm.com>
References: <1363453413-8139-1-git-send-email-jiang.liu@huawei.com>
 <1363453413-8139-3-git-send-email-jiang.liu@huawei.com>
 <20130317214642.GA20875@mudshark.cambridge.arm.com>
Message-ID: <51474D2E.7060709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 05:46 AM, Will Deacon wrote:
> On Sat, Mar 16, 2013 at 05:03:23PM +0000, Jiang Liu wrote:
>> Use free_reserved_area() to kill poison_init_mem() on ARM64.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>  arch/arm64/mm/init.c |   17 +++--------------
>>  1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index e58dd7f..b87bdb8 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -197,14 +197,6 @@ void __init bootmem_init(void)
>>  	max_pfn = max_low_pfn = max;
>>  }
>>  
>> -/*
>> - * Poison init memory with an undefined instruction (0x0).
>> - */
>> -static inline void poison_init_mem(void *s, size_t count)
>> -{
>> -	memset(s, 0, count);
>> -}
>> -
>>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
>>  static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>>  {
>> @@ -386,8 +378,7 @@ void __init mem_init(void)
>>  
>>  void free_initmem(void)
>>  {
>> -	poison_init_mem(__init_begin, __init_end - __init_begin);
>> -	 free_initmem_default(-1);
>> +	free_initmem_default(0);
> 
> This change looks unrelated to $subject. We should probably just poison with
> 0 from the outset, when free_initmem_default is introduced.
Hi Will,
	As you have suggested, this patch should be merged into patchset which
introduces free_initmem_default(). I have a plan to merge it in v3, but the v2
patchset has been merged into -mm tree, so I generated another patch against the
mm tree.
	free_initmem_default(-1) doesn't poison the freed memory and 
free_initmem_default(0) poisons the freed memory with 0, so it's needed to
kill poison_init_mem().

regards!
Gerry

> 
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
