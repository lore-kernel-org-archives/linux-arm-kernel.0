From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Feb 2014 11:52:30 -0800
Subject: [PATCH v3] ARM: mm: report both sections from PMD
Message-ID: <20140213195230.GA15275@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2-level page table systems, the PMD has 2 section entries. Report
these, otherwise ARM_PTDUMP will miss reporting permission changes on
odd section boundaries.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
 - re-reorganize, drop use of pmd_sect; suggested by Catalin Marinas.
v2:
 - reorganize, suggested by Catalin Marinas.
---
 arch/arm/mm/dump.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 2b342177f5de..61cc78ae9f21 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -264,6 +264,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 			note_page(st, addr, 3, pmd_val(*pmd));
 		else
 			walk_pte(st, pmd, addr);
+
+		if (SECTION_SIZE < PMD_SIZE && pmd_large(pmd[1]))
+			note_page(st, addr + SECTION_SIZE, 3, pmd_val(pmd[1]));
 	}
 }
 
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
