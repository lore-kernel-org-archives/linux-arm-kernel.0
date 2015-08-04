From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 20:03:08 +0200
Subject: [PATCH 3/7] ARM: shmobile: Remove obsolete custom earlyprintk code
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438711392-23763-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last caller of shmobile_setup_console() was removed in commit
44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
A1").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile  |  2 +-
 arch/arm/mach-shmobile/common.h  |  1 -
 arch/arm/mach-shmobile/console.c | 27 ---------------------------
 3 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/console.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 476de30798d7290b..b02841528e05bbdb 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o
+obj-y				:= timer.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 8d27ec546a35f4b9..ee8fe9e473d72895 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -4,7 +4,6 @@
 extern void shmobile_earlytimer_init(void);
 extern void shmobile_init_delay(void);
 struct twd_local_timer;
-extern void shmobile_setup_console(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
diff --git a/arch/arm/mach-shmobile/console.c b/arch/arm/mach-shmobile/console.c
deleted file mode 100644
index e329ccbd0a6734f1..0000000000000000
--- a/arch/arm/mach-shmobile/console.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * SH-Mobile Console
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <asm/mach/map.h>
-#include "common.h"
-
-void __init shmobile_setup_console(void)
-{
-	parse_early_param();
-
-	/* Let earlyprintk output early console messages */
-	early_platform_driver_probe("earlyprintk", 1, 1);
-}
-- 
1.9.1
