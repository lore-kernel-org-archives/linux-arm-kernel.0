From: steve.capper@arm.com (Steve Capper)
Date: Thu, 10 May 2018 17:23:46 +0100
Subject: [PATCH v3 7/8] arm64: mm: Make VA space size variable
In-Reply-To: <20180510162347.3858-1-steve.capper@arm.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
Message-ID: <20180510162347.3858-8-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow the kernel to select different virtual address sizes
on boot we need to "de-constify" VA space size. This patch introduces
vabits_actual, a variable which is defined at very early boot.

The meaning of a few variables changes, however, to facilitate this
change.

VA_BITS - The maximum size of the VA space (compile time constant),
VA_BITS_MIN - The minimum size of the VA space (compile time constant),
VA_BITS_ACTUAL - The actual size of the VA space (determined at boot).

Signed-off-by: Steve Capper <steve.capper@arm.com>

---

Changed in V3, I have been asked to try keep VA_BITS itself constant,
and this is my attempt at doing this.

I am happy to extend this patch or go back to forcing VA_BITS variable
depending upon feedback.
---
 arch/arm64/Kconfig                     |  4 ++++
 arch/arm64/include/asm/efi.h           |  4 ++--
 arch/arm64/include/asm/kasan.h         |  2 +-
 arch/arm64/include/asm/memory.h        | 22 ++++++++++++++--------
 arch/arm64/include/asm/mmu_context.h   |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pgtable.h       |  2 +-
 arch/arm64/include/asm/processor.h     |  2 +-
 arch/arm64/kernel/head.S               |  6 ++++--
 arch/arm64/kernel/kaslr.c              |  6 +++---
 arch/arm64/kernel/machine_kexec.c      |  2 +-
 arch/arm64/kvm/va_layout.c             | 14 +++++++-------
 arch/arm64/mm/fault.c                  |  4 ++--
 arch/arm64/mm/init.c                   |  7 ++++++-
 arch/arm64/mm/kasan_init.c             |  3 ++-
 arch/arm64/mm/mmu.c                    |  7 +++++--
 arch/arm64/mm/proc.S                   | 28 ++++++++++++++++++++++++++++
 17 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4d2bc91d4017..f68eeab08904 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -680,6 +680,10 @@ config ARM64_VA_BITS
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 
+config ARM64_VA_BITS_MIN
+	int
+	default ARM64_VA_BITS
+
 choice
 	prompt "Physical address space size"
 	default ARM64_PA_BITS_48
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 192d791f1103..dc2e47c53dff 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -68,7 +68,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
- * which is a 1 GB aligned region of size '1UL << (VA_BITS - 1)' that is
+ * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
  * guaranteed to cover the kernel Image.
  *
  * Since the EFI stub is part of the kernel Image, we can relax the
@@ -79,7 +79,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 						    unsigned long image_addr)
 {
-	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS - 1));
+	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index ea397897ae4a..59ff3ba9bb90 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -27,7 +27,7 @@
  *				(1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
  */
 #define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
-#define KASAN_SHADOW_START      _KASAN_SHADOW_START(VA_BITS)
+#define KASAN_SHADOW_START      _KASAN_SHADOW_START(VA_BITS_ACTUAL)
 
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index aa26958e5034..2d96501b8712 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -57,10 +57,6 @@
  * VA_START - the first kernel virtual address.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
-#define VA_START		(UL(0xffffffffffffffff) - \
-	(UL(1) << (VA_BITS - 1)) + 1)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
-	(UL(1) << VA_BITS) + 1)
 #define PAGE_OFFSET_END		(VA_START)
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
@@ -70,6 +66,9 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
+#define VA_BITS_MIN		(CONFIG_ARM64_VA_BITS_MIN)
+#define _VA_START(va)		(UL(0xffffffffffffffff) - \
+				(UL(1) << ((va) - 1)) + 1)
 
 #define KERNEL_START      _text
 #define KERNEL_END        _end
@@ -88,7 +87,7 @@
 					+ KASAN_SHADOW_OFFSET)
 #else
 #define KASAN_THREAD_SHIFT	0
-#define KASAN_SHADOW_END	(VA_START)
+#define KASAN_SHADOW_END	(_VA_START(VA_BITS_MIN))
 #endif
 
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
@@ -174,10 +173,17 @@
 #endif
 
 #ifndef __ASSEMBLY__
+extern u64			vabits_actual;
+#define VA_BITS_ACTUAL		({vabits_actual;})
+#define VA_START		(_VA_START(VA_BITS_ACTUAL))
+#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
+					(UL(1) << VA_BITS_ACTUAL) + 1)
+#define PAGE_OFFSET_END		(VA_START)
 
 #include <linux/bitops.h>
 #include <linux/mmdebug.h>
 
