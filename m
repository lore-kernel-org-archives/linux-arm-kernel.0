From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Jul 2012 08:48:30 +0000
Subject: [PATCH 1/2] ARM: sa1100: add missing include of linux/io.h
Message-ID: <201207070848.30706.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After c00184f9ab4 "ARM: sa11x0/pxa: convert OS timer registers to IOMEM",
pleb_defconfig produces this new warning:

arch/arm/mach-sa1100/cpu-sa1100.c: In function 'sa1100_update_dram_timings':
arch/arm/mach-sa1100/cpu-sa1100.c:153:3: error: implicit declaration of function 'IOMEM'

Adding linux/io.h to the file using the __REG() macro avoids the warning.
In the long run, we still need to convert the entire file to use
readl/writel rather than directly derefencing the pointer, but this makes
it compile again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
index 19b2053..e8f4d1e 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/arch/arm/mach-sa1100/cpu-sa1100.c
@@ -87,6 +87,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/cpufreq.h>
+#include <linux/io.h>
 
 #include <asm/cputype.h>
 
