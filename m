From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 22 Oct 2012 16:13:07 -0500
Subject: [PATCH v2 4/4] zynq: remove use of CLKDEV_LOOKUP
In-Reply-To: <20121022211040.GA31538@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121022211307.GE31538@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Zynq support in mainline does not (yet) make use of any of the
generic clk or clk lookup functionality.  Remove what is upstream for
now, until the out-of-tree implementation is in suitable form for
merging.

An important side effect of this patch is that it allows the building of
a Zynq kernel without running into unresolved symbol problems:

   drivers/built-in.o: In function `amba_get_enable_pclk':
   clkdev.c:(.text+0x444): undefined reference to `clk_enable'
   drivers/built-in.o: In function `amba_remove':
   clkdev.c:(.text+0x488): undefined reference to `clk_disable'
   drivers/built-in.o: In function `amba_probe':
   clkdev.c:(.text+0x540): undefined reference to `clk_disable'
   drivers/built-in.o: In function `amba_device_add':
   clkdev.c:(.text+0x77c): undefined reference to `clk_disable'
   drivers/built-in.o: In function `enable_clock':
   clkdev.c:(.text+0x29738): undefined reference to `clk_enable'
   drivers/built-in.o: In function `disable_clock':
   clkdev.c:(.text+0x29778): undefined reference to `clk_disable'
   drivers/built-in.o: In function `__pm_clk_remove':
   clkdev.c:(.text+0x297f8): undefined reference to `clk_disable'
   drivers/built-in.o: In function `pm_clk_suspend':
   clkdev.c:(.text+0x29bc8): undefined reference to `clk_disable'
   drivers/built-in.o: In function `pm_clk_resume':
   clkdev.c:(.text+0x29c28): undefined reference to `clk_enable'
   make[2]: *** [vmlinux] Error 1
   make[1]: *** [sub-make] Error 2
   make: *** [all] Error 2

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/Kconfig                         |  1 -
 arch/arm/mach-zynq/common.c              |  1 -
 arch/arm/mach-zynq/include/mach/clkdev.h | 32 --------------------------------
 3 files changed, 34 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cce4f8d..de70d99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -946,7 +946,6 @@ config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
 	select ARM_AMBA
 	select ARM_GIC
-	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select ICST
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index e4e422b..e10268c 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -31,7 +31,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/zynq_soc.h>
-#include <mach/clkdev.h>
 #include "common.h"
 
 static struct of_device_id zynq_of_bus_ids[] __initdata = {
diff --git a/arch/arm/mach-zynq/include/mach/clkdev.h b/arch/arm/mach-zynq/include/mach/clkdev.h
deleted file mode 100644
index c6e73d8..0000000
--- a/arch/arm/mach-zynq/include/mach/clkdev.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/mach-zynq/include/mach/clkdev.h
- *
- *  Copyright (C) 2011 Xilinx, Inc.
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
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#include <plat/clock.h>
-
-struct clk {
-	unsigned long		rate;
-	const struct clk_ops	*ops;
-	const struct icst_params *params;
-	void __iomem		*vcoreg;
-};
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do { } while (0)
-
-#endif
-- 
1.8.0
