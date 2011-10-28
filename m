From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:18 +0100
Subject: [PATCH 50/51] ARM: plat-s3c24xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-51-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates plat-s3c24xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-s3c2410/include/mach/system-reset.h |   32 ---------------------
 arch/arm/mach-s3c2410/include/mach/system.h       |    2 -
 arch/arm/mach-s3c64xx/include/mach/system.h       |    2 +-
 arch/arm/plat-s3c24xx/cpu.c                       |   23 +++++++++++++--
 4 files changed, 21 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h

diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-s3c2410/include/mach/system-reset.h
deleted file mode 100644
index 6faadce..0000000
--- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/system-reset.h
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - System define for arch_reset() function
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <mach/hardware.h>
-#include <plat/watchdog-reset.h>
-
-extern void (*s3c24xx_reset_hook)(void);
-
-static void
-arch_reset(char mode, const char *cmd)
-{
-	if (mode == 's') {
-		cpu_reset(0);
-	}
-
-	if (s3c24xx_reset_hook)
-		s3c24xx_reset_hook();
-
-	arch_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	cpu_reset(0);
-}
diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index a8cbca6..a94e7a6 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -54,5 +54,3 @@ static void arch_idle(void)
 	else
 		s3c24xx_default_idle();
 }
-
-#include <mach/system-reset.h>
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index 51bc8eb..436a8b3 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -16,7 +16,7 @@ static void arch_idle(void)
 	/* nothing here yet */
 }
 
-static void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
 }
 
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index c1fc6c6..b8714db 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -38,8 +38,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/system-reset.h>
-
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 
@@ -51,6 +49,7 @@
 #include <plat/s3c2416.h>
 #include <plat/s3c244x.h>
 #include <plat/s3c2443.h>
+#include <plat/watchdog-reset.h>
 
 /* table of supported CPUs */
 
@@ -205,7 +204,7 @@ static void s3c24xx_pm_restart(char mode, const char *cmd)
 		__cpuc_flush_kern_all();
 		__cpuc_flush_user_all();
 
-		arch_reset(mode, cmd);
+		arm_arch_reset(mode, cmd);
 		local_irq_restore(flags);
 	}
 
@@ -213,6 +212,23 @@ static void s3c24xx_pm_restart(char mode, const char *cmd)
 	arm_machine_restart(mode, cmd);
 }
 
+extern void (*s3c24xx_reset_hook)(void);
+
+static void s3c24xx_arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		cpu_reset(0);
+	}
+
+	if (s3c24xx_reset_hook)
+		s3c24xx_reset_hook();
+
+	arch_wdt_reset();
+
+	/* we'll take a jump through zero as a poor second */
+	cpu_reset(0);
+}
+
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
 	unsigned long idcode = 0x0;
@@ -227,6 +243,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 		idcode = s3c24xx_read_idcode_v4();
 	}
 
+	arm_arch_reset = s3c24xx_arch_reset;
 	arm_pm_restart = s3c24xx_pm_restart;
 
 	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
-- 
1.7.4.1
