From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:21:59 -0500
Subject: [PATCH v4 02/15] ARM: mcpm: introduce the CPU/cluster power API
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the basic API used to handle the powering up/down of individual
CPUs in a (multi-)cluster system.  The platform specific backend
implementation has the responsibility to also handle the cluster level
power as well when the first/last CPU in a cluster is brought up/down.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/mcpm_entry.c      | 88 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/mcpm_entry.h | 92 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 3a6d7e70fd..c8c0e2113e 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -11,11 +11,13 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 
 #include <asm/mcpm_entry.h>
 #include <asm/barrier.h>
 #include <asm/proc-fns.h>
 #include <asm/cacheflush.h>
+#include <asm/idmap.h>
 
 extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];
 
@@ -27,3 +29,89 @@ void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
 	outer_clean_range(__pa(&mcpm_entry_vectors[cluster][cpu]),
 			  __pa(&mcpm_entry_vectors[cluster][cpu + 1]));
 }
+
+static const struct mcpm_platform_ops *platform_ops;
+
+int __init mcpm_platform_register(const struct mcpm_platform_ops *ops)
+{
+	if (platform_ops)
+		return -EBUSY;
+	platform_ops = ops;
+	return 0;
+}
+
+int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster)
+{
+	if (!platform_ops)
+		return -EUNATCH; /* try not to shadow power_up errors */
+	might_sleep();
+	return platform_ops->power_up(cpu, cluster);
+}
+
+typedef void (*phys_reset_t)(unsigned long);
+
+void mcpm_cpu_power_down(void)
+{
+	phys_reset_t phys_reset;
+
+	BUG_ON(!platform_ops);
+	BUG_ON(!irqs_disabled());
+
+	/*
+	 * Do this before calling into the power_down method,
+	 * as it might not always be safe to do afterwards.
+	 */
+	setup_mm_for_reboot();
+
+	platform_ops->power_down();
+
+	/*
+	 * It is possible for a power_up request to happen concurrently
+	 * with a power_down request for the same CPU. In this case the
+	 * power_down method might not be able to actually enter a
+	 * powered down state with the WFI instruction if the power_up
+	 * method has removed the required reset condition.  The
+	 * power_down method is then allowed to return. We must perform
+	 * a re-entry in the kernel as if the power_up method just had
+	 * deasserted reset on the CPU.
+	 *
+	 * To simplify race issues, the platform specific implementation
+	 * must accommodate for the possibility of unordered calls to
+	 * power_down and power_up with a usage count. Therefore, if a
+	 * call to power_up is issued for a CPU that is not down, then
+	 * the next call to power_down must not attempt a full shutdown
+	 * but only do the minimum (normally disabling L1 cache and CPU
+	 * coherency) and return just as if a concurrent power_up request
+	 * had happened as described above.
+	 */
+
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(mcpm_entry_point));
+
+	/* should never get here */
+	BUG();
+}
+
+void mcpm_cpu_suspend(u64 expected_residency)
+{
+	phys_reset_t phys_reset;
+
+	BUG_ON(!platform_ops);
+	BUG_ON(!irqs_disabled());
+
+	/* Very similar to mcpm_cpu_power_down() */
+	setup_mm_for_reboot();
+	platform_ops->suspend(expected_residency);
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(mcpm_entry_point));
+	BUG();
+}
+
+int mcpm_cpu_powered_up(void)
+{
+	if (!platform_ops)
+		return -EUNATCH;
+	if (platform_ops->powered_up)
+		platform_ops->powered_up();
+	return 0;
+}
diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
index cc10ebbd2e..3286d5eb91 100644
--- a/arch/arm/include/asm/mcpm_entry.h
+++ b/arch/arm/include/asm/mcpm_entry.h
@@ -31,5 +31,97 @@ extern void mcpm_entry_point(void);
  */
 void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr);
 
+/*
+ * CPU/cluster power operations API for higher subsystems to use.
+ */
+
+/**
+ * mcpm_cpu_power_up - make given CPU in given cluster runable
+ *
+ * @cpu: CPU number within given cluster
+ * @cluster: cluster number for the CPU
+ *
+ * The identified CPU is brought out of reset.  If the cluster was powered
+ * down then it is brought up as well, taking care not to let the other CPUs
+ * in the cluster run, and ensuring appropriate cluster setup.
+ *
+ * Caller must ensure the appropriate entry vector is initialized with
+ * mcpm_set_entry_vector() prior to calling this.
+ *
+ * This must be called in a sleepable context.  However, the implementation
+ * is strongly encouraged to return early and let the operation happen
+ * asynchronously, especially when significant delays are expected.
+ *
+ * If the operation cannot be performed then an error code is returned.
+ */
+int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster);
+
+/**
+ * mcpm_cpu_power_down - power the calling CPU down
+ *
+ * The calling CPU is powered down.
+ *
+ * If this CPU is found to be the "last man standing" in the cluster
+ * then the cluster is prepared for power-down too.
+ *
+ * This must be called with interrupts disabled.
+ *
+ * This does not return.  Re-entry in the kernel is expected via
+ * mcpm_entry_point.
+ */
+void mcpm_cpu_power_down(void);
+
+/**
+ * mcpm_cpu_suspend - bring the calling CPU in a suspended state
+ *
+ * @expected_residency: duration in microseconds the CPU is expected
+ *			to remain suspended, or 0 if unknown/infinity.
+ *
+ * The calling CPU is suspended.  The expected residency argument is used
+ * as a hint by the platform specific backend to implement the appropriate
+ * sleep state level according to the knowledge it has on wake-up latency
+ * for the given hardware.
+ *
+ * If this CPU is found to be the "last man standing" in the cluster
+ * then the cluster may be prepared for power-down too, if the expected
+ * residency makes it worthwhile.
+ *
+ * This must be called with interrupts disabled.
+ *
+ * This does not return.  Re-entry in the kernel is expected via
+ * mcpm_entry_point.
+ */
+void mcpm_cpu_suspend(u64 expected_residency);
+
+/**
+ * mcpm_cpu_powered_up - housekeeping workafter a CPU has been powered up
+ *
+ * This lets the platform specific backend code perform needed housekeeping
+ * work.  This must be called by the newly activated CPU as soon as it is
+ * fully operational in kernel space, before it enables interrupts.
+ *
+ * If the operation cannot be performed then an error code is returned.
+ */
+int mcpm_cpu_powered_up(void);
+
+/*
+ * Platform specific methods used in the implementation of the above API.
+ */
+struct mcpm_platform_ops {
+	int (*power_up)(unsigned int cpu, unsigned int cluster);
+	void (*power_down)(void);
+	void (*suspend)(u64);
+	void (*powered_up)(void);
+};
+
+/**
+ * mcpm_platform_register - register platform specific power methods
+ *
+ * @ops: mcpm_platform_ops structure to register
+ *
+ * An error is returned if the registration has been done previously.
+ */
+int __init mcpm_platform_register(const struct mcpm_platform_ops *ops);
+
 #endif /* ! __ASSEMBLY__ */
 #endif
-- 
1.8.1.2
