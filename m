From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 14:42:43 -0500
Subject: [PATCH v2 6/6] ARM: make mach/gpio.h headers optional
In-Reply-To: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346960563-18689-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Most platforms don't need mach/gpio.h and it prevents multi-platform
kernel images. Add CONFIG_NEED_MACH_GPIO_H and make platforns select it
if they need gpio.h. This is platforms that define __GPIOLIB_COMPLEX
or have lots of implicit includes pulled in by mach/gpio.h.

at91 and omap have gpio clean-up pending and can drop
CONFIG_NEED_MACH_GPIO_H once that is in.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                            |   21 +++++++++++++++++++++
 arch/arm/include/asm/gpio.h                 |    2 ++
 arch/arm/mach-dove/include/mach/gpio.h      |    1 -
 arch/arm/mach-ep93xx/include/mach/gpio.h    |    1 -
 arch/arm/mach-highbank/include/mach/gpio.h  |    1 -
 arch/arm/mach-ixp4xx/include/mach/gpio.h    |    2 --
 arch/arm/mach-kirkwood/include/mach/gpio.h  |    1 -
 arch/arm/mach-msm/include/mach/gpio.h       |    1 -
 arch/arm/mach-mxs/include/mach/gpio.h       |    1 -
 arch/arm/mach-nomadik/include/mach/gpio.h   |    4 ----
 arch/arm/mach-orion5x/include/mach/gpio.h   |    1 -
 arch/arm/mach-picoxcell/include/mach/gpio.h |    1 -
 arch/arm/mach-realview/include/mach/gpio.h  |    1 -
 arch/arm/mach-shmobile/include/mach/gpio.h  |    1 -
 arch/arm/mach-spear13xx/include/mach/gpio.h |   19 -------------------
 arch/arm/mach-spear3xx/include/mach/gpio.h  |   19 -------------------
 arch/arm/mach-spear6xx/include/mach/gpio.h  |   19 -------------------
 arch/arm/mach-tegra/include/mach/gpio.h     |    1 -
 arch/arm/mach-u300/include/mach/gpio.h      |    1 -
 arch/arm/mach-ux500/include/mach/gpio.h     |    5 -----
 arch/arm/mach-versatile/include/mach/gpio.h |    1 -
 arch/arm/mach-vexpress/include/mach/gpio.h  |    1 -
 arch/arm/mach-vt8500/include/mach/gpio.h    |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h       |    1 -
 arch/arm/plat-spear/include/plat/gpio.h     |    1 -
 25 files changed, 23 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-realview/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/gpio.h
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
index c5f9ae5..4f5652d 100644
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
@@ -345,6 +352,7 @@ config ARCH_AT91
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H if PCCARD
 	help
 	  This enables support for systems based on Atmel
@@ -523,6 +531,7 @@ config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
@@ -536,6 +545,7 @@ config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
 	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	select NEED_RET_TO_USER
 	select PLAT_IOP
@@ -645,6 +655,7 @@ config ARCH_MMP
 	select PLAT_PXA
 	select SPARSE_IRQ
 	select GENERIC_ALLOCATOR
+	select NEED_MACH_GPIO_H
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
@@ -733,6 +744,7 @@ config ARCH_PXA
 	select MULTI_IRQ_HANDLER
 	select ARM_CPU_SUSPEND if PM
 	select HAVE_IDE
+	select NEED_MACH_GPIO_H
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
@@ -795,6 +807,7 @@ config ARCH_SA1100
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_IDE
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
@@ -810,6 +823,7 @@ config ARCH_S3C24XX
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	help
 	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
@@ -837,6 +851,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_GPIOLIB_4BIT
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S3C64XX series based systems
 
@@ -851,6 +866,7 @@ config ARCH_S5P64X0
 	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -865,6 +881,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	help
 	  Samsung S5PC100 series based systems
 
@@ -882,6 +899,7 @@ config ARCH_S5PV210
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Samsung S5PV210/S5PC110 series based systems
@@ -899,6 +917,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
@@ -971,6 +990,7 @@ config ARCH_DAVINCI
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_CHIP
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's DaVinci platform.
 
@@ -983,6 +1003,7 @@ config ARCH_OMAP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select ARCH_HAS_HOLES_MEMORYMODEL
+	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
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
diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-dove/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
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
diff --git a/arch/arm/mach-kirkwood/include/mach/gpio.h b/arch/arm/mach-kirkwood/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-kirkwood/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
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
diff --git a/arch/arm/mach-orion5x/include/mach/gpio.h b/arch/arm/mach-orion5x/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-orion5x/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-picoxcell/include/mach/gpio.h b/arch/arm/mach-picoxcell/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-picoxcell/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-realview/include/mach/gpio.h b/arch/arm/mach-realview/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-realview/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
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
