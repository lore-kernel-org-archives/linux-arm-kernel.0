From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:24 -0700
Subject: [PATCH v2 4/7] ARM: B15: Add CPU hotplug awareness
In-Reply-To: <20170623175227.19743-1-f.fainelli@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
Message-ID: <20170623175227.19743-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Brahma-B15 readahead cache needs to be disabled,
respectively re-enable during a CPU hotplug. In case we were not to do,
CPU hotplug would occasionally fail with random crashes when a given CPU
exits the coherency domain while the RAC is still enabled, as it would
get stale data from the RAC.

In order to avoid adding any specific B15 readahead-cache awareness to
arch/arm/mach-bcm/hotplug-brcmstb.c we use a CPU hotplug state machine
which allows us to catch CPU hotplug events and disable/flush enable the
RAC accordingly.

Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-b15-rac.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |  2 +
 2 files changed, 93 insertions(+)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 679d44f003fd..d85b63211759 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/of_address.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-b15-rac.h>
@@ -42,6 +44,7 @@ extern void v7_flush_kern_cache_all(void);
 
 static void __iomem *b15_rac_base;
 static DEFINE_SPINLOCK(rac_lock);
+static u32 rac_config0_reg;
 
 /* Initialization flag to avoid checking for b15_rac_base, and to prevent
  * multi-platform kernels from crashing here as well.
@@ -137,6 +140,74 @@ static void b15_rac_enable(void)
 	__b15_rac_enable(enable);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* The CPU hotplug case is the most interesting one, we basically need to make
+ * sure that the RAC is disabled for the entire system prior to having a CPU
+ * die, in particular prior to this dying CPU having exited the coherency
+ * domain.
+ *
+ * Once this CPU is marked dead, we can safely re-enable the RAC for the
+ * remaining CPUs in the system which are still online.
+ *
+ * Offlining a CPU is the problematic case, onlining a CPU is not much of an
+ * issue since the CPU and its cache-level hierarchy will start filling with
+ * the RAC disabled, so L1 and L2 only.
+ *
+ * In this function, we should NOT have to verify any unsafe setting/condition
+ * b15_rac_base:
+ *
+ *   It is protected by the RAC_ENABLED flag which is cleared by default, and
+ *   being cleared when initial procedure is done. b15_rac_base had been set at
+ *   that time.
+ *
+ * RAC_ENABLED:
+ *   There is a small timing windows, in b15_rac_init(), between
+ *      cpuhp_setup_state_*()
+ *      ...
+ *      set RAC_ENABLED
+ *   However, there is no hotplug activity based on the Linux booting procedure.
+ *
+ * Since we have to disable RAC for all cores, we keep RAC on as long as as
+ * possible (disable it as late as possible) to gain the cache benefit.
+ *
+ * Thus, dying/dead states are chosen here
+ *
+ * We are choosing not do disable the RAC on a per-CPU basis, here, if we did
+ * we would want to consider disabling it as early as possible to benefit the
+ * other active CPUs.
+ */
+
+/* Running on the dying CPU */
+static int b15_rac_dying_cpu(unsigned int cpu)
+{
+	spin_lock(&rac_lock);
+
+	/* Indicate that we are starting a hotplug procedure */
+	__clear_bit(RAC_ENABLED, &b15_rac_flags);
+
+	/* Disable the readahead cache and save its value to a global */
+	rac_config0_reg = b15_rac_disable_and_flush();
+
+	spin_unlock(&rac_lock);
+
+	return 0;
+}
+
+/* Running on a non-dying CPU */
+static int b15_rac_dead_cpu(unsigned int cpu)
+{
+	spin_lock(&rac_lock);
+
+	/* And enable it */
+	__b15_rac_enable(rac_config0_reg);
+	__set_bit(RAC_ENABLED, &b15_rac_flags);
+
+	spin_unlock(&rac_lock);
+
+	return 0;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __init b15_rac_init(void)
 {
 	struct device_node *dn;
@@ -157,6 +228,20 @@ static int __init b15_rac_init(void)
 		goto out;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
+					"arm/cache-b15-rac:dead",
+					NULL, b15_rac_dead_cpu);
+	if (ret)
+		goto out_unmap;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
+					"arm/cache-b15-rac:dying",
+					NULL, b15_rac_dying_cpu);
+	if (ret)
+		goto out_cpu_dead;
+#endif
+
 	spin_lock(&rac_lock);
 	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
 	for_each_possible_cpu(cpu)
@@ -170,6 +255,12 @@ static int __init b15_rac_init(void)
 	pr_info("Broadcom Brahma-B15 readahead cache at: 0x%p\n",
 		b15_rac_base + RAC_CONFIG0_REG);
 
+	goto out;
+
+out_cpu_dead:
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING);
+out_unmap:
+	iounmap(b15_rac_base);
 out:
 	of_node_put(dn);
 	return ret;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f2a80377520..69d504fb23f2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -41,6 +41,7 @@ enum cpuhp_state {
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_SCSI_BNX2FC_DEAD,
 	CPUHP_SCSI_BNX2I_DEAD,
+	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -119,6 +120,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
+	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
-- 
2.9.3
