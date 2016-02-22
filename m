From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 15:02:08 +0100
Subject: [RFC PATCH 2/2] ARM: memremap: implement arch_memremap_wb()
In-Reply-To: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456149728-16706-3-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm/include/asm/io.h |  3 +++
 arch/arm/mm/ioremap.c     | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 485982084fe9..7456638e6b3a 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -402,6 +402,9 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *iomem_cookie);
 #define iounmap iounmap
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
+#define arch_memremap_wb arch_memremap_wb
+
 /*
  * io{read,write}{16,32}be() macros
  */
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 66a978d05958..d3a2b028c614 100644
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
@@ -414,6 +415,12 @@ __arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 			__builtin_return_address(0));
 }
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+{
+	return __arm_ioremap_caller(phys_addr, size, MT_MEMORY_RW,
+			__builtin_return_address(0));
+}
+
 void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
-- 
2.5.0