+extern s64			physvirt_offset;
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
@@ -221,9 +227,9 @@ static inline unsigned long kaslr_offset(void)
  * space. Testing the top bit for the start of the region is a
  * sufficient check.
  */
-#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS - 1)))
+#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS_ACTUAL - 1)))
 
-#define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+#define __lm_to_phys(addr)	(((addr) + physvirt_offset))
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
 
 #define __virt_to_phys_nodebug(x) ({					\
@@ -242,7 +248,7 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
 #endif
 
-#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
+#define __phys_to_virt(x)	((unsigned long)((x) - physvirt_offset))
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 39ec0b8a689e..75d8d7a48a3c 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -101,7 +101,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 	isb();
 }
 
-#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS))
+#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS_ACTUAL))
 #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fd208eac9f2a..20f8740c505a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -81,6 +81,7 @@
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
+#define PTRS_PER_PGD_ACTUAL	(1 << (VA_BITS_ACTUAL - PGDIR_SHIFT))
 
 /*
  * Section address mask and size definitions.
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 31e26f3ab078..337ea50f2440 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -583,7 +583,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
 
 /* to find an entry in a page-table-directory */
-#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD_ACTUAL - 1))
 
 #define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 767598932549..244d23d1d911 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -19,7 +19,7 @@
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
 
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
+#define TASK_SIZE_64		(UL(1) << VA_BITS_MIN)
 
 #define KERNEL_DS	UL(-1)
 #define USER_DS		(TASK_SIZE_64 - 1)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..50abb6617a8a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -119,6 +119,7 @@ ENTRY(stext)
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
+	bl	__setup_va_constants
 	bl	__create_page_tables
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -253,6 +254,7 @@ ENDPROC(preserve_boot_args)
 	add \rtbl, \tbl, #PAGE_SIZE
 	mov \sv, \rtbl
 	mov \count, #0
+
 	compute_indices \vstart, \vend, #PGDIR_SHIFT, \pgds, \istart, \iend, \count
 	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
 	mov \tbl, \sv
@@ -338,7 +340,7 @@ __create_page_tables:
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
 
-#if (VA_BITS < 48)
+#if (VA_BITS_MIN < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
 
@@ -376,7 +378,7 @@ __create_page_tables:
 	adrp	x0, swapper_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
-	mov	x4, PTRS_PER_PGD
+	ldr_l	x4, ptrs_per_pgd
 	adrp	x6, _end			// runtime __pa(_end)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index f0e6ab8abe9c..bb6ab342f80b 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -117,15 +117,15 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
-	 * middle half of the VMALLOC area (VA_BITS - 2), and stay clear of
+	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
 	 * the lower and upper quarters to avoid colliding with other
 	 * allocations.
 	 * Even if we could randomize@page granularity for 16k and 64k pages,
 	 * let's always round to 2 MB so we don't interfere with the ability to
 	 * map using contiguous PTEs
 	 */
