From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:26:23 +0000
Subject: [PATCH 22/22] ARM: SMP: remove smp_mpidr.h
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcD1-0007sP-Rs@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With "ARM: CPU hotplug: remove bug checks in platform_cpu_die()", we
now do not use hard_smp_processor_id(), we no longer need to read the
hardware processor ID.  Remove the include providing this function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_mpidr.h          |   17 -----------------
 arch/arm/mach-realview/include/mach/smp.h |    1 -
 arch/arm/mach-s5pv310/include/mach/smp.h  |    1 -
 arch/arm/mach-tegra/include/mach/smp.h    |    1 -
 arch/arm/mach-ux500/include/mach/smp.h    |    1 -
 arch/arm/mach-vexpress/include/mach/smp.h |    1 -
 arch/arm/plat-omap/include/plat/smp.h     |    1 -
 7 files changed, 0 insertions(+), 23 deletions(-)
 delete mode 100644 arch/arm/include/asm/smp_mpidr.h

diff --git a/arch/arm/include/asm/smp_mpidr.h b/arch/arm/include/asm/smp_mpidr.h
deleted file mode 100644
index 6a9307d..0000000
--- a/arch/arm/include/asm/smp_mpidr.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef ASMARM_SMP_MIDR_H
-#define ASMARM_SMP_MIDR_H
-
-#define hard_smp_processor_id()						\
-	({								\
-		unsigned int cpunum;					\
-		__asm__("\n"						\
-			"1:	mrc p15, 0, %0, c0, c0, 5\n"		\
-			"	.pushsection \".alt.smp.init\", \"a\"\n"\
-			"	.long	1b\n"				\
-			"	mov	%0, #0\n"			\
-			"	.popsection"				\
-			: "=r" (cpunum));				\
-		cpunum &= 0x0F;						\
-	})
-
-#endif
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
index d1aa704..c8221b3 100644
--- a/arch/arm/mach-realview/include/mach/smp.h
+++ b/arch/arm/mach-realview/include/mach/smp.h
@@ -2,7 +2,6 @@
 #define ASMARM_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
index 2897747..77e5a84 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -7,7 +7,6 @@
 #define ASM_ARCH_SMP_H __FILE__
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 extern void __iomem *gic_cpu_base_addr;
 
diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
index d1aa704..c8221b3 100644
--- a/arch/arm/mach-tegra/include/mach/smp.h
+++ b/arch/arm/mach-tegra/include/mach/smp.h
@@ -2,7 +2,6 @@
 #define ASMARM_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
index bd57c50..ca2b15b 100644
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -10,7 +10,6 @@
 #define ASMARM_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 /* This is required to wakeup the secondary core */
 extern void u8500_secondary_startup(void);
diff --git a/arch/arm/mach-vexpress/include/mach/smp.h b/arch/arm/mach-vexpress/include/mach/smp.h
index 721be0f..4c05e4a 100644
--- a/arch/arm/mach-vexpress/include/mach/smp.h
+++ b/arch/arm/mach-vexpress/include/mach/smp.h
@@ -2,7 +2,6 @@
 #define __MACH_SMP_H
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index e5541e5..7a10257 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -18,7 +18,6 @@
 #define OMAP_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
-#include <asm/smp_mpidr.h>
 
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
-- 
1.6.2.5
