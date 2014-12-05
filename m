From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  5 Dec 2014 12:34:55 +0000
Subject: [PATCH 2/2] arm64: mm: dump: don't skip final region
In-Reply-To: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
References: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1417782895-13657-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the final page table entry we walk is a valid mapping, the page table
dumping code will not log the region this entry is part of, as the final
note_page call in ptdump_show will trigger an early return. Luckily this
isn't seen on contemporary systems as they typically don't have enough
RAM to extend the linear mapping right to the end of the address space.

In note_page, we log a region  when we reach its end (i.e. we hit an
entry immediately afterwards which has different prot bits or is
invalid). The final entry has no subsequent entry, so we will not log
this immediately. We try to cater for this with a subsequent call to
note_page in ptdump_show, but this returns early as 0 < LOWEST_ADDR, and
hence we will skip a valid mapping if it spans to the final entry we
note.

Unlike 32-bit ARM, the pgd with the kernel mapping is never shared with
user mappings, so we do not need the check to ensure we don't log user
page tables. Due to the way addr is constructed in the walk_* functions,
it can never be less than LOWEST_ADDR when walking the page tables, so
it is not necessary to avoid dereferencing invalid table addresses. The
existing checks for st->current_prot and st->marker[1].start_address are
sufficient to ensure we will not print and/or dereference garbage when
trying to log information.

This patch removes the unnecessary check against LOWEST_ADDR, ensuring
we log all regions in the kernel page table, including those which span
right to the end of the address space.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index a546776..cf33f33 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -182,9 +182,6 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 	static const char units[] = "KMGTPE";
 	u64 prot = val & pg_level[level].mask;
 
-	if (addr < LOWEST_ADDR)
-		return;
-
 	if (!st->level) {
 		st->level = level;
 		st->current_prot = prot;
-- 
1.9.1
