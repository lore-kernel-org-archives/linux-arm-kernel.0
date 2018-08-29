From: steve.capper@arm.com (Steve Capper)
Date: Wed, 29 Aug 2018 13:45:40 +0100
Subject: [PATCH 2/5] arm64: mm: introduce 52-bit userspace support
In-Reply-To: <20180829124543.25314-1-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
Message-ID: <20180829124543.25314-3-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 there is optional support for a 52-bit virtual address space.
To exploit this one has to be running with a 64KB page size and be
running on hardware that supports this.

For an arm64 kernel supporting a 48 bit VA with a 64KB page size,
a few changes are needed to support a 52-bit userspace:
 * TCR_EL1.T0SZ needs to be 12 instead of 16,
 * pgd_offset needs to work with a different PTRS_PER_PGD,
 * PGD_SIZE needs to be increased,
 * TASK_SIZE needs to reflect the new size.

This patch implements the above when the support for 52-bit VAs is
detected at early boot time.

On arm64 userspace addresses translation is controlled by TTBR0_EL1. As
well as userspace, TTBR0_EL1 controls:
 * The identity mapping,
 * EFI runtime code.

It is possible to run a kernel with an identity mapping that has a
larger VA size than userspace (and for this case __cpu_set_tcr_t0sz()
would set TCR_EL1.T0SZ as appropriate). However, when the conditions for
52-bit userspace are met; it is possible to keep TCR_EL1.T0SZ fixed at
12. Thus in this patch, the TCR_EL1.T0SZ size changing logic is
disabled.

A future patch enables CONFIG_ARM64_TRY_52BIT_VA (which essentially
activates this patch) as we need to also change the mmap logic to maintain
compatibility with a userspace that expects at most 48-bits of VA.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/assembler.h   |  7 +++----
 arch/arm64/include/asm/cpucaps.h     |  3 ++-
 arch/arm64/include/asm/mmu_context.h |  3 +++
 arch/arm64/include/asm/pgalloc.h     |  4 ++++
 arch/arm64/include/asm/pgtable.h     | 16 +++++++++++++---
 arch/arm64/include/asm/processor.h   | 10 +++++-----
 arch/arm64/kernel/cpufeature.c       | 16 ++++++++++++++++
 arch/arm64/kernel/entry.S            |  6 +++++-
 arch/arm64/kernel/head.S             | 13 +++++++++++++
 arch/arm64/mm/fault.c                |  2 +-
 arch/arm64/mm/mmu.c                  |  1 +
 arch/arm64/mm/proc.S                 | 10 +++++++++-
 12 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..8c8ed20beca9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -343,11 +343,10 @@ alternative_endif
 	.endm
 
 /*
- * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
+ * tcr_set_t0sz - update TCR.T0SZ so that we can load the ID map
  */
-	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
-	ldr_l	\tmpreg, idmap_t0sz
-	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
+	.macro	tcr_set_t0sz, valreg, t0sz
+	bfi	\valreg, \t0sz, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ae1f70450fb2..0cf286307b79 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -51,7 +51,8 @@
 #define ARM64_SSBD				30
 #define ARM64_MISMATCHED_CACHE_TYPE		31
 #define ARM64_HAS_STAGE2_FWB			32
+#define ARM64_HAS_52BIT_VA			33
 
-#define ARM64_NCAPS				33
+#define ARM64_NCAPS				34
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 39ec0b8a689e..70598750a21e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,6 +72,9 @@ extern u64 idmap_ptrs_per_pgd;
 
 static inline bool __cpu_uses_extended_idmap(void)
 {
+	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA))
+		return false;
+
 	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
 }
 
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2e05bcd944c8..7f50804a677e 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -27,7 +27,11 @@
 #define check_pgt_cache()		do { } while (0)
 
 #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
+#ifdef CONFIG_ARM64_TRY_52BIT_VA
+#define PGD_SIZE	((1 << (52 - PGDIR_SHIFT)) * sizeof(pgd_t))
+#else
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
+#endif
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..8449e266cd46 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -577,11 +577,21 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 /* to find an entry in a page-table-directory */
-#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_index(addr, ptrs)		(((addr) >> PGDIR_SHIFT) & ((ptrs) - 1))
+#define _pgd_offset_raw(pgd, addr, ptrs) ((pgd) + pgd_index(addr, ptrs))
+#define pgd_offset_raw(pgd, addr)	(_pgd_offset_raw(pgd, addr, PTRS_PER_PGD))
 
