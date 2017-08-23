From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 23 Aug 2017 21:08:34 +0200
Subject: [PATCH] ARM: bcm283x: Fix SMP for old dtb files
Message-ID: <1503515314-16576-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since "irqchip: bcm2836: Move SMP startup code to arch/arm" the SMP
for BCM2836 and BCM2837 (32 bit) depends on commit "ARM: dts: bcm283x:
Add 32-bit enable method for SMP". This patch fixes SMP for older
dtb files.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-bcm/board_bcm2835.c |  6 +++++-
 arch/arm/mach-bcm/platsmp.c       |  2 +-
 arch/arm/mach-bcm/platsmp.h       | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-bcm/platsmp.h

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 24af33f..8cff865 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -19,16 +19,20 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include "platsmp.h"
+
 static const char * const bcm2835_compat[] = {
 #ifdef CONFIG_ARCH_MULTI_V6
 	"brcm,bcm2835",
 #endif
 #ifdef CONFIG_ARCH_MULTI_V7
 	"brcm,bcm2836",
+	"brcm,bcm2837",
 #endif
 	NULL
 };
 
 DT_MACHINE_START(BCM2835, "BCM2835")
-	.dt_compat = bcm2835_compat
+	.dt_compat = bcm2835_compat,
+	.smp = smp_ops(bcm2836_smp_ops),
 MACHINE_END
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 7811160..7d95483 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -339,7 +339,7 @@ static const struct smp_operations nsp_smp_ops __initconst = {
 };
 CPU_METHOD_OF_DECLARE(bcm_smp_nsp, "brcm,bcm-nsp-smp", &nsp_smp_ops);
 
-static const struct smp_operations bcm2836_smp_ops __initconst = {
+const struct smp_operations bcm2836_smp_ops __initconst = {
 	.smp_boot_secondary	= bcm2836_boot_secondary,
 };
 CPU_METHOD_OF_DECLARE(bcm_smp_bcm2836, "brcm,bcm2836-smp", &bcm2836_smp_ops);
diff --git a/arch/arm/mach-bcm/platsmp.h b/arch/arm/mach-bcm/platsmp.h
new file mode 100644
index 0000000..b8b8b3f
--- /dev/null
+++ b/arch/arm/mach-bcm/platsmp.h
@@ -0,0 +1,10 @@
+/*
+ * Copyright (C) 2017 Stefan Wahren <stefan.wahren@i2se.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ */
+
+extern const struct smp_operations bcm2836_smp_ops;
-- 
2.7.4
