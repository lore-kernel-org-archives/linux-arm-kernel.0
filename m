From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 30 May 2011 10:04:16 +0900
Subject: [PATCH] Consolidate the clkdev header files
Message-ID: <20110530010416.GA24365@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Now most of ARM machines has the alsmot same __clk_get/put() macro

So place it at the arch/arm/include/asm/clkdev.h and remove the reduntant header files

But some machines don't have the same form as above. It can use the machince specific clkdev file by HAVE_MACH_CLKDEV config

Now there are only 3 caese.

1) define the clk structure with clkdev macro => Need to move clk structure to proper header file

arch/arm/mach-versatile/include/mach/clkdev.h
arch/arm/mach-realview/include/mach/clkdev.h
arch/arm/mach-vexpress/include/mach/clkdev.h
arch/arm/mach-integrator/include/mach/clkdev.h

2) export the __clk_get/put function at clock.c

arch/arm/mach-shmobile/include/mach/clkdev.h

3) demuxing the clk source
arch/arm/mach-u300/include/mach/clkdev.h

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                             |    6 ++++
 arch/arm/include/asm/clkdev.h                |    5 ++++
 arch/arm/mach-at91/include/mach/clkdev.h     |    7 -----
 arch/arm/mach-bcmring/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-davinci/include/mach/clkdev.h  |   15 -----------
 arch/arm/mach-ep93xx/include/mach/clkdev.h   |   11 --------
 arch/arm/mach-lpc32xx/include/mach/clkdev.h  |   25 -------------------
 arch/arm/mach-mmp/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-msm/include/mach/clkdev.h      |   19 --------------
 arch/arm/mach-mxs/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-nomadik/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-nuc93x/include/mach/clkdev.h   |    7 -----
 arch/arm/mach-omap1/include/mach/clkdev.h    |    5 ----
 arch/arm/mach-omap2/include/mach/clkdev.h    |    5 ----
 arch/arm/mach-pnx4008/include/mach/clkdev.h  |    7 -----
 arch/arm/mach-pxa/include/mach/clkdev.h      |    7 -----
 arch/arm/mach-spear3xx/include/mach/clkdev.h |   19 --------------
 arch/arm/mach-spear6xx/include/mach/clkdev.h |   19 --------------
 arch/arm/mach-tegra/include/mach/clkdev.h    |   34 --------------------------
 arch/arm/mach-ux500/include/mach/clkdev.h    |    7 -----
 arch/arm/mach-w90x900/include/mach/clkdev.h  |    7 -----
 arch/arm/plat-mxc/include/mach/clkdev.h      |    7 -----
 arch/arm/plat-omap/include/plat/clkdev.h     |   13 ----------
 arch/arm/plat-spear/include/plat/clkdev.h    |   20 ---------------
 arch/arm/plat-tcc/include/mach/clkdev.h      |    7 -----
 drivers/clk/Kconfig                          |    3 ++
 26 files changed, 14 insertions(+), 269 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-msm/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-nuc93x/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-omap/include/plat/clkdev.h
 delete mode 100644 arch/arm/plat-spear/include/plat/clkdev.h
 delete mode 100644 arch/arm/plat-tcc/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..2aa4563 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -239,6 +239,7 @@ config ARCH_INTEGRATOR
 	select ARM_AMBA
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
@@ -250,6 +251,7 @@ config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARM_AMBA
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -265,6 +267,7 @@ config ARCH_VERSATILE
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -281,6 +284,7 @@ config ARCH_VEXPRESS
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	select HAVE_PATA_PLATFORM
@@ -638,6 +642,7 @@ config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile / R-Mobile"
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select NO_IOPORT
 	select SPARSE_IRQ
@@ -808,6 +813,7 @@ config ARCH_U300
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
 	select GENERIC_GPIO
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index 765d332..80751c1 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -14,7 +14,12 @@
 
 #include <linux/slab.h>
 
+#ifdef CONFIG_HAVE_MACH_CLKDEV
 #include <mach/clkdev.h>
