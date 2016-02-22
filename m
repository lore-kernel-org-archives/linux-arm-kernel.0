From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:29 +0100
Subject: [RFC PATCH 07/10] arm64: mm: avoid __pa translations for idmap_pg_dir
 and swapper_pg_dir
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When taking the physical address of idmap_pg_dir or swapper_pg_dir,
which are static kernel globals, use __pa_symbol() not __pa().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/mm/mmu.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b03272fc501e..a8ba62955a62 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -123,7 +123,7 @@ static inline void cpu_install_idmap(void)
 	local_flush_tlb_all();
 	cpu_set_idmap_tcr_t0sz();
 
-	cpu_switch_mm(idmap_pg_dir, &init_mm);
+	cpu_do_switch_mm(__pa_symbol(idmap_pg_dir), &init_mm);
 }
 
 /*
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 13517699bea6..980dd9cbdc19 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -557,7 +557,7 @@ void __init paging_init(void)
 	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
 	 * allocated with it.
 	 */
-	memblock_free(__pa(swapper_pg_dir) + PAGE_SIZE,
+	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
 		      SWAPPER_DIR_SIZE - PAGE_SIZE);
 
 	bootmem_init();
-- 
2.5.0
