From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 10 Dec 2010 14:58:53 +0900
Subject: [PATCH 02/02][RFC] ARM: shmobile: Use Subarch IRQ handler for INTC
In-Reply-To: <20101210055835.8635.98614.sendpatchset@t400s>
References: <20101210055835.8635.98614.sendpatchset@t400s>
Message-ID: <20101210055853.8635.83051.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Example code that shows how to use arch_irq_handler
together with the handle_irq callback on SH-Mobile ARM.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                    |    3 ++
 arch/arm/mach-shmobile/Makefile                   |   12 ++++++--
 arch/arm/mach-shmobile/board-ap4evb.c             |    1 
 arch/arm/mach-shmobile/board-g3evm.c              |    1 
 arch/arm/mach-shmobile/board-g4evm.c              |    1 
 arch/arm/mach-shmobile/entry-intc.S               |   30 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h      |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   27 ------------------
 arch/arm/mach-shmobile/include/mach/hardware.h    |    3 --
 9 files changed, 46 insertions(+), 33 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-12-09 23:15:46.000000000 +0900
@@ -9,6 +9,7 @@ config ARCH_SH7367
 	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
 
 config ARCH_SH7377
 	bool "SH-Mobile G4 (SH7377)"
@@ -17,6 +18,7 @@ config ARCH_SH7377
 	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
@@ -25,6 +27,7 @@ config ARCH_SH7372
 	select CLKDEV_LOOKUP
 	select SH_CLK_CPG
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
 
 comment "SH-Mobile Board Type"
 
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-09 23:15:46.000000000 +0900
@@ -6,9 +6,15 @@
 obj-y				:= timer.o console.o clock.o pm_runtime.o
 
 # CPU objects
-obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
-obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7377.o intc-sh7377.o
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
+obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o
+obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7377.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o
+
+# IRQ objects
+irq-$(CONFIG_ARCH_SH7367)	+= intc-sh7367.o entry-intc.o
+irq-$(CONFIG_ARCH_SH7377)	+= intc-sh7377.o entry-intc.o
+irq-$(CONFIG_ARCH_SH7372)	+= intc-sh7372.o entry-intc.o
+obj-y				+= $(irq-y)
 
 # Pinmux setup
 pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-12-09 23:15:46.000000000 +0900
@@ -1356,6 +1356,7 @@ static struct sys_timer ap4evb_timer = {
 MACHINE_START(AP4EVB, "ap4evb")
 	.map_io		= ap4evb_map_io,
 	.init_irq	= sh7372_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= ap4evb_init,
 	.timer		= &ap4evb_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-12-09 23:15:46.000000000 +0900
@@ -367,6 +367,7 @@ static struct sys_timer g3evm_timer = {
 MACHINE_START(G3EVM, "g3evm")
 	.map_io		= g3evm_map_io,
 	.init_irq	= sh7367_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g3evm_init,
 	.timer		= &g3evm_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2010-12-09 23:15:46.000000000 +0900
@@ -394,6 +394,7 @@ static struct sys_timer g4evm_timer = {
 MACHINE_START(G4EVM, "g4evm")
 	.map_io		= g4evm_map_io,
 	.init_irq	= sh7377_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g4evm_init,
 	.timer		= &g4evm_timer,
 MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/entry-intc.S	2010-12-09 23:20:52.000000000 +0900
@@ -0,0 +1,30 @@
+/*
+ * ARM Interrupt demux handler using INTC 
+ *
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/entry-macro-multi.S>
+
+#define INTFLGA	0xe6980018
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr     \base, =INTFLGA
+	.endm
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr     \irqnr, [\base]
+	cmp	\irqnr, #0
+	beq	1000f
+	/* intevt to irq number */
+	lsr	\irqnr, \irqnr, #0x5
+	subs	\irqnr, \irqnr, #16
+1000:
+	.endm
+
+	arch_irq_handler shmobile_handle_irq_intc
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-12-09 23:15:46.000000000 +0900
@@ -5,6 +5,7 @@ extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 struct clk;
 extern int clk_init(void);
+extern void shmobile_handle_irq_intc(struct pt_regs *);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-12-09 23:15:46.000000000 +0900
@@ -1,39 +1,12 @@
-/*
- * Copyright (C) 2008 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 
 	.macro  disable_fiq
 	.endm
 
 	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =INTFLGA
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
 
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \irqnr, [\base]
-	cmp	\irqnr, #0
-	beq	1000f
-	/* intevt to irq number */
-	lsr	\irqnr, \irqnr, #0x5
-	subs	\irqnr, \irqnr, #16
-
-1000:
 	.endm
--- 0001/arch/arm/mach-shmobile/include/mach/hardware.h
+++ work/arch/arm/mach-shmobile/include/mach/hardware.h	2010-12-09 23:18:37.000000000 +0900
@@ -1,7 +1,4 @@
 #ifndef __ASM_MACH_HARDWARE_H
 #define __ASM_MACH_HARDWARE_H
 
-/* INTFLGA register - used by low level interrupt code in entry-macro.S */
-#define INTFLGA			0xe6980018
-
 #endif /* __ASM_MACH_HARDWARE_H */
