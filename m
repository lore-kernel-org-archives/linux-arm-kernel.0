From: labbott@redhat.com (Laura Abbott)
Date: Wed, 2 Nov 2016 18:05:38 -0600
Subject: [PATCHv2 6/6] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161102230642.GB19591@remoulade>
References: <20161102210054.16621-1-labbott@redhat.com>
 <20161102210054.16621-7-labbott@redhat.com>
 <20161102230642.GB19591@remoulade>
Message-ID: <a77c2162-6eb9-09c8-e84f-03a207b59c6b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 05:06 PM, Mark Rutland wrote:
> On Wed, Nov 02, 2016 at 03:00:54PM -0600, Laura Abbott wrote:
>> +CFLAGS_physaddr.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>> +obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
>
>> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
>> new file mode 100644
>> index 0000000..874c782
>> --- /dev/null
>> +++ b/arch/arm64/mm/physaddr.c
>> @@ -0,0 +1,34 @@
>> +#include <linux/mm.h>
>> +
>> +#include <asm/memory.h>
>> +
>> +unsigned long __virt_to_phys(unsigned long x)
>> +{
>> +	phys_addr_t __x = (phys_addr_t)x;
>> +
>> +	if (__x & BIT(VA_BITS - 1)) {
>> +		/*
>> +		 * The linear kernel range starts in the middle of the virtual
>> +		 * adddress space. Testing the top bit for the start of the
>> +		 * region is a sufficient check.
>> +		 */
>> +		return (__x & ~PAGE_OFFSET) + PHYS_OFFSET;
>> +	} else {
>> +		VIRTUAL_BUG_ON(x < kimage_vaddr || x >= (unsigned long)_end);
>> +		return (__x - kimage_voffset);
>> +	}
>> +}
>> +EXPORT_SYMBOL(__virt_to_phys);
>> +
>> +unsigned long __phys_addr_symbol(unsigned long x)
>> +{
>> +	phys_addr_t __x = (phys_addr_t)x;
>> +
>> +	/*
>> +	 * This is intentionally different than above to be a tighter check
>> +	 * for symbols.
>> +	 */
>> +	VIRTUAL_BUG_ON(x < kimage_vaddr + TEXT_OFFSET || x > (unsigned long) _end);
>
> Can't we use _text instead of kimage_vaddr + TEXT_OFFSET? That way we don't
> need CFLAGS_physaddr.o.
>
> Or KERNEL_START / KERNEL_END from <asm/memory.h>?
>
> Otherwise, this looks good to me (though I haven't grokked the need for
> __pa_symbol() yet).

I guess it's a question of what's clearer. I like kimage_vaddr +
TEXT_OFFSET because it clearly states we are checking from the
start of the kernel image vs. _text only shows the start of the
text region. Yes, it's technically the same but a little less
obvious. I suppose that could be solved with some more elaboration
in the comment.

Thanks,
Laura

>
> Thanks,
> Mark.
>
>> +	return (__x - kimage_voffset);
>> +}
>> +EXPORT_SYMBOL(__phys_addr_symbol);
>> --
>> 2.10.1
>>
