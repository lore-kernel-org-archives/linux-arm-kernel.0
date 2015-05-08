From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 May 2015 19:27:40 +0200
Subject: [PATCH v4 10/13] arm64: move kernel mapping out of linear region
In-Reply-To: <CAKv+Gu_=HKURayPU3EE1k+sn_s-HJMroCiU7mBW-vdW48FsPpA@mail.gmail.com>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429112064-19952-11-git-send-email-ard.biesheuvel@linaro.org>
 <20150508171637.GG12601@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=HKURayPU3EE1k+sn_s-HJMroCiU7mBW-vdW48FsPpA@mail.gmail.com>
Message-ID: <CAKv+Gu9V-fvdxhDEqbAK3452QLGLywW5NbyjaMOpcG=kBy_2LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 19:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 8 May 2015 at 19:16, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Wed, Apr 15, 2015 at 05:34:21PM +0200, Ard Biesheuvel wrote:
>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>> index f800d45ea226..801331793bd3 100644
>>> --- a/arch/arm64/include/asm/memory.h
>>> +++ b/arch/arm64/include/asm/memory.h
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/compiler.h>
>>>  #include <linux/const.h>
>>>  #include <linux/types.h>
>>> +#include <asm/boot.h>
>>>  #include <asm/sizes.h>
>>>
>>>  /*
>>> @@ -39,7 +40,12 @@
>>>  #define PCI_IO_SIZE          SZ_16M
>>>
>>>  /*
>>> - * PAGE_OFFSET - the virtual address of the start of the kernel image (top
>>> + * Offset below PAGE_OFFSET where to map the kernel Image.
>>> + */
>>> +#define KIMAGE_OFFSET                MAX_KIMG_SIZE
>>> +
>>> +/*
>>> + * PAGE_OFFSET - the virtual address of the base of the linear mapping (top
>>>   *            (VA_BITS - 1))
>>>   * VA_BITS - the maximum number of bits for virtual addresses.
>>>   * TASK_SIZE - the maximum size of a user space task.
>>> @@ -49,7 +55,8 @@
>>>   */
>>>  #define VA_BITS                      (CONFIG_ARM64_VA_BITS)
>>>  #define PAGE_OFFSET          (UL(0xffffffffffffffff) << (VA_BITS - 1))
>>> -#define MODULES_END          (PAGE_OFFSET)
>>> +#define KIMAGE_VADDR         (PAGE_OFFSET - KIMAGE_OFFSET)
>>> +#define MODULES_END          KIMAGE_VADDR
>>>  #define MODULES_VADDR                (MODULES_END - SZ_64M)
>>>  #define PCI_IO_END           (MODULES_VADDR - SZ_2M)
>>>  #define PCI_IO_START         (PCI_IO_END - PCI_IO_SIZE)
>>> @@ -77,7 +84,11 @@
>>>   * private definitions which should NOT be used outside memory.h
>>>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
>>>   */
>>> -#define __virt_to_phys(x)    (((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET))
>>> +#define __virt_to_phys(x) ({                                         \
>>> +     long __x = (long)(x) - PAGE_OFFSET;                             \
>>> +     __x >= 0 ? (phys_addr_t)(__x + PHYS_OFFSET) :                   \
>>> +                (phys_addr_t)(__x + PHYS_OFFSET + kernel_va_offset); })
>>
>> Just wondering, when do we need a __pa on kernel addresses? But it looks
>> to me like second case is always (__x + PHYS_OFFSET + KIMAGE_OFFSET).
>
> For now, yes. But when the kernel Image moves up in physical memory,
> and/or the kernel virtual image moves down in virtual memory (for
> kaslr) this offset could increase.
>
>> Before map_mem(), we have phys_offset_bias set but kernel_va_offset 0.
>> After map_mem(), we reset the former and set the latter. Maybe we can
>> get rid of kernel_va_offset entirely (see more below about
>> phys_offset_bias).
>>
>
>
>>> +
>>>  #define __phys_to_virt(x)    ((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
>>>
>>>  /*
>>> @@ -111,7 +122,16 @@
>>>
>>>  extern phys_addr_t           memstart_addr;
>>>  /* PHYS_OFFSET - the physical address of the start of memory. */
>>> -#define PHYS_OFFSET          ({ memstart_addr; })
>>> +#define PHYS_OFFSET          ({ memstart_addr + phys_offset_bias; })
>>> +
>>> +/*
>>> + * Before the linear mapping has been set up, __va() translations will
>>> + * not produce usable virtual addresses unless we tweak PHYS_OFFSET to
>>> + * compensate for the offset between the kernel mapping and the base of
>>> + * the linear mapping. We will undo this in map_mem().
>>> + */
>>> +extern u64 phys_offset_bias;
>>> +extern u64 kernel_va_offset;
>>
>> Can we not add the bias to memstart_addr during boot and reset it later
>> in map_mem()? Otherwise the run-time kernel ends up having to do a dummy
>> addition any time it needs PHYS_OFFSET.
>>
>
> Yes, that is how I started out. At some point during development, that
> became a bit cumbersome, because for instance, when you remove the
> memory that is inaccessible, you want memstart_addr to contain a
> meaningful value and not have to undo the bias. But looking at this
> version of the series, I think there are no references left to
> memstart_addr.


Patch #12 in this series removes the problematic references to
memstart_addr, so I could squash the bias in that patch.
