From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:36 -0500
Subject: [PATCH 10/10] ARM: make mach/gpio.h headers optional
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Most platforms don't need mach/gpio.h and it prevents multi-platform
kernel images. Add CONFIG_NEED_MACH_GPIO_H and make platforns select it
if they need gpio.h. This is platforms that define __GPIOLIB_COMPLEX
or have lots of implicit includes pulled in by mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                            |   17 ++++++++++++++
 arch/arm/include/asm/gpio.h                 |    2 ++
 arch/arm/mach-ep93xx/include/mach/gpio.h    |    1 -
 arch/arm/mach-highbank/include/mach/gpio.h  |    1 -
 arch/arm/mach-ixp4xx/include/mach/gpio.h    |    2 --
 arch/arm/mach-mmp/include/mach/gpio.h       |    8 -------
 arch/arm/mach-msm/include/mach/gpio.h       |    1 -
 arch/arm/mach-mxs/include/mach/gpio.h       |    1 -
 arch/arm/mach-nomadik/include/mach/gpio.h   |    4 ----
 arch/arm/mach-picoxcell/include/mach/gpio.h |    1 -
 arch/arm/mach-pxa/include/mach/gpio.h       |   32 ---------------------------
 arch/arm/mach-realview/include/mach/gpio.h  |    1 -
 arch/arm/mach-spear13xx/include/mach/gpio.h |   19 ----------------
 arch/arm/mach-spear3xx/include/mach/gpio.h  |   19 ----------------
 arch/arm/mach-spear6xx/include/mach/gpio.h  |   19 ----------------
 arch/arm/mach-tegra/include/mach/gpio.h     |    1 -
 arch/arm/mach-u300/include/mach/gpio.h      |    1 -
 arch/arm/mach-ux500/include/mach/gpio.h     |    5 -----
 arch/arm/mach-versatile/include/mach/gpio.h |    1 -
 arch/arm/mach-vexpress/include/mach/gpio.h  |    1 -
 arch/arm/mach-vt8500/include/mach/gpio.h    |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h       |    1 -
 arch/arm/plat-spear/include/plat/gpio.h     |    1 -
 23 files changed, 19 insertions(+), 121 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-realview/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d6e18f..3557f12 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -202,6 +202,13 @@ config ARM_PATCH_PHYS_VIRT
 	  this feature (eg, building a kernel for a single machine) and
 	  you need to shrink the kernel to the minimal size.
 
+config NEED_MACH_GPIO_H
+	bool
+	help
+	  Select this when mach/gpio.h is required to provide special
+	  definitions for this platform. The need for mach/gpio.h should
+	  be avoided when possible.
+
 config NEED_MACH_IO_H
 	bool
 	help
@@ -523,6 +530,7 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
@@ -536,6 +544,7 @@ config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
@@ -795,6 +804,7 @@ config ARCH_SA1100
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_IDE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
@@ -810,6 +820,7 @@ config ARCH_S3C24XX
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	help
 	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
@@ -837,6 +848,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_GPIOLIB_4BIT
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S3C64XX series based systems
 
@@ -851,6 +863,7 @@ config ARCH_S5P64X0
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -865,6 +878,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S5PC100 series based systems
 
@@ -882,6 +896,7 @@ config ARCH_S5PV210
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Samsung S5PV210/S5PC110 series based systems
@@ -899,6 +914,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
@@ -971,6 +987,7 @@ config ARCH_DAVINCI
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_CHIP
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's DaVinci platform.
 
diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index c402e9b..477e020 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -6,7 +6,9 @@
 #endif
 
 /* not all ARM platforms necessarily support this API ... */
+#ifdef CONFIG_NEED_MACH_GPIO_H
 #include <mach/gpio.h>
+#endif
 
 #ifndef __ARM_GPIOLIB_COMPLEX
 /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-highbank/include/mach/gpio.h b/arch/arm/mach-highbank/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-highbank/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
deleted file mode 100644
index ef37f26..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* empty */
-
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
deleted file mode 100644
index 13219eb..0000000
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __ASM_MACH_GPIO_H
-#define __ASM_MACH_GPIO_H
-
-#include <asm-generic/gpio.h>
-
-#include <mach/cputype.h>
-
-#endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-msm/include/mach/gpio.h b/arch/arm/mach-msm/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-msm/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-nomadik/include/mach/gpio.h b/arch/arm/mach-nomadik/include/mach/gpio.h
deleted file mode 100644
index efdde0a..0000000
--- a/arch/arm/mach-nomadik/include/mach/gpio.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-picoxcell/include/mach/gpio.h b/arch/arm/mach-picoxcell/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-picoxcell/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
deleted file mode 100644
index 0248e43..0000000
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/gpio.h
- *
- * PXA GPIO wrappers for arch-neutral GPIO calls
- *
- * Written by Philipp Zabel <philipp.zabel@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef __ASM_ARCH_PXA_GPIO_H
-#define __ASM_ARCH_PXA_GPIO_H
-
-#include <asm-generic/gpio.h>
-
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-
-#endif
diff --git a/arch/arm/mach-realview/include/mach/gpio.h b/arch/arm/mach-realview/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-realview/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear13xx/include/mach/gpio.h b/arch/arm/mach-spear13xx/include/mach/gpio.h
deleted file mode 100644
index 85f1763..0000000
--- a/arch/arm/mach-spear13xx/include/mach/gpio.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear13xx/include/mach/gpio.h
- *
- * GPIO macros for SPEAr13xx machine family
- *
- * Copyright (C) 2012 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GPIO_H
-#define __MACH_GPIO_H
-
-#include <plat/gpio.h>
-
-#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
deleted file mode 100644
index 2ac74c6..0000000
--- a/arch/arm/mach-spear3xx/include/mach/gpio.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/gpio.h
- *
- * GPIO macros for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GPIO_H
-#define __MACH_GPIO_H
-
-#include <plat/gpio.h>
-
-#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/gpio.h b/arch/arm/mach-spear6xx/include/mach/gpio.h
deleted file mode 100644
index d42cefc..0000000
--- a/arch/arm/mach-spear6xx/include/mach/gpio.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/gpio.h
- *
- * GPIO macros for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_GPIO_H
-#define __MACH_GPIO_H
-
-#include <plat/gpio.h>
-
-#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
deleted file mode 100644
index c01ef66..0000000
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-versatile/include/mach/gpio.h b/arch/arm/mach-versatile/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-versatile/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-vexpress/include/mach/gpio.h b/arch/arm/mach-vexpress/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-vexpress/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-vt8500/include/mach/gpio.h b/arch/arm/mach-vt8500/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-vt8500/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/plat-spear/include/plat/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
-- 
1.7.9.5
