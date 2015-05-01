From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 01 May 2015 12:06:29 -0400
Subject: [PATCH 2/5] ARM: MCPM: remove backward compatibility code
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1430496392-15956-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that no one uses the old callbacks anymore, let's remove them
and associated support code.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 45 +++++---------------------------------------
 arch/arm/include/asm/mcpm.h  |  6 ------
 2 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 5f8a52ac7e..0908f96278 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -78,16 +78,11 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster)
 	bool cpu_is_down, cluster_is_down;
 	int ret = 0;
 
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (!platform_ops)
 		return -EUNATCH; /* try not to shadow power_up errors */
 	might_sleep();
 
-	/* backward compatibility callback */
-	if (platform_ops->power_up)
-		return platform_ops->power_up(cpu, cluster);
-
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-
 	/*
 	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
 	 * variant exists, we need to disable IRQs manually here.
@@ -128,29 +123,17 @@ void mcpm_cpu_power_down(void)
 	bool cpu_going_down, last_man;
 	phys_reset_t phys_reset;
 
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (WARN_ON_ONCE(!platform_ops))
 	       return;
 	BUG_ON(!irqs_disabled());
 
-	/*
-	 * Do this before calling into the power_down method,
-	 * as it might not always be safe to do afterwards.
-	 */
 	setup_mm_for_reboot();
 
-	/* backward compatibility callback */
-	if (platform_ops->power_down) {
-		platform_ops->power_down();
-		goto not_dead;
-	}
-
-	mpidr = read_cpuid_mpidr();
-	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-
 	__mcpm_cpu_going_down(cpu, cluster);
-
 	arch_spin_lock(&mcpm_lock);
 	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
 
@@ -187,7 +170,6 @@ void mcpm_cpu_power_down(void)
 	if (cpu_going_down)
 		wfi();
 
-not_dead:
 	/*
 	 * It is possible for a power_up request to happen concurrently
 	 * with a power_down request for the same CPU. In this case the
@@ -224,17 +206,6 @@ void mcpm_cpu_suspend(u64 expected_residency)
 	if (WARN_ON_ONCE(!platform_ops))
 		return;
 
-	/* backward compatibility callback */
-	if (platform_ops->suspend) {
-		phys_reset_t phys_reset;
-		BUG_ON(!irqs_disabled());
-		setup_mm_for_reboot();
-		platform_ops->suspend(expected_residency);
-		phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-		phys_reset(virt_to_phys(mcpm_entry_point));
-		BUG();
-	}
-
 	/* Some platforms might have to enable special resume modes, etc. */
 	if (platform_ops->cpu_suspend_prepare) {
 		unsigned int mpidr = read_cpuid_mpidr();
@@ -256,12 +227,6 @@ int mcpm_cpu_powered_up(void)
 	if (!platform_ops)
 		return -EUNATCH;
 
-	/* backward compatibility callback */
-	if (platform_ops->powered_up) {
-		platform_ops->powered_up();
-		return 0;
-	}
-
 	mpidr = read_cpuid_mpidr();
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 50b378f59e..e2118c941d 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -234,12 +234,6 @@ struct mcpm_platform_ops {
 	void (*cpu_is_up)(unsigned int cpu, unsigned int cluster);
 	void (*cluster_is_up)(unsigned int cluster);
 	int (*wait_for_powerdown)(unsigned int cpu, unsigned int cluster);
-
-	/* deprecated callbacks */
-	int (*power_up)(unsigned int cpu, unsigned int cluster);
-	void (*power_down)(void);
-	void (*suspend)(u64);
-	void (*powered_up)(void);
 };
 
 /**
-- 
2.1.0
