From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 Oct 2018 16:07:20 -0700
Subject: [PATCH v2 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd()
 implementation
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Message-ID: <20181030230721.28429-6-f.fainelli@gmail.com>
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
 arch/arm64/include/asm/memory.h | 8 --------
 drivers/of/fdt.c                | 9 +++++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

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
index e34cb49231b5..f2b5becae96a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,15 +892,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
+	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
+	 * enabled since __va() is called too early. ARM64 does make use
+	 * of phys_initrd_start/phys_initrd_size so we can skip this
+	 * conversion.
+	 */
+#if (!IS_ENABLED(CONFIG_ARM64))
 	initrd_start = (unsigned long)__va(start);
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
-}
 #endif
+}
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1
