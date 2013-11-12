From: msalter@redhat.com (Mark Salter)
Date: Tue, 12 Nov 2013 08:22:17 -0500
Subject: [PATCH 03/11] arm: use generic fixmap.h
In-Reply-To: <1384262545-20875-1-git-send-email-msalter@redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
Message-ID: <1384262545-20875-4-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/fixmap.h | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index bbae919..f88ae8b 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -17,25 +17,12 @@
 #define FIXADDR_TOP		0xfffe0000UL
 #define FIXADDR_SIZE		(FIXADDR_TOP - FIXADDR_START)
 
-#define FIX_KMAP_BEGIN		0
-#define FIX_KMAP_END		(FIXADDR_SIZE >> PAGE_SHIFT)
+enum fixed_addresses {
+	FIX_KMAP_BEGIN,
+	FIX_KMAP_END = (FIXADDR_SIZE >> PAGE_SHIFT) - 1,
+	__end_of_fixed_addresses
+};
 
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
-
-extern void __this_fixmap_does_not_exist(void);
-
-static inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	if (idx >= FIX_KMAP_END)
-		__this_fixmap_does_not_exist();
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned int virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
+#include <asm-generic/fixmap.h>
 
 #endif
-- 
1.8.3.1
