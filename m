From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:18:37 +0900
Subject: [PATCH 08/08] ARM: Dynamic IRQ demux for SH-Mobile
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071837.28048.58439.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This patch adds Dynamic IRQ demux support to the
SH-Mobile line of processors. The actual demux code
is implemented in entry-irq-common.S and each INTC
implementation is responsible for registering the
shared demux code using setup_irq_stubs().

Future processors will add a new a IRQ demux instance
and register that from the INTC implementation for
that particular processor.

Tested on sh7372 and AP4EVB.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Kconfig                                  |    1 
 arch/arm/mach-shmobile/Makefile                   |    1 
 arch/arm/mach-shmobile/entry-irq-common.S         |   38 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h      |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   17 ---------
 arch/arm/mach-shmobile/intc-sh7367.c              |    4 ++
 arch/arm/mach-shmobile/intc-sh7372.c              |    4 ++
 arch/arm/mach-shmobile/intc-sh7377.c              |    4 ++
 8 files changed, 53 insertions(+), 17 deletions(-)

--- 0008/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2010-10-06 14:43:07.000000000 +0900
@@ -1377,6 +1377,7 @@ config SPARSE_IRQ
 	  experimental until they have been independently verified.
 
 config DEFAULT_IRQ_DEMUX
+	default n if ARCH_SHMOBILE
 	def_bool y
 
 source "mm/Kconfig"
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-10-06 14:36:27.000000000 +0900
@@ -4,6 +4,7 @@
 
 # Common objects
 obj-y				:= timer.o console.o clock.o pm_runtime.o
+obj-y				+= entry-irq-common.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
--- /dev/null
+++ work/arch/arm/mach-shmobile/entry-irq-common.S	2010-10-06 14:38:29.000000000 +0900
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <asm/entry-header.S>
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
+
+1000:
+	.endm
+
+	__irq_svc shmobile_common
+	__irq_usr shmobile_common
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-10-06 14:39:29.000000000 +0900
@@ -5,6 +5,7 @@ extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 struct clk;
 extern int clk_init(void);
+extern char __irq_usr_shmobile_common[], __irq_svc_shmobile_common[];
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-10-06 14:38:01.000000000 +0900
@@ -14,26 +14,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#include <mach/hardware.h>
-#include <mach/irqs.h>
 
 	.macro  disable_fiq
 	.endm
 
-	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =INTFLGA
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \irqnr, [\base]
-	cmp	\irqnr, #0
-	beq	1000f
-	/* intevt to irq number */
-	lsr	\irqnr, \irqnr, #0x5
-	subs	\irqnr, \irqnr, #16
-
-1000:
-	.endm
--- 0001/arch/arm/mach-shmobile/intc-sh7367.c
+++ work/arch/arm/mach-shmobile/intc-sh7367.c	2010-10-06 14:44:20.000000000 +0900
@@ -24,6 +24,8 @@
 #include <linux/sh_intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/traps.h>
+#include <mach/common.h>
 
 enum {
 	UNUSED_INTCA = 0,
@@ -431,6 +433,8 @@ void __init sh7367_init_irq(void)
 {
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
+	setup_irq_stubs(__irq_usr_shmobile_common, __irq_svc_shmobile_common);
+
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intcs_desc);
 
--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2010-10-06 14:44:09.000000000 +0900
@@ -24,6 +24,8 @@
 #include <linux/sh_intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/traps.h>
+#include <mach/common.h>
 
 enum {
 	UNUSED_INTCA = 0,
@@ -580,6 +582,8 @@ void __init sh7372_init_irq(void)
 {
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
+	setup_irq_stubs(__irq_usr_shmobile_common, __irq_svc_shmobile_common);
+
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intcs_desc);
 
--- 0001/arch/arm/mach-shmobile/intc-sh7377.c
+++ work/arch/arm/mach-shmobile/intc-sh7377.c	2010-10-06 14:44:28.000000000 +0900
@@ -24,6 +24,8 @@
 #include <linux/sh_intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/traps.h>
+#include <mach/common.h>
 
 enum {
 	UNUSED_INTCA = 0,
@@ -637,6 +639,8 @@ void __init sh7377_init_irq(void)
 {
 	void __iomem *intevtsa = ioremap_nocache(INTEVTSA, PAGE_SIZE);
 
+	setup_irq_stubs(__irq_usr_shmobile_common, __irq_svc_shmobile_common);
+
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intcs_desc);
 
