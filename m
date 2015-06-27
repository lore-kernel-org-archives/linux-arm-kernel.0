From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Jun 2015 21:02:28 -0600
Subject: [PATCH RFC v2 08/16] arm: domain: Handle CPU online reference counting
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1435374156-19214-9-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the CPU device usage count is incremented for a CPU that
just came online. CPUs coming online do not follow the same code path as
CPUs warm booting back to CPUIdle. Register for hotplug notifier and
ensure the reference count is incremented correctly.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 59b0180..680c3fb 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -41,10 +41,49 @@ static void run_cpu(void *unused)
 	pm_runtime_get_noresume(cpu_dev);
 }
 
+static int cpu_online_notifier(struct notifier_block *n,
+		unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long)hcpu;
+	struct device *dev = get_cpu_device(cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		/*
+		 * Attach the cpu to its domain if the cpu is coming up
+		 * for the first time.
+		 * Called from the cpu that is coming up.
+		 */
+		pm_runtime_set_active(dev);
+		pm_runtime_get_noresume(dev);
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hotplug_notifier = {
+	.notifier_call = cpu_online_notifier,
+};
+
 static int arm_domain_cpu_init(void)
 {
 	int cpuid, ret = 0;
 
+	/*
+	 * Register for hotplug notifier, because not all CPUs
+	 * may be online at this time. Also, hotplug entry path is not
+	 * the same as warm boot. So the reference counting would have
+	 * to be adjusted here accordingly.
+	 * Register early, incase, a core comes online,
+	 * while we are executing this.
+	 */
+	register_cpu_notifier(&hotplug_notifier);
+
 	/* Find any CPU nodes with a phandle to this power domain */
 	for_each_possible_cpu(cpuid) {
 		struct device *cpu_dev;
-- 
2.1.4
