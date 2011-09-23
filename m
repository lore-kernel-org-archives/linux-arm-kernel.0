From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2011 17:51:27 +0100
Subject: [RFC PATCH 09/14] ARM: shmobile: convert smp platforms to
	gic_handle_irq()
In-Reply-To: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1316796692-15964-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SMP shmobile platforms to use gic_handle_irq() instead
of the assembly macro.

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile              |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c        |    2 +-
 arch/arm/mach-shmobile/entry-gic.S           |   18 ------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 4 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/entry-gic.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 612b270..f58ef1e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -28,7 +28,6 @@ pfc-$(CONFIG_ARCH_SH73A0)	+= pfc-sh73a0.o
 obj-$(CONFIG_ARCH_SH7367)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
-obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 475342b..145473e 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -602,7 +602,7 @@ struct sys_timer ag5evm_timer = {
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= ag5evm_map_io,
 	.init_irq	= ag5evm_init_irq,
-	.handle_irq	= shmobile_handle_irq_gic,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= ag5evm_init,
 	.timer		= &ag5evm_timer,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/entry-gic.S b/arch/arm/mach-shmobile/entry-gic.S
deleted file mode 100644
index e20239b..0000000
--- a/arch/arm/mach-shmobile/entry-gic.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * ARM Interrupt demux handler using GIC
- *
- * Copyright (C) 2010 Magnus Damm
- * Copyright (C) 2011 Paul Mundt
- * Copyright (C) 2010 - 2011 Renesas Solutions Corp.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <asm/assembler.h>
-#include <asm/entry-macro-multi.S>
-#include <asm/hardware/gic.h>
-#include <asm/hardware/entry-macro-gic.S>
-
-	arch_irq_handler shmobile_handle_irq_gic
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 06aecb3..29d3876 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -7,7 +7,6 @@ extern void shmobile_secondary_vector(void);
 struct clk;
 extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
-extern void shmobile_handle_irq_gic(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 struct cpuidle_device;
 extern void (*shmobile_cpuidle_modes[])(void);
-- 
1.7.0.4
