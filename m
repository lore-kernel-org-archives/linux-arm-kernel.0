From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:45 +0800
Subject: [PATCH 09/13] ARM: mxs: remove mm.c
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static mapping is used nowhere now.  Hence mm.c can be removed
completely.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile              |    2 +-
 arch/arm/mach-mxs/include/mach/common.h |    2 --
 arch/arm/mach-mxs/mm.c                  |   52 -------------------------------
 3 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/mm.c

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 5339973..2568d24 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,5 +1,5 @@
 # Common support
-obj-y := ocotp.o mm.o
+obj-y := ocotp.o
 
 obj-$(CONFIG_PM) += pm.o
 
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index b7946a6..79cb572 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -15,9 +15,7 @@ extern const u32 *mxs_get_ocotp(void);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
 extern int mx23_clocks_init(void);
-extern void mx23_map_io(void);
 
 extern int mx28_clocks_init(void);
-extern void mx28_map_io(void);
 
 #endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
deleted file mode 100644
index e63b7d8..0000000
--- a/arch/arm/mach-mxs/mm.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * The code contained herein is licensed under the GNU General Public
- * License.  You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- *
- * Create static mapping between physical to virtual memory.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/mx23.h>
-#include <mach/mx28.h>
-#include <mach/common.h>
-
-/*
- * Define the MX23 memory map.
- */
-static struct map_desc mx23_io_desc[] __initdata = {
-	mxs_map_entry(MX23, OCRAM, MT_DEVICE),
-	mxs_map_entry(MX23, IO, MT_DEVICE),
-};
-
-/*
- * Define the MX28 memory map.
- */
-static struct map_desc mx28_io_desc[] __initdata = {
-	mxs_map_entry(MX28, OCRAM, MT_DEVICE),
-	mxs_map_entry(MX28, IO, MT_DEVICE),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx23_map_io(void)
-{
-	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
-}
-
-void __init mx28_map_io(void)
-{
-	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
-}
-- 
1.7.9.5
