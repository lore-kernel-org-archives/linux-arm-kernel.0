From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:20 +0100
Subject: [RFC PATCH 02/14] ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the RealView platforms to be using the gic_handle_irq
function as their primary interrupt handler.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                  |    1 +
 arch/arm/mach-realview/include/mach/entry-macro.S |    2 --
 arch/arm/mach-realview/realview_eb.c              |    1 +
 arch/arm/mach-realview/realview_pb1176.c          |    1 +
 arch/arm/mach-realview/realview_pb11mp.c          |    1 +
 arch/arm/mach-realview/realview_pba8.c            |    1 +
 arch/arm/mach-realview/realview_pbx.c             |    1 +
 7 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 472a7f8..6c31cc2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -262,6 +262,7 @@ config ARCH_REALVIEW
 	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
+	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for ARM Ltd RealView boards.
 
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
index 4071164..e8a5179 100644
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ b/arch/arm/mach-realview/include/mach/entry-macro.S
@@ -7,8 +7,6 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 427e44e..f01e332 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -470,6 +470,7 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_eb_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_eb_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 863f286..539cde3 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -365,6 +365,7 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb1176_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pb1176_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 6cb8318..32d18e5 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -367,6 +367,7 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pb11mp_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pb11mp_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 3db72c5..0896cc4 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -317,6 +317,7 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pba8_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pba8_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 7e5d540..eaedeaa 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -400,6 +400,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.init_early	= realview_init_early,
 	.init_irq	= gic_init_irq,
 	.timer		= &realview_pbx_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= realview_pbx_init,
 #ifdef CONFIG_ZONE_DMA
 	.dma_zone_size	= SZ_256M,
-- 
1.7.0.4
