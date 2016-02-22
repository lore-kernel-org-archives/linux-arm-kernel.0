From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:25 +0100
Subject: [RFC PATCH 03/10] arm64: mm: avoid __pa translations in
 cpu_replace_ttbr1
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the use of generic __pa() translations in cpu_replace_ttbr1(),
by changing its argument to a physical pgd[] address, and using
__pa_symbol() on the reference to swapper_pg_dir.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h | 6 ++----
 arch/arm64/mm/mmu.c                  | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index a00f7cf35bbd..40fc56f3ed52 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -130,15 +130,13 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgd)
+static inline void cpu_replace_ttbr1(phys_addr_t pgd_phys)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgd);
-
-	replace_phys = (void *)virt_to_phys(idmap_cpu_replace_ttbr1);
+	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
 	replace_phys(pgd_phys);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 00d166465ff4..fbba941a6e87 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -546,9 +546,9 @@ void __init paging_init(void)
 	 *
 	 * To do this we need to go via a temporary pgd.
 	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
+	cpu_replace_ttbr1(pgd_phys);
 	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
-	cpu_replace_ttbr1(swapper_pg_dir);
+	cpu_replace_ttbr1(__pa_symbol(swapper_pg_dir));
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.5.0
