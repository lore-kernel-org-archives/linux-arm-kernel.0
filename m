From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:42 +0000
Subject: [PATCH v3 08/17] ARM: msm: convert SMP platforms to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SMP msm platforms to be using the gic_handle_irq
function as their primary interrupt handler.

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/Kconfig                         |    2 +
 arch/arm/mach-msm/board-msm8960.c                 |    2 +
 arch/arm/mach-msm/board-msm8x60.c                 |    4 ++
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   17 ---------
 arch/arm/mach-msm/include/mach/entry-macro-vic.S  |   37 ---------------------
 arch/arm/mach-msm/include/mach/entry-macro.S      |   27 +++++++++++++--
 6 files changed, 31 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-qgic.S
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro-vic.S

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index ebde97f..ba36b74 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -50,6 +50,7 @@ config ARCH_MSM8X60
 	select GPIO_MSM_V2
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
+	select MULTI_IRQ_HANDLER
 
 config ARCH_MSM8960
 	bool "MSM8960"
@@ -60,6 +61,7 @@ config ARCH_MSM8960
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
+	select MULTI_IRQ_HANDLER
 
 endchoice
 
diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index c811e29..7af9a6d 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -101,6 +101,7 @@ MACHINE_START(MSM8960_SIM, "QCT MSM8960 SIMULATOR")
 	.map_io = msm8960_map_io,
 	.init_irq = msm8960_init_irq,
 	.timer = &msm_timer,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8960_sim_init,
 MACHINE_END
 
@@ -111,6 +112,7 @@ MACHINE_START(MSM8960_RUMI3, "QCT MSM8960 RUMI3")
 	.map_io = msm8960_map_io,
 	.init_irq = msm8960_init_irq,
 	.timer = &msm_timer,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8960_rumi3_init,
 MACHINE_END
 
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index fdc8a34..bf5b04d 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -111,6 +111,7 @@ MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
 	.timer = &msm_timer,
 MACHINE_END
@@ -121,6 +122,7 @@ MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
 	.timer = &msm_timer,
 MACHINE_END
@@ -131,6 +133,7 @@ MACHINE_START(MSM8X60_SIM, "QCT MSM8X60 SIMULATOR")
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
 	.timer = &msm_timer,
 MACHINE_END
@@ -141,6 +144,7 @@ MACHINE_START(MSM8X60_FFA, "QCT MSM8X60 FFA")
 	.reserve = msm8x60_reserve,
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_init,
 	.timer = &msm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S b/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
deleted file mode 100644
index 717076f..0000000
--- a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Low-level IRQ helper macros
- *
- * Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/hardware/entry-macro-gic.S>
-
-	.macro	disable_fiq
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
diff --git a/arch/arm/mach-msm/include/mach/entry-macro-vic.S b/arch/arm/mach-msm/include/mach/entry-macro-vic.S
deleted file mode 100644
index 70563ed..0000000
--- a/arch/arm/mach-msm/include/mach/entry-macro-vic.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2007 Google, Inc.
- * Author: Brian Swetland <swetland@google.com>
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
-#include <mach/msm_iomap.h>
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	@ enable imprecise aborts
-	cpsie	a
-	mov	\base, #MSM_VIC_BASE
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	@ 0xD0 has irq# or old irq# if the irq has been handled
-	@ 0xD4 has irq# or -1 if none pending *but* if you just
-	@ read 0xD4 you never get the first irq for some reason
-	ldr	\irqnr, [\base, #0xD0]
-	ldr	\irqnr, [\base, #0xD4]
-	cmp	\irqnr, #0xffffffff
-	.endm
diff --git a/arch/arm/mach-msm/include/mach/entry-macro.S b/arch/arm/mach-msm/include/mach/entry-macro.S
index b16f082..41f7003 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro.S
@@ -16,8 +16,27 @@
  *
  */
 
-#if defined(CONFIG_ARM_GIC)
-#include <mach/entry-macro-qgic.S>
-#else
-#include <mach/entry-macro-vic.S>
+	.macro	disable_fiq
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+#if !defined(CONFIG_ARM_GIC)
+#include <mach/msm_iomap.h>
+
+	.macro	get_irqnr_preamble, base, tmp
+	@ enable imprecise aborts
+	cpsie	a
+	mov	\base, #MSM_VIC_BASE
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+	@ 0xD0 has irq# or old irq# if the irq has been handled
+	@ 0xD4 has irq# or -1 if none pending *but* if you just
+	@ read 0xD4 you never get the first irq for some reason
+	ldr	\irqnr, [\base, #0xD0]
+	ldr	\irqnr, [\base, #0xD4]
+	cmp	\irqnr, #0xffffffff
+	.endm
 #endif
-- 
1.7.0.4
