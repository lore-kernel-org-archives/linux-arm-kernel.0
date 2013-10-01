From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Oct 2013 18:15:17 +0100
Subject: [PATCH v3 2/3] ARM: mcpm: Implement cpu_kill() to synchronise on
 powerdown
In-Reply-To: <1380647718-9178-1-git-send-email-Dave.Martin@arm.com>
References: <1380647718-9178-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1380647718-9178-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU hotplug and kexec rely on smp_ops.cpu_kill(), which is supposed
to wait for the CPU to park or power down, and perform the last
rites (such as disabling clocks etc., where the platform doesn't do
this automatically).

kexec in particular is unsafe without performing this
synchronisation to park secondaries.  Without it, the secondaries
might not be parked when kexec trashes the kernel.

There is no generic way to do this synchronisation, so a new mcpm
platform_ops method power_down_finish() is added by this patch.

The new method is mandatory.  A platform which provides no way to
detect when CPUs are parked is likely broken.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/common/mcpm_entry.c   |   15 +++++++++++++++
 arch/arm/common/mcpm_platsmp.c |   10 ++++++++++
 arch/arm/include/asm/mcpm.h    |   31 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 9902509..6c03d01 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -90,6 +90,21 @@ void mcpm_cpu_power_down(void)
 	BUG();
 }
 
+int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(!platform_ops || !platform_ops->power_down_finish))
+		return -EUNATCH;
+
+	ret = platform_ops->power_down_finish(cpu, cluster);
+	if (ret)
+		pr_warn("%s: cpu %u, cluster %u failed to power down (%d)\n",
+			__func__, cpu, cluster, ret);
+
+	return ret;
+}
+
 void mcpm_cpu_suspend(u64 expected_residency)
 {
 	phys_reset_t phys_reset;
diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index c0c3cd7..177251a 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -56,6 +56,15 @@ static void mcpm_secondary_init(unsigned int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
+static int mcpm_cpu_kill(unsigned int cpu)
+{
+	unsigned int pcpu, pcluster;
+
+	cpu_to_pcpu(cpu, &pcpu, &pcluster);
+
+	return !mcpm_cpu_power_down_finish(pcpu, pcluster);
+}
+
 static int mcpm_cpu_disable(unsigned int cpu)
 {
 	/*
@@ -82,6 +91,7 @@ static struct smp_operations __initdata mcpm_smp_ops = {
 	.smp_boot_secondary	= mcpm_boot_secondary,
 	.smp_secondary_init	= mcpm_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= mcpm_cpu_kill,
 	.cpu_disable		= mcpm_cpu_disable,
 	.cpu_die		= mcpm_cpu_die,
 #endif
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index fc82a88..1cf2601 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -81,10 +81,40 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster);
  *
  * This will return if mcpm_platform_register() has not been called
  * previously in which case the caller should take appropriate action.
+ *
+ * On success, the CPU is not guaranteed to be truly halted until
+ * mcpm_cpu_power_down_finish() subsequently returns non-zero for the
+ * specified cpu.  Until then, other CPUs should make sure they do not
+ * trash memory the target CPU might be executing/accessing.
  */
 void mcpm_cpu_power_down(void);
 
 /**
+ * mcpm_cpu_power_down_finish - wait for a specified CPU to halt, and
+ *	make sure it is powered off
+ *
+ * @cpu: CPU number within given cluster
+ * @cluster: cluster number for the CPU
+ *
+ * Call this function to ensure that a pending powerdown has taken
+ * effect and the CPU is safely parked before performing non-mcpm
+ * operations that may affect the CPU (such as kexec trashing the
+ * kernel text).
+ *
+ * It is *not* necessary to call this function if you only need to
+ * serialise a pending powerdown with mcpm_cpu_power_up() or a wakeup
+ * event.
+ *
+ * Do not call this function unless the specified CPU has already
+ * called mcpm_cpu_power_down() or has committed to doing so.
+ *
+ * @return:
+ *	- zero if the CPU is in a safely parked state
+ *	- nonzero otherwise (e.g., timeout)
+ */
+int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster);
+
+/**
  * mcpm_cpu_suspend - bring the calling CPU in a suspended state
  *
  * @expected_residency: duration in microseconds the CPU is expected
@@ -126,6 +156,7 @@ int mcpm_cpu_powered_up(void);
 struct mcpm_platform_ops {
 	int (*power_up)(unsigned int cpu, unsigned int cluster);
 	void (*power_down)(void);
+	int (*power_down_finish)(unsigned int cpu, unsigned int cluster);
 	void (*suspend)(u64);
 	void (*powered_up)(void);
 };
-- 
1.7.9.5
