From: james.morse@arm.com (James Morse)
Date: Fri, 6 Jul 2018 15:41:07 +0100
Subject: [PATCH v3 3/5] arm64/mm: Create initial page tables in init_pg_dir
In-Reply-To: <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
 <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
Message-ID: <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 06/07/18 09:58, James Morse wrote:
> The series so far fails to boot from me. This is because the kaslr code tries to
> read the kaslr-seed from the DT, via the fixmap. To do this, it needs the fixmap
> tables installed, which early_fixmap_init() does.
> 
> early_fixmap_init() calls pgd_offset_k(), which assumes init_mm.pgd is in use,
> so we hit a BUG_ON() when trying to setup the fixmap because we added the tables
> to the wrong page tables.
> 
> If you enable 'CONFIG_RANDOMIZE_BASE', even without EFI you should see the same
> thing happen.
> 
> 
> I think we should move this hunk:
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 30ad2f085d1f..b065c08d4008 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -249,6 +249,7 @@ void __init setup_arch(char **cmdline_p)
>>  	init_mm.end_code   = (unsigned long) _etext;
>>  	init_mm.end_data   = (unsigned long) _edata;
>>  	init_mm.brk	   = (unsigned long) _end;
>> +	init_mm.pgd	   = init_pg_dir;
>>
>>  	*cmdline_p = boot_command_line;
>>
> 
> into early_fixmap_init(), which is the first thing setup_arch() calls.
> Something like [0] fixes it.
> 
> This looks to be the only thing that goes near init_mm.pgd before paging_init().

I missed one: head.S has a call to kasan_early_init() before start_kernel(),
this goes messing with the page tables, and calls pgd_offset_k(), which pulls in
swapper_pg_dir. This one is enabled by CONFIG_KASAN.

Something like that same hunk [0] in kasan_early_init() fixes it. This is still
within arch/arm64, so I still think we should get away without some #ifdeffery
to override the core-code's initial setup of swapper_pg_dir...

Thanks,

James


> [0] make sure fixmap tables go in the init page tables
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 117d080639b3..e097c78a66f8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -770,6 +771,13 @@ void __init early_fixmap_init(void)
>         pmd_t *pmdp;
>         unsigned long addr = FIXADDR_START;
> 
> +       /*
> +        * During early setup we use init_pg_dir, update init_mm so its
> +        * implicit use by pgd_offset_k() gets the live page tables.
> +        * swapper_pg_dir is restored by paging_init().
> +        */
> +       init_mm.pgd = init_pg_dir;
> +
>         pgdp = pgd_offset_k(addr);
>         pgd = READ_ONCE(*pgdp);
>         if (CONFIG_PGTABLE_LEVELS > 3 &&
> 
> 
> 
