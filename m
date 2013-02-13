From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 22:47:07 +0900
Subject: [PATCH 04/06] ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
In-Reply-To: <20130213134628.12153.47120.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
Message-ID: <20130213134707.12153.67490.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename headsmp-sh73a0.S into headsmp-scu.S and
introduce shmobile_secondary_vector_scu().

The goal is to be able to share the function
above between all mach-shmobile SoCs that use
SCU for SMP. So far only sh73a0 use this.

At this time the SCU base address is still hard
coded in headsmp-scu.S to 0xf0000000, but this
will be changed in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Hum, perhaps git can generate a better patch with "rename" information?

 arch/arm/mach-shmobile/Makefile              |    2 -
 arch/arm/mach-shmobile/headsmp-scu.S         |   50 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/headsmp-sh73a0.S      |   50 --------------------------
 arch/arm/mach-shmobile/include/mach/common.h |    2 -
 arch/arm/mach-shmobile/smp-sh73a0.c          |    4 +-
 5 files changed, 54 insertions(+), 54 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-02-05 18:23:20.000000000 +0900
@@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-sh73a0.o
+smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
 
--- /dev/null
+++ work/arch/arm/mach-shmobile/headsmp-scu.S	2013-02-05 18:23:21.000000000 +0900
@@ -0,0 +1,50 @@
+/*
+ * Shared SCU setup for mach-shmobile
+ *
+ * Copyright (C) 2012 Bastian Hecht
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/memory.h>
+
+	__CPUINIT
+/*
+ * Reset vector for secondary CPUs.
+ *
+ * First we turn on L1 cache coherency for our CPU. Then we jump to
+ * shmobile_invalidate_start that invalidates the cache and hands over control
+ * to the common ARM startup code.
+ * This function will be mapped to address 0 by the SBAR register.
+ * A normal branch is out of range here so we need a long jump. We jump to
+ * the physical address as the MMU is still turned off.
+ */
+	.align	12
+ENTRY(shmobile_secondary_vector_scu)
+	mrc     p15, 0, r0, c0, c0, 5	@ read MIPDR
+	and	r0, r0, #3		@ mask out cpu ID
+	lsl	r0, r0, #3		@ we will shift by cpu_id * 8 bits
+	mov	r1, #0xf0000000		@ SCU base address
+	ldr	r2, [r1, #8]		@ SCU Power Status Register
+	mov	r3, #3
+	bic	r2, r2, r3, lsl r0	@ Clear bits of our CPU (Run Mode)
+	str	r2, [r1, #8]		@ write back
+
+	ldr	pc, 1f
+1:	.long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
+ENDPROC(shmobile_secondary_vector_scu)
--- 0001/arch/arm/mach-shmobile/headsmp-sh73a0.S
+++ /dev/null	2013-01-21 13:48:16.387453344 +0900
@@ -1,50 +0,0 @@
-/*
- * SMP support for SoC sh73a0
- *
- * Copyright (C) 2012 Bastian Hecht
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <asm/memory.h>
-
-	__CPUINIT
-/*
- * Reset vector for secondary CPUs.
- *
- * First we turn on L1 cache coherency for our CPU. Then we jump to
- * shmobile_invalidate_start that invalidates the cache and hands over control
- * to the common ARM startup code.
- * This function will be mapped to address 0 by the SBAR register.
- * A normal branch is out of range here so we need a long jump. We jump to
- * the physical address as the MMU is still turned off.
- */
-	.align	12
-ENTRY(sh73a0_secondary_vector)
-	mrc     p15, 0, r0, c0, c0, 5	@ read MIPDR
-	and	r0, r0, #3		@ mask out cpu ID
-	lsl	r0, r0, #3		@ we will shift by cpu_id * 8 bits
-	mov	r1, #0xf0000000		@ SCU base address
-	ldr	r2, [r1, #8]		@ SCU Power Status Register
-	mov	r3, #3
-	bic	r2, r2, r3, lsl r0	@ Clear bits of our CPU (Run Mode)
-	str	r2, [r1, #8]		@ write back
-
-	ldr	pc, 1f
-1:	.long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
-ENDPROC(sh73a0_secondary_vector)
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-02-05 18:29:43.000000000 +0900
@@ -8,6 +8,7 @@ extern void shmobile_setup_delay(unsigne
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
+extern void shmobile_secondary_vector_scu(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
@@ -45,7 +46,6 @@ extern void sh73a0_add_standard_devices_
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern void sh73a0_pm_init(void);
-extern void sh73a0_secondary_vector(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-02-05 18:23:20.000000000 +0900
@@ -80,9 +80,9 @@ static void __init sh73a0_smp_prepare_cp
 {
 	scu_enable(scu_base_addr());
 
-	/* Map the reset vector (in headsmp-sh73a0.S) */
+	/* Map the reset vector (in headsmp-scu.S) */
 	__raw_writel(0, APARMBAREA);      /* 4k */
-	__raw_writel(__pa(sh73a0_secondary_vector), SBAR);
+	__raw_writel(__pa(shmobile_secondary_vector_scu), SBAR);
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(scu_base_addr(), SCU_PM_NORMAL);
