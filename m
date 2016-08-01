From: zijun_hu@zoho.com (zijun_hu)
Date: Mon, 1 Aug 2016 18:59:50 +0800
Subject: [PATCH] arm64: fix address fault during mapping fdt region
In-Reply-To: <CAKv+Gu9QQdncCD_T8+tpdVP8qx=EKM9-PGLvb8J9RNA2qHddFw@mail.gmail.com>
References: <579F197B.80101@zoho.com>
 <CAKv+Gu9QQdncCD_T8+tpdVP8qx=EKM9-PGLvb8J9RNA2qHddFw@mail.gmail.com>
Message-ID: <579F2BA6.1010203@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2016 05:50 PM, Ard Biesheuvel wrote:
> On 1 August 2016 at 11:42, zijun_hu <zijun_hu@zoho.com> wrote:
>> From 07b9216ec3494515e7a6c41e0333eb8782427db3 Mon Sep 17 00:00:00 2001
>> From: zijun_hu <zijun_hu@htc.com>
>> Date: Mon, 1 Aug 2016 17:04:59 +0800
>> Subject: [PATCH] arm64: fix address fault during mapping fdt region
>>
>> fdt_check_header() accesses other fileds of fdt header but
>> the first 8 bytes such as version; so accessing unmapped
>> address fault happens if fdt region locates below align
>> boundary nearly during mapping fdt region, or expressed as
>> (offset + sizeof(struct fdt_header)) > SWAPPER_BLOCK_SIZE
>>
>> fdt header size at least is mapped in order to avoid the issue
>>
>> Signed-off-by: zijun_hu <zijun_hu@htc.com>
>> ---
>>  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 0f85a46..0d72b71 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -744,6 +744,7 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>>         const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
>>         int offset;
>>         void *dt_virt;
>> +       int dt_header_map_size;
>>
>>         /*
>>          * Check whether the physical FDT address is set and meets the minimum
>> @@ -774,9 +775,18 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>>         offset = dt_phys % SWAPPER_BLOCK_SIZE;
>>         dt_virt = (void *)dt_virt_base + offset;
>>
>> +       /*
>> +        * fdt_check_header() maybe access any field of fdt header not
>> +        * the first 8 bytes only, so map fdt header size at least for
>> +        * checking fdt header without address fault more portably
>> +        */
>> +       BUILD_BUG_ON(sizeof(struct fdt_header) > SWAPPER_BLOCK_SIZE);
>> +       dt_header_map_size = round_up(offset + sizeof(struct fdt_header),
>> +                       SWAPPER_BLOCK_SIZE);
>> +
>>         /* map the first chunk so we can read the size from the header */
>>         create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE),
>> -                       dt_virt_base, SWAPPER_BLOCK_SIZE, prot);
>> +                       dt_virt_base, dt_header_map_size, prot);
>>
>>         if (fdt_check_header(dt_virt) != 0)
>>                 return NULL;
>> @@ -785,7 +795,7 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>>         if (*size > MAX_FDT_SIZE)
>>                 return NULL;
>>
>> -       if (offset + *size > SWAPPER_BLOCK_SIZE)
>> +       if (offset + *size > dt_header_map_size)
>>                 create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
>>                                round_up(offset + *size, SWAPPER_BLOCK_SIZE), prot);
>>
> 
> Couldn't we simply do this instead?
this solution maybe better, my reason as follows?

1?it can achieve our original purpose, namely, checking whether fdt
header is corrupted before fetching fdt size field; good fdt header can
ensure good fdt size field included more rightly than only a magic filed
normally

2?it is more portable; we only need to call fdt_check_header() and don't
care about fdt header filed layout; moreover,fdt module is another independent
module and arm64 only uses it and should not depend on more details of fdt
such as size and magic fields locate within the first MIN_FDT_ALIGN bytes;
the decision whether a fdt header is corrupted should be left to fdt team

> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0f85a46c3e18..e8d3b04a2b57 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -778,7 +778,7 @@ void *__init __fixmap_remap_fdt(phys_addr_t
> dt_phys, int *size, pgprot_t prot)
>         create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE),
>                         dt_virt_base, SWAPPER_BLOCK_SIZE, prot);
> 
> -       if (fdt_check_header(dt_virt) != 0)
> +       if (fdt_magic(dt_virt) != FDT_MAGIC)
>                 return NULL;
> 
>         *size = fdt_totalsize(dt_virt);
> 
> We are simply looking for a size field. The OF code will call
> fdt_check_header() again, so anything that is checked there in
> addition to the magic field will still be checked.
> 
here is the first position to involve fdt functions, it maybe more suitable
to checking before using
