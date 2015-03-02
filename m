From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Mar 2015 14:47:41 +0000
Subject: [RFC PATCH] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <20150302144036.GE16779@leverpostej>
References: <1425048823-25206-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150302144036.GE16779@leverpostej>
Message-ID: <CAKv+Gu8TkDRfYmf+V==m7EJyVGC-ZiCSnTtvmHtHgQtbJJo5Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2015 at 14:40, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Feb 27, 2015 at 02:53:43PM +0000, Ard Biesheuvel wrote:
>> Currently, the FDT blob needs to be in the same naturally aligned
>> 512 MB region as the kernel, so that it can be mapped into the
>> kernel virtual memory space very early on using a minimal set of
>> statically allocated translation tables.
>>
>> Now that we have early fixmap support, we can relax this restriction,
>> by moving the permanent FDT mapping to the fixmap region instead.
>> This way, the FDT blob may be anywhere in memory.
>
> Neat! I was hoping we'd have the chance to do this at some point.
>
> [...]
>
>> +     /*
>> +      * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
>> +      * region. Keep this at the top so it remains 2 MB aligned.
>> +      */
>> +#define FIX_FDT_SIZE         SZ_2M
>> +     FIX_FDT_END,
>> +     FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>
> Doesn't the presence of the FIX_HOLE entry mean that this isn't 2MB
> aligned?
>

Well, the fixmap is a bit odd in this respect: FIXADDR_TOP is
exclusive, so FIX_HOLE is only there as a placeholder.

> [...]
>
>>  __create_page_tables:
>> -     pgtbl   x25, x26, x28                   // idmap_pg_dir and swapper_pg_dir addresses
>> +     pgtbl   x25, x26, x28   // idmap_pg_dir and swapper_pg_dir addresses
>>       mov     x27, lr
>>
>>       /*
>
> This comment should just stay where it was. It aligns with comments
> later within __create_page_tables that are left alone by this patch, so
> we don't gain anything by moving it.
>

I'll drop it.

> [...]
>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index e8420f635bd4..7ea087d904ad 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -309,12 +309,14 @@ static void __init setup_processor(void)
>>
>>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>  {
>> -     if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
>> +     void *dt_virt = fixmap_remap_fdt(dt_phys);
>> +
>> +     if (!dt_phys || !early_init_dt_scan(dt_virt)) {
>>               early_print("\n"
>>                       "Error: invalid device tree blob at physical address 0x%p (virtual address 0x%p)\n"
>> -                     "The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
>> +                     "The dtb must be 8-byte aligned\n"
>>                       "\nPlease check your bootloader.\n",
>> -                     dt_phys, phys_to_virt(dt_phys));
>> +                     dt_phys, dt_virt);
>
> We should also check that the reported size in the header doesn't cross
> a 2MB PA boundary, or we won't be able to map the whole DTB and the
> crc32 code will explode later.
>

Good point.

> Otherwise this looks good!
>

Actually, there is a bit of a snag:
early_init_fdt_scan_reserved_mem() reserves the FDT region, but does
so by using __pa() to retrieve the physical offset, which doesn't work
now the FDT is not accessed through the linear mapping.

I will try and figure out what the best way is to work around this.
Any and all suggestions appreciated.

-- 
Ard.
