From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Mar 2018 19:19:56 +0800
Subject: [RFC PATCH 4/6] arm64/mm: stop using __pa_symbol() for swapper_pg_dir
In-Reply-To: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
Message-ID: <20180319111958.4171-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to decouple the physical backing of swapper_pg_dir from the
kernel itself, so that leaking the former (which is unavoidable on
cores susceptible to Spectre/Meltdown variant 3a) does not leak the
latter.

This means __pa_symbol() will no longer work, so make preparations
for dropping it, by keeping the physical address of swapper_pg_dir
in a variable.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 arch/arm64/kernel/cpufeature.c   | 2 +-
 arch/arm64/kernel/hibernate.c    | 2 +-
 arch/arm64/mm/kasan_init.c       | 2 +-
 arch/arm64/mm/mmu.c              | 6 +++++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e2c27e63cd8..ce5e51554468 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -723,6 +723,8 @@ extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 
+extern phys_addr_t __pa_swapper_pg_dir;
+
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2985a067fc13..4792cd8bad07 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -909,7 +909,7 @@ static int kpti_install_ng_mappings(void *__unused)
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();
-	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
+	remap_fn(cpu, num_online_cpus(), __pa_swapper_pg_dir);
 	cpu_uninstall_idmap();
 
 	if (!cpu)
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 1ec5f28c39fc..5797c9b141dc 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -125,7 +125,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 		return -EOVERFLOW;
 
 	arch_hdr_invariants(&hdr->invariants);
-	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
+	hdr->ttbr1_el1		= __pa_swapper_pg_dir;
 	hdr->reenter_kernel	= _cpu_resume;
 
 	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 1f17642811b3..b01c7bb133a6 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -236,7 +236,7 @@ void __init kasan_init(void)
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
 	memset(kasan_zero_page, 0, PAGE_SIZE);
-	cpu_replace_ttbr1(__pa_symbol(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_swapper_pg_dir);
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 365fedf22fcd..af6fe001df0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -55,6 +55,8 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
+phys_addr_t __pa_swapper_pg_dir;
+
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
@@ -639,6 +641,8 @@ void __init paging_init(void)
 	phys_addr_t pgd_phys = early_pgtable_alloc();
 	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
 
+	__pa_swapper_pg_dir = __pa_symbol(swapper_pg_dir);
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
@@ -652,7 +656,7 @@ void __init paging_init(void)
 	 */
 	cpu_replace_ttbr1(pgd_phys);
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
-	cpu_replace_ttbr1(__pa_symbol(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_swapper_pg_dir);
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.11.0
