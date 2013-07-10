From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Jul 2013 23:16:00 +0100
Subject: [RFC PATCH 5/5] arm64: add PSCI CPU_OFF-based hotplug support
In-Reply-To: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1373494560-25011-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for using PSCI CPU_OFF calls for CPU hotplug.
With this code it is possible to hot unplug CPUs with "psci" as their
boot-method, as long as there's an appropriate cpu_off function id
specified in the psci node.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/smp_psci.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kernel/smp_psci.c b/arch/arm64/kernel/smp_psci.c
index 24dbad9..d536f3e 100644
--- a/arch/arm64/kernel/smp_psci.c
+++ b/arch/arm64/kernel/smp_psci.c
@@ -47,9 +47,39 @@ static int __cpuinit smp_psci_cpu_boot(unsigned int cpu)
 	return err;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int __cpuinit smp_psci_cpu_disable(unsigned int cpu)
+{
+	/* Fail early if we don't have CPU_OFF support */
+	if (!psci_ops.cpu_off)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void __cpuinit smp_psci_cpu_die(unsigned int cpu)
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
+	pr_warn("psci: unable to power off CPU%u (%d)", cpu, ret);
+}
+#endif
+
 const struct smp_operations smp_psci_ops __cpuinitconst = {
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
1.7.9.5
