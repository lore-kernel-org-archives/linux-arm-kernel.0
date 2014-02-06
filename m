From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:53 +0100
Subject: [PATCH v2 08/12] ARM: SAMSUNG: pm: Move s3c_pm_check_* prototypes to
 plat/pm-common.h
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow using Samsung PM memory check helpers on platforms that do not
use the legacy Samsung PM core, this patch moves prototypes of relevant
functions to plat/pm-common.h header.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/pm-common.h | 14 ++++++++++++++
 arch/arm/plat-samsung/include/plat/pm.h        | 14 --------------
 arch/arm/plat-samsung/pm-check.c               |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index 741723e..8705f9e 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -93,4 +93,18 @@ static inline void s3c_pm_save_uarts(void) { }
 static inline void s3c_pm_restore_uarts(void) { }
 #endif
 
+/* suspend memory checking */
+
+#ifdef CONFIG_SAMSUNG_PM_CHECK
+extern void s3c_pm_check_prepare(void);
+extern void s3c_pm_check_restore(void);
+extern void s3c_pm_check_cleanup(void);
+extern void s3c_pm_check_store(void);
+#else
+#define s3c_pm_check_prepare() do { } while (0)
+#define s3c_pm_check_restore() do { } while (0)
+#define s3c_pm_check_cleanup() do { } while (0)
+#define s3c_pm_check_store()   do { } while (0)
+#endif
+
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 4099e8d..e17d871 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -80,20 +80,6 @@ extern void s3c_pm_debug_smdkled(u32 set, u32 clear);
 static inline void s3c_pm_debug_smdkled(u32 set, u32 clear) { }
 #endif /* CONFIG_S3C_PM_DEBUG_LED_SMDK */
 
-/* suspend memory checking */
-
-#ifdef CONFIG_SAMSUNG_PM_CHECK
-extern void s3c_pm_check_prepare(void);
-extern void s3c_pm_check_restore(void);
-extern void s3c_pm_check_cleanup(void);
-extern void s3c_pm_check_store(void);
-#else
-#define s3c_pm_check_prepare() do { } while(0)
-#define s3c_pm_check_restore() do { } while(0)
-#define s3c_pm_check_cleanup() do { } while(0)
-#define s3c_pm_check_store()   do { } while(0)
-#endif
-
 /**
  * s3c_pm_configure_extint() - ensure pins are correctly set for IRQ
  *
diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index 3cbd626..04aff2c 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -19,7 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 
-#include <plat/pm.h>
+#include <plat/pm-common.h>
 
 #if CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE < 1
 #error CONFIG_SAMSUNG_PM_CHECK_CHUNKSIZE must be a positive non-zero value
-- 
1.8.5.2
