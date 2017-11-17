From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:51 +0000
Subject: [PATCH 08/18] arm64: mm: Add arm64_kernel_mapped_at_el0 helper using
 static key
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for code such as TLB invalidation to operate efficiently when
the decision to map the kernel at EL0 is determined at runtime, this
patch introduces a helper function, arm64_kernel_mapped_at_el0, which
uses a static key that will later be hooked up to a command-line option.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu.h | 11 +++++++++++
 arch/arm64/mm/mmu.c          |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 01bfb184f2a8..a84f851409ca 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,8 @@
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
 #define USER_ASID_FLAG	(UL(1) << 48)
 
+#ifndef __ASSEMBLY__
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
@@ -32,6 +34,14 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+DECLARE_STATIC_KEY_TRUE(__unmap_kernel_at_el0);
+
+static inline bool arm64_kernel_mapped_at_el0(void)
+{
+	return !IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) ||
+	       !static_branch_likely(&__unmap_kernel_at_el0);
+}
+
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
@@ -42,4 +52,5 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 extern void mark_linear_text_alias_ro(void);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f1eb15e0e864..a75858267b6d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -525,6 +525,11 @@ static int __init parse_rodata(char *arg)
 }
 early_param("rodata", parse_rodata);
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+DEFINE_STATIC_KEY_TRUE(__unmap_kernel_at_el0);
+EXPORT_SYMBOL_GPL(__unmap_kernel_at_el0);
+#endif
+
 /*
  * Create fine-grained mappings for the kernel.
  */
-- 
2.1.4
