From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 26 Jan 2018 14:30:47 +0100
Subject: [RFC 1/2] arm: cacheflush syscall: process only pages that are
 in the memory
In-Reply-To: <20180126113226.GX17719@n2100.armlinux.org.uk>
References: <CGME20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8@eucas1p1.samsung.com>
 <20180126111441.29353-1-m.szyprowski@samsung.com>
 <20180126113226.GX17719@n2100.armlinux.org.uk>
Message-ID: <589aa8ab-5bfc-e065-51f9-3a403c346d92@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 2018-01-26 12:32, Russell King - ARM Linux wrote:
> On Fri, Jan 26, 2018 at 12:14:40PM +0100, Marek Szyprowski wrote:
>> glibc in calls cacheflush syscall on the whole textrels section of the
>> relocated binaries. However, relocation usually doesn't touch all pages
>> of that section, so not all of them are read to memory when calling this
>> syscall. However flush_cache_user_range() function will unconditionally
>> touch all pages from the provided range, resulting additional overhead
>> related to reading all clean pages. Optimize this by calling
>> flush_cache_user_range() only on the pages that are already in the
>> memory.
> What ensures that another CPU doesn't remove a page while we're
> flushing it?  That will trigger a data abort, which will want to
> take the mmap_sem, causing a deadlock.

I thought that taking mmap_sem will prevent pages from being removed.
mmap_sem has been already taken in the previous implementation of that
syscall, until code simplification done by commit 97c72d89ce0e ("ARM:
cacheflush: don't bother rounding to nearest vma").

>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/kernel/traps.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 5e3633c24e63..a5ec262ab30e 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -564,23 +564,36 @@ static int bad_syscall(int n, struct pt_regs *regs)
>>   static inline int
>>   __do_cache_op(unsigned long start, unsigned long end)
>>   {
>> -	int ret;
>> +	struct vm_area_struct *vma = NULL;
>> +	int ret = 0;
>>   
>> +	down_read(&current->mm->mmap_sem);
>>   	do {
>>   		unsigned long chunk = min(PAGE_SIZE, end - start);
>>   
>> +		if (!vma || vma->vm_end <= start) {
>> +			vma = find_vma(current->mm, start);
>> +			if (!vma) {
>> +				ret = -EFAULT;
>> +				goto done;
>> +			}
>> +		}
>> +
>>   		if (fatal_signal_pending(current))
>>   			return 0;
>>   
>> -		ret = flush_cache_user_range(start, start + chunk);
>> -		if (ret)
>> -			return ret;
>> +		if (follow_page(vma, start, 0)) {
>> +			ret = flush_cache_user_range(start, start + chunk);
>> +			if (ret)
>> +				goto done;
>> +		}
>>   
>>   		cond_resched();
>>   		start += chunk;
>>   	} while (start < end);
>> -
>> -	return 0;
>> +done:
>> +	up_read(&current->mm->mmap_sem);
>> +	return ret;
>>   }
>>   
>>   static inline int
>> -- 
>> 2.15.0
>>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
