From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 17:38:33 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <20161011162914.GF9532@arm.com>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
 <CAPvkgC1p5yZLtENYMi6zd5-pPDOYUtMw0Lxvb592u975gc+Zvg@mail.gmail.com>
 <CAKv+Gu-e6HT2YNvXJV2AbAzLrEeV6OvM6-hfTsCH0oXqH8zbKQ@mail.gmail.com>
 <CAKv+Gu9W69rP5o09t+d498nVE666Show1VK-Sm9LmchjeUsD_A@mail.gmail.com>
 <20161011124118.GB9532@arm.com>
 <CAKv+Gu_AX80Uts8gtn+PD9F0DWDMU2tEw6PEZg1p6G+ajXS_eg@mail.gmail.com>
 <20161011162914.GF9532@arm.com>
Message-ID: <CAKv+Gu8XrB5id0bX1mobsyZte4BY_Z7=+aDkPdEK2Zv0MHn7Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2016 at 17:29, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Oct 11, 2016 at 01:56:26PM +0100, Ard Biesheuvel wrote:
>> On 11 October 2016 at 13:41, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Oct 11, 2016 at 12:17:54PM +0100, Ard Biesheuvel wrote:
>> >> On 11 October 2016 at 10:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >> > On 11 October 2016 at 09:48, Steve Capper <steve.capper@linaro.org> wrote:
>> >> >> So in arch/arm64/include/asm/pgtable-hwdef.h, we have:
>> >> >> CONT_PTE_SHIFT
>> >> >> CONT_PMD_SHIFT
>> >> >> CONT_PTES
>> >> >> CONT_PMDS
>> >> >> CONT_PTE_SIZE
>> >> >> CONT_PTE_MASK
>> >> >> ...
>> >> >>
>> >> >> which are used by the contiguous hint HugeTLB code.
>> >> >> Can those be adopted instead of CONT_MASK and CONT_SIZE?
>> >> >>
>> >>
>> >> Looking at the hugetlb code, it appears to support contiguous PMDs for
>> >> 4k and 64k pages as well, while the ARM ARM only defines it for 16k
>> >> pages. I suppose the contiguous bit is simply ignored for level 2
>> >> entries when using 4k or 64k pages kernels, but I think it would be
>> >> better for the code to reflect this as well.
>> >
>> > Which bit in the ARM ARM says that you can't support contiguous PMDs for 4k
>> > and 64k pages? I see that the number of contiguous entries changes between
>> > levels for 16k pages, but that's it.
>> >
>>
>> You are right, the ARM ARM does not say that at all. But given Mark's comment:
>>
>> """
>> With 16K pages, we can have contiguous PMD entries. Should we handle those,
>> too? e.g. have separate {PMD,PTE}_CONT{,_SIZE}?
>> """
>>
>> it seems I am not the only one who is confused about this. In any
>> case, the fact that the ARM ARM documents levels 2 and 3 explicitly
>> for 16k pages does very little to clarify at which levels this bit is
>> defined, and if it is defined at levels < 2, what the granularity is
>> for 16k pages.
>
> I see you're going to work on a more comprehensive v3 (thanks!), but just
> to help clarify this: the contiguous bit is valid whenever a block or page
> (i.e. a leaf) entry is valid. The only complication with 16k pages is that
> the number of contiguous entries changes between level 2 and level 3,
> which makes sense if you think about the TLB entries supported due to
> non-contiguous block mappings in other regimes anyway (and brings into
> question whether people bother with 16G in practice).
>
> That means you can use the contiguous bit as:
>
> 4k: levels 1,2,3 (16G, 32M, 64K)
> 16k: levels 2,3 (1G, 2M)
> 64k: levels 2,3 (16G, 2M)
>
> Hopefully my maths is correct and that clears things up,
>

Yes, that resembles my own calculations. Another complication is that
folded PUDs and PMDs need to be dealt with at the PGD level, but I
think I have worked it out now.

Re 16 GB: are you saying don't bother? Because supporting this would
require ARM64_MEMSTART_SHIFT to be increased to (CONT_PUD_SHIFT +
PUD_SHIFT) or (CONT_PMD_SHIFT + PMD_SHIFT) [for 4k and 16k/64k,
respectively] in order to guarantee that the physical and virtual
addresses are always equal modulo 16 GB (for granules that support
it). It's a nice idea that the linear mapping can be covered by fewer
TLB entries if you have huge amounts of RAM, but if the hardware is
unlikely to honour it, it may not be worth the trouble.
