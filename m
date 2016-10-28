From: labbott@redhat.com (Laura Abbott)
Date: Fri, 28 Oct 2016 15:07:14 -0700
Subject: [RFC][PATCH] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <4911a788-602f-6ad0-b8e7-53f9de9fa8c5@redhat.com>
References: <1477613892-26076-1-git-send-email-labbott@redhat.com>
 <20161028144951.GI5806@leverpostej>
 <4911a788-602f-6ad0-b8e7-53f9de9fa8c5@redhat.com>
Message-ID: <6a76edf2-3f80-fb18-4fc1-2e0b1f085d20@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
>>> new file mode 100644
>>> index 0000000..6c271e2
>>> --- /dev/null
>>> +++ b/arch/arm64/mm/physaddr.c
>>> @@ -0,0 +1,17 @@
>>> +#include <linux/mm.h>
>>> +
>>> +#include <asm/memory.h>
>>> +
>>> +unsigned long __virt_to_phys(unsigned long x)
>>> +{
>>> +    phys_addr_t __x = (phys_addr_t)x;
>>> +
>>> +    if (__x & BIT(VA_BITS - 1)) {
>>> +        /* The bit check ensures this is the right range */
>>> +        return (__x & ~PAGE_OFFSET) + PHYS_OFFSET;
>>> +    } else {
>>> +        VIRTUAL_BUG_ON(x < kimage_vaddr || x > (unsigned long)_end);
>>
>> IIUC, in (3) you were asking if the last check should be '>' or '>='?
>>
>> To match high_memory, I suspect the latter, as _end doesn't fall within
>> the mapped virtual address space.
>>
>
> I was actually concerned about if _end would be correct with KASLR.
> Ard confirmed that it gets fixed up to be correct. I'll change the
> check to check for >=.
>

While testing this, I found two places with __pa(_end) to get bounds,
one in arm64 code and one in memblock code. x86 gets away with this
because memblock is actually __pa_symbol and x86 does image placement
different and can check against the maximum image size. I think
including _end in __pa_symbol but excluding it from the generic
__virt_to_phys makes sense. It's a bit nicer than doing _end - 1 +
1 everywhere.

Thanks,
Laura
