From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Dec 2014 12:05:37 +0000
Subject: [PATCH] arm: mm: dump: don't skip final region
In-Reply-To: <CAPvkgC1oOU_3D03ZV-uZqTW_DX8J74oGEKQZTTi2YrC+oSqJyA@mail.gmail.com>
References: <1417782016-11825-1-git-send-email-mark.rutland@arm.com>
 <CAPvkgC1oOU_3D03ZV-uZqTW_DX8J74oGEKQZTTi2YrC+oSqJyA@mail.gmail.com>
Message-ID: <20141208120537.GB21680@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 04:23:47PM +0000, Steve Capper wrote:
> On 5 December 2014 at 12:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > If the final page table entry we walk is a valid mapping, the page table
> > dumping code will not log the region this entry is part of, as the final
> > note_page call in walk_pgd will trigger an early return. Luckily this
> > isn't seen on contemporary systems as they typically don't have enough
> > RAM to extend the linear mapping right to the end of the address space.
> >
> > In note_page, we log a region when we reach its end (i.e. we hit an
> > entry immediately afterwards which has different prot bits or is
> > invalid). The final entry has no subsequent entry, so we will not log
> > this immediately. We try to cater for this with a subsequent call to
> > note_page in ptdump_show, but this returns early as 0 is less than
> > USER_PGTABLES_CEILING, and hence we will skip a valid mapping if it
> > spans to the final entry we note.
> >
> > Luckily, the final note_page call has level == 0, while all prior calls
> > have a non-zero level, so if we also check level we will both skip user
> > entries and handle the final note_page call correctly. Due to the way
> > addr is constructed in the walk_* functions, it can never be less than
> > LOWEST_ADDR when walking the page tables, so it is not necessary to
> > avoid dereferencing invalid table addresses. The existing checks for
> > st->current_prot and st->marker[1].start_address are sufficient to
> > ensure we will not print and/or dereference garbage when trying to log
> > information.
> 
> Do you mean USER_PGTABLES_CEILING instead of LOWEST_ADDR?

Yes; sorry about that.

Looking at this again my commit message is bogus: we can construct an
address below USER_PGTABLES_CEILING in walk_pmd in the case of LPAE, as
USER_PGTABLES_CEILING isn't pgd_t aligned in that case.

As the swapper_pg_dir only contains kernel entries, the handling of
USER_PGTABLES_CEILING is just an optimisation to skip some entries that
we expect to be empty in the kernel page tables. We can handle them in
note_page as we do for other *_none() entries and don't need to skip
them early.

So I can entirely remove the check against USER_PGTABLES_CEILING in
note_page. Would that make sense to you?

I also think we should remove pgdoff from walk_pgd. It's only non-zero
for LPAE kernels, so currently if we corrupt the tables somehow and have
entries below pgdoff we won't note them, making that case harder to
spot.

Thanks,
Mark.

> >
> > This patch adds the aformentioned check for level, ensuring we log all
> > regions in the kernel mappings, including those which span right to the
> > end of the address space.
> >
> 
> One comment above, then:
> Acked-by: Steve Capper <steve.capper@linaro.org>
> 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Steve Capper <steve.capper@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mm/dump.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I found this via inspection, rather than being hit by the problem described
> > above, but it seemed worthwhile to fix this up (otherwise the final note_page
> > call is pointless).
> >
> > diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> > index 5942493..f459c0d 100644
> > --- a/arch/arm/mm/dump.c
> > +++ b/arch/arm/mm/dump.c
> > @@ -220,7 +220,7 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u
> >         static const char units[] = "KMGTPE";
> >         u64 prot = val & pg_level[level].mask;
> >
> > -       if (addr < USER_PGTABLES_CEILING)
> > +       if (level && addr < USER_PGTABLES_CEILING)
> >                 return;
> >
> >         if (!st->level) {
> > --
> > 1.9.1
> >
> 