-	mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1);
-	offset = BIT(VA_BITS - 3) + (seed & mask);
+	mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
+	offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
 
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f76ea92dff91..732ef5dd1e4c 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -355,7 +355,7 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 
 void arch_crash_save_vmcoreinfo(void)
 {
-	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(VA_BITS_ACTUAL);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index c712a7376bc1..c9a1debb45bd 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -40,25 +40,25 @@ static void compute_layout(void)
 	int kva_msb;
 
 	/* Where is my RAM region? */
-	hyp_va_msb  = idmap_addr & BIT(VA_BITS - 1);
-	hyp_va_msb ^= BIT(VA_BITS - 1);
+	hyp_va_msb  = idmap_addr & BIT(VA_BITS_ACTUAL - 1);
+	hyp_va_msb ^= BIT(VA_BITS_ACTUAL - 1);
 
 	kva_msb = fls64((u64)phys_to_virt(memblock_start_of_DRAM()) ^
 			(u64)(high_memory - 1));
 
-	if (kva_msb == (VA_BITS - 1)) {
+	if (kva_msb == (VA_BITS_ACTUAL - 1)) {
 		/*
 		 * No space in the address, let's compute the mask so
-		 * that it covers (VA_BITS - 1) bits, and the region
+		 * that it covers (VA_BITS_ACTUAL - 1) bits, and the region
 		 * bit. The tag stays set to zero.
 		 */
-		va_mask  = BIT(VA_BITS - 1) - 1;
+		va_mask  = BIT(VA_BITS_ACTUAL - 1) - 1;
 		va_mask |= hyp_va_msb;
 	} else {
 		/*
 		 * We do have some free bits to insert a random tag.
 		 * Hyp VAs are now created from kernel linear map VAs
-		 * using the following formula (with V == VA_BITS):
+		 * using the following formula (with V == VA_BITS_ACTUAL):
 		 *
 		 *  63 ... V |     V-1    | V-2 .. tag_lsb | tag_lsb - 1 .. 0
 		 *  ---------------------------------------------------------
@@ -66,7 +66,7 @@ static void compute_layout(void)
 		 */
 		tag_lsb = kva_msb;
 		va_mask = GENMASK_ULL(tag_lsb - 1, 0);
-		tag_val = get_random_long() & GENMASK_ULL(VA_BITS - 2, tag_lsb);
+		tag_val = get_random_long() & GENMASK_ULL(VA_BITS_ACTUAL - 2, tag_lsb);
 		tag_val |= hyp_va_msb;
 		tag_val >>= tag_lsb;
 	}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4165485e8b6e..7990f25d2031 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -151,9 +151,9 @@ void show_pte(unsigned long addr)
 		return;
 	}
 
-	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
+	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp = %p\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
-		 VA_BITS, mm->pgd);
+		 VA_BITS_ACTUAL, mm->pgd);
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index efb7e860f99f..ff005ea5c8e8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,6 +62,9 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+s64 physvirt_offset __ro_after_init = -1;
+EXPORT_SYMBOL(physvirt_offset);
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
@@ -361,7 +364,7 @@ static void __init fdt_enforce_memory_region(void)
 
 void __init arm64_memblock_init(void)
 {
-	const s64 linear_region_size = BIT(VA_BITS - 1);
+	const s64 linear_region_size = BIT(VA_BITS_ACTUAL - 1);
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -375,6 +378,8 @@ void __init arm64_memblock_init(void)
 	memstart_addr = round_down(memblock_start_of_DRAM(),
 				   ARM64_MEMSTART_ALIGN);
 
+	physvirt_offset = PHYS_OFFSET - PAGE_OFFSET;
+
 	/*
 	 * Remove the memory that we will not be able to cover with the
 	 * linear mapping. Take care not to clip the kernel which may be
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 221ddead81ac..452b36fbf2b0 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -135,7 +135,8 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 /* The early shadow maps everything to a single page of zeroes */
 asmlinkage void __init kasan_early_init(void)
 {
-	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
 			   true);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 197f4110ae2c..e5834492dbcc 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -49,8 +49,11 @@
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
 
-u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
+u64 idmap_t0sz __ro_after_init;
+u64 ptrs_per_pgd __ro_after_init;
+u64 vabits_actual __ro_after_init;
+EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
@@ -668,7 +671,7 @@ int kern_addr_valid(unsigned long addr)
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
 
-	if ((((long)addr) >> VA_BITS) != -1UL)
+	if ((((long)addr) >> VA_BITS_ACTUAL) != -1UL)
 		return 0;
 
 	pgdp = pgd_offset_k(addr);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..5f8d9e452190 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -437,9 +437,18 @@ ENTRY(__cpu_setup)
 	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
 	 * both user and kernel.
 	 */
+	ldr	x10, =TCR_TxSZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
+			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
+			TCR_TBI0 | TCR_A1
+#if (CONFIG_ARM64_VA_BITS != CONFIG_ARM64_VA_BITS_MIN)
+	ldr_l	x9, vabits_actual
+	cmp	x9, #VA_BITS
+	b.ne	1f
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1
+1:
+#endif
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
@@ -461,3 +470,22 @@ ENTRY(__cpu_setup)
 	msr	tcr_el1, x10
 	ret					// return to head.S
 ENDPROC(__cpu_setup)
+
+ENTRY(__setup_va_constants)
+	mov	x0, #VA_BITS_MIN
+	mov	x1, TCR_T0SZ(VA_BITS_MIN)
+	mov	x2, #1 << (VA_BITS_MIN - PGDIR_SHIFT)
+	str_l	x0, vabits_actual, x5
+	str_l	x1, idmap_t0sz, x5
+	str_l	x2, ptrs_per_pgd, x5
+
+	adr_l	x0, vabits_actual
+	adr_l	x1, idmap_t0sz
+	adr_l	x2, ptrs_per_pgd
+	dmb	sy
+	dc	ivac, x0	// Invalidate potentially stale cache
+	dc	ivac, x1
+	dc	ivac, x2
+
+	ret
+ENDPROC(__setup_va_constants)
-- 
2.11.0
