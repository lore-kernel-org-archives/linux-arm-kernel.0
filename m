From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  4 Mar 2016 10:48:48 +0100
Subject: [PATCH v3 4/4] ARM: memremap: implement arch_memremap_wb()
In-Reply-To: <1457084928-21179-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457084928-21179-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457084928-21179-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic memremap() falls back to using ioremap_cache() to create
MEMREMAP_WB mappings if the requested region is not already covered
by the linear mapping, unless the architecture provides an implementation
of arch_memremap_wb().

Since ioremap_cache() is not appropriate on ARM to map memory with the
same attributes used for the linear mapping, implement arch_memremap_wb()
which does exactly that. Also, relax the WARN() check to allow MT_MEMORY_RW
mappings of pfn_valid() pages.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/io.h |  6 ++++++
 arch/arm/mm/ioremap.c     | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index fb94de290edd..781ef5fe235d 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -392,6 +392,9 @@ void __iomem *ioremap(resource_size_t res_cookie, size_t size);
 #define ioremap ioremap
 #define ioremap_nocache ioremap
 
+/*
+ * Do not use ioremap_cache for mapping memory. Use memremap instead.
+ */
 void __iomem *ioremap_cache(resource_size_t res_cookie, size_t size);
 #define ioremap_cache ioremap_cache
 
@@ -408,6 +411,9 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *iomem_cookie);
 #define iounmap iounmap
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
+#define arch_memremap_wb arch_memremap_wb
+
 /*
  * io{read,write}{16,32}be() macros
  */
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index d5350f6af089..ff0eed23ddf1 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -297,9 +297,10 @@ static void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	}
 
 	/*
-	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 * Don't allow RAM to be mapped with mismatched attributes - this
+	 * causes problems with ARMv6+
 	 */
-	if (WARN_ON(pfn_valid(pfn)))
+	if (WARN_ON(pfn_valid(pfn) && mtype != MT_MEMORY_RW))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
@@ -418,6 +419,13 @@ __arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 			__builtin_return_address(0));
 }
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+{
+	return (__force void *)arch_ioremap_caller(phys_addr, size,
+						   MT_MEMORY_RW,
+						   __builtin_return_address(0));
+}
+
 void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
-- 
2.5.0
