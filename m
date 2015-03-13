From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Mar 2015 16:14:34 +0000
Subject: [PATCH 1/4] arm64: apply alternatives for !SMP kernels
In-Reply-To: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1426263277-9827-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only perform alternative patching for kernels built with
CONFIG_SMP, as we call apply_alternatives_all() in smp.c, which is only
built for CONFIG_SMP. Thus !SMP kernels may not have necessary
alternatives patched in.

This patch ensures that we call apply_alternatives_all() once all CPUs
are booted, even for !SMP kernels, by having the smp_init_cpus() stub
call this for !SMP kernels via up_late_init. A new wrapper,
do_post_cpus_up_work, is added so we can hook other calls here later
(e.g. boot mode logging).

Fixes: e039ee4ee3fcf174 ("arm64: add alternative runtime patching")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                |  4 ++++
 arch/arm64/include/asm/smp_plat.h |  2 ++
 arch/arm64/kernel/setup.c         | 12 ++++++++++++
 arch/arm64/kernel/smp.c           |  2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..0d46deb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -470,6 +470,10 @@ config HOTPLUG_CPU
 
 source kernel/Kconfig.preempt
 
+config UP_LATE_INIT
+       def_bool y
+       depends on !SMP
+
 config HZ
 	int
 	default 100
diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 59e2823..8dcd61e 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -40,4 +40,6 @@ static inline u32 mpidr_hash_size(void)
 extern u64 __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
+void __init do_post_cpus_up_work(void);
+
 #endif /* __ASM_SMP_PLAT_H */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e8420f6..781f469 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -207,6 +207,18 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
+void __init do_post_cpus_up_work(void)
+{
+	apply_alternatives_all();
+}
+
+#ifdef CONFIG_UP_LATE_INIT
+void __init up_late_init(void)
+{
+	do_post_cpus_up_work();
+}
+#endif /* CONFIG_UP_LATE_INIT */
+
 static void __init setup_processor(void)
 {
 	struct cpu_info *cpu_info;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 328b8ce..4257369 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -309,7 +309,7 @@ void cpu_die(void)
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	pr_info("SMP: Total of %d processors activated.\n", num_online_cpus());
-	apply_alternatives_all();
+	do_post_cpus_up_work();
 }
 
 void __init smp_prepare_boot_cpu(void)
-- 
1.9.1
