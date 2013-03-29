From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 17:00:59 +0800
Subject: [PATCH 3/3] ARM: mxs: enable multiplatform build
In-Reply-To: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
References: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547659-30574-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove files that are not needed by multiplatform build, and make
necessary changes on Kconfig to enable multiplatform build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                            |   17 ------
 arch/arm/configs/mxs_defconfig              |    2 +-
 arch/arm/mach-mxs/Kconfig                   |   22 ++++----
 arch/arm/mach-mxs/Makefile                  |    2 +-
 arch/arm/mach-mxs/Makefile.boot             |    1 -
 arch/arm/mach-mxs/include/mach/timex.h      |   21 --------
 arch/arm/mach-mxs/include/mach/uncompress.h |   76 ---------------------------
 7 files changed, 14 insertions(+), 127 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/Makefile.boot
 delete mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6f61286..92175ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -469,23 +469,6 @@ config ARCH_FOOTBRIDGE
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-config ARCH_MXS
-	bool "Freescale MXS-based"
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK_PREPARE
-	select MULTI_IRQ_HANDLER
-	select PINCTRL
-	select SPARSE_IRQ
-	select STMP_DEVICE
-	select USE_OF
-	help
-	  Support for Freescale MXS-based family of processors
-
 config ARCH_NETX
 	bool "Hilscher NetX based"
 	select ARM_VIC
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 6a99e30..023c4e1 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -22,8 +22,8 @@ CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXS=y
-CONFIG_MACH_MXS_DT=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index ecc4319..02e6935 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -1,5 +1,3 @@
-if ARCH_MXS
-
 config SOC_IMX23
 	bool
 	select ARM_AMBA
@@ -15,14 +13,18 @@ config SOC_IMX28
 	select HAVE_PWM
 	select PINCTRL_IMX28
 
-comment "MXS platforms:"
-
-config MACH_MXS_DT
-	bool "Support MXS platforms from device tree"
+config ARCH_MXS
+	bool "Freescale MXS (i.MX23, i.MX28) support"
+	depends on ARCH_MULTI_V5
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK_PREPARE
+	select PINCTRL
 	select SOC_IMX23
 	select SOC_IMX28
+	select STMP_DEVICE
 	help
-	  Include support for Freescale MXS platforms(i.MX23 and i.MX28)
-	  using the device tree for discovery
-
-endif
+	  Support for Freescale MXS-based family of processors
diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 80db726..cc2bf67 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_PM) += pm.o
-obj-$(CONFIG_MACH_MXS_DT) += mach-mxs.o
+obj-$(CONFIG_ARCH_MXS) += mach-mxs.o
diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
deleted file mode 100644
index 07b11fe..0000000
--- a/arch/arm/mach-mxs/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y += 0x40008000
diff --git a/arch/arm/mach-mxs/include/mach/timex.h b/arch/arm/mach-mxs/include/mach/timex.h
deleted file mode 100644
index 734ce89..0000000
--- a/arch/arm/mach-mxs/include/mach/timex.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  Copyright (C) 1999 ARM Limited
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
- */
-
-#ifndef __MACH_MXS_TIMEX_H__
-#define __MACH_MXS_TIMEX_H__
-
-#define CLOCK_TICK_RATE		32000	/* 32K */
-
-#endif /* __MACH_MXS_TIMEX_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
deleted file mode 100644
index 533f518..0000000
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- *  arch/arm/mach-mxs/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) Shane Nay (shane at minirl.com)
- *  Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
- */
-#ifndef __MACH_MXS_UNCOMPRESS_H__
-#define __MACH_MXS_UNCOMPRESS_H__
-
-unsigned long mxs_duart_base;
-
-#define MXS_DUART(x)	(*(volatile unsigned long *)(mxs_duart_base + (x)))
-
-#define MXS_DUART_DR		0x00
-#define MXS_DUART_FR		0x18
-#define MXS_DUART_FR_TXFE	(1 << 7)
-#define MXS_DUART_CR		0x30
-#define MXS_DUART_CR_UARTEN	(1 << 0)
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader. If it's not, the output is
- * simply discarded.
- */
-
-static void putc(int ch)
-{
-	if (!mxs_duart_base)
-		return;
-	if (!(MXS_DUART(MXS_DUART_CR) & MXS_DUART_CR_UARTEN))
-		return;
-
-	while (!(MXS_DUART(MXS_DUART_FR) & MXS_DUART_FR_TXFE))
-		barrier();
-
-	MXS_DUART(MXS_DUART_DR) = ch;
-}
-
-static inline void flush(void)
-{
-}
-
-#define MX23_DUART_BASE_ADDR	0x80070000
-#define MX28_DUART_BASE_ADDR	0x80074000
-#define MXS_DIGCTL_CHIPID	0x8001c310
-
-static inline void __arch_decomp_setup(unsigned long arch_id)
-{
-	u16 chipid = (*(volatile unsigned long *) MXS_DIGCTL_CHIPID) >> 16;
-
-	switch (chipid) {
-	case 0x3780:
-		mxs_duart_base = MX23_DUART_BASE_ADDR;
-		break;
-	case 0x2800:
-		mxs_duart_base = MX28_DUART_BASE_ADDR;
-		break;
-	default:
-		break;
-	}
-}
-
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
-#endif /* __MACH_MXS_UNCOMPRESS_H__ */
-- 
1.7.9.5
