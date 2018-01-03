From: steve.capper@arm.com (Steve Capper)
Date: Wed, 3 Jan 2018 17:11:11 +0000
Subject: [PATCH V3 3/3] arm64: Extend early page table code to allow for
 larger kernels
In-Reply-To: <CAKv+Gu_uQ-5TNmWRcmADR6Rnm0qDL7FHZ7FKGR7Kd-toXTxqww@mail.gmail.com>
References: <20180102151254.4063-1-steve.capper@arm.com>
 <20180102151254.4063-4-steve.capper@arm.com>
 <CAKv+Gu8tpRhri5CbvhYzE-ZZViqt7EAiDhf=EY_Ft=LoWu5-cQ@mail.gmail.com>
 <20180103162011.xswbj25mszudlmyt@capper-debian.cambridge.arm.com>
 <CAKv+Gu_uQ-5TNmWRcmADR6Rnm0qDL7FHZ7FKGR7Kd-toXTxqww@mail.gmail.com>
Message-ID: <20180103171111.7axxlpcdplfatl56@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 03, 2018 at 04:38:47PM +0000, Ard Biesheuvel wrote:
> On 3 January 2018 at 16:20, Steve Capper <steve.capper@arm.com> wrote:
> > On Tue, Jan 02, 2018 at 10:01:29PM +0000, Ard Biesheuvel wrote:
> >> Hi Steve,
> >
> > Hi Ard,
> >
> >>
> >> On 2 January 2018 at 15:12, Steve Capper <steve.capper@arm.com> wrote:
> >> > Currently the early assembler page table code assumes that precisely
> >> > 1xpgd, 1xpud, 1xpmd are sufficient to represent the early kernel text
> >> > mappings.
> >> >
> >> > Unfortunately this is rarely the case when running with a 16KB granule,
> >> > and we also run into limits with 4KB granule when building much larger
> >> > kernels.
> >> >
> >> > This patch re-writes the early page table logic to compute indices of
> >> > mappings for each level of page table, and if multiple indices are
> >> > required, the next-level page table is scaled up accordingly.
> >> >
> >> > Also the required size of the swapper_pg_dir is computed at link time
> >> > to cover the mapping [KIMAGE_ADDR + VOFFSET, _end]. When KASLR is
> >> > enabled, an extra page is set aside for each level that may require extra
> >> > entries at runtime.
> >> >
> >> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> >> >
> >> > ---
> >> > Changed in V3:
> >> > Corrected KASLR computation
> >> > Rebased against arm64/for-next/core, particularly Kristina's 52-bit
> >> > PA series.
> >> > ---
> >> >  arch/arm64/include/asm/kernel-pgtable.h |  47 ++++++++++-
> >> >  arch/arm64/include/asm/pgtable.h        |   1 +
> >> >  arch/arm64/kernel/head.S                | 145 +++++++++++++++++++++++---------
> >> >  arch/arm64/kernel/vmlinux.lds.S         |   1 +
> >> >  arch/arm64/mm/mmu.c                     |   3 +-
> >> >  5 files changed, 157 insertions(+), 40 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> >> > index 77a27af01371..82386e860dd2 100644
> >> > --- a/arch/arm64/include/asm/kernel-pgtable.h
> >> > +++ b/arch/arm64/include/asm/kernel-pgtable.h

[...]

> >> > - * Preserves:  tbl, flags
> >> > - * Corrupts:   phys, start, end, tmp, pstate
> >> > + * Preserves:  vstart, vend, shift, ptrs
> >> > + * Returns:    istart, iend, count
> >> >   */
> >> > -       .macro  create_block_map, tbl, flags, phys, start, end, tmp
> >> > -       lsr     \start, \start, #SWAPPER_BLOCK_SHIFT
> >> > -       and     \start, \start, #PTRS_PER_PTE - 1       // table index
> >> > -       bic     \phys, \phys, #SWAPPER_BLOCK_SIZE - 1
> >> > -       lsr     \end, \end, #SWAPPER_BLOCK_SHIFT
> >> > -       and     \end, \end, #PTRS_PER_PTE - 1           // table end index
> >> > -9999:  phys_to_pte \phys, \tmp
> >> > -       orr     \tmp, \tmp, \flags                      // table entry
> >> > -       str     \tmp, [\tbl, \start, lsl #3]            // store the entry
> >> > -       add     \start, \start, #1                      // next entry
> >> > -       add     \phys, \phys, #SWAPPER_BLOCK_SIZE               // next block
> >> > -       cmp     \start, \end
> >> > -       b.ls    9999b
> >> > +       .macro compute_indices, vstart, vend, shift, ptrs, istart, iend, count
> >> > +       lsr     \iend, \vend, \shift
> >> > +       mov     \istart, \ptrs
> >> > +       sub     \istart, \istart, #1
> >> > +       and     \iend, \iend, \istart   // iend = (vend >> shift) & (ptrs - 1)
> >> > +       mov     \istart, \ptrs
> >> > +       sub     \count, \count, #1
> >> > +       mul     \istart, \istart, \count
> >> > +       add     \iend, \iend, \istart   // iend += (count - 1) * ptrs
> >> > +                                       // our entries span multiple tables
> >> > +
> >> > +       lsr     \istart, \vstart, \shift
> >> > +       mov     \count, \ptrs
> >> > +       sub     \count, \count, #1
> >> > +       and     \istart, \istart, \count
> >> > +
> >> > +       sub     \count, \iend, \istart
> >> > +       add     \count, \count, #1
> >> > +       .endm
> >> > +
> >>
> >> You can simplify this macro by using an immediate for \ptrs. Please
> >> see the diff below [whitespace mangling courtesy of Gmail]
> >
> > Thanks, I like the simplification a lot. For 52-bit kernel VAs though, I
> > will need a variable PTRS_PER_PGD at compile time.
> >
> > For 52-bit kernel PAs one can just use the maximum number of ptrs available.
> > For a 48-bit PA the leading address bits will always be zero, thus we
> > will derive the same PGD indices from both 48 and 52 bit PTRS_PER_PGD.
> >
> > For kernel VAs, because the leading address bits are one, we need to use a
> > PTRS_PER_PGD corresponding to the VA size.
> >
> 
> OK, so you are saying you shouldn't mask off too many bits, right? In
> any case, I suppose you can just use the same trick as I used for
> .Lidmap_ptrs_per_pgd, i.e., use .set to assign the correct value and
> pass that into the macro.
>

Yeah, that's right, one needs to mask off the correct number of bits.

If I've understood correctly, we choose which .set to use at compile
time rather than runtime though?

The problem I have is the number of PGDs is only known precisely at boot
time when one has a kernel that switches between 48/52 bit VAs. That's
why I had the number of PGDs in a register.

Cheers,
-- 
Steve
