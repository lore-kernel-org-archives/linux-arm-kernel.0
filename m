From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:49:49 +0000
Subject: [PATCH 29/41] ARM: restart: realview: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6qr-0001YZ-Bf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.h                |    1 -
 arch/arm/mach-realview/include/mach/system.h |   13 -------------
 arch/arm/mach-realview/realview_eb.c         |    5 +++--
 arch/arm/mach-realview/realview_pb1176.c     |    5 +++--
 arch/arm/mach-realview/realview_pb11mp.c     |    5 +++--
 arch/arm/mach-realview/realview_pba8.c       |    5 +++--
 arch/arm/mach-realview/realview_pbx.c        |    5 +++--
 7 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 47259c8..735b57a 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -65,6 +65,5 @@ extern int realview_usb_register(struct resource *res);
 extern void realview_init_early(void);
 extern void realview_fixup(struct tag *tags, char **from,
 			   struct meminfo *meminfo);
-extern void (*realview_reset)(char);
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
index 6657ff23..1630766 100644
--- a/arch/arm/mach-realview/include/mach/system.h
+++ b/arch/arm/mach-realview/include/mach/system.h
@@ -21,12 +21,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-void (*realview_reset)(char mode);
-
 static inline void arch_idle(void)
 {
 	/*
@@ -38,13 +32,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * To reset, we hit the on-board reset register
-	 * in the system FPGA
-	 */
-	if (realview_reset)
-		realview_reset(mode);
-	dsb();
 }
 
 #endif
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 026c66a..4b79624 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -415,7 +415,7 @@ static struct sys_timer realview_eb_timer = {
 	.init		= realview_eb_timer_init,
 };
 
-static void realview_eb_reset(char mode)
+static void realview_eb_restart(char mode, const char *cmd)
 {
 	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
 	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
@@ -427,6 +427,7 @@ static void realview_eb_reset(char mode)
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
 	if (core_tile_eb11mp())
 		__raw_writel(0x0008, reset_ctrl);
+	dsb();
 }
 
 static void __init realview_eb_init(void)
@@ -458,7 +459,6 @@ static void __init realview_eb_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
-	realview_reset = realview_eb_reset;
 }
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
@@ -473,4 +473,5 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
 #endif
+	.restart	= realview_eb_restart,
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index c057540..09e630b 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -336,12 +336,13 @@ static struct sys_timer realview_pb1176_timer = {
 	.init		= realview_pb1176_timer_init,
 };
 
-static void realview_pb1176_reset(char mode)
+static void realview_pb1176_restart(char mode, const char *cmd)
 {
 	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
 	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
 	__raw_writel(REALVIEW_PB1176_SYS_SOFT_RESET, reset_ctrl);
+	dsb();
 }
 
 static void realview_pb1176_fixup(struct tag *tags, char **from,
@@ -381,7 +382,6 @@ static void __init realview_pb1176_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
-	realview_reset = realview_pb1176_reset;
 }
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
@@ -396,4 +396,5 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
 #endif
+	.restart	= realview_pb1176_restart,
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 671ad6d..e38e85b 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -315,7 +315,7 @@ static struct sys_timer realview_pb11mp_timer = {
 	.init		= realview_pb11mp_timer_init,
 };
 
-static void realview_pb11mp_reset(char mode)
+static void realview_pb11mp_restart(char mode, const char *cmd)
 {
 	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
 	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
@@ -327,6 +327,7 @@ static void realview_pb11mp_reset(char mode)
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
 	__raw_writel(0x0000, reset_ctrl);
 	__raw_writel(0x0004, reset_ctrl);
+	dsb();
 }
 
 static void __init realview_pb11mp_init(void)
@@ -355,7 +356,6 @@ static void __init realview_pb11mp_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
-	realview_reset = realview_pb11mp_reset;
 }
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
@@ -370,4 +370,5 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
 #endif
+	.restart	= realview_pb11mp_restart,
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index cbf22df..04d1e49 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -271,7 +271,7 @@ static struct sys_timer realview_pba8_timer = {
 	.init		= realview_pba8_timer_init,
 };
 
-static void realview_pba8_reset(char mode)
+static void realview_pba8_restart(char mode, const char *cmd)
 {
 	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
 	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
@@ -283,6 +283,7 @@ static void realview_pba8_reset(char mode)
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
 	__raw_writel(0x0000, reset_ctrl);
 	__raw_writel(0x0004, reset_ctrl);
+	dsb();
 }
 
 static void __init realview_pba8_init(void)
@@ -305,7 +306,6 @@ static void __init realview_pba8_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
-	realview_reset = realview_pba8_reset;
 }
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
@@ -320,4 +320,5 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
 #endif
+	.restart	= realview_pba8_restart,
 MACHINE_END
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 63c4114..d515452 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -339,7 +339,7 @@ static void realview_pbx_fixup(struct tag *tags, char **from,
 #endif
 }
 
-static void realview_pbx_reset(char mode)
+static void realview_pbx_restart(char mode, const char *cmd)
 {
 	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
 	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
@@ -351,6 +351,7 @@ static void realview_pbx_reset(char mode)
 	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
 	__raw_writel(0x00F0, reset_ctrl);
 	__raw_writel(0x00F4, reset_ctrl);
+	dsb();
 }
 
 static void __init realview_pbx_init(void)
@@ -388,7 +389,6 @@ static void __init realview_pbx_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
-	realview_reset = realview_pbx_reset;
 }
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
@@ -403,4 +403,5 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
 #endif
+	.restart	= realview_pbx_restart,
 MACHINE_END
-- 
1.7.4.4
