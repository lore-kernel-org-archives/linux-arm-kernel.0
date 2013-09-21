From: robherring2@gmail.com (Rob Herring)
Date: Sat, 21 Sep 2013 14:28:09 -0500
Subject: [PATCH] ARM: move ARM errata 798181 declaration out of CONFIG_MMU
Message-ID: <1379791689-3141-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit 75a675720d980d7 (ARM: 7838/1: Add check for Cortex-A15 errata
798181 ECO), !CONFIG_MMU builds fail to build:

../../arch/arm/kernel/setup.c:602:2: error: implicit declaration of function 'erratum_a15_798181_init' [-Werror=implicit-function-declaration]

Fix this by moving the declarations for errata 798181 out of CONFIG_MMU
ifdef. The errata work-around already depends on SMP, so other condition
checks are not needed.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Based on rmk's for-next branch. Compiled all defconfigs.

Rob

 arch/arm/include/asm/tlbflush.h | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index dfad966..def9e57 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -560,21 +560,6 @@ static inline void __flush_bp_all(void)
 		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
 }
 
-#ifdef CONFIG_ARM_ERRATA_798181
-extern void erratum_a15_798181_init(void);
-#else
-static inline void erratum_a15_798181_init(void) {}
-#endif
-extern bool (*erratum_a15_798181_handler)(void);
-
-static inline bool erratum_a15_798181(void)
-{
-	if (unlikely(IS_ENABLED(CONFIG_ARM_ERRATA_798181) &&
-		erratum_a15_798181_handler))
-		return erratum_a15_798181_handler();
-	return false;
-}
-
 /*
  *	flush_pmd_entry
  *
@@ -681,4 +666,21 @@ extern void flush_bp_all(void);
 
 #endif
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_ARM_ERRATA_798181
+extern void erratum_a15_798181_init(void);
+#else
+static inline void erratum_a15_798181_init(void) {}
+#endif
+extern bool (*erratum_a15_798181_handler)(void);
+
+static inline bool erratum_a15_798181(void)
+{
+	if (unlikely(IS_ENABLED(CONFIG_ARM_ERRATA_798181) &&
+		erratum_a15_798181_handler))
+		return erratum_a15_798181_handler();
+	return false;
+}
+#endif
+
 #endif
-- 
1.8.1.2
