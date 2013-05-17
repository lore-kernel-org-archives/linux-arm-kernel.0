From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:07:49 +0100
Subject: [PATCH 10/14] ARM: fix type of PHYS_PFN_OFFSET to unsigned long
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368810473-26070-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

On LPAE machines, PHYS_OFFSET evaluates to a phys_addr_t and this type is
inherited by the PHYS_PFN_OFFSET definition as well.  Consequently, the kernel
build emits warnings of the form:

init/main.c: In function 'start_kernel':
init/main.c:588:7: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'phys_addr_t' [-Wformat]

This patch fixes this warning by pinning down the PFN type to unsigned long.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index e506088..584786f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -223,7 +223,7 @@ static inline unsigned long __phys_to_virt(unsigned long x)
  * direct-mapped view.  We assume this is the first page
  * of RAM in the mem_map as well.
  */
-#define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
+#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
 
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
-- 
1.8.2.2
