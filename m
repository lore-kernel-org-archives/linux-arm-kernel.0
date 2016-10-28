From: labbott@redhat.com (Laura Abbott)
Date: Fri, 28 Oct 2016 10:43:00 -0700
Subject: [RFC][PATCH] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161028144951.GI5806@leverpostej>
References: <1477613892-26076-1-git-send-email-labbott@redhat.com>
 <20161028144951.GI5806@leverpostej>
Message-ID: <4911a788-602f-6ad0-b8e7-53f9de9fa8c5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2016 07:49 AM, Mark Rutland wrote:
> Hi Laura,
>
> On Thu, Oct 27, 2016 at 05:18:12PM -0700, Laura Abbott wrote:
>> x86 has an option CONFIG_DEBUG_VIRTUAL to do additional checks
>> on virt_to_phys calls. The goal is to catch users who are calling
>> virt_to_phys on non-linear addresses immediately. As features
>> such as CONFIG_VMAP_STACK get enabled for arm64, this becomes
>> increasingly important. Add checks to catch bad virt_to_phys
>> usage.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> This has been on my TODO list for a while. It caught a few bugs with
>> CONFIG_VMAP_STACK on x86 so when that eventually gets added
>> for arm64 it will be useful to have. This caught one driver calling __pa on an
>> ioremapped address already.
>
> This is fantastic; thanks for putting this together!
>
>> RFC for a couple of reasons:
>>
>> 1) This is basically a direct port of the x86 approach.
>> 2) I needed some #ifndef __ASSEMBLY__ which I don't like to throw around.
>> 3) I'm not quite sure about the bounds check for the VIRTUAL_BUG_ON with KASLR,
>> specifically the _end check.
>> 4) Is it worth actually keeping this as DEBUG_VIRTUAL vs. folding it into
>> another option?
>
> I think it's worth aligning with x86, so modulo a couple of comments
> below, (1) and (4) seem fine. I think (2) just requires an additional
> shuffle.
>
>> ---
>>  arch/arm64/include/asm/memory.h | 11 ++++++++++-
>>  arch/arm64/mm/Makefile          |  2 +-
>>  arch/arm64/mm/physaddr.c        | 17 +++++++++++++++++
>>  lib/Kconfig.debug               |  2 +-
>>  mm/cma.c                        |  2 +-
>>  5 files changed, 30 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/arm64/mm/physaddr.c
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index ba62df8..9805adc 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -106,11 +106,19 @@
>>   * private definitions which should NOT be used outside memory.h
>>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
>>   */
>> -#define __virt_to_phys(x) ({						\
>> +#define __virt_to_phys_nodebug(x) ({					\
>>  	phys_addr_t __x = (phys_addr_t)(x);				\
>>  	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
>>  				 (__x - kimage_voffset); })
>>
>> +#ifdef CONFIG_DEBUG_VIRTUAL
>> +#ifndef __ASSEMBLY__
>> +extern unsigned long __virt_to_phys(unsigned long x);
>> +#endif
>> +#else
>> +#define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
>> +#endif
>> +
>>  #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
>>  #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
>
> I think we can move all the existing conversion logic here (including
> into page_to_phys/phys_to_page) into the existing #ifndef __ASSEMBLY__
> block at the end of the file. Assembly clearly can't use these, and we
> already have virt_to_phys and others in that #ifndef.
>
> Assuming that works, would you mind doing that as a preparatory patch?
>

Sure.

>> @@ -202,6 +210,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>   * Drivers should NOT use these either.
>>   */
>>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
>> +#define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
>>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>>  #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys(x))
>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
>> index 54bb209..bcea84e 100644
>> --- a/arch/arm64/mm/Makefile
>> +++ b/arch/arm64/mm/Makefile
>> @@ -5,6 +5,6 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>>  obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
>>  obj-$(CONFIG_NUMA)		+= numa.o
>> -
>> +obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
>>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>>  KASAN_SANITIZE_kasan_init.o	:= n
>> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
>> new file mode 100644
>> index 0000000..6c271e2
>> --- /dev/null
>> +++ b/arch/arm64/mm/physaddr.c
>> @@ -0,0 +1,17 @@
>> +#include <linux/mm.h>
>> +
>> +#include <asm/memory.h>
>> +
>> +unsigned long __virt_to_phys(unsigned long x)
>> +{
>> +	phys_addr_t __x = (phys_addr_t)x;
>> +
>> +	if (__x & BIT(VA_BITS - 1)) {
>> +		/* The bit check ensures this is the right range */
>> +		return (__x & ~PAGE_OFFSET) + PHYS_OFFSET;
>> +	} else {
>> +		VIRTUAL_BUG_ON(x < kimage_vaddr || x > (unsigned long)_end);
>
> IIUC, in (3) you were asking if the last check should be '>' or '>='?
>
> To match high_memory, I suspect the latter, as _end doesn't fall within
> the mapped virtual address space.
>

I was actually concerned about if _end would be correct with KASLR.
Ard confirmed that it gets fixed up to be correct. I'll change the
check to check for >=.

>> +		return (__x - kimage_voffset);
>> +	}
>> +}
>> +EXPORT_SYMBOL(__virt_to_phys);
>
> It's a bit annoying that we have to duplicate the logic here to add the
> VIRTUAL_BUG_ON(), but I see that x86 also do this, and I don't have a
> better suggestion.
>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 33bc56c..e5634bb 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -604,7 +604,7 @@ config DEBUG_VM_PGFLAGS
>>
>>  config DEBUG_VIRTUAL
>>  	bool "Debug VM translations"
>> -	depends on DEBUG_KERNEL && X86
>> +	depends on DEBUG_KERNEL && (X86 || ARM64)
>
> I have no strong feelings about this, but perhaps it's nicer to have
> something like ARCH_HAS_DEBUG_VIRTUAL?
>

Yes, if this ever gets added for other arches this will start to get
unwieldy. I'll look at cleaning that up.

>>  	help
>>  	  Enable some costly sanity checks in virtual to page code. This can
>>  	  catch mistakes with virt_to_page() and friends.
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 384c2cb..2345803 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -235,7 +235,7 @@ int __init cma_declare_contiguous(phys_addr_t base,
>>  	phys_addr_t highmem_start;
>>  	int ret = 0;
>>
>> -#ifdef CONFIG_X86
>> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
>
> Rather than an architecture list, can we depend on DEBUG_VIRTUAL? Are
> there other checks that we're trying to avoid?
>
> ... or could we avoid ifdeffery entirely with something like:
>
> 	/*
> 	 * We can't use __pa(high_memory) directly, since high_memory
> 	 * isn't a valid direct map VA, and DEBUG_VIRTUAL will (validly)
> 	 * complain. Find the boundary by adding one to the last valid
> 	 * address.
> 	 */
> 	highmem_start = __pa(high_memory - 1) + 1;
>

I like getting rid of the #ifdef there. Maybe future cleanup could turn
this into a #define, HIGHMEM_PHYS since it seems to be used in quite
a few places in the kernel.

> Thanks,
> Mark.
>

Thanks,
Laura

>>  	/*
>>  	 * high_memory isn't direct mapped memory so retrieving its physical
>>  	 * address isn't appropriate.  But it would be useful to check the
>> --
>> 2.7.4
>>
