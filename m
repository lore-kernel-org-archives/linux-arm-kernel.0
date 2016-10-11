From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 13:56:26 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <20161011124118.GB9532@arm.com>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
 <CAPvkgC1p5yZLtENYMi6zd5-pPDOYUtMw0Lxvb592u975gc+Zvg@mail.gmail.com>
 <CAKv+Gu-e6HT2YNvXJV2AbAzLrEeV6OvM6-hfTsCH0oXqH8zbKQ@mail.gmail.com>
 <CAKv+Gu9W69rP5o09t+d498nVE666Show1VK-Sm9LmchjeUsD_A@mail.gmail.com>
 <20161011124118.GB9532@arm.com>
Message-ID: <CAKv+Gu_AX80Uts8gtn+PD9F0DWDMU2tEw6PEZg1p6G+ajXS_eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2016 at 13:41, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Oct 11, 2016 at 12:17:54PM +0100, Ard Biesheuvel wrote:
>> On 11 October 2016 at 10:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 11 October 2016 at 09:48, Steve Capper <steve.capper@linaro.org> wrote:
>> >> So in arch/arm64/include/asm/pgtable-hwdef.h, we have:
>> >> CONT_PTE_SHIFT
>> >> CONT_PMD_SHIFT
>> >> CONT_PTES
>> >> CONT_PMDS
>> >> CONT_PTE_SIZE
>> >> CONT_PTE_MASK
>> >> ...
>> >>
>> >> which are used by the contiguous hint HugeTLB code.
>> >> Can those be adopted instead of CONT_MASK and CONT_SIZE?
>> >>
>>
>> Looking at the hugetlb code, it appears to support contiguous PMDs for
>> 4k and 64k pages as well, while the ARM ARM only defines it for 16k
>> pages. I suppose the contiguous bit is simply ignored for level 2
>> entries when using 4k or 64k pages kernels, but I think it would be
>> better for the code to reflect this as well.
>
> Which bit in the ARM ARM says that you can't support contiguous PMDs for 4k
> and 64k pages? I see that the number of contiguous entries changes between
> levels for 16k pages, but that's it.
>

You are right, the ARM ARM does not say that at all. But given Mark's comment:

"""
With 16K pages, we can have contiguous PMD entries. Should we handle those,
too? e.g. have separate {PMD,PTE}_CONT{,_SIZE}?
"""

it seems I am not the only one who is confused about this. In any
case, the fact that the ARM ARM documents levels 2 and 3 explicitly
for 16k pages does very little to clarify at which levels this bit is
defined, and if it is defined at levels < 2, what the granularity is
for 16k pages.

So the v2 I just sent out could be modified to allow contiguous PMDs
(32 MB blocks) on 4 KB kernels, which seems useful. I will take that
into account when I prepare the v3.

-- 
Ard.