+#else
+#define __clk_get(clk)	({ 1; })
+#define __clk_put(clk)	do { } while (0)
+#endif
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/arch/arm/mach-at91/include/mach/clkdev.h b/arch/arm/mach-at91/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-at91/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-bcmring/include/mach/clkdev.h b/arch/arm/mach-bcmring/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-bcmring/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-davinci/include/mach/clkdev.h b/arch/arm/mach-davinci/include/mach/clkdev.h
deleted file mode 100644
index 14a5048..0000000
--- a/arch/arm/mach-davinci/include/mach/clkdev.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-struct clk;
-
-static inline int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-
-static inline void __clk_put(struct clk *clk)
-{
-}
-
-#endif
diff --git a/arch/arm/mach-ep93xx/include/mach/clkdev.h b/arch/arm/mach-ep93xx/include/mach/clkdev.h
deleted file mode 100644
index 50cb991..0000000
--- a/arch/arm/mach-ep93xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/clkdev.h
- */
-
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/clkdev.h b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
deleted file mode 100644
index 9bf0637..0000000
--- a/arch/arm/mach-lpc32xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/clkdev.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
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
-#ifndef __ASM_ARCH_CLKDEV_H
-#define __ASM_ARCH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-mmp/include/mach/clkdev.h b/arch/arm/mach-mmp/include/mach/clkdev.h
deleted file mode 100644
index 2fb354e..0000000
--- a/arch/arm/mach-mmp/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif /* __ASM_MACH_CLKDEV_H */
diff --git a/arch/arm/mach-msm/include/mach/clkdev.h b/arch/arm/mach-msm/include/mach/clkdev.h
deleted file mode 100644
index f87a57b..0000000
--- a/arch/arm/mach-msm/include/mach/clkdev.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* Copyright (c) 2011, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __ASM_ARCH_MSM_CLKDEV_H
-#define __ASM_ARCH_MSM_CLKDEV_H
-
-struct clk;
-
-static inline int __clk_get(struct clk *clk) { return 1; }
-static inline void __clk_put(struct clk *clk) { }
-#endif
diff --git a/arch/arm/mach-mxs/include/mach/clkdev.h b/arch/arm/mach-mxs/include/mach/clkdev.h
deleted file mode 100644
index 3a8f2e3..0000000
--- a/arch/arm/mach-mxs/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_MXS_CLKDEV_H__
-#define __MACH_MXS_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-nomadik/include/mach/clkdev.h b/arch/arm/mach-nomadik/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-nomadik/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-nuc93x/include/mach/clkdev.h b/arch/arm/mach-nuc93x/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-nuc93x/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-omap1/include/mach/clkdev.h b/arch/arm/mach-omap1/include/mach/clkdev.h
deleted file mode 100644
index ea8640e..0000000
--- a/arch/arm/mach-omap1/include/mach/clkdev.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/clkdev.h
- */
-
-#include <plat/clkdev.h>
diff --git a/arch/arm/mach-omap2/include/mach/clkdev.h b/arch/arm/mach-omap2/include/mach/clkdev.h
deleted file mode 100644
index 53b0274..0000000
--- a/arch/arm/mach-omap2/include/mach/clkdev.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/clkdev.h
- */
-
-#include <plat/clkdev.h>
diff --git a/arch/arm/mach-pnx4008/include/mach/clkdev.h b/arch/arm/mach-pnx4008/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-pnx4008/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/clkdev.h b/arch/arm/mach-pxa/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-pxa/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-spear3xx/include/mach/clkdev.h b/arch/arm/mach-spear3xx/include/mach/clkdev.h
deleted file mode 100644
index a3d0733..0000000
--- a/arch/arm/mach-spear3xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/clkdev.h
- *
- * Clock Dev framework definitions for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-#include <plat/clkdev.h>
-
-#endif /* __MACH_CLKDEV_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/clkdev.h b/arch/arm/mach-spear6xx/include/mach/clkdev.h
deleted file mode 100644
index 05676bf..0000000
--- a/arch/arm/mach-spear6xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/clkdev.h
- *
- * Clock Dev framework definitions for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-#include <plat/clkdev.h>
-
-#endif /* __MACH_CLKDEV_H */
diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
deleted file mode 100644
index 66cd3f4..0000000
--- a/arch/arm/mach-tegra/include/mach/clkdev.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/clkdev.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-struct clk;
-
-static inline int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-
-static inline void __clk_put(struct clk *clk)
-{
-}
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/clkdev.h b/arch/arm/mach-ux500/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-ux500/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/mach-w90x900/include/mach/clkdev.h b/arch/arm/mach-w90x900/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/mach-w90x900/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/clkdev.h b/arch/arm/plat-mxc/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/plat-mxc/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/arch/arm/plat-omap/include/plat/clkdev.h b/arch/arm/plat-omap/include/plat/clkdev.h
deleted file mode 100644
index 730c49d..0000000
--- a/arch/arm/plat-omap/include/plat/clkdev.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __MACH_CLKDEV_H
-#define __MACH_CLKDEV_H
-
-static inline int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-
-static inline void __clk_put(struct clk *clk)
-{
-}
-
-#endif
diff --git a/arch/arm/plat-spear/include/plat/clkdev.h b/arch/arm/plat-spear/include/plat/clkdev.h
deleted file mode 100644
index a2d0112..0000000
--- a/arch/arm/plat-spear/include/plat/clkdev.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/clkdev.h
- *
- * Clock Dev framework definitions for SPEAr platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_CLKDEV_H
-#define __PLAT_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif /* __PLAT_CLKDEV_H */
diff --git a/arch/arm/plat-tcc/include/mach/clkdev.h b/arch/arm/plat-tcc/include/mach/clkdev.h
deleted file mode 100644
index 04b37a8..0000000
--- a/arch/arm/plat-tcc/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_CLKDEV_H
-#define __ASM_MACH_CLKDEV_H
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4168c88..3530927 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -2,3 +2,6 @@
 config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
+
+config HAVE_MACH_CLKDEV
+	bool
-- 
1.7.5.1.300.gc565c
