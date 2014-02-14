From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Feb 2014 10:15:30 +0000
Subject: [PATCH v2] ARM: mm: report both sections from PMD
In-Reply-To: <CAGXu5jKG=8Fwd=yJEFF0-8tO0v4H_3sr_x2JLW4jm1Y2ouDFHQ@mail.gmail.com>
References: <20140212224638.GA4558@www.outflux.net>
 <20140213171211.GJ19841@arm.com>
 <CAGXu5jKG=8Fwd=yJEFF0-8tO0v4H_3sr_x2JLW4jm1Y2ouDFHQ@mail.gmail.com>
Message-ID: <20140214101530.GB10590@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 07:52:03PM +0000, Kees Cook wrote:
> On Thu, Feb 13, 2014 at 9:12 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, Feb 12, 2014 at 10:46:38PM +0000, Kees Cook wrote:
> >> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> >> index 03243f7eeddf..fb3de59ee811 100644
> >> --- a/arch/arm/include/asm/pgtable-3level.h
> >> +++ b/arch/arm/include/asm/pgtable-3level.h
> >> @@ -138,10 +138,6 @@
> >>  #define pud_none(pud)                (!pud_val(pud))
> >>  #define pud_bad(pud)         (!(pud_val(pud) & 2))
> >>  #define pud_present(pud)     (pud_val(pud))
> >> -#define pmd_table(pmd)               ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >> -                                              PMD_TYPE_TABLE)
> >> -#define pmd_sect(pmd)                ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >> -                                              PMD_TYPE_SECT)
> >>  #define pmd_large(pmd)               pmd_sect(pmd)
> >>
> >>  #define pud_clear(pudp)                      \
> >> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> >> index 7d59b524f2af..934aa5b60c7c 100644
> >> --- a/arch/arm/include/asm/pgtable.h
> >> +++ b/arch/arm/include/asm/pgtable.h
> >> @@ -183,6 +183,10 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> >>
> >>  #define pmd_none(pmd)                (!pmd_val(pmd))
> >>  #define pmd_present(pmd)     (pmd_val(pmd))
> >> +#define pmd_table(pmd)               ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >> +                                              PMD_TYPE_TABLE)
> >> +#define pmd_sect(pmd)                ((pmd_val(pmd) & PMD_TYPE_MASK) == \
> >> +                                              PMD_TYPE_SECT)
> >
> > Do you still need to move these two if you only use pmd_large()? AFAICT,
> > it is equivalent to pmd_sect().
> 
> Why does pmd_sect exist? I can reduce it to just using pmd_large.

pmd_sect/pmd_table were there first and used by kvm. The pmd_large() was
added by Russell because the dump.c code was derived from x86 which uses
such macro. And we have another close relative, pmd_huge(), though only
defined if CONFIG_HUGETLB_PAGE.

We could drop pmd_large() in favour of pmd_sect() but it's up to
Russell. OTOH, when someone will try to add arm64 support, I'll most
likely ask for part of the x86 code to be turned into a generic library
and we'll need some common naming for such macros (e.g. pmd_large()).

-- 
Catalin
