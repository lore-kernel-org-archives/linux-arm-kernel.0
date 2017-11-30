From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Nov 2017 16:39:36 +0000
Subject: [PATCH v2 08/18] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
In-Reply-To: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512059986-21325-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for code such as TLB invalidation to operate efficiently when
the decision to map the kernel at EL0 is determined at runtime, this
patch introduces a helper function, arm64_kernel_unmapped_at_el0, to
determine whether or not the kernel is mapped whilst running in userspace.

Currently, this just reports the value of CONFIG_UNMAP_KERNEL_AT_EL0,
but will later be hooked up to a fake CPU capability using a static key.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 01bfb184f2a8..c07954638658 100644
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
@@ -32,6 +34,11 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+static inline bool arm64_kernel_unmapped_at_el0(void)
+{
+	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
+}
+
 extern void paging_init(void);
 extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
@@ -42,4 +49,5 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 extern void mark_linear_text_alias_ro(void);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
-- 
2.1.4
