From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:56:24 +0530
Subject: [PATCH 2/5] ARM: SAMSUNG: Make the sleep code common for S3C64XX and
	newer SoCs
In-Reply-To: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1313144787-30666-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sleep code for S5PV210 and EXYNOS4 is identical; moreover it is quite similar
to that for S3C64XX except for some SoC specific debug logic. S5P64X0 and S5PC100,
for which support will be added soon, can also use the same procedure. Create a
common sleep code in the plat-samsung directory so that it can be re-used.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig  |    1 +
 arch/arm/mach-exynos4/Makefile |    2 +-
 arch/arm/mach-exynos4/sleep.S  |   54 ---------------------------
 arch/arm/mach-s3c64xx/Kconfig  |    1 +
 arch/arm/mach-s3c64xx/Makefile |    1 -
 arch/arm/mach-s3c64xx/sleep.S  |   72 ------------------------------------
 arch/arm/mach-s5pv210/Kconfig  |    1 +
 arch/arm/mach-s5pv210/Makefile |    2 +-
 arch/arm/mach-s5pv210/sleep.S  |   52 --------------------------
 arch/arm/plat-samsung/Kconfig  |    7 +++
 arch/arm/plat-samsung/Makefile |    1 +
 arch/arm/plat-samsung/sleep.S  |   80 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 93 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/sleep.S
 delete mode 100644 arch/arm/mach-s3c64xx/sleep.S
 delete mode 100644 arch/arm/mach-s5pv210/sleep.S
 create mode 100644 arch/arm/plat-samsung/sleep.S

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 77362c2..6c39ac4 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -13,6 +13,7 @@ config CPU_EXYNOS4210
 	bool
 	select S3C_PL330_DMA
 	select S5P_PM if PM
+	select SAMSUNG_SLEEP if PM
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index b7fe1d7..e172b4b 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
-obj-$(CONFIG_PM)		+= pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
deleted file mode 100644
index 0984078..0000000
--- a/arch/arm/mach-exynos4/sleep.S
+++ /dev/null
@@ -1,54 +0,0 @@
-/* linux/arch/arm/mach-exynos4/sleep.S
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4210 power Manager (Suspend-To-RAM) support
- * Based on S3C2410 sleep code by:
- *	Ben Dooks, (c) 2004 Simtec Electronics
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
-	/*
-	 * sleep magic, to allow the bootloader to check for an valid
-	 * image to resume to. Must be the first word before the
-	 * s3c_cpu_resume entry.
-	 */
-
-	.word	0x2bedf00d
-
-	/*
-	 * s3c_cpu_resume
-	 *
-	 * resume code entry for bootloader to call
-	 *
-	 * we must put this code here in the data segment as we have no
-	 * other way of restoring the stack pointer after sleep, and we
-	 * must not write to the code segment (code is read-only)
-	 */
-
-ENTRY(s3c_cpu_resume)
-	b	cpu_resume
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f057b6a..764cca3 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -8,6 +8,7 @@ config PLAT_S3C64XX
 	bool
 	depends on ARCH_S3C64XX
 	select SAMSUNG_WAKEMASK
