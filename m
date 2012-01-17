From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 16:48:51 +0000
Subject: [PATCH v2 1/2] ARM: logical_cpu_map: decouple CPU mapping from SMP
Message-ID: <1326818932-4922-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that the logical CPU mapping is useful even when !CONFIG_SMP
for manipulation of devices like interrupt and power controllers when
running a UP kernel on a CPU other than 0. This can happen when kexecing
a UP image from an SMP kernel.

In the future, multi-cluster systems running AMP configurations will
require something similar for mapping cluster IDs, so it makes sense to
decouple this logic in preparation for this support.

Acked-by: Yang Bai <hamo.by@gmail.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reported-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v2: Update mach-shmobile/smp-r8a7779.c as well.

 arch/arm/common/gic.c                |    7 ++-----
 arch/arm/include/asm/smp.h           |    6 ------
 arch/arm/include/asm/smp_plat.h      |    6 ++++++
 arch/arm/kernel/setup.c              |   14 ++++++++++++++
 arch/arm/kernel/smp.c                |   14 --------------
 arch/arm/mach-exynos/hotplug.c       |    1 +
 arch/arm/mach-exynos/platsmp.c       |    1 +
 arch/arm/mach-highbank/highbank.c    |    3 +--
 arch/arm/mach-imx/src.c              |    5 +----
 arch/arm/mach-msm/hotplug.c          |    1 +
 arch/arm/mach-msm/platsmp.c          |    1 +
 arch/arm/mach-realview/hotplug.c     |    1 +
 arch/arm/mach-shmobile/smp-r8a7779.c |    1 +
 arch/arm/mach-shmobile/smp-sh73a0.c  |    1 +
 arch/arm/mach-ux500/hotplug.c        |    1 +
 arch/arm/mach-ux500/platsmp.c        |    1 +
 arch/arm/mach-vexpress/hotplug.c     |    1 +
 arch/arm/plat-versatile/platsmp.c    |    1 +
 18 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index b2dc2dd..c47d619 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -41,6 +41,7 @@
 
 #include <asm/irq.h>
 #include <asm/exception.h>
+#include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
 
@@ -352,11 +353,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	unsigned int gic_irqs = gic->gic_irqs;
 	struct irq_domain *domain = &gic->domain;
 	void __iomem *base = gic_data_dist_base(gic);
-	u32 cpu = 0;
-
-#ifdef CONFIG_SMP
-	cpu = cpu_logical_map(smp_processor_id());
-#endif
+	u32 cpu = cpu_logical_map(smp_processor_id());
 
 	cpumask = 1 << cpu;
 	cpumask |= cpumask << 8;
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 1e5717a..ae29293 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -71,12 +71,6 @@ extern void platform_secondary_init(unsigned int cpu);
 extern void platform_smp_prepare_cpus(unsigned int);
 
 /*
- * Logical CPU mapping.
- */
-extern int __cpu_logical_map[NR_CPUS];
-#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
-
-/*
  * Initial data for bringing up a secondary CPU.
  */
 struct secondary_data {
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f24c1b9..558d6c8 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -43,4 +43,10 @@ static inline int cache_ops_need_broadcast(void)
 }
 #endif
 
+/*
+ * Logical CPU mapping.
+ */
+extern int __cpu_logical_map[];
+#define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 129fbd5..2a9d81a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -427,6 +427,20 @@ void cpu_init(void)
 	    : "r14");
 }
 
+int __cpu_logical_map[NR_CPUS];
+
+void __init smp_setup_processor_id(void)
+{
+	int i;
+	u32 cpu = is_smp() ? read_cpuid_mpidr() & 0xff : 0;
+
+	cpu_logical_map(0) = cpu;
+	for (i = 1; i < NR_CPUS; ++i)
+		cpu_logical_map(i) = i == cpu ? 0 : i;
+
+	printk(KERN_INFO "Booting Linux on physical CPU %d\n", cpu);
+}
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57db122..43c8d96 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -233,20 +233,6 @@ void __ref cpu_die(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-int __cpu_logical_map[NR_CPUS];
-
-void __init smp_setup_processor_id(void)
-{
-	int i;
-	u32 cpu = is_smp() ? read_cpuid_mpidr() & 0xff : 0;
-
-	cpu_logical_map(0) = cpu;
-	for (i = 1; i < NR_CPUS; ++i)
-		cpu_logical_map(i) = i == cpu ? 0 : i;
-
-	printk(KERN_INFO "Booting Linux on physical CPU %d\n", cpu);
-}
-
 /*
  * Called by both boot and secondaries to move global data into
  * per-processor storage.
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index da70e7e..dd1ad55 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 
 #include <mach/regs-pmu.h>
 
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 60bc45e..dc393bb 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -23,6 +23,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 804c4a5..5acbb91 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -26,6 +26,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/unified.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
@@ -73,9 +74,7 @@ static void __init highbank_map_io(void)
 
 void highbank_set_cpu_jump(int cpu, void *jump_addr)
 {
-#ifdef CONFIG_SMP
 	cpu = cpu_logical_map(cpu);
-#endif
 	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
 	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
 	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 4bde04f..c34bcc0 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
+#include <asm/smp_plat.h>
 #include <asm/unified.h>
 
 #define SRC_SCR				0x000
@@ -25,10 +26,6 @@
 
 static void __iomem *src_base;
 
-#ifndef CONFIG_SMP
-#define cpu_logical_map(cpu)		0
-#endif
-
 void imx_enable_cpu(int cpu, bool enable)
 {
 	u32 mask, val;
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 41c252d..a446fc1 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 
 extern volatile int pen_release;
 
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 0b3e357..db0117e 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/mach-types.h>
+#include <asm/smp_plat.h>
 
 #include <mach/msm_iomap.h>
 
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index ac1aed2..eb55f05 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 
 extern volatile int pen_release;
 
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index cc97ef8..4fe2e9e 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <mach/common.h>
 #include <mach/r8a7779.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index be1ade7..0d159d6 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <mach/common.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 572015e..c76f0f4 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 
 extern volatile int pen_release;
 
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a19e398..d2058ef 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -19,6 +19,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index 813ee08..3034a4d 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 #include <asm/system.h>
 
 extern volatile int pen_release;
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 92f18d3..49c7db4 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
 #include <asm/hardware/gic.h>
 
 /*
-- 
1.7.4.1
