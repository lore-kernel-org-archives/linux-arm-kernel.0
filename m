From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 12 Dec 2011 21:46:52 +0000
Subject: [PATCH 3/5] ARM: picoxcell: move io mappings to common.c
In-Reply-To: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
References: <1323726414-3319-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1323726414-3319-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have lost our machine specific ioremap() we just have one
mapping that covers all peripherals.  Move this to common.c to simplify
things a little.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile |    1 -
 arch/arm/mach-picoxcell/common.c |   13 +++++++++++++
 arch/arm/mach-picoxcell/common.h |    1 -
 arch/arm/mach-picoxcell/io.c     |   32 --------------------------------
 4 files changed, 13 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/io.c

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index c550b63..e5ec4a8 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,3 +1,2 @@
 obj-y	:= common.o
 obj-y	+= time.o
-obj-y	+= io.o
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 7d91165..88c53e0 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -16,12 +16,25 @@
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/vic.h>
+#include <asm/mach/map.h>
 
 #include <mach/map.h>
 #include <mach/picoxcell_soc.h>
 
 #include "common.h"
 
+static struct map_desc io_map __initdata = {
+	.virtual	= PHYS_TO_IO(PICOXCELL_PERIPH_BASE),
+	.pfn		= __phys_to_pfn(PICOXCELL_PERIPH_BASE),
+	.length		= PICOXCELL_PERIPH_LENGTH,
+	.type		= MT_DEVICE,
+};
+
+static void __init picoxcell_map_io(void)
+{
+	iotable_init(&io_map, 1);
+}
+
 static void __init picoxcell_init_machine(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
index 5263f0f..83d55ab 100644
--- a/arch/arm/mach-picoxcell/common.h
+++ b/arch/arm/mach-picoxcell/common.h
@@ -13,6 +13,5 @@
 #include <asm/mach/time.h>
 
 extern struct sys_timer picoxcell_timer;
-extern void picoxcell_map_io(void);
 
 #endif /* __PICOXCELL_COMMON_H__ */
diff --git a/arch/arm/mach-picoxcell/io.c b/arch/arm/mach-picoxcell/io.c
deleted file mode 100644
index 39e9b9e..0000000
--- a/arch/arm/mach-picoxcell/io.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * All enquiries to support at picochip.com
- */
-#include <linux/io.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/of.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/map.h>
-#include <mach/picoxcell_soc.h>
-
-#include "common.h"
-
-void __init picoxcell_map_io(void)
-{
-	struct map_desc io_map = {
-		.virtual	= PHYS_TO_IO(PICOXCELL_PERIPH_BASE),
-		.pfn		= __phys_to_pfn(PICOXCELL_PERIPH_BASE),
-		.length		= PICOXCELL_PERIPH_LENGTH,
-		.type		= MT_DEVICE,
-	};
-
-	iotable_init(&io_map, 1);
-}
-- 
1.7.5.4
