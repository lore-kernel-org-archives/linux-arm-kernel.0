From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:57 -0800
Subject: [PATCH 20/26] ARM: S3C24XX: remove dsc.c and make regs-dsc.h local
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-21-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-s3c2440/dsc.c is no longer used and the header, regs-dsc.h
can be local in mach-s3c24xx/.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/Makefile                     |    2 -
 arch/arm/mach-s3c2440/dsc.c                        |   54 --------------------
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 |    8 +--
 .../arm/mach-s3c24xx/{include/mach => }/regs-dsc.h |    0
 arch/arm/mach-s3c24xx/s3c2412.c                    |    3 +-
 arch/arm/mach-s3c24xx/s3c244x.c                    |    3 +-
 6 files changed, 8 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2440/dsc.c
 rename arch/arm/mach-s3c24xx/{include/mach => }/regs-dsc.h (100%)

diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index c460924..0ddd17f 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -9,8 +9,6 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2440)	+= dsc.o
-
 obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
 
 obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
diff --git a/arch/arm/mach-s3c2440/dsc.c b/arch/arm/mach-s3c2440/dsc.c
deleted file mode 100644
index 9ea66e3..0000000
--- a/arch/arm/mach-s3c2440/dsc.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/* linux/arch/arm/mach-s3c2440/dsc.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * Samsung S3C2440 Drive Strength Control support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/io.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <mach/regs-gpio.h>
-#include <mach/regs-dsc.h>
-
-#include <plat/cpu.h>
-#include <plat/s3c244x.h>
-
-int s3c2440_set_dsc(unsigned int pin, unsigned int value)
-{
-	void __iomem *base;
-	unsigned long val;
-	unsigned long flags;
-	unsigned long mask;
-
-	base = (pin & S3C2440_SELECT_DSC1) ? S3C2440_DSC1 : S3C2440_DSC0;
-	mask = 3 << S3C2440_DSC_GETSHIFT(pin);
-
-	local_irq_save(flags);
-
-	val = __raw_readl(base);
-	val &= ~mask;
-	val |= value & mask;
-	__raw_writel(val, base);
-
-	local_irq_restore(flags);
-	return 0;
-}
-
-EXPORT_SYMBOL(s3c2440_set_dsc);
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index c60f67a..206765c 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -21,19 +21,19 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/cacheflush.h>
 #include <asm/irq.h>
 
-#include <mach/regs-power.h>
+#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-dsc.h>
+#include <mach/regs-power.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-
 #include <plat/s3c2412.h>
 
+#include "regs-dsc.h"
+
 extern void s3c2412_sleep_enter(void);
 
 static int s3c2412_cpu_suspend(unsigned long arg)
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-dsc.h b/arch/arm/mach-s3c24xx/regs-dsc.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/regs-dsc.h
rename to arch/arm/mach-s3c24xx/regs-dsc.h
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 26ab760..c511a22 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -33,7 +33,6 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-dsc.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-power.h>
 
@@ -48,6 +47,8 @@
 #include <plat/regs-spi.h>
 #include <plat/s3c2412.h>
 
+#include "regs-dsc.h"
+
 #define S3C2412_SWRST			(S3C24XX_VA_CLKPWR + 0x30)
 #define S3C2412_SWRST_RESET		(0x533C2412)
 
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index b0b60a1..ad2671b 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -36,7 +36,6 @@
 #include <mach/regs-clock.h>
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-dsc.h>
 
 #include <plat/s3c2410.h>
 #include <plat/s3c244x.h>
@@ -48,6 +47,8 @@
 #include <plat/nand-core.h>
 #include <plat/watchdog-reset.h>
 
+#include "regs-dsc.h"
+
 static struct map_desc s3c244x_iodesc[] __initdata = {
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
-- 
1.7.10.4
