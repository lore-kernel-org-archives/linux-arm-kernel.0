From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Oct 2015 14:25:58 +0100
Subject: [PATCH v2 7/7] arm64: allow kernel Image to be loaded anywhere in
 physical memory
In-Reply-To: <561E3CBF.60704@arm.com>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
 <1442968663-31843-8-git-send-email-ard.biesheuvel@linaro.org>
 <561E3CBF.60704@arm.com>
Message-ID: <CAKv+Gu-8i5ktTxBn6kW=cEppoW-CYnJqxrgKFeuutAUtTXoA1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2015 at 12:30, James Morse <james.morse@arm.com> wrote:
> Hi Ard,
>
> On 23/09/15 01:37, Ard Biesheuvel wrote:
>> This relaxes the kernel Image placement requirements, so that it
>> may be placed at any 2 MB aligned offset in physical memory.
>>
>> This is accomplished by ignoring PHYS_OFFSET when installing
>> memblocks, and accounting for the apparent virtual offset of
>> the kernel Image (in addition to the 64 MB that it is moved
>> below PAGE_OFFSET). As a result, virtual address references
>> below PAGE_OFFSET are correctly mapped onto physical references
>> into the kernel Image regardless of where it sits in memory.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> [SNIP]
>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 4a1c9d0769f2..675757c01eff 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/errno.h>
>>  #include <linux/init.h>
>> +#include <linux/initrd.h>
>>  #include <linux/libfdt.h>
>>  #include <linux/mman.h>
>>  #include <linux/nodemask.h>
>> @@ -432,11 +433,34 @@ static void __init bootstrap_linear_mapping(unsigned long va_offset)
>>  static void __init map_mem(void)
>>  {
>>       struct memblock_region *reg;
>> +     u64 new_memstart_addr;
>> +     u64 new_va_offset;
>>
>> -     bootstrap_linear_mapping(KIMAGE_OFFSET);
>> +     /*
>> +      * Select a suitable value for the base of physical memory.
>> +      * This should be equal to or below the lowest usable physical
>> +      * memory address, and aligned to PUD/PMD size so that we can map
>> +      * it efficiently.
>> +      */
>> +     new_memstart_addr = round_down(memblock_start_of_DRAM(), SZ_1G);
>> +
>> +     /*
>> +      * Calculate the offset between the kernel text mapping that exists
>> +      * outside of the linear mapping, and its mapping in the linear region.
>> +      */
>> +     new_va_offset = memstart_addr - new_memstart_addr;
>> +
>> +     bootstrap_linear_mapping(new_va_offset);
>> +
>> +     kernel_va_offset = new_va_offset;
>> +
>> +     /* Recalculate virtual addresses of initrd region */
>> +     if (initrd_start) {
>> +             initrd_start += new_va_offset;
>> +             initrd_end += new_va_offset;
>> +     }
>
> This breaks the build for me, with messages like:
>> arch/arm64/mm/built-in.o: In function `map_mem':
>> ... arch/arm64/mm/mmu.c:458: undefined reference to `initrd_start'
>
> Wrapping the if with:
>> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD))
>
> Solves the problem for me.
>
>

Thank you James

I will take this into account when I spin the next version (probably
after 16k pages support is merged)

-- 
Ard.
