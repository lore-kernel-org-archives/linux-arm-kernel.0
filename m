From: vitalya@ti.com (Vitaly Andrianov)
Date: Tue, 23 Jun 2015 11:13:06 -0400
Subject: [PATCH] ARM: use phys_addr_t in pfn_to_kaddr()
Message-ID: <1435072386-13527-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes pfn_to_kaddr() to use phys_addr_t.  Without this,
this macro is broken on LPAE systems. For physical addresses above
first 4GB result of shifting pfn with PAGE_SHIFT may be truncated.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 184def0..063ef31 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -291,7 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
-#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define pfn_to_kaddr(pfn)	__va((phys_addr_t)(pfn) << PAGE_SHIFT)
 
 extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
 
-- 
1.9.1
