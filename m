From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 27 Sep 2011 16:22:43 -0400
Subject: [PATCH 2/3] ARM: S5P: Make the sleep code common for S5P series SoCs
In-Reply-To: <1317154964-22600-1-git-send-email-a.kesavan@samsung.com>
References: <1317154964-22600-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1317154964-22600-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sleep code for S5PV210 and EXYNOS4 are identical; moreover
S5p64X0 and S5PC100 for which support will be added soon can
use the same procedure. Create a common sleep code in the plat-s5p
directory so that it can be re-used.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig               |    2 +
 arch/arm/mach-exynos4/Makefile              |    2 +-
 arch/arm/mach-s5pv210/Kconfig               |    1 +
 arch/arm/mach-s5pv210/Makefile              |    2 +-
 arch/arm/mach-s5pv210/sleep.S               |   52 ---------------------------
 arch/arm/plat-s5p/Kconfig                   |    6 +++
 arch/arm/plat-s5p/Makefile                  |    1 +
 arch/arm/{mach-exynos4 => plat-s5p}/sleep.S |   13 ++-----
 8 files changed, 16 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/sleep.S
 rename arch/arm/{mach-exynos4 => plat-s5p}/sleep.S (81%)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 7ed7d49..d440df9 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -13,12 +13,14 @@ config CPU_EXYNOS4210
 	bool
 	select SAMSUNG_DMADEV
 	select S5P_PM if PM
+	select S5P_SLEEP if PM
 	help
 	  Enable EXYNOS4210 CPU support
 
 config SOC_EXYNOS4212
 	bool
 	select S5P_PM if PM
+	select S5P_SLEEP if PM
 	help
 	  Enable EXYNOS4212 SoC support
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index e19cd12..c8f68ab 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
-obj-$(CONFIG_PM)		+= pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 356aa75..a356e82 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -15,6 +15,7 @@ config CPU_S5PV210
 	select S5P_EXT_INT
 	select S5P_HRT
 	select S5P_PM if PM
+	select S5P_SLEEP if PM
 	help
 	  Enable S5PV210 CPU support
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index ef7e466..009fbe5 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
-obj-$(CONFIG_PM)		+= pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
deleted file mode 100644
index e3452cc..0000000
--- a/arch/arm/mach-s5pv210/sleep.S
+++ /dev/null
@@ -1,52 +0,0 @@
-/* linux/arch/arm/plat-s5p/sleep.S
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5PV210 power Manager (Suspend-To-RAM) support
- * Based on S3C2410 sleep code by:
- * 	Ben Dooks, (c) 2004 Simtec Electronics
- *
- * Based on PXA/SA1100 sleep code by:
- *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
- *	Cliff Brake, (c) 2001
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/memory.h>
-
-	.text
-
-	/* sleep magic, to allow the bootloader to check for an valid
-	 * image to resume to. Must be the first word before the
-	 * s3c_cpu_resume entry.
-	*/
-
-	.word	0x2bedf00d
-
-	/* s3c_cpu_resume
-	 *
-	 * resume code entry for bootloader to call
-	 *
-	 * we must put this code here in the data segment as we have no
-	 * other way of restoring the stack pointer after sleep, and we
-	 * must not write to the code segment (code is read-only)
-	*/
-
-ENTRY(s3c_cpu_resume)
-	b	cpu_resume
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 53e6743..7b9dada 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -54,6 +54,12 @@ config S5P_SYSTEM_MMU
 	help
 	  Say Y here if you want to enable System MMU
 
+config S5P_SLEEP
+	bool
+	help
+	  Internal config node to apply common S5P sleep management code.
+	  Can be selected by S5P and newer SoCs with similar sleep procedure.
+
 config S5P_DEV_FIMC0
 	bool
 	help
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 755d7ac..06401dc 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpioint.o
 obj-$(CONFIG_S5P_SYSTEM_MMU)	+= sysmmu.o
 obj-$(CONFIG_S5P_PM)		+= pm.o irq-pm.o
+obj-$(CONFIG_S5P_SLEEP)		+= sleep.o
 obj-$(CONFIG_S5P_HRT) 		+= s5p-time.o
 
 # devices
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/plat-s5p/sleep.S
similarity index 81%
rename from arch/arm/mach-exynos4/sleep.S
rename to arch/arm/plat-s5p/sleep.S
index 0984078..0fd591b 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/plat-s5p/sleep.S
@@ -1,15 +1,11 @@
-/* linux/arch/arm/mach-exynos4/sleep.S
+/* linux/arch/arm/plat-s5p/sleep.S
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4210 power Manager (Suspend-To-RAM) support
- * Based on S3C2410 sleep code by:
- *	Ben Dooks, (c) 2004 Simtec Electronics
- *
- * Based on PXA/SA1100 sleep code by:
- *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
- *	Cliff Brake, (c) 2001
+ * Common S5P Sleep Code
+ * Based on S3C64XX sleep code by:
+ *	Ben Dooks, (c) 2008 Simtec Electronics
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -28,7 +24,6 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
 
 	.text
 
-- 
1.7.0.4
