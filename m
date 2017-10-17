From: james.morse@arm.com (James Morse)
Date: Tue, 17 Oct 2017 17:34:22 +0100
Subject: [PATCH v3 08/13] arm64: Add vmap_stack header file
In-Reply-To: <20171013154226.xswo4y2viht22wvk@armageddon.cambridge.arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-9-james.morse@arm.com>
 <20171013154226.xswo4y2viht22wvk@armageddon.cambridge.arm.com>
Message-ID: <59E6310E.6080705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 13/10/17 16:42, Catalin Marinas wrote:
> On Fri, Sep 22, 2017 at 07:26:09PM +0100, James Morse wrote:
>> diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
>> new file mode 100644
>> index 000000000000..f41d043cac31
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/vmap_stack.h
>> @@ -0,0 +1,41 @@

>> +#ifndef __ASM_VMAP_STACK_H
>> +#define __ASM_VMAP_STACK_H
>> +
>> +#include <linux/vmalloc.h>
>> +#include <asm/memory.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/thread_info.h>
>> +
>> +#ifdef CONFIG_VMAP_STACK
>> +/*
>> + * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
>> + * stacks need to have the same alignment.
>> + */
>> +static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
>> +{
>> +	return __vmalloc_node_range(stack_size, THREAD_ALIGN,
>> +				    VMALLOC_START, VMALLOC_END,
>> +				    THREADINFO_GFP, PAGE_KERNEL, 0, node,
>> +				    __builtin_return_address(0));
>> +}
>> +
>> +#else
>> +unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node); // link error

> Do you actually need this here? The calling site (at least in this
> patch), is surrounded by CONFIG_VMAP_STACK. Removing the dummy
> declaration should be fine (I haven't read the rest of the patches yet,
> maybe it's needed later;

This was to avoid having to #ifdef the calling site I add in a later patch.


> would a BUILD_BUG do?).

Ah, you can put those in header files, yes that would be clearer.


Thanks,

James
