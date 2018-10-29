From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 29 Oct 2018 14:52:37 -0700
Subject: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
References: <20181029190014.6455-1-f.fainelli@gmail.com>
 <20181029190014.6455-2-f.fainelli@gmail.com>
 <CAL_JsqL2g69Duhkqd=f09BStoAKeakJz8Wgz3is37YU0+fc80A@mail.gmail.com>
Message-ID: <e3033413-555e-72ca-be75-e4b566b62480@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/18 12:59 PM, Rob Herring wrote:
> +Ard who last touched this.
> 
> On Mon, Oct 29, 2018 at 2:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override, just get rid of that
>> implementation and perform the virtual to physical conversion of these
>> addresses in arm64_memblock_init() where relevant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/arm64/include/asm/memory.h |  8 -------
>>  arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
>>  2 files changed, 27 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index b96442960aea..dc3ca21ba240 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -168,14 +168,6 @@
>>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
>>  #endif
>>
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -#define __early_init_dt_declare_initrd(__start, __end)                 \
>> -       do {                                                            \
>> -               initrd_start = (__start);                               \
>> -               initrd_end = (__end);                                   \
>> -       } while (0)
>> -#endif
>> -
>>  #ifndef __ASSEMBLY__
>>
>>  #include <linux/bitops.h>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..292570b08f85 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -62,6 +62,8 @@
>>  s64 memstart_addr __ro_after_init = -1;
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>
>> +static phys_addr_t phys_initrd_start, phys_initrd_end;
>> +
>>  #ifdef CONFIG_BLK_DEV_INITRD
>>  static int __init early_initrd(char *p)
>>  {
>> @@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
>>         if (*endp == ',') {
>>                 size = memparse(endp + 1, NULL);
>>
>> -               initrd_start = start;
>> -               initrd_end = start + size;
>> +               phys_initrd_start = start;
>> +               phys_initrd_end = start + size;
>>         }
>>         return 0;
>>  }
>> @@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
>>  void __init arm64_memblock_init(void)
>>  {
>>         const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> +       u64 __maybe_unused base, size;
>>
>>         /* Handle linux,usable-memory-range property */
>>         fdt_enforce_memory_region();
>> @@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>         }
>>
>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
>> +           (initrd_start || phys_initrd_start)) {
> 
> I've tried to explain already that this is broken. The problem is
> __early_init_dt_declare_initrd using __va() which happens before this
> function is called. __va() uses PHYS_OFFSET which in turn is defined
> as memstart_addr. However, memstart_addr may be changed just above
> this hunk, so the earlier conversion to a VA may not be valid at this
> point. This is explained if you read Ard's commit that added all this
> mess.

Thanks for explaining this again, looks like I had overlooked that
explanation in the "other branch" of the thread last time I read it.

> 
> You could fix this by converting back to a PA before adjusting
> memstart_addr, but that's 2 wrongs making a right and fragile. The
> better solution is the other proposal making the DT code set
> phys_initrd_* (whatever the ARM code calls them).

OK, that sounds reasonable, will cook something doing that. Thanks!

> 
>>                 /*
>>                  * Add back the memory we just removed if it results in the
>>                  * initrd to become inaccessible via the linear mapping.
>>                  * Otherwise, this is a no-op
>>                  */
>> -               u64 base = initrd_start & PAGE_MASK;
>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>> +               if (phys_initrd_start) {
>> +                       /* Command line specified the initrd location */
>> +                       initrd_start = __phys_to_virt(phys_initrd_start);
>> +                       initrd_end = __phys_to_virt(phys_initrd_end);
>> +               } else if (initrd_start) {
>> +                       /* FDT specified the initrd location */
>> +                       phys_initrd_start = __pa(initrd_start);
>> +                       phys_initrd_end = __pa(initrd_end);
> 
> Kind of inconsistent to mix __phys_to_virt and __pa flavors.
> 
> Rob
> 


-- 
Florian
