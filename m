From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 15:08:59 -0700
Subject: [PATCH 11/11] ARM: msm: Remove nr_cpus detection logic
In-Reply-To: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383343739-23080-12-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the SMP supported MSM devices are using devicetree and they
have a cpus node in DT. Given this we know that arm generic code
detects the number of cpus from the cpus node so we can drop
support for detecting the number of CPUs from the mpidr register
here.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/platsmp.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 87e4fdc..36b2294 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -41,12 +41,6 @@ extern void secondary_startup(void);
 
 static DEFINE_SPINLOCK(boot_lock);
 
-static inline int get_core_count(void)
-{
-	/* 1 + the PART[1:0] field of MIDR */
-	return ((read_cpuid_id() >> 4) & 3) + 1;
-}
-
 static void msm_secondary_init(unsigned int cpu)
 {
 	/*
@@ -268,26 +262,6 @@ static int msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system. The msm8x60
- * does not support the ARM SCU, so just set the possible cpu mask to
- * NR_CPUS.
- */
-static void __init msm_smp_init_cpus(void)
-{
-	unsigned int i, ncores = get_core_count();
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
 static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu, map;
@@ -319,7 +293,6 @@ static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 struct smp_operations msm_smp_ops __initdata = {
-	.smp_init_cpus		= msm_smp_init_cpus,
 	.smp_prepare_cpus	= msm_smp_prepare_cpus,
 	.smp_secondary_init	= msm_secondary_init,
 	.smp_boot_secondary	= msm_boot_secondary,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
