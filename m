From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 04 May 2010 17:44:59 +0100
Subject: [PATCH 8/8] ARM: Implement phys_mem_access_prot() to avoid
	attributes aliasing
In-Reply-To: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100504164459.26355.88200.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 onwards requires that there are no aliases to the same physical
location using different memory types (i.e. Normal vs Strongly Ordered).
Access to SO mappings when the unaligned accesses are handled in
hardware is also Unpredictable (pgprot_noncached() mappings in user
space).

The /dev/mem driver requires uncached mappings with O_SYNC. The patch
implements the phys_mem_access_prot() function which generates Strongly
Ordered memory attributes if !pfn_valid() (independent of O_SYNC) and
Normal Noncacheable (writecombine) if O_SYNC.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h |    3 +++
 arch/arm/mm/mmu.c              |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1139768..6fae619 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -317,6 +317,9 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 #if __LINUX_ARM_ARCH__ >= 7
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
 #else
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 241c24a..deb62cc 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -14,6 +14,7 @@
 #include <linux/bootmem.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
+#include <linux/fs.h>
 
 #include <asm/cputype.h>
 #include <asm/mach-types.h>
@@ -485,6 +486,19 @@ static void __init build_mem_type_table(void)
 	}
 }
 
+#if __LINUX_ARM_ARCH__ >= 7
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (!pfn_valid(pfn))
+		return pgprot_noncached(vma_prot);
+	else if (file->f_flags & O_SYNC)
+		return pgprot_writecombine(vma_prot);
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
+#endif
+
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
 static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
