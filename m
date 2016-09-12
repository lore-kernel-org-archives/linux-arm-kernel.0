From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 17:26:33 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <CAKv+Gu9R+jrc5w8FgrKKnm+vk82ahLHy-NYV4JzULHjPbNy02w@mail.gmail.com>
References: <1473689784-29745-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160912145931.GB14165@leverpostej>
 <CAKv+Gu9pfBt5n58vUy7P-VytJ1xRiETO8vqxkPqQ3tF6WtXJaQ@mail.gmail.com>
 <20160912153858.GD14165@leverpostej>
 <CAKv+Gu9R+jrc5w8FgrKKnm+vk82ahLHy-NYV4JzULHjPbNy02w@mail.gmail.com>
Message-ID: <20160912162633.GE14165@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 04:54:58PM +0100, Ard Biesheuvel wrote:
> On 12 September 2016 at 16:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Sep 12, 2016 at 04:12:19PM +0100, Ard Biesheuvel wrote:
> >> On 12 September 2016 at 15:59, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Mon, Sep 12, 2016 at 03:16:24PM +0100, Ard Biesheuvel wrote:
> >> >>       BSS_SECTION(0, 0, 0)
> >> >>
> >> >> -     . = ALIGN(PAGE_SIZE);
> >> >> +     . = ALIGN(SEGMENT_ALIGN);
> >> >> +     __robss_start = .;
> >> >>       idmap_pg_dir = .;
> >> >> -     . += IDMAP_DIR_SIZE;
> >> >> +     . = ALIGN(. + IDMAP_DIR_SIZE + PAGE_SIZE, SEGMENT_ALIGN);
> >> >> +     __robss_end = .;
> >> >
> >> > Is it really worth aligning this beyond PAGE_SIZE?
> >> >
> >> > We shouldn't be poking these very often, the padding is always larger
> >> > than the number of used pages, and the swapper dir is relegated to page
> >> > mappings regardless.
> >>
> >> The segment alignment is intended to take advantage of PTE_CONT
> >> mappings (support for which still hasn't landed, afaict). I don't care
> >> deeply either way ...
> >
> > I understood that; my concern was that there was little gain relative to
> > the cost of the padding:
> >
> > * With the above .robss will contain 5 pages that we care about, but
> >   could be padded to 16 or 512 pages (assuming 4K pages with or without
> >   DEBUG_RODATA_ALIGN). I think we can put those pages to better use.
> 
> Yes, I realised that. DEBUG_RODATA_ALIGN generally wastes a lot of
> memory on padding, and this case is no different.
> 
> > * We don't frequently need to poke the idmap, so in practice I suspect
> >   TLB pressure for it doesn't matter too much.
> 
> Does that apply to empty_zero_page as well?

Good question -- I'm not sure how often we access it in practice from a
kernel VA.

> > * As we don't align _end, swapper (which we're more likely to access
> >   frequently) is mapped with a non-contiguous mapping regardless.
> 
> Indeed. However, we could defer the r/o mapping of this segment to
> mark_rodata_ro(), which allows us to move other stuff in there as
> well, such as bm_pmd/bm_pud (from fixmap), and actually, anything that
> would qualify for __ro_after_init but is not statically initialized to
> non-zero value.

True. That could be be good.

Thanks,
Mark.
