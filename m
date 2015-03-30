From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Mar 2015 15:34:42 +0100
Subject: [PATCH 2/4] arm64: fixmap: move translation tables to dedicated
 region
In-Reply-To: <CAKv+Gu-wibouuV7mZHPycofPk3xT=LEEAPoxKWkEX9u+7u+sWA@mail.gmail.com>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150326012808.GD1676@flaeskesteg-linux.cambridge.arm.com>
 <CAKv+Gu-wibouuV7mZHPycofPk3xT=LEEAPoxKWkEX9u+7u+sWA@mail.gmail.com>
Message-ID: <20150330143442.GF29200@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 06:20:38AM +0000, Ard Biesheuvel wrote:
> On 26 March 2015 at 02:28, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Ard,
> >
> > On Mon, Mar 23, 2015 at 03:36:54PM +0000, Ard Biesheuvel wrote:
> >> This moves the fixmap translation tables to a dedicated region
> >> in the linker map. This is needed for a split kernel text from
> >> the linear mapping, to ensure that the contents of the tables
> >> rely on a single translation regime.
> >
> > I'm not sure what you mean by this. Could you elaborate?
> >
> > What problem would we have if we didn't have this section, and how does this
> > section solve that?
> >
> 
> The pgd manipulation code is riddled with va/pa and pa/va
> translations, and uses both statically and dynamically allocated
> pages. Untangling all of that is not so easy, and it is simpler just
> to refer to those regions through the linear mapping exclusively.

I'm missing the leap as to how the .pgdir section helps with that,
unfortunately ;)

> > Regardless, I have some comments on the implementation below.
> >
> >> Also make the population of the translation levels conditional,
> >> so that the kernel text can share some levels of translation if
> >> needed.
> >
> > I guess you mean shared with the tables for the text mapping?
> >
> > Please word this to be explicit w.r.t. what is shared between whom, and when.
> >
> 
> Yes. Currently, the address space is split down the middle, so fixmap
> and linear always live in regions that are disjoint all the way up to
> different root pgdir entries. Once that changes, the fixmap code needs
> to be prepared for any of the levels it needs to populated having
> already been populated.

Ok.

> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/linkage.h |  2 ++
> >>  arch/arm64/kernel/vmlinux.lds.S  | 15 ++++++++++-----
> >>  arch/arm64/mm/mmu.c              | 15 +++++++++------
> >>  3 files changed, 21 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> >> index 636c1bced7d4..dc9354de6f52 100644
> >> --- a/arch/arm64/include/asm/linkage.h
> >> +++ b/arch/arm64/include/asm/linkage.h
> >> @@ -4,4 +4,6 @@
> >>  #define __ALIGN              .align 4
> >>  #define __ALIGN_STR  ".align 4"
> >>
> >> +#define __pgdir              __attribute__((__section__(".pgdir")))
> >
> > It would be nice for this to also provide page alignment, like
> > __page_aligned_bss that this replaces uses of.
> >
> 
> I thought it wasn't necessary, because we allocate a full page for the
> highest level, but we should probably not rely on that.

While it shouldn't be necessary I'd feel more comfortable knowing that
the alignment is definitely applied to each object.

[...]

> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 43496748e3d9..bb3ce41130f3 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -549,12 +549,12 @@ void vmemmap_free(unsigned long start, unsigned long end)
> >>  }
> >>  #endif       /* CONFIG_SPARSEMEM_VMEMMAP */
> >>
> >> -static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> >> +static pte_t bm_pte[PTRS_PER_PTE] __pgdir;
> >>  #if CONFIG_ARM64_PGTABLE_LEVELS > 2
> >> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
> >> +static pmd_t bm_pmd[PTRS_PER_PMD] __pgdir;
> >>  #endif
> >>  #if CONFIG_ARM64_PGTABLE_LEVELS > 3
> >> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
> >> +static pud_t bm_pud[PTRS_PER_PUD] __pgdir;
> >>  #endif
> >
> > These used to be zeroed (by the bss init code in head.S), but now they won't
> > be, and as they live after all the initialized data they could contain garbage
> > if we're unlucky. So I suspect this is broken.
> >
> 
> Actually, they are in this case, as the init code zeroes from the
> beginning of idmap to the end of swapper :-)
> But that is something that should be more explicit I guess
> 
> I was wondering if we should worry about doing the zeroing with the
> caches off, which is not needed for fixmap

It's unfortunate to do more than we have to before the caches are off,
so I guess we need to be able to determine the region(s) corresponding
to the idmap + swapper, independent of the other page tables.

> > If we zero these before use then that's fine. We could define the swapper and
> > idmap similarly in this C file for consistency (we zero those in head.S). That
> > would bring all the page table allocations into the same file, and .pgdir could
> > be simpler:
> >
> >         .pgdir {
> >                 . = ALIGN(PAGE_SIZE);
> >                 __pgdir_start = .;
> >                 *(.pgdir)
> >                 __pgdir_end = .;
> >         }

Given that, the simplified .pgdir suggestion wouldn't work unless we
modified head.S to handle the idmap and swapper independently (rather
than treating them as a single entity for cache maintenance and
zeroing).

Mark.
