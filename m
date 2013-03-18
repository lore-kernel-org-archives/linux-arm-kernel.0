From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:47:05 +0900
Subject: [PATCH 13/43] ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607255-6385-14-git-send-email-horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/headsmp-scu.S         |   50 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c          |    4 +--
 4 files changed, 54 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/headsmp-scu.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e1fac57..245a873 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-sh73a0.o
+smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
 
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
new file mode 100644
index 0000000..4ee287d
--- /dev/null
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
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
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index c72d301..20acf00 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -8,6 +8,7 @@ extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
+extern void shmobile_secondary_vector_scu(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
@@ -44,7 +45,6 @@ extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern void sh73a0_pm_init(void);
-extern void sh73a0_secondary_vector(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 0757f4a..de7518f 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -72,9 +72,9 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
 	scu_enable(shmobile_scu_base);
 
-	/* Map the reset vector (in headsmp-sh73a0.S) */
+	/* Map the reset vector (in headsmp-scu.S) */
 	__raw_writel(0, APARMBAREA);      /* 4k */
-	__raw_writel(__pa(sh73a0_secondary_vector), SBAR);
+	__raw_writel(__pa(shmobile_secondary_vector_scu), SBAR);
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
-- 
1.7.10.4
