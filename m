From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:26 +0800
Subject: [PATCH 04/29] arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-5-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit fc0e1299da54 upstream.

In order for code such as TLB invalidation to operate efficiently when
the decision to map the kernel at EL0 is determined at runtime, this
patch introduces a helper function, arm64_kernel_unmapped_at_el0, to
determine whether or not the kernel is mapped whilst running in userspace.

Currently, this just reports the value of CONFIG_UNMAP_KERNEL_AT_EL0,
but will later be hooked up to a fake CPU capability using a static key.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/mmu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 49924e5..279e75b 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,8 @@
 
 #define USER_ASID_FLAG	(UL(1) << 48)
 
+#ifndef __ASSEMBLY__
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
@@ -30,6 +32,11 @@ typedef struct {
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
@@ -39,4 +46,5 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool allow_block_mappings);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 
+#endif	/* !__ASSEMBLY__ */
 #endif
-- 
2.7.4
