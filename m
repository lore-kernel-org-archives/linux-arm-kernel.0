From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 23 Apr 2014 10:35:47 +0300
Subject: [PATCH] ARM: Fix double definition of virt_to_pfn()
In-Reply-To: <20140422195514.GA13106@arch.cereza>
References: <20140422195514.GA13106@arch.cereza>
Message-ID: <1398238547-23065-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One definition of virt_to_pfn() was outside of the #if #elif #else section
causing constant redefinition of the macro.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

the redefinition actually coming from different source. It is caused by the
leftover definition of virt_to_pfn() which would redefine the virt_to_pfn()
all the time.

The redefinition still exist in next-20140423.

Regards,
Peter

 arch/arm/include/asm/memory.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d3e91fa41b37..7a0dc0f9d1a1 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -293,8 +293,6 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
-#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
 
 extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
 
-- 
1.9.2
