From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Jan 2015 16:36:30 +0000
Subject: [PATCH] arm64: mm: use *_sect to check for section maps
Message-ID: <1422376590-14312-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The below patch is based on the arm64 for-next/core branch [1]. While
currently it shouldn't result in a functional change given the
definition of the *_bad macros, I believe it makes the code better
describe the intended behaviour (hence making it easier to read).

I've given this a spin on Juno with and without DEBUG_RODATA.

Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core

---->8----
The {pgd,pud,pmd}_bad family of macros have slightly fuzzy
cross-architecture semantics, and seem to imply a populated entry that
is not a next-level table, rather than a particular type of entry (e.g.
a section map).

In arm64 code, for those cases where we care about whether an entry is a
section mapping, we can instead use the {pud,pmd}_sect macros to
explicitly check for this case. This helps to document precisely what we
care about, making the code easier to read, and allows for future
relaxation of the *_bad macros to check for other "bad" entries.

To that end this patch updates the table dumping and initial table setup
to check for section mappings with {pud,pmd}_sect, and adds/restores
BUG_ON(*_bad((*p)) checks after we've handled the *_sect and *_none
cases so as to catch remaining "bad" cases.

In the fault handling code, show_pte is left with *_bad checks as it
only cares about whether it can walk the next level table, and this path
is used for both kernel and userspace fault handling. The former case
will be followed by a die() where we'll report the address that
triggered the fault, which can be useful context for debugging.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Steve Capper <steve.capper@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 18 ++++++++++++------
 arch/arm64/mm/mmu.c  |  6 ++++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index bbc5a29..61296537 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -249,10 +249,12 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
 		addr = start + i * PMD_SIZE;
-		if (pmd_none(*pmd) || pmd_sect(*pmd) || pmd_bad(*pmd))
+		if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 			note_page(st, addr, 3, pmd_val(*pmd));
-		else
+		} else {
+			BUG_ON(pmd_bad(*pmd));
 			walk_pte(st, pmd, addr);
+		}
 	}
 }
 
@@ -264,10 +266,12 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
 		addr = start + i * PUD_SIZE;
-		if (pud_none(*pud) || pud_sect(*pud) || pud_bad(*pud))
+		if (pud_none(*pud) || pud_sect(*pud)) {
 			note_page(st, addr, 2, pud_val(*pud));
-		else
+		} else {
+			BUG_ON(pud_bad(*pud));
 			walk_pmd(st, pud, addr);
+		}
 	}
 }
 
@@ -279,10 +283,12 @@ static void walk_pgd(struct pg_state *st, struct mm_struct *mm, unsigned long st
 
 	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
 		addr = start + i * PGDIR_SIZE;
-		if (pgd_none(*pgd) || pgd_bad(*pgd))
+		if (pgd_none(*pgd)) {
 			note_page(st, addr, 1, pgd_val(*pgd));
-		else
+		} else {
+			BUG_ON(pgd_bad(*pgd));
 			walk_pud(st, pgd, addr);
+		}
 	}
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 155cbb0..29fe8aa 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -90,13 +90,14 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 
-	if (pmd_none(*pmd) || pmd_bad(*pmd)) {
+	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
 		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
 		if (pmd_sect(*pmd))
 			split_pmd(pmd, pte);
 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
 		flush_tlb_all();
 	}
+	BUG_ON(pmd_bad(*pmd));
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
@@ -128,7 +129,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 	/*
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
-	if (pud_none(*pud) || pud_bad(*pud)) {
+	if (pud_none(*pud) || pud_sect(*pud)) {
 		pmd = alloc(PTRS_PER_PMD * sizeof(pmd_t));
 		if (pud_sect(*pud)) {
 			/*
@@ -140,6 +141,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 		pud_populate(mm, pud, pmd);
 		flush_tlb_all();
 	}
+	BUG_ON(pud_bad(*pud));
 
 	pmd = pmd_offset(pud, addr);
 	do {
-- 
1.9.1
