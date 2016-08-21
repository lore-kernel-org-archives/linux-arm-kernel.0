From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 21 Aug 2016 14:18:34 +0200
Subject: [RFC/RFT PATCH] arm64: mm: allow userland to run with one fewer
 translation level
Message-ID: <1471781914-16681-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The choice of VA size is usually decided by the requirements on the kernel
side, particularly the size of the linear region, which must be large
enough to cover all of physical memory, including the holes in between,
which may be very large (~512 GB on some systems).

Since running with more translation levels could potentially result in
a performance penalty due to additional TLB pressure, this patch allows the
kernel to be configured so that it runs with one fewer translation level on
the userland side. Rather than modifying all the compile time logic to deal
with folded PUDs or PMDs, we simply allocate the root table and the next
table adjacently, so that we can simply point TTBR0_EL1 to the next table
(and update TCR_EL1.T0SZ accordingly)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is just a proof of concept. *If* there is a performance penalty associated
with using 4 translation levels instead of 3, I would expect this patch to
compensate for that, given that the additional TLB pressure should be on the
userland side primarily. Benchmark results are highly appreciated.

As a bonus, this would fix the horrible yet real JIT issues we have been seeing
with 48-bit VA configurations. IOW, I expect this to be an easier sell than
simply limiting TASKSIZE to 47 bits (assuming anyone can show a benchmark where
this patch has a positive impact on the performance of a 48-bit/4 levels kernel)
and distros can ship kernels that work on all hardware (including Freescale and
Xgene with >= 64 GB) but don't break their JITs.

This patch is most likely broken for 16k/47-bit configs, but I didn't bother to
fix that before having the discussion.

 arch/arm64/Kconfig                   | 38 +++++++++++++++++++-
 arch/arm64/include/asm/memory.h      |  3 +-
 arch/arm64/include/asm/mmu_context.h |  5 ++-
 arch/arm64/include/asm/proc-fns.h    | 10 +++---
 arch/arm64/mm/pgd.c                  | 15 +++++---
 5 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..6b68371af550 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -509,7 +509,7 @@ config ARM64_64K_PAGES
 endchoice
 
 choice
-	prompt "Virtual address space size"
+	prompt "Kernel virtual address space size"
 	default ARM64_VA_BITS_39 if ARM64_4K_PAGES
 	default ARM64_VA_BITS_47 if ARM64_16K_PAGES
 	default ARM64_VA_BITS_42 if ARM64_64K_PAGES
@@ -539,6 +539,34 @@ config ARM64_VA_BITS_48
 
 endchoice
 
+choice
+	prompt "Userland virtual address space size"
+	default ARM64_USER_VA_BITS_39 if ARM64_4K_PAGES
+	default ARM64_USER_VA_BITS_47 if ARM64_16K_PAGES
+	default ARM64_USER_VA_BITS_42 if ARM64_64K_PAGES
+
+config ARM64_USER_VA_BITS_36
+	bool "36-bit"
+	depends on ARM64_VA_BITS_36 || ARM64_VA_BITS_47
+
+config ARM64_USER_VA_BITS_39
+	bool "39-bit"
+	depends on ARM64_4K_PAGES
+
+config ARM64_USER_VA_BITS_42
+	bool "42-bit"
+	depends on ARM64_64K_PAGES
+
+config ARM64_USER_VA_BITS_47
+	bool "47-bit"
+	depends on ARM64_16K_PAGES && !ARM64_VA_BITS_36
+
+config ARM64_USER_VA_BITS_48
+	bool "48-bit"
+	depends on ARM64_VA_BITS_48
+
+endchoice
+
 config ARM64_VA_BITS
 	int
 	default 36 if ARM64_VA_BITS_36
@@ -547,6 +575,14 @@ config ARM64_VA_BITS
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 
+config ARM64_USER_VA_BITS
+	int
+	default 36 if ARM64_USER_VA_BITS_36
+	default 39 if ARM64_USER_VA_BITS_39
+	default 42 if ARM64_USER_VA_BITS_42
+	default 47 if ARM64_USER_VA_BITS_47
+	default 48 if ARM64_USER_VA_BITS_48
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 31b73227b41f..605ace198c99 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -64,6 +64,7 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
+#define USER_VA_BITS		(CONFIG_ARM64_USER_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define KIMAGE_VADDR		(MODULES_END)
@@ -74,7 +75,7 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
+#define TASK_SIZE_64		(UL(1) << USER_VA_BITS)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b1892a0dbcb0..a605d671b79a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -67,8 +67,7 @@ extern u64 idmap_t0sz;
 
 static inline bool __cpu_uses_extended_idmap(void)
 {
-	return (!IS_ENABLED(CONFIG_ARM64_VA_BITS_48) &&
-		unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS)));
+	return idmap_t0sz != TCR_T0SZ(USER_VA_BITS);
 }
 
 /*
@@ -90,7 +89,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 	: "r"(t0sz), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
 }
 
-#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS))
+#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(USER_VA_BITS))
 #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
 
 /*
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 14ad6e4e87d1..3d61f942adec 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -35,10 +35,12 @@ extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-#define cpu_switch_mm(pgd,mm)				\
-do {							\
-	BUG_ON(pgd == swapper_pg_dir);			\
-	cpu_do_switch_mm(virt_to_phys(pgd),mm);		\
+#define cpu_switch_mm(pgd,mm)						\
+do {									\
+	pgd_t *__pgd = (VA_BITS == USER_VA_BITS || pgd == idmap_pg_dir)	\
+		       ? pgd : (void *)pgd + PAGE_SIZE;			\
+	BUG_ON(pgd == swapper_pg_dir);					\
+	cpu_do_switch_mm(virt_to_phys(__pgd),mm);			\
 } while (0)
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index ae11d4e03d0e..1912c7b10ebb 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -32,15 +32,22 @@ static struct kmem_cache *pgd_cache;
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	if (PGD_SIZE == PAGE_SIZE)
+	if (USER_VA_BITS < VA_BITS) {
+		pgd_t *pgd = (pgd_t *)__get_free_pages(PGALLOC_GFP, 1);
+
+		set_pgd(pgd,
+			__pgd(__pa((void *)pgd + PAGE_SIZE) | PUD_TYPE_TABLE));
+		return pgd;
+	} else if (PGD_SIZE == PAGE_SIZE) {
 		return (pgd_t *)__get_free_page(PGALLOC_GFP);
-	else
+	} else {
 		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+	}
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	if (PGD_SIZE == PAGE_SIZE)
+	if (USER_VA_BITS < VA_BITS || PGD_SIZE == PAGE_SIZE)
 		free_page((unsigned long)pgd);
 	else
 		kmem_cache_free(pgd_cache, pgd);
@@ -48,7 +55,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 void __init pgd_cache_init(void)
 {
-	if (PGD_SIZE == PAGE_SIZE)
+	if (USER_VA_BITS < VA_BITS || PGD_SIZE == PAGE_SIZE)
 		return;
 
 	/*
-- 
2.7.4