+	select SAMSUNG_SLEEP if PM
 	default y
 	help
 	  Base platform code for any Samsung S3C64XX device
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 61b4034..c83b7d7 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 # PM
 
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_PM)		+= irq-pm.o
 
 # Machine support
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
deleted file mode 100644
index 34313f9..0000000
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ /dev/null
@@ -1,72 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/sleep.S
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX CPU sleep code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <mach/map.h>
-
-#undef S3C64XX_VA_GPIO
-#define S3C64XX_VA_GPIO (0x0)
-
-#include <mach/regs-gpio.h>
-
-#define LL_UART (S3C_PA_UART + (0x400 * CONFIG_S3C_LOWLEVEL_UART_PORT))
-
-	.text
-
-	/* Sleep magic, the word before the resume entry point so that the
-	 * bootloader can check for a resumeable image. */
-
-	.word	0x2bedf00d
-
-	/* s3c_cpu_reusme
-	 *
-	 * This is the entry point, stored by whatever method the bootloader
-	 * requires to get the kernel runnign again. This code expects to be
-	 * entered with no caches live and the MMU disabled. It will then
-	 * restore the MMU and other basic CP registers saved and restart
-	 * the kernel C code to finish the resume code.
-	*/
-
-ENTRY(s3c_cpu_resume)
-	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
-	ldr	r2, =LL_UART		/* for debug */
-
-#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-
-#define S3C64XX_GPNCON			(S3C64XX_GPN_BASE + 0x00)
-#define S3C64XX_GPNDAT			(S3C64XX_GPN_BASE + 0x04)
-
-#define S3C64XX_GPN_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPN_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-	/* Initialise the GPIO state if we are debugging via the SMDK LEDs,
-	 * as the uboot version supplied resets these to inputs during the
-	 * resume checks.
-	*/
-
-	ldr	r3, =S3C64XX_PA_GPIO
-	ldr	r0, [ r3, #S3C64XX_GPNCON ]
-	bic	r0, r0, #(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) | \
-			  S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15))
-	orr	r0, r0, #(S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) | \
-			  S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15))
-	str	r0, [ r3, #S3C64XX_GPNCON ]
-
-	ldr	r0, [ r3, #S3C64XX_GPNDAT ]
-	bic	r0, r0, #0xf << 12			@ GPN12..15
-	orr	r0, r0, #1 << 15			@ GPN15
-	str	r0, [ r3, #S3C64XX_GPNDAT ]
-#endif
-	b	cpu_resume
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index b31e866..008eb67 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -15,6 +15,7 @@ config CPU_S5PV210
 	select S5P_EXT_INT
 	select S5P_HRT
 	select S5P_PM if PM
+	select SAMSUNG_SLEEP if PM
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
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..aae6d55 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -359,6 +359,13 @@ config SAMSUNG_WAKEMASK
 	  and above. This code allows a set of interrupt to wakeup-mask
 	  mappings. See <plat/wakeup-mask.h>
 
+config SAMSUNG_SLEEP
+	bool
+	help
+	  Internal configuration to enable the common Samsung sleep code.
+	  Can be selected by S3C64XX and newer SoCs having similar sleep
+	  procedure.
+
 comment "Power Domain"
 
 config SAMSUNG_PD
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 853764b..4cb4fcb 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_PM)		+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
+obj-$(CONFIG_SAMSUNG_SLEEP)	+= sleep.o
 
 # PD support
 
diff --git a/arch/arm/plat-samsung/sleep.S b/arch/arm/plat-samsung/sleep.S
new file mode 100644
index 0000000..02777c5
--- /dev/null
+++ b/arch/arm/plat-samsung/sleep.S
@@ -0,0 +1,80 @@
+/* linux/arch/arm/plat-samsung/sleep.S
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Common Samsung sleep code for S3C64XX and newer SoCs
+ * Based on S3C64XX sleep code by:
+ *	Ben Dooks, (c) 2008 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#if defined(CONFIG_S3C_PM_DEBUG_LED_SMDK)
+#include <mach/map.h>
+#include <mach/regs-gpio.h>
+#endif
+	.text
+
+	/*
+	 * sleep magic, to allow the bootloader to check for an valid
+	 * image to resume to. Must be the first word before the
+	 * s3c_cpu_resume entry.
+	 */
+
+	.word	0x2bedf00d
+
+	/*
+	 * s3c_cpu_resume
+	 *
+	 * resume code entry for bootloader to call
+	 *
+	 * we must put this code here in the data segment as we have no
+	 * other way of restoring the stack pointer after sleep, and we
+	 * must not write to the code segment (code is read-only)
+	 */
+
+ENTRY(s3c_cpu_resume)
+#if defined(CONFIG_S3C_PM_DEBUG_LED_SMDK)
+
+#undef S3C64XX_VA_GPIO
+#define S3C64XX_VA_GPIO (0x0)
+#define S3C64XX_GPNCON			(S3C64XX_GPN_BASE + 0x00)
+#define S3C64XX_GPNDAT			(S3C64XX_GPN_BASE + 0x04)
+
+#define S3C64XX_GPN_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
+#define S3C64XX_GPN_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
+
+	/* Initialise the GPIO state if we are debugging via the SMDK LEDs,
+	 * as the uboot version supplied resets these to inputs during the
+	 * resume checks.
+	*/
+
+	ldr	r3, =S3C64XX_PA_GPIO
+	ldr	r0, [ r3, #S3C64XX_GPNCON ]
+	bic	r0, r0, #(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) | \
+			  S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15))
+	orr	r0, r0, #(S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) | \
+			  S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15))
+	str	r0, [ r3, #S3C64XX_GPNCON ]
+
+	ldr	r0, [ r3, #S3C64XX_GPNDAT ]
+	bic	r0, r0, #0xf << 12			@ GPN12..15
+	orr	r0, r0, #1 << 15			@ GPN15
+	str	r0, [ r3, #S3C64XX_GPNDAT ]
+#endif
+	b	cpu_resume
-- 
1.7.4.1
