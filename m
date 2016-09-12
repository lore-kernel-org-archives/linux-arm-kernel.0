From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Sep 2016 16:54:58 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <20160912153858.GD14165@leverpostej>
References: <1473689784-29745-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160912145931.GB14165@leverpostej>
 <CAKv+Gu9pfBt5n58vUy7P-VytJ1xRiETO8vqxkPqQ3tF6WtXJaQ@mail.gmail.com>
 <20160912153858.GD14165@leverpostej>
Message-ID: <CAKv+Gu9R+jrc5w8FgrKKnm+vk82ahLHy-NYV4JzULHjPbNy02w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2016 at 16:40, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Sep 12, 2016 at 04:12:19PM +0100, Ard Biesheuvel wrote:
>> On 12 September 2016 at 15:59, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Mon, Sep 12, 2016 at 03:16:24PM +0100, Ard Biesheuvel wrote:
>> >> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
>> >> index 4e7e7067afdb..44e94e234ba0 100644
>> >> --- a/arch/arm64/include/asm/sections.h
>> >> +++ b/arch/arm64/include/asm/sections.h
>> >> @@ -26,5 +26,6 @@ extern char __hyp_text_start[], __hyp_text_end[];
>> >>  extern char __idmap_text_start[], __idmap_text_end[];
>> >>  extern char __irqentry_text_start[], __irqentry_text_end[];
>> >>  extern char __mmuoff_data_start[], __mmuoff_data_end[];
>> >> +extern char __robss_start[], __robss_end[];
>> >>
>> >>  #endif /* __ASM_SECTIONS_H */
>> >> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> >> index 5ce9b2929e0d..eae5036dc725 100644
>> >> --- a/arch/arm64/kernel/vmlinux.lds.S
>> >> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> >> @@ -209,9 +209,19 @@ SECTIONS
>> >>
>> >>       BSS_SECTION(0, 0, 0)
>> >>
>> >> -     . = ALIGN(PAGE_SIZE);
>> >> +     . = ALIGN(SEGMENT_ALIGN);
>> >> +     __robss_start = .;
>> >>       idmap_pg_dir = .;
>> >> -     . += IDMAP_DIR_SIZE;
>> >> +     . = ALIGN(. + IDMAP_DIR_SIZE + PAGE_SIZE, SEGMENT_ALIGN);
>> >> +     __robss_end = .;
>> >
>> > Is it really worth aligning this beyond PAGE_SIZE?
>> >
>> > We shouldn't be poking these very often, the padding is always larger
>> > than the number of used pages, and the swapper dir is relegated to page
>> > mappings regardless.
>>
>> The segment alignment is intended to take advantage of PTE_CONT
>> mappings (support for which still hasn't landed, afaict). I don't care
>> deeply either way ...
>
> I understood that; my concern was that there was little gain relative to
> the cost of the padding:
>
> * With the above .robss will contain 5 pages that we care about, but
>   could be padded to 16 or 512 pages (assuming 4K pages with or without
>   DEBUG_RODATA_ALIGN). I think we can put those pages to better use.
>

Yes, I realised that. DEBUG_RODATA_ALIGN generally wastes a lot of
memory on padding, and this case is no different.

> * We don't frequently need to poke the idmap, so in practice I suspect
>   TLB pressure for it doesn't matter too much.
>

Does that apply to empty_zero_page as well?

> * As we don't align _end, swapper (which we're more likely to access
>   frequently) is mapped with a non-contiguous mapping regardless.
>

Indeed. However, we could defer the r/o mapping of this segment to
mark_rodata_ro(), which allows us to move other stuff in there as
well, such as bm_pmd/bm_pud (from fixmap), and actually, anything that
would qualify for __ro_after_init but is not statically initialized to
non-zero value.


> [...]
>
>> >>       /*
>> >> -      * Map the linear alias of the [_text, __init_begin) interval as
>> >> -      * read-only/non-executable. This makes the contents of the
>> >> -      * region accessible to subsystems such as hibernate, but
>> >> -      * protects it from inadvertent modification or execution.
>> >> +      * Map the linear alias of the intervals [_text, __init_begin) and
>> >> +      * [robss_start, robss_end) as read-only/non-executable. This makes
>> >> +      * the contents of these regions accessible to subsystems such
>> >> +      * as hibernate, but protects them from inadvertent modification or
>> >> +      * execution.
>> >
>> > For completeness, it may also be worth stating that we're mapping the
>> > gap between those as usual, since this will be freed.
>> >
>> > Then again, maybe not. ;)
>>
>> Well, there is a tacit assumption here that a memblock that covers any
>> part of the kernel covers all of it, but I think this is reasonable,
>> given that the memblock layer merges adjacent entries, and we could
>> not have holes.
>
> By "the gap between those", I meant the linear alias of the init memory
> that we explicitly mapped with a call to __create_pgd_mapping after the
> comment. As taht falls between the start of text and end of robss it
> would not have been mapped prior to this.
>

I don't think the code maps any more or less that it did before. The
only difference is that anything after __init_begin is now no longer
mapped by the conditional 'if (kernel_end < end)' call to
__create_pgd_mapping() above but by the second to last one below.

> Trivially, the comment above mentioned two mappings we create, when
> there are three calls to __create_pgd_mapping.
>
> Not a big deal, either way.
>
>> Re freeing, I don't get your point: all of these mappings are permanent.
>
> Please ignore this, it was irrelevant. ;)
>

OK.
