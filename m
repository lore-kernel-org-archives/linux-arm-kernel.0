From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Wed,  7 May 2014 10:27:27 -0400
Subject: [PATCH v9 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1399472847-14377-4-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCIv0.2 adds a new function called AFFINITY_INFO, which
can be used to query if a specified CPU has actually gone
offline. Calling this function via cpu_kill ensures that
a CPU has quiesced after a call to cpu_die.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/psci_smp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 570a48c..502e6cf 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/of.h>
+#include <linux/delay.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
@@ -66,6 +68,34 @@ void __ref psci_cpu_die(unsigned int cpu)
        /* We should never return */
        panic("psci: cpu %d failed to shutdown\n", cpu);
 }
+
+int __ref psci_cpu_kill(unsigned int cpu)
+{
+	int err, i;
+
+	if (!psci_ops.affinity_info)
+		return 1;
+	/*
+	 * cpu_kill could race with cpu_die and we can
+	 * potentially end up declaring this cpu undead
+	 * while it is dying. So, try again a few times.
+	 */
+
+	for (i=0; i<10; i++) {
+		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
+		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF)
+			return 1;
+
+		msleep(10);
+		pr_info("Retrying again to check for CPU kill\n");
+	}
+
+	pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
+			cpu, err);
+	/* Make platform_cpu_kill() fail. */
+	return 0;
+}
+
 #endif
 
 bool __init psci_smp_available(void)
@@ -78,5 +108,6 @@ struct smp_operations __initdata psci_smp_ops = {
 	.smp_boot_secondary	= psci_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= psci_cpu_die,
+	.cpu_kill		= psci_cpu_kill,
 #endif
 };
-- 
1.8.3.2
