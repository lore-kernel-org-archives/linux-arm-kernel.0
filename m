From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:51 +0000
Subject: [RFC v2 PATCH 09/23] ARM: move arm_heavy_mb to MMU/noMMU neutral place
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-10-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it can be referenced from both camps.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/flush.c |   15 ---------------
 arch/arm/mm/iomap.c |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3cced84..0c73969 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -21,21 +21,6 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_ARM_HEAVY_MB
-void (*soc_mb)(void);
-
-void arm_heavy_mb(void)
-{
-#ifdef CONFIG_OUTER_CACHE_SYNC
-	if (outer_cache.sync)
-		outer_cache.sync();
-#endif
-	if (soc_mb)
-		soc_mb();
-}
-EXPORT_SYMBOL(arm_heavy_mb);
-#endif
-
 #ifdef CONFIG_CPU_CACHE_VIPT
 
 static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index 4614208..1b601db 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -9,6 +9,8 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 
+#include <asm/outercache.h>
+
 unsigned long vga_base;
 EXPORT_SYMBOL(vga_base);
 
@@ -40,3 +42,18 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 }
 EXPORT_SYMBOL(pci_iounmap);
 #endif
+
+#ifdef CONFIG_ARM_HEAVY_MB
+void (*soc_mb)(void);
+
+void arm_heavy_mb(void)
+{
+#ifdef CONFIG_OUTER_CACHE_SYNC
+	if (outer_cache.sync)
+		outer_cache.sync();
+#endif
+	if (soc_mb)
+		soc_mb();
+}
+EXPORT_SYMBOL(arm_heavy_mb);
+#endif
-- 
1.7.9.5
