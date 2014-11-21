From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 20 Nov 2014 17:08:49 -0800
Subject: [PATCHv5 7/7] arm64: add better page protections to arm64
In-Reply-To: <20141119163151.GC12851@leverpostej>
References: <1416272105-14787-1-git-send-email-lauraa@codeaurora.org>
 <1416272105-14787-8-git-send-email-lauraa@codeaurora.org>
 <20141119163151.GC12851@leverpostej>
Message-ID: <546E90A1.3080107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2014 8:31 AM, Mark Rutland wrote:
...
>
> Could we have macros defined once above, something like:
>
> #ifdef CONFIG_DEBUG_ALIGN_RODATA
> #define ALIGN_DEBUG_RO                  . = ALIGN(1<<SECTION_SHIFT);
> #define ALIGN_DEBUG_RO_MIN(min)         ALIGN_DEBUG_RO
> #else
> #define ALIGN_DEBUG_RO
> #define ALIGN_DEBUG_RO_MIN(min)         . = ALIGN(min)
> #endif
>
> Then we can avoid all the ifdefs below.
>

Yes, that looks cleaner.

>>          .text : {                       /* Real text segment            */
>>                  _stext = .;             /* Text and read-only data      */
>>                          *(.latehead.text)
>> @@ -71,19 +75,35 @@ SECTIONS
>>                  *(.got)                 /* Global offset table          */
>>          }
>>
>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +       . = ALIGN(1<<SECTION_SHIFT);
>> +#endif
>>          RO_DATA(PAGE_SIZE)
>>          EXCEPTION_TABLE(8)
>>          NOTES
>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +       . = ALIGN(1<<SECTION_SHIFT);
>> +#endif
>>          _etext = .;                     /* End of text and rodata section */
>>
>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +       . = ALIGN(1<<SECTION_SHIFT);
>> +#else
>>          . = ALIGN(PAGE_SIZE);
>> +#endif
>>          __init_begin = .;
>>
>>          INIT_TEXT_SECTION(8)
>>          .exit.text : {
>>                  ARM_EXIT_KEEP(EXIT_TEXT)
>>          }
>> +
>> +#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +       . = ALIGN(1<<SECTION_SHIFT);
>> +       __init_data_begin = .;
>
> Is this used anywhere? we seem to have left __init_end after this, and
> haven't introduced an __init_data_end.
>

I think this was a hold over from an older version of the series which
set things up differently. I'll drop it.

>> +#else
>>          . = ALIGN(16);
>> +#endif
>>          .init.data : {
...
>> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
>> +{
>> +       unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
>> +       pgprot_t prot = __pgprot(pud_val(*old_pud) ^ pud_pfn(*old_pud));
>> +       int i = 0;
>> +
>> +       do {
>> +               set_pmd(pmd, __pmd(addr | prot));
>> +               addr += PMD_SIZE;
>> +       } while (pmd++, i++, i < PTRS_PER_PMD);
>> +}
>
> As far as I can see only the functions which call early_alloc
> (split_pmd, alloc_init_pte, alloc_init_pmd) need the __ref annotation,
> so we can drop it heere and elsewhere.
>
> It would be nice if we could avoid the mismatch entirely. Perhaps we
> could pass an allocator function down instead of the early parameter?
> Something like:
>
> static void *late_alloc(unsigned long sz)
> {
> 	BUG_ON(PAGE_SIZE < sz);
> 	return (void *)__get_free_page(PGALLOC_GFP);
> }
>
> which we could pass down from create_mapping_late in place of
> early_alloc for create_id_mapping and create_mapping.
>

Yes, the __ref annotations are ugly. I'll see if I can clean them
up.

> Thanks,
> Mark.
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
