From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:35 +0100
Subject: [PATCH 35/40] ARM: ux500: Take out STUIB support when not booting
 with Device Tree
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-36-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Makefile             |  2 +-
 arch/arm/mach-ux500/board-mop500-stuib.c | 14 --------------
 arch/arm/mach-ux500/board-mop500-uib.c   |  8 --------
 arch/arm/mach-ux500/board-mop500.h       |  1 -
 4 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-stuib.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 8634a3fa..b34b74b 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
-				board-mop500-uib.o board-mop500-stuib.o \
+				board-mop500-uib.o \
 				board-mop500-pins.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-ux500/board-mop500-stuib.c b/arch/arm/mach-ux500/board-mop500-stuib.c
deleted file mode 100644
index 7fa3021..0000000
--- a/arch/arm/mach-ux500/board-mop500-stuib.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL), version 2
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include "board-mop500.h"
-
-void __init mop500_stuib_init(void)
-{
-}
diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 0e94f1d..2742eec 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -15,7 +15,6 @@
 #include "id.h"
 
 enum mop500_uib {
-	STUIB,
 };
 
 struct uib {
@@ -25,11 +24,6 @@ struct uib {
 };
 
 static struct uib __initdata mop500_uibs[] = {
-	[STUIB] = {
-		.name	= "ST-UIB",
-		.option	= "stuib",
-		.init	= mop500_stuib_init,
-	},
 };
 
 static struct uib *mop500_uib;
@@ -99,7 +93,5 @@ int __init mop500_uib_init(void)
 		return 0;
 	}
 
-	__mop500_uib_init(&mop500_uibs[STUIB], "detected");
-
 	return 0;
 }
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index 223639b..2fb89e2 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -89,7 +89,6 @@ extern struct msp_i2s_platform_data msp2_platform_data;
 extern struct msp_i2s_platform_data msp3_platform_data;
 extern struct pl022_ssp_controller ssp0_plat;
 
-void __init mop500_stuib_init(void);
 void __init mop500_pinmaps_init(void);
 void __init snowball_pinmaps_init(void);
 void __init hrefv60_pinmaps_init(void);
-- 
1.8.1.2
