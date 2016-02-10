From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 10 Feb 2016 11:40:00 +0100
Subject: [PATCHv4 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <20160210103814.GC13577@e104818-lin.cambridge.arm.com>
References: <1454718288-31374-1-git-send-email-labbott@fedoraproject.org>
 <1454718288-31374-3-git-send-email-labbott@fedoraproject.org>
 <20160210103814.GC13577@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9H2d5762MBAJGrxchw1CYCsz0WwAs=8zTf0aB1eFT8RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2016 at 11:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Feb 05, 2016 at 04:24:47PM -0800, Laura Abbott wrote:
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -149,6 +149,19 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
>>       } while (pmd++, i++, i < PTRS_PER_PMD);
>>  }
>>
>> +bool block_mappings_allowed(phys_addr_t (*pgtable_alloc)(void))
>> +{
>> +
>> +     /*
>> +      * If debug_page_alloc is enabled we must map the linear map
>> +      * using pages. However, other mappings created by
>> +      * create_mapping_noalloc must use sections in some cases. Allow
>> +      * sections to be used in those cases, where no pgtable_alloc
>> +      * function is provided.
>> +      */
>> +     return !pgtable_alloc || !debug_pagealloc_enabled();
>> +}
>
> This breaks the build when CONFIG_DEBUG_PAGEALLOC is not enabled
> (defconfig) since debug_pagealloc_enabled() is not defined. A fix went
> in next/master as commit 0987684b855c
> ("mm-slab-clean-up-debug_pagealloc-processing-code-fix"). I need to
> track it down and merge it via the arm64 tree, otherwise I'll add some
> #ifdefs in this function.
>
> BTW, shouldn't the block_mappings_allowed() function be static?
>

Yes, it should.
