From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  5 Dec 2014 12:34:54 +0000
Subject: [PATCH 1/2] arm64: mm: dump: fix shift warning
In-Reply-To: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
References: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1417782895-13657-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with 48-bit VAs, it's possible to get the following
warning when building the arm64 page table dumping code:

arch/arm64/mm/dump.c: In function ?walk_pgd?:
arch/arm64/mm/dump.c:266:2: warning: right shift count >= width of type
  pgd_t *pgd = pgd_offset(mm, 0);
  ^

As pgd_offset is a macro and the second argument is not cast to any
particular type, the zero will be given integer type by the compiler.
As pgd_offset passes the pargument to pgd_index, we then try to shift
the 32-bit integer by at least 39 bits (for 4k pages).

Elsewhere the pgd_offset is passed a second argument of unsigned long
type, so let's do the same here by passing '0UL' rather than '0'.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index bf69601..a546776 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -272,7 +272,7 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm, unsigned long start)
 {
-	pgd_t *pgd = pgd_offset(mm, 0);
+	pgd_t *pgd = pgd_offset(mm, 0UL);
 	unsigned i;
 	unsigned long addr;
 
-- 
1.9.1
