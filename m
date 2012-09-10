From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 10 Sep 2012 20:07:11 +0100
Subject: [PATCH v3 00/12] Initial multi-platform support
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120910190711.GA11366@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Sep 06, 2012 at 03:12:43PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series enables initial ARM multi-platform support for highbank, mvebu,
> socfpga, picoxcell, and vexpress. Multi-platform support is dependent on
> some DEBUG_LL and dtb build rules restructuring. This series is also
> dependent on my gpio clean-up series posted here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118138.html
> 
> New in this version:
> - Moved ARCH_MULTIPLATFORM back into choice so converted platforms'
>   defconfigs work before and after conversion.
> - Added mvebu, socfpga and picoxcell DEBUG_LL support. DEBUG_LL should
>   work for all converted platforms.
> - Fixed make dtbs.
> - Removed all unused headers (timex.h, uncompress.h) and Makefile.boot
> - Add ARCH_MULTIPLATFORM depends for XIP found with randconfig builds
> - Split out Vexpress to separate patch as now DT board support is always
>   enabled.
> 
> This series plus gpio clean-up is available here:
> git://sources.calxeda.com/kernel/linux.git multi-plat

This all looks great, thanks for your hard work!  I needed a small fixup 
patch (below), feel free to fold it into your patches or whatever you 
think is best.

Acked-by: Jamie Iles <jamie@jamieiles.com>

8<---

Subject: [PATCH] ARM: picoxcell: fixup multiplatform breakage.

The debug macros had a dependency on mach headers.  Break that
dependency and restore building.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/include/debug/picoxcell.S      |    4 ++--
 arch/arm/mach-picoxcell/common.c        |   11 ++++++-----
 arch/arm/mach-picoxcell/picoxcell_soc.h |   25 -------------------------
 3 files changed, 8 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/picoxcell_soc.h

diff --git a/arch/arm/include/debug/picoxcell.S b/arch/arm/include/debug/picoxcell.S
index 58d4ee3..7419deb 100644
--- a/arch/arm/include/debug/picoxcell.S
+++ b/arch/arm/include/debug/picoxcell.S
@@ -9,10 +9,10 @@
  * accesses to the 8250.
  */
 #include <linux/serial_reg.h>
-#include <mach/hardware.h>
-#include <mach/map.h>
 
 #define UART_SHIFT 2
+#define PICOXCELL_UART1_BASE		0x80230000
+#define PHYS_TO_IO(x)			(((x) & 0x00ffffff) | 0xfe000000)
 
 		.macro	addruart, rp, rv, tmp
 		ldr	\rv, =PHYS_TO_IO(PICOXCELL_UART1_BASE)
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index a8b70b5..f6c0849 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -20,14 +20,15 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
 
-#include "picoxcell_soc.h"
 #include "common.h"
 
-#define PHYS_TO_IO(x)		(((x) & 0x00ffffff) | 0xfe000000)
+#define PHYS_TO_IO(x)			(((x) & 0x00ffffff) | 0xfe000000)
+#define PICOXCELL_PERIPH_BASE		0x80000000
+#define PICOXCELL_PERIPH_LENGTH		SZ_4M
 
-#define WDT_CTRL_REG_EN_MASK	(1 << 0)
-#define WDT_CTRL_REG_OFFS	(0x00)
-#define WDT_TIMEOUT_REG_OFFS	(0x04)
+#define WDT_CTRL_REG_EN_MASK		(1 << 0)
+#define WDT_CTRL_REG_OFFS		(0x00)
+#define WDT_TIMEOUT_REG_OFFS		(0x04)
 static void __iomem *wdt_regs;
 
 /*
diff --git a/arch/arm/mach-picoxcell/picoxcell_soc.h b/arch/arm/mach-picoxcell/picoxcell_soc.h
deleted file mode 100644
index 5566fc8..0000000
--- a/arch/arm/mach-picoxcell/picoxcell_soc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This file contains the hardware definitions of the picoXcell SoC devices.
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
-#ifndef __PICOXCELL_SOC_H__
-#define __PICOXCELL_SOC_H__
-
-#define PICOXCELL_UART1_BASE		0x80230000
-#define PICOXCELL_PERIPH_BASE		0x80000000
-#define PICOXCELL_PERIPH_LENGTH		SZ_4M
-#define PICOXCELL_VIC0_BASE		0x80060000
-#define PICOXCELL_VIC1_BASE		0x80064000
-
-#endif /* __PICOXCELL_SOC_H__ */
-- 
1.7.9.5
