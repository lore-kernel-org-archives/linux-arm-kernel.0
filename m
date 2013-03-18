From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:06 +0900
Subject: [PATCH 14/43] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the code in headsmp-scu.S to use a global
shmobile_scu_base variable both for convenient SCU
base address storage and for the early SCU setup
code in shmobile_secondary_vector_scu.

With this patch applied r8a7779, sh73a0 and EMEV2
all make use of the global shmobile_scu_base
variable. However only sh73a0 makes use of the SCU
bring up code in shmobile_secondary_vector_scu.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile              |    4 +--
 arch/arm/mach-shmobile/headsmp-scu.S         |    8 ++++-
 arch/arm/mach-shmobile/headsmp-sh73a0.S      |   50 --------------------------
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/smp-emev2.c           |    2 --
 arch/arm/mach-shmobile/smp-r8a7779.c         |    2 --
 arch/arm/mach-shmobile/smp-sh73a0.c          |    2 --
 7 files changed, 10 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 245a873..d7d2057 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -16,8 +16,8 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
-smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
-smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
+smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
+smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 4ee287d..0b93170 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -39,7 +39,8 @@ ENTRY(shmobile_secondary_vector_scu)
 	mrc     p15, 0, r0, c0, c0, 5	@ read MIPDR
 	and	r0, r0, #3		@ mask out cpu ID
 	lsl	r0, r0, #3		@ we will shift by cpu_id * 8 bits
-	mov	r1, #0xf0000000		@ SCU base address
+	ldr	r1, =shmobile_scu_base
+	ldr	r1, [r1]		@ SCU base address
 	ldr	r2, [r1, #8]		@ SCU Power Status Register
 	mov	r3, #3
 	bic	r2, r2, r3, lsl r0	@ Clear bits of our CPU (Run Mode)
@@ -48,3 +49,8 @@ ENTRY(shmobile_secondary_vector_scu)
 	ldr	pc, 1f
 1:	.long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
 ENDPROC(shmobile_secondary_vector_scu)
+
+	.text
+	.globl	shmobile_scu_base
+shmobile_scu_base:
+	.space	4
diff --git a/arch/arm/mach-shmobile/headsmp-sh73a0.S b/arch/arm/mach-shmobile/headsmp-sh73a0.S
deleted file mode 100644
index bec4c0d..0000000
--- a/arch/arm/mach-shmobile/headsmp-sh73a0.S
+++ /dev/null
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
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 20acf00..84dcaa4 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -95,6 +95,7 @@ extern int shmobile_cpu_is_dead(unsigned int cpu);
 static inline int shmobile_cpu_is_dead(unsigned int cpu) { return 1; }
 #endif
 
+extern void __iomem *shmobile_scu_base;
 extern void shmobile_smp_init_cpus(unsigned int ncores);
 
 static inline void __init shmobile_init_late(void)
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 136867e..bc8e071 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -32,8 +32,6 @@
 
 #define EMEV2_SCU_BASE 0x1e000000
 
-static void __iomem *shmobile_scu_base;
-
 static DEFINE_SPINLOCK(scu_lock);
 
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index d92188d..7fd58a3 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -33,8 +33,6 @@
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE IOMEM(0xf0000000)
 
-static void __iomem *shmobile_scu_base;
-
 static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 1, /* ARM1 */
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index de7518f..2244fd0 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -41,8 +41,6 @@
 
 #define SH73A0_SCU_BASE IOMEM(0xf0000000)
 
-static void __iomem *shmobile_scu_base;
-
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
 void __init sh73a0_register_twd(void)
-- 
1.7.10.4
