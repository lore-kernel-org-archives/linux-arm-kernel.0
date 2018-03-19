From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Mar 2018 19:19:55 +0800
Subject: [RFC PATCH 3/6] arm64/mm: use physical address as cpu_replace_ttbr1()
 argument
In-Reply-To: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
Message-ID: <20180319111958.4171-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every caller of cpu_replace_ttbr1() currently translates the
pgd* argument from physical to virtual, only to translate it
back in the implementation of the function. Drop this redundancy.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h | 4 +---
 arch/arm64/mm/kasan_init.c           | 4 ++--
 arch/arm64/mm/mmu.c                  | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 39ec0b8a689e..3eddb871f251 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -141,14 +141,12 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void cpu_replace_ttbr1(phys_addr_t pgd_phys)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgdp);
-
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index dabfc1ecda3d..1f17642811b3 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -199,7 +199,7 @@ void __init kasan_init(void)
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
-	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
+	cpu_replace_ttbr1(__pa_symbol(tmp_pg_dir));
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -236,7 +236,7 @@ void __init kasan_init(void)
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
 	memset(kasan_zero_page, 0, PAGE_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_symbol(swapper_pg_dir));
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0a9c08c0948c..365fedf22fcd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -650,9 +650,9 @@ void __init paging_init(void)
 	 *
 	 * To do this we need to go via a temporary pgd.
 	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
+	cpu_replace_ttbr1(pgd_phys);
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_symbol(swapper_pg_dir));
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.11.0
