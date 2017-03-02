From: keescook@chromium.org (Kees Cook)
Date: Wed, 1 Mar 2017 23:55:54 -0800
Subject: [PATCH] ARM: dump: Add domain to output
Message-ID: <20170302075554.GA33308@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the memory domain (on non-LPAE) to the PMD and PTE dumps. This
isn't in the regular PMD bits because I couldn't find a clean way to
fall back to retain some of the PMD bits when reporting PTE. So this is
special-cased currently.

New output example:

---[ Modules ]---
0x7f000000-0x7f001000       4K DOMAIN_KERNEL      ro x  SHD MEM/CACHED/WBWA
0x7f001000-0x7f002000       4K DOMAIN_KERNEL      ro NX SHD MEM/CACHED/WBWA
0x7f002000-0x7f004000       8K DOMAIN_KERNEL      RW NX SHD MEM/CACHED/WBWA
---[ Kernel Mapping ]---
0x80000000-0x80100000       1M DOMAIN_KERNEL      RW NX SHD
0x80100000-0x80800000       7M DOMAIN_KERNEL      ro x  SHD
0x80800000-0x80b00000       3M DOMAIN_KERNEL      ro NX SHD
0x80b00000-0xa0000000     501M DOMAIN_KERNEL      RW NX SHD
...
---[ Vectors ]---
0xffff0000-0xffff1000       4K DOMAIN_VECTORS USR ro x  SHD MEM/CACHED/WBWA
0xffff1000-0xffff2000       4K DOMAIN_VECTORS     ro x  SHD MEM/CACHED/WBWA

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/dump.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 21192d6eda40..63faa33a83b1 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/seq_file.h>
 
+#include <asm/domain.h>
 #include <asm/fixmap.h>
 #include <asm/memory.h>
 #include <asm/pgtable.h>
@@ -43,6 +44,7 @@ struct pg_state {
 	unsigned long start_address;
 	unsigned level;
 	u64 current_prot;
+	const char *domain;
 };
 
 struct prot_bits {
@@ -240,6 +242,8 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u
 				unit++;
 			}
 			seq_printf(st->seq, "%9lu%c", delta, *unit);
+			if (st->domain)
+				seq_printf(st->seq, " %s", st->domain);
 			if (pg_level[st->level].bits)
 				dump_prot(st, pg_level[st->level].bits, pg_level[st->level].num);
 			seq_printf(st->seq, "\n");
@@ -267,6 +271,29 @@ static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
 	}
 }
 
+static void set_domain_name(struct pg_state *st, pmd_t *pmd)
+{
+#ifndef CONFIG_ARM_LPAE
+	switch (pmd_val(*pmd) & PMD_DOMAIN_MASK) {
+	case PMD_DOMAIN(DOMAIN_KERNEL):
+		st->domain = "DOMAIN_KERNEL ";
+		break;
+	case PMD_DOMAIN(DOMAIN_USER):
+		st->domain = "DOMAIN_USER   ";
+		break;
+	case PMD_DOMAIN(DOMAIN_IO):
+		st->domain = "DOMAIN_IO     ";
+		break;
+	case PMD_DOMAIN(DOMAIN_VECTORS):
+		st->domain = "DOMAIN_VECTORS";
+		break;
+	default:
+		st->domain = "DOMAIN_unknown";
+		break;
+	}
+#endif
+}
+
 static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 {
 	pmd_t *pmd = pmd_offset(pud, 0);
@@ -275,14 +302,21 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
 		addr = start + i * PMD_SIZE;
+		set_domain_name(st, pmd);
 		if (pmd_none(*pmd) || pmd_large(*pmd) || !pmd_present(*pmd))
 			note_page(st, addr, 3, pmd_val(*pmd));
 		else
 			walk_pte(st, pmd, addr);
 
-		if (SECTION_SIZE < PMD_SIZE && pmd_large(pmd[1]))
-			note_page(st, addr + SECTION_SIZE, 3, pmd_val(pmd[1]));
+		if (SECTION_SIZE < PMD_SIZE && pmd_large(pmd[1])) {
+			addr += SECTION_SIZE;
+			pmd++;
+			set_domain_name(st, pmd);
+			note_page(st, addr, 3, pmd_val(*pmd));
+		}
 	}
+
+	st->domain = NULL;
 }
 
 static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
