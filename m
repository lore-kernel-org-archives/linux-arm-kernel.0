From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Oct 2016 17:57:33 +0100
Subject: [PATCH v3 3/5] arm64: mm: set the contiguous bit for kernel
 mappings where appropriate
In-Reply-To: <20161013162806.GH21592@e104818-lin.cambridge.arm.com>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476271425-19401-4-git-send-email-ard.biesheuvel@linaro.org>
 <20161013162806.GH21592@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9WqUvtHRJvgWhsvYwFOgho97EaLV4qojaa0fjGpJT3WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2016 at 17:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Oct 12, 2016 at 12:23:43PM +0100, Ard Biesheuvel wrote:
>> Now that we no longer allow live kernel PMDs to be split, it is safe to
>> start using the contiguous bit for kernel mappings. So set the contiguous
>> bit in the kernel page mappings for regions whose size and alignment are
>> suitable for this.
>>
>> This enables the following contiguous range sizes for the virtual mapping
>> of the kernel image, and for the linear mapping:
>>
>>           granule size |  cont PTE  |  cont PMD  |
>>           -------------+------------+------------+
>>                4 KB    |    64 KB   |   32 MB    |
>>               16 KB    |     2 MB   |    1 GB*   |
>>               64 KB    |     2 MB   |   16 GB*   |
>>
>> * only when built for 3 or more levels of translation
>
> I assume the limitation to have contiguous PMD only with 3 or move
> levels is because of the way p*d folding was implemented in the kernel.
> With nopmd, looping over pmds is done in __create_pgd_mapping() rather
> than alloc_init_pmd().
>
> A potential solution would be to replicate the contiguous pmd code to
> the pud and pgd level, though we probably won't benefit from any
> contiguous entries at higher level (when more than 2 levels).
> Alternatively, with an #ifdef __PGTABLE_PMD_FOLDED, we could set the
> PMD_CONT in prot in __create_pgd_mapping() directly (if the right
> addr/phys alignment).
>

Indeed. See the next patch :-)

> Anyway, it's probably not worth the effort given that 42-bit VA with 64K
> pages is becoming a less likely configuration (36-bit VA with 16K pages
> is even less likely, also depending on EXPERT).
>

This is the reason I put it in a separate patch: this one contains the
most useful combinations, and the next patch adds the missing ones,
but clutters up the code significantly. I'm perfectly happy to drop 4
and 5 if you don't think it is worth the trouble.
