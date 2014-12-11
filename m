From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Dec 2014 18:50:43 +0000
Subject: [PATCHv2] arm: mm: dump: don't skip regions
Message-ID: <1418323843-28448-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an update to v1 [1], dropping the unnecessary use of
USER_PGTABLES_CEILING, as discussed [2]. I've given this a spin on TC2 and the
output looks correct.

Steve, I dropped your ack given the change, but I hope to receive a new one
soon :)

Russell, if you're happy with this should I drop it in the patch system
shortly, or should I hold off until -rc1?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308952.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310161.html

---->8----
Currently the arm page table dumping code starts dumping page tables
from USER_PGTABLES_CEILING. This is unnecessary for skipping any entries
related to userspace as the swapper_pg_dir does not contain such
entries, and results in a couple of unfortuante side effects.

Firstly, any kernel mappings which might exist below
USER_PGTABLES_CEILING will not be accounted in the dump output. This
masks any entries erroneously created below this address.

Secondly, if the final page table entry walked is part of a valid
mapping the page table dumping code will not log the region this entry
is part of, as the final note_page call in walk_pgd will trigger an
early return when 0 < USER_PGTABLES_CEILING. Luckily this isn't seen on
contemporary systems as they typically don't have enough RAM to extend
the linear mapping right to the end of the address space.

Due to the way addr is constructed in the walk_* functions, it can never
be less than USER_PGTABLES_CEILING when walking the page tables, so it
is not necessary to avoid dereferencing invalid table addresses. The
existing checks for st->current_prot and st->marker[1].start_address are
sufficient to ensure we will not print and/or dereference garbage when
trying to log information.

This patch removes both problematic uses of USER_PGTABLES_CEILING from
the arm page table dumping code, preventing both of these issues. We
will now report any low mappings, and the final note_page call will not
return early, ensuring all regions are logged.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dump.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 5942493..9fe8e24 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -220,9 +220,6 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u
 	static const char units[] = "KMGTPE";
 	u64 prot = val & pg_level[level].mask;
 
-	if (addr < USER_PGTABLES_CEILING)
-		return;
-
 	if (!st->level) {
 		st->level = level;
 		st->current_prot = prot;
@@ -308,15 +305,13 @@ static void walk_pgd(struct seq_file *m)
 	pgd_t *pgd = swapper_pg_dir;
 	struct pg_state st;
 	unsigned long addr;
-	unsigned i, pgdoff = USER_PGTABLES_CEILING / PGDIR_SIZE;
+	unsigned i;
 
 	memset(&st, 0, sizeof(st));
 	st.seq = m;
 	st.marker = address_markers;
 
-	pgd += pgdoff;
-
-	for (i = pgdoff; i < PTRS_PER_PGD; i++, pgd++) {
+	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
 		addr = i * PGDIR_SIZE;
 		if (!pgd_none(*pgd)) {
 			walk_pud(&st, pgd, addr);
-- 
1.9.1
