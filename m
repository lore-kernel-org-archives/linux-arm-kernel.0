From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 00:11:09 -0400
Subject: [PATCH 1/3] ARM: MCPM: provide infrastructure to allow for MCPM
 loopback
In-Reply-To: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1403583071-5650-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel already has the responsibility to handle resources such as the
CCI when hotplugging CPUs, during the booting of secondary CPUs, and when
resuming from suspend/idle.  It would be more coherent and less confusing
if the CCI for the boot CPU (or cluster)  was also initialized by the kernel rather than expecting the
firmware/bootloader to do it and only in that case. After all, the kernel
has all the necessary code already and the bootloader shouldn't have to
care at all.

The CCI may be turned on only when the cache is off. Leveraging the CPU
suspend code to loop back through the low-level MCPM entry point is all
that is needed to properly turn on the CCI from the kernel by using the
same code as for secondary boot.

Let's provide a generic MCPM loopback function that can be invoked by
backend initialization code to set things (CCI or similar) on the boot
CPU just as it is done for the other CPUs.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/mcpm.h  | 16 ++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index f91136ab44..5e7284a3f8 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -12,11 +12,13 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/cpu_pm.h>
 
 #include <asm/mcpm.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
 #include <asm/cputype.h>
+#include <asm/suspend.h>
 
 extern unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
 
@@ -146,6 +148,56 @@ int mcpm_cpu_powered_up(void)
 	return 0;
 }
 
+#ifdef CONFIG_ARM_CPU_SUSPEND
+
+static int __init nocache_trampoline(unsigned long _arg)
+{
+	void (*cache_disable)(void) = (void *)_arg;
+	unsigned int mpidr = read_cpuid_mpidr();
+	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	phys_reset_t phys_reset;
+
+	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
+	setup_mm_for_reboot();
+
+	__mcpm_cpu_going_down(cpu, cluster);
+	BUG_ON(!__mcpm_outbound_enter_critical(cpu, cluster));
+	cache_disable();
+	__mcpm_outbound_leave_critical(cluster, CLUSTER_DOWN);
+	__mcpm_cpu_down(cpu, cluster);
+
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(mcpm_entry_point));
+	BUG();
+}
+	
+int __init mcpm_loopback(void (*cache_disable)(void))
+{
+	int ret;
+
+	/*
+	 * We're going to soft-restart the current CPU through the
+	 * low-level MCPM code by leveraging the suspend/resume
+	 * infrastructure. Let's play it safe by using cpu_pm_enter()
+	 * in case the CPU init code path resets the VFP or similar.
+	 */
+	local_irq_disable();
+	local_fiq_disable();
+	ret = cpu_pm_enter();
+	if (!ret) {
+		ret = cpu_suspend((unsigned long)cache_disable, nocache_trampoline);
+		cpu_pm_exit();
+	}
+	local_fiq_enable();
+	local_irq_enable();
+	if (ret)
+		pr_err("%s returned %d\n", __func__, ret);
+	return ret;
+}
+
+#endif
+
 struct sync_struct mcpm_sync;
 
 /*
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 94060adba1..ff73affd45 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -217,6 +217,22 @@ int __mcpm_cluster_state(unsigned int cluster);
 int __init mcpm_sync_init(
 	void (*power_up_setup)(unsigned int affinity_level));
 
+/**
+ * mcpm_loopback - make a run through the MCPM low-level code
+ *
+ * @cache_disable: pointer to function performing cache disabling
+ *
+ * This exercises the MCPM machinery by soft resetting the CPU and branching
+ * to the MCPM low-level entry code before returning to the caller.  
+ * The @cache_disable function must do the necessary cache disabling to
+ * let the regular kernel init code turn it back on as if the CPU was
+ * hotplugged in. The MCPM state machine is set as if the cluster was
+ * initialized meaning the power_up_setup callback passed to mcpm_sync_init()
+ * will be invoked for all affinity levels. This may be useful to initialize
+ * some resources such as enabling the CCI that requires the cache to be off, or simply for testing purposes.
+ */
+int __init mcpm_loopback(void (*cache_disable)(void));
+
 void __init mcpm_smp_set_ops(void);
 
 #else
-- 
1.8.4.108.g55ea5f6
