From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 13:43:03 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4wi3My=7M2sTwDNTAPxr+JFFAMrDDfBMy08ztjD3soWrQ@mail.gmail.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107062231.51117.arnd@arndb.de>
	<CAGsJ_4wi3My=7M2sTwDNTAPxr+JFFAMrDDfBMy08ztjD3soWrQ@mail.gmail.com>
Message-ID: <201107071343.03591.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011, Barry Song wrote:
> > FWIW, I've double-checked the Xilinx zynq platform that I've already queued
> > up for 3.1: this one defines IO_SPACE_LIMIT to 0xffff because PCI support
> > will get merged later, so that's fine.
> 
> as far as i know, zynq still has some static mapping tables and board
> file board_dt.c. as you have reviewed csr platform very carefully, i
> guess those can get fixed in zynq later too :-)
> xilinx zynq and csr prima2 should be the pioneering two new SoCs to
> move to DT in arm for the moment. at least, these two things can try
> to get same.

Good point. I'm not planning to change the initial xilinx code, since
it's already in the tree, but I'd like to apply the patch below
to make it do the same as prima2 in this regard.
John, can you ack this patch?

For the iotable, it would also be good to remove that from zynq,
but it's harder to do for me when I can't test it. I'll try to split
out the serial setup, and I'd hope that John can do the others
along the lines of what you have done in sirfprima2.

8<----
Subject: [PATCH] ARM: Xilinx: merge board file into main platform code

The zynq platform will never have board files other than the
device tree one, so there is no point splitting it from common.c.

This makes the code more compact.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-zynq/board_dt.c |   37 -------------------------------------
 arch/arm/mach-zynq/common.c   |   22 +++++++++++++++++++---
 arch/arm/mach-zynq/common.h   |    5 -----
 3 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-zynq/board_dt.c b/arch/arm/mach-zynq/board_dt.c
index 5b4710d..e69de29 100644
--- a/arch/arm/mach-zynq/board_dt.c
+++ b/arch/arm/mach-zynq/board_dt.c
@@ -1,37 +0,0 @@
-/*
- * This file contains code for boards with device tree support.
- *
- *  Copyright (C) 2011 Xilinx
- *
- * based on arch/arm/mach-realview/core.c
- *
- *  Copyright (C) 1999 - 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/of.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include "common.h"
-
-static const char *xilinx_dt_match[] = {
-	"xlnx,zynq-ep107",
-	NULL
-};
-
-MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
-	.map_io		= xilinx_map_io,
-	.init_irq	= xilinx_irq_init,
-	.init_machine	= xilinx_init_machine,
-	.timer		= &xttcpss_sys_timer,
-	.dt_compat	= xilinx_dt_match,
-MACHINE_END
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index b3ac5c2..73e9368 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -21,8 +21,11 @@
 #include <linux/clk.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of.h>
 
+#include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -40,7 +43,7 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
  * xilinx_init_machine() - System specific initialization, intended to be
  *			   called from board specific initialization.
  */
-void __init xilinx_init_machine(void)
+static void __init xilinx_init_machine(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/*
@@ -55,7 +58,7 @@ void __init xilinx_init_machine(void)
 /**
  * xilinx_irq_init() - Interrupt controller initialization for the GIC.
  */
-void __init xilinx_irq_init(void)
+static void __init xilinx_irq_init(void)
 {
 	gic_init(0, 29, SCU_GIC_DIST_BASE, SCU_GIC_CPU_BASE);
 }
@@ -96,7 +99,20 @@ static struct map_desc io_desc[] __initdata = {
 /**
  * xilinx_map_io() - Create memory mappings needed for early I/O.
  */
-void __init xilinx_map_io(void)
+static void __init xilinx_map_io(void)
 {
 	iotable_init(io_desc, ARRAY_SIZE(io_desc));
 }
+
+static const char *xilinx_dt_match[] = {
+	"xlnx,zynq-ep107",
+	NULL
+};
+
+MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
+	.map_io		= xilinx_map_io,
+	.init_irq	= xilinx_irq_init,
+	.init_machine	= xilinx_init_machine,
+	.timer		= &xttcpss_sys_timer,
+	.dt_compat	= xilinx_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index bca2196..a009644 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -17,13 +17,8 @@
 #ifndef __MACH_ZYNQ_COMMON_H__
 #define __MACH_ZYNQ_COMMON_H__
 
-#include <linux/init.h>
 #include <asm/mach/time.h>
 
-extern void xilinx_init_machine(void);
-extern void xilinx_irq_init(void);
-extern void xilinx_map_io(void);
-
 extern struct sys_timer xttcpss_sys_timer;
 
 #endif
-- 
1.7.4.1
