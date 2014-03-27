From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 27 Mar 2014 11:38:35 -0400
Subject: [PATCH v2 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1395934715-31348-3-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCIv0.2 adds a new function called AFFINITY_INFO, which
can be used to query if a specified CPU has actually gone
offline. Calling this function via cpu_kill ensures that
a CPU has quiesced after a call to cpu_die.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 arch/arm/kernel/psci_smp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 570a48c..2407843 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -66,6 +66,24 @@ void __ref psci_cpu_die(unsigned int cpu)
        /* We should never return */
        panic("psci: cpu %d failed to shutdown\n", cpu);
 }
+
+int __ref psci_cpu_kill(unsigned int cpu)
+{
+	int err = 0;
+
+	if (psci_ops.affinity_info) {
+		err = psci_ops.affinity_info(cpu, 0);
+
+		if (err != 1) {
+			pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
+					cpu, err);
+			/* Make platform_cpu_kill() fail. */
+			return 0;
+		}
+	}
+	return err;
+}
+
 #endif
 
 bool __init psci_smp_available(void)
@@ -78,5 +96,6 @@ struct smp_operations __initdata psci_smp_ops = {
 	.smp_boot_secondary	= psci_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= psci_cpu_die,
+	.cpu_kill		= psci_cpu_kill,
 #endif
 };
-- 
1.8.3.2
