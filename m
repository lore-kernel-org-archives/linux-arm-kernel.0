From: cyril@ti.com (Cyril Chemparathy)
Date: Thu, 31 Jan 2013 16:58:32 -0500
Subject: [PATCH v4 13/13] ARM: fix type of PHYS_PFN_OFFSET to unsigned long
In-Reply-To: <1359669512-31276-1-git-send-email-cyril@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
Message-ID: <1359669512-31276-14-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On LPAE machines, PHYS_OFFSET evaluates to a phys_addr_t and this type is
inherited by the PHYS_PFN_OFFSET definition as well.  Consequently, the kernel
build emits warnings of the form:

init/main.c: In function 'start_kernel':
init/main.c:588:7: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'phys_addr_t' [-Wformat]

This patch fixes this warning by pinning down the PFN type to unsigned long.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/include/asm/memory.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index f3a7f76..32e9e5a 100644
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
1.7.9.5
