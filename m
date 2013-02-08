From: dave.martin@linaro.org (Dave Martin)
Date: Fri,  8 Feb 2013 12:19:40 +0000
Subject: [PATCH] ARM: Allow modules to read cpu_logical_map
Message-ID: <1360325980-19089-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is reasonable for loadable modules to be CPU topology aware
(particular examples include cpufreq and cpuidle drivers).

This patch exports a new function cpu_get_hwid(cpu) to provide
suitable read-only access outside vmlinux.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
Modules using this function will be arch-dependent and highly coupled to
the kernel, so cpu_get_hwid() shouldn't be considered a stable API,
especially while the details of kernel topology awareness are still
under discussion: therefore, export only to GPL code for now.

 arch/arm/include/asm/smp_plat.h |    3 +++
 arch/arm/kernel/setup.c         |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index aaa61b6..518e466 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -66,4 +66,7 @@ static inline int get_logical_index(u32 mpidr)
 	return -EINVAL;
 }
 
+/* Read-only accessor for use by modules: */
+int cpu_get_hwid(int cpu);
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..1ac5e8b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -429,6 +429,13 @@ void cpu_init(void)
 
 int __cpu_logical_map[NR_CPUS];
 
+/* Read-only accessor for use by modules: */
+int cpu_get_hwid(int cpu)
+{
+	return cpu_logical_map(cpu);
+}
+EXPORT_SYMBOL_GPL(cpu_get_hwid);
+
 void __init smp_setup_processor_id(void)
 {
 	int i;
-- 
1.7.4.1
