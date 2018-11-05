From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 14:54:30 -0800
Subject: [PATCH v4 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd()
 implementation
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Message-ID: <20181105225431.24485-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ARM64 uses phys_initrd_start/phys_initrd_size, we can get rid
of its custom __early_init_dt_declare_initrd() which causes a fair
amount of objects rebuild when changing CONFIG_BLK_DEV_INITRD. In order
to make sure ARM64 does not produce a BUG() when VM debugging is turned
on though, we must avoid early calls to __va() which is what
__early_init_dt_declare_initrd() does and wrap this around to avoid
running that code on ARM64.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 88760a0983a7..cd72a41fcab2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -891,15 +891,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
-	initrd_start = (unsigned long)__va(start);
-	initrd_end = (unsigned long)__va(end);
-	initrd_below_start_ok = 1;
+	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
+	 * enabled since __va() is called too early. ARM64 does make use
+	 * of phys_initrd_start/phys_initrd_size so we can skip this
+	 * conversion.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64)) {
+		initrd_start = (unsigned long)__va(start);
+		initrd_end = (unsigned long)__va(end);
+		initrd_below_start_ok = 1;
+	}
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1
