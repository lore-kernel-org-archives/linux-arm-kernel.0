From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 12 Aug 2014 17:25:24 +0100
Subject: [PATCH v9 11/12] arm64: Add pgprot_device() interface for device
 mappings.
In-Reply-To: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1407860725-25202-12-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pgprot_device(). It will be aliased to pgprot_noncached for
architectures that do not support special attributes for device
mapping. Used by arm64 to define new attributes for devices.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 include/asm-generic/pgtable.h    | 4 ++++
 arch/arm64/include/asm/pgtable.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 53b2acc..977e545 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -249,6 +249,10 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 #define pgprot_writecombine pgprot_noncached
 #endif
 
+#ifndef pgprot_device
+#define pgprot_device pgprot_noncached
+#endif
+
 /*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e0ccceb..7dbacaf 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -277,6 +277,8 @@ static inline int has_transparent_hugepage(void)
 	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE) | PTE_PXN | PTE_UXN)
 #define pgprot_writecombine(prot) \
 	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN | PTE_UXN)
+#define pgprot_device(prot) \
+	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRE) | PTE_PXN | PTE_UXN)
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
-- 
2.0.4
