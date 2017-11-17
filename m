From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:54 +0000
Subject: [PATCH 11/18] arm64: mm: Map entry trampoline into trampoline and
 kernel page tables
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception entry trampoline needs to be mapped at the same virtual
address in both the trampoline page table (which maps nothing else)
and also the kernel page table, so that we can swizzle TTBR1_EL1 on
exceptions from and return to EL0.

This patch maps the trampoline at a fixed virtual address (TRAMP_VALIAS),
which allows the kernel proper to be randomized with respect to the
trampoline when KASLR is enabled.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/memory.h  |  1 +
 arch/arm64/include/asm/pgtable.h |  1 +
 arch/arm64/mm/mmu.c              | 48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f7c4d2146aed..18a3cb86ef17 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -70,6 +70,7 @@
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
 	(UL(1) << (VA_BITS - 1)) + 1)
 #define KIMAGE_VADDR		(MODULES_END)
+#define TRAMP_VALIAS		(KIMAGE_VADDR)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
 #define MODULES_VSIZE		(SZ_128M)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b46e54c2399b..2f3b58a1d434 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -667,6 +667,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a75858267b6d..5ce5cb1249da 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -528,6 +528,51 @@ early_param("rodata", parse_rodata);
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 DEFINE_STATIC_KEY_TRUE(__unmap_kernel_at_el0);
 EXPORT_SYMBOL_GPL(__unmap_kernel_at_el0);
+
+static void __init add_tramp_vma(void)
+{
+	extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+	static struct vm_struct vmlinux_tramp;
+	unsigned long size = (unsigned long)__entry_tramp_text_end -
+			     (unsigned long)__entry_tramp_text_start;
+
+	vmlinux_tramp = (struct vm_struct) {
+		.addr		= (void *)TRAMP_VALIAS,
+		.phys_addr	= __pa_symbol(__entry_tramp_text_start),
+		.size		= size + PAGE_SIZE,
+		.flags		= VM_MAP,
+		.caller		= __builtin_return_address(0),
+
+	};
+
+	vm_area_add_early(&vmlinux_tramp);
+}
+
+static int __init map_entry_trampoline(void)
+{
+	extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+
+	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
+	phys_addr_t size = (unsigned long)__entry_tramp_text_end -
+			   (unsigned long)__entry_tramp_text_start;
+	phys_addr_t pa_start = __pa_symbol(__entry_tramp_text_start);
+
+	/* The trampoline is always mapped and can therefore be global */
+	pgprot_val(prot) &= ~PTE_NG;
+
+	/* Map only the text into the trampoline page table */
+	memset((char *)tramp_pg_dir, 0, PGD_SIZE);
+	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, size, prot,
+			     pgd_pgtable_alloc, 0);
+
+	/* ...as well as the kernel page table */
+	__create_pgd_mapping(init_mm.pgd, pa_start, TRAMP_VALIAS, size, prot,
+			     pgd_pgtable_alloc, 0);
+	return 0;
+}
+core_initcall(map_entry_trampoline);
+#else
+static void __init add_tramp_vma(void) {}
 #endif
 
 /*
@@ -559,6 +604,9 @@ static void __init map_kernel(pgd_t *pgd)
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
 	map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
 
+	/* Add a VMA for the trampoline page, which will be mapped later on */
+	add_tramp_vma();
+
 	if (!pgd_val(*pgd_offset_raw(pgd, FIXADDR_START))) {
 		/*
 		 * The fixmap falls in a separate pgd to the kernel, and doesn't
-- 
2.1.4
