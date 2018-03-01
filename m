From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:39 +0800
Subject: [PATCH 02/45] arm64: alternatives: apply boot time fixups via the
 linear mapping
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-3-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 5ea5306c323 upstream.

One important rule of thumb when desiging a secure software system is
that memory should never be writable and executable at the same time.
We mostly adhere to this rule in the kernel, except at boot time, when
regions may be mapped RWX until after we are done applying alternatives
or making other one-off changes.

For the alternative patching, we can improve the situation by applying
the fixups via the linear mapping, which is never mapped with executable
permissions. So map the linear alias of .text with RW- permissions
initially, and remove the write permissions as soon as alternative
patching has completed.

Reviewed-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/mmu.h    |  1 +
 arch/arm64/kernel/alternative.c | 11 ++++++-----
 arch/arm64/kernel/smp.c         |  1 +
 arch/arm64/mm/mmu.c             | 22 +++++++++++++++++-----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce0..b075140 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -36,5 +36,6 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool allow_block_mappings);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+extern void mark_linear_text_alias_ro(void);
 
 #endif
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 06d650f..8840c10 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -105,11 +105,11 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 	return insn;
 }
 
-static void __apply_alternatives(void *alt_region)
+static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-	u32 *origptr, *replptr;
+	u32 *origptr, *replptr, *updptr;
 
 	for (alt = region->begin; alt < region->end; alt++) {
 		u32 insn;
@@ -124,11 +124,12 @@ static void __apply_alternatives(void *alt_region)
 
 		origptr = ALT_ORIG_PTR(alt);
 		replptr = ALT_REPL_PTR(alt);
+		updptr = use_linear_alias ? (u32 *)lm_alias(origptr) : origptr;
 		nr_inst = alt->alt_len / sizeof(insn);
 
 		for (i = 0; i < nr_inst; i++) {
 			insn = get_alt_insn(alt, origptr + i, replptr + i);
-			*(origptr + i) = cpu_to_le32(insn);
+			updptr[i] = cpu_to_le32(insn);
 		}
 
 		flush_icache_range((uintptr_t)origptr,
@@ -155,7 +156,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(patched);
-		__apply_alternatives(&region);
+		__apply_alternatives(&region, true);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(patched, 1);
 	}
@@ -176,5 +177,5 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region);
+	__apply_alternatives(&region, false);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a70f7d3..66db515 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -426,6 +426,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	setup_cpu_features();
 	hyp_mode_check();
 	apply_alternatives_all();
+	mark_linear_text_alias_ro();
 }
 
 void __init smp_prepare_boot_cpu(void)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d5cc6d7..5dc72c0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -354,16 +354,28 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
 				     !debug_pagealloc_enabled());
 
 	/*
-	 * Map the linear alias of the [_text, __init_begin) interval as
-	 * read-only/non-executable. This makes the contents of the
-	 * region accessible to subsystems such as hibernate, but
-	 * protects it from inadvertent modification or execution.
+	 * Map the linear alias of the [_text, __init_begin) interval
+	 * as non-executable now, and remove the write permission in
+	 * mark_linear_text_alias_ro() below (which will be called after
+	 * alternative patching has completed). This makes the contents
+	 * of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
 	__create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
-			     kernel_end - kernel_start, PAGE_KERNEL_RO,
+			     kernel_end - kernel_start, PAGE_KERNEL,
 			     early_pgtable_alloc, !debug_pagealloc_enabled());
 }
 
+void __init mark_linear_text_alias_ro(void)
+{
+	/*
+	 * Remove the write permissions from the linear alias of .text/.rodata
+	 */
+	create_mapping_late(__pa_symbol(_text), (unsigned long)lm_alias(_text),
+			    (unsigned long)__init_begin - (unsigned long)_text,
+			    PAGE_KERNEL_RO);
+}
+
 static void __init map_mem(pgd_t *pgd)
 {
 	struct memblock_region *reg;
-- 
2.7.4
