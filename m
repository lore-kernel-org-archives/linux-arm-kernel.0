From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:56 +0100
Subject: [PATCH v8 13/13] ARM: consolidate pen_release instead of having per
 platform definitions
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost each SMP platform defines pen_release to manage booting secondary
CPUs. This of course clashes with the single zImage effort.

Add the pen_release definition to the ARM SMP code, and remove all others.
This should only be used by platforms which lack any kind of CPU power
management...

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp.h        |    1 +
 arch/arm/kernel/smp.c             |    6 ++++++
 arch/arm/mach-exynos/hotplug.c    |    2 --
 arch/arm/mach-exynos/platsmp.c    |    7 -------
 arch/arm/mach-msm/hotplug.c       |    2 --
 arch/arm/mach-msm/platsmp.c       |    5 -----
 arch/arm/mach-realview/hotplug.c  |    2 --
 arch/arm/mach-spear13xx/hotplug.c |    2 --
 arch/arm/mach-spear13xx/platsmp.c |    5 -----
 arch/arm/mach-ux500/hotplug.c     |    2 --
 arch/arm/mach-ux500/platsmp.c     |    6 ------
 arch/arm/mach-vexpress/hotplug.c  |    2 --
 arch/arm/plat-versatile/platsmp.c |    6 ------
 13 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 873d297..0eac3a4 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -70,6 +70,7 @@ struct secondary_data {
 	void *stack;
 };
 extern struct secondary_data secondary_data;
+extern volatile int pen_release;
 
 extern int __cpu_disable(void);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index c49c0b8..7587e81 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -51,6 +51,12 @@
  */
 struct secondary_data secondary_data;
 
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+
 enum ipi_msg_type {
 	IPI_TIMER = 2,
 	IPI_RESCHEDULE,
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 8cd02f8..23bdffd 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -23,8 +23,6 @@
 
 #include "common.h"
 
-extern volatile int pen_release;
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 2dfca9b..78b0980 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -40,13 +40,6 @@ extern void exynos4_secondary_startup(void);
 				S5P_INFORM5 : S5P_VA_SYSRAM)
 
 /*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-
-volatile int __cpuinitdata pen_release = -1;
-
-/*
  * Write pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 6ba3602..1968277 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -15,8 +15,6 @@
 
 #include "core.h"
 
-extern volatile int pen_release;
-
 static inline void cpu_enter_lowpower(void)
 {
 	/* Just flush the cache. Changing the coherency is not yet
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 7670ace..d1a8259 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -35,11 +35,6 @@
 #define GIC_PPI_EDGE_MASK 0xFFFFD7FF
 
 extern void msm_secondary_startup(void);
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen".
- */
-volatile int pen_release = -1;
 
 static DEFINE_SPINLOCK(boot_lock);
 
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 95e6723..fbd4d9c 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -16,8 +16,6 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-extern volatile int pen_release;
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
index e8fa26d..d4d5fb9 100644
--- a/arch/arm/mach-spear13xx/hotplug.c
+++ b/arch/arm/mach-spear13xx/hotplug.c
@@ -17,8 +17,6 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-extern volatile int pen_release;
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index 742653c..f2514bd 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -22,11 +22,6 @@
 #include <mach/spear.h>
 #include <mach/generic.h>
 
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
 static DEFINE_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index ae1a8eb..ee178dd 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -17,8 +17,6 @@
 
 #include <mach/setup.h>
 
-extern volatile int pen_release;
-
 static inline void platform_do_lowpower(unsigned int cpu)
 {
 	flush_cache_all();
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 9afd9d7..d6984e2 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -28,12 +28,6 @@
 extern void u8500_secondary_startup(void);
 
 /*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int pen_release = -1;
-
-/*
  * Write pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index c280125..f0c2f67 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -16,8 +16,6 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
-extern volatile int pen_release;
-
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 41b4706..8c2a016 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -20,12 +20,6 @@
 #include <asm/hardware/gic.h>
 
 /*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
-
-/*
  * Write pen_release in a way that is guaranteed to be visible to all
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
-- 
1.7.10.3
