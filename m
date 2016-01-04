From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  4 Jan 2016 17:56:41 +0000
Subject: [PATCHv2 08/18] arm64: kasan: avoid TLB conflicts
In-Reply-To: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1451930211-22460-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The page table modification performed during the KASAN init risks the
allocation of conflicting TLB entries, as it swaps a set of valid global
entries for another without suitable TLB maintenance.

The presence of conflicting TLB entries can result in the delivery of
synchronous TLB conflict aborts, or may result in the use of erroneous
data being returned in response to a TLB lookup. This can affect
explicit data accesses from software as well as translations performed
asynchronously (e.g. as part of page table walks or speculative I-cache
fetches), and can therefore result in a wide variety of problems.

To avoid this, use cpu_replace_ttbr1 to swap the page tables. This
ensures that when the new tables are installed there are no stale
entries from the old tables which may conflict. As all updates are made
to the tables while they are not active, the updates themselves are
safe.

At the same time, add the missing barrier to ensure that the tmp_pg_dir
entries updated via memcpy are visible to the page table walkers at the
point the tmp_pg_dir is installed. All other page table updates made as
part of KASAN initialisation have the requisite barriers due to the use
of the standard page table accessors.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/kasan_init.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index cf038c7..3e3d280 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/start_kernel.h>
 
+#include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
@@ -108,15 +109,6 @@ static void __init clear_pgds(unsigned long start,
 		set_pgd(pgd_offset_k(start), __pgd(0));
 }
 
-static void __init cpu_set_ttbr1(unsigned long ttbr1)
-{
-	asm(
-	"	msr	ttbr1_el1, %0\n"
-	"	isb"
-	:
-	: "r" (ttbr1));
-}
-
 void __init kasan_init(void)
 {
 	struct memblock_region *reg;
@@ -129,8 +121,8 @@ void __init kasan_init(void)
 	 * setup will be finished.
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
-	cpu_set_ttbr1(__pa(tmp_pg_dir));
-	flush_tlb_all();
+	dsb(ishst);
+	cpu_replace_ttbr1(tmp_pg_dir);
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -156,8 +148,7 @@ void __init kasan_init(void)
 	}
 
 	memset(kasan_zero_page, 0, PAGE_SIZE);
-	cpu_set_ttbr1(__pa(swapper_pg_dir));
-	flush_tlb_all();
+	cpu_replace_ttbr1(swapper_pg_dir);
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-- 
1.9.1
