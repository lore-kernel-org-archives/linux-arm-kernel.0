From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Aug 2013 17:20:28 +0100
Subject: [PATCHv3 5/5] arm64: add PSCI CPU_OFF-based hotplug support
In-Reply-To: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1376497228-20543-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for using PSCI CPU_OFF calls for CPU hotplug.
With this code it is possible to hot unplug CPUs with "psci" as their
boot-method, as long as there's an appropriate cpu_off function id
specified in the psci node.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/smp_psci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kernel/smp_psci.c b/arch/arm64/kernel/smp_psci.c
index 20499bc..e9e5890 100644
--- a/arch/arm64/kernel/smp_psci.c
+++ b/arch/arm64/kernel/smp_psci.c
@@ -47,9 +47,39 @@ static int smp_psci_cpu_boot(unsigned int cpu)
 	return err;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int smp_psci_cpu_disable(unsigned int cpu)
+{
+	/* Fail early if we don't have CPU_OFF support */
+	if (!psci_ops.cpu_off)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void smp_psci_cpu_die(unsigned int cpu)
+{
+	int ret;
+	/*
+	 * There are no known implementations of PSCI actually using the
+	 * power state field, pass a sensible default for now.
+	 */
+	struct psci_power_state state = {
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+	};
+
+	ret = psci_ops.cpu_off(state);
+
+	pr_crit("psci: unable to power off CPU%u (%d)\n", cpu, ret);
+}
+#endif
+
 const struct smp_operations smp_psci_ops = {
 	.name		= "psci",
 	.cpu_init	= smp_psci_cpu_init,
 	.cpu_prepare	= smp_psci_cpu_prepare,
 	.cpu_boot	= smp_psci_cpu_boot,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= smp_psci_cpu_disable,
+	.cpu_die	= smp_psci_cpu_die,
+#endif
 };
-- 
1.8.1.1
