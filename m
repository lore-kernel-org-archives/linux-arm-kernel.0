From: alex@ghiti.fr (Alexandre Ghiti)
Date: Wed,  4 Jul 2018 05:51:56 +0000
Subject: [PATCH 00/11] hugetlb: Factorize architecture hugetlb primitives
Message-ID: <20180704055207.27978-1-alex@ghiti.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to reduce copy/paste of functions across architectures and then
make riscv hugetlb port simpler and smaller, this patchset intends to
factorize the numerous hugetlb primitives that are defined across all the
architectures.

Except for prepare_hugepage_range, this patchset moves the versions that
are just pass-through to standard pte primitives into
asm-generic/hugetlb.h by using the same #ifdef semantic that can be
found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.

s390 architecture has not been tackled in this serie since it does not
use asm-generic/hugetlb.h at all.
powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).

This patchset has been compiled on x86 only.

Alexandre Ghiti (11):
  hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
  hugetlb: Introduce generic version of hugetlb_free_pgd_range
  hugetlb: Introduce generic version of set_huge_pte_at
  hugetlb: Introduce generic version of huge_ptep_get_and_clear
  hugetlb: Introduce generic version of huge_ptep_clear_flush
  hugetlb: Introduce generic version of huge_pte_none
  hugetlb: Introduce generic version of huge_pte_wrprotect
  hugetlb: Introduce generic version of prepare_hugepage_range
  hugetlb: Introduce generic version of huge_ptep_set_wrprotect
  hugetlb: Introduce generic version of huge_ptep_set_access_flags
  hugetlb: Introduce generic version of huge_ptep_get

 arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
 arch/arm/include/asm/hugetlb.h               | 33 +----------
 arch/arm64/include/asm/hugetlb.h             | 39 +++---------
 arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
 arch/mips/include/asm/hugetlb.h              | 40 +++----------
 arch/parisc/include/asm/hugetlb.h            | 33 +++--------
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
 arch/sh/include/asm/hugetlb.h                | 54 ++---------------
 arch/sparc/include/asm/hugetlb.h             | 40 +++----------
 arch/x86/include/asm/hugetlb.h               | 72 +----------------------
 include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
 15 files changed, 143 insertions(+), 384 deletions(-)

-- 
2.16.2