-#define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
+static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *ret;
+
+	if (IS_ENABLED(CONFIG_ARM64_TRY_52BIT_VA) && (addr < TASK_SIZE))
+		ret = _pgd_offset_raw(mm->pgd, addr, 1ULL << (vabits_user - PGDIR_SHIFT));
+	else
+		ret = pgd_offset_raw(mm->pgd, addr);
 
-#define pgd_offset(mm, addr)	(pgd_offset_raw((mm)->pgd, (addr)))
+	return ret;
+}
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 46c9d9ff028c..ba63b8a8dac1 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -19,13 +19,13 @@
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
 
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
-
-#define KERNEL_DS	UL(-1)
-#define USER_DS		(TASK_SIZE_64 - 1)
-
+#define KERNEL_DS		UL(-1)
+#define _USER_DS(vabits)	((UL(1) << (vabits)) - 1)
 #ifndef __ASSEMBLY__
 
+extern u64 vabits_user;
+#define TASK_SIZE_64		(UL(1) << vabits_user)
+#define USER_DS			_USER_DS(vabits_user)
 #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e238b7932096..4807fee515b6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1006,6 +1006,14 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
 
 #endif
 
+#ifdef CONFIG_ARM64_TRY_52BIT_VA
+extern u64 vabits_user;
+static bool has_52bit_vas(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	return vabits_user == 52;
+}
+#endif
+
 #ifdef CONFIG_ARM64_VHE
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
 {
@@ -1222,6 +1230,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
 #endif
+#ifdef CONFIG_ARM64_TRY_52BIT_VA
+	{
+		.desc = "52-bit Virtual Addresses",
+		.capability = ARM64_HAS_52BIT_VA,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = has_52bit_vas,
+	},
+#endif /* CONFIG_ARM64_TRY_52BIT_VA */
 	{},
 };
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 09dbea221a27..72b4b0b069b9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -189,7 +189,11 @@ alternative_cb_end
 	/* Save the task's original addr_limit and set USER_DS */
 	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
 	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
-	mov	x20, #USER_DS
+alternative_if	ARM64_HAS_52BIT_VA
+	mov	x20, #_USER_DS(52)
+alternative_else
+	mov	x20, #_USER_DS(VA_BITS)
+alternative_endif
 	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
 	/* No need to reset PSTATE.UAO, hardware's already set it to 0 for us */
 	.endif /* \el == 0 */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..6b7d32990b25 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -316,6 +316,19 @@ __create_page_tables:
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
+#ifdef CONFIG_ARM64_TRY_52BIT_VA
+	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
+	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
+	mov	x5, #52
+	cbnz	x6, 1f
+#endif
+	mov	x5, #VA_BITS
+1:
+	adr_l	x6, vabits_user
+	str	x5, [x6]
+	dmb	sy
+	dc	ivac, x6		// Invalidate potentially stale cache line
+
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 50b30ff30de4..4a9b86152b9a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -153,7 +153,7 @@ void show_pte(unsigned long addr)
 
 	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
-		 VA_BITS, mm->pgd);
+		 (addr >= TASK_SIZE) ? VA_BITS : (int) vabits_user, mm->pgd);
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..f5e37705b399 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -52,6 +52,7 @@
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
+u64 vabits_user __ro_after_init;
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6a2ef4..4834bd434143 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -441,7 +441,15 @@ ENTRY(__cpu_setup)
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1
-	tcr_set_idmap_t0sz	x10, x9
+
+#ifdef CONFIG_ARM64_TRY_52BIT_VA
+	ldr_l 		x9, vabits_user
+	sub		x9, xzr, x9
+	add		x9, x9, #64
+#else
+	ldr_l		x9, idmap_t0sz
+#endif
+	tcr_set_t0sz	x10, x9
 
 	/*
 	 * Set the IPS bits in TCR_EL1.
-- 
2.11.0
