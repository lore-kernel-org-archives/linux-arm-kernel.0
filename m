From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 17 Apr 2014 15:15:46 -0400
Subject: [PATCH v6 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1397762146-8337-4-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCIv0.2 adds a new function called AFFINITY_INFO, which
can be used to query if a specified CPU has actually gone
offline. Calling this function via cpu_kill ensures that
a CPU has quiesced after a call to cpu_die.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/psci_smp.c | 21 +++++++++++++++++++++
 include/uapi/linux/psci.h  |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 570a48c..c6f1420 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/of.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
@@ -66,6 +67,25 @@ void __ref psci_cpu_die(unsigned int cpu)
        /* We should never return */
        panic("psci: cpu %d failed to shutdown\n", cpu);
 }
+
+int __ref psci_cpu_kill(unsigned int cpu)
+{
+	int err;
+
+	if (!psci_ops.affinity_info)
+		return 1;
+
+	err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
+
+	if (err != PSCI_AFFINITY_INFO_RET_OFF) {
+		pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
+				cpu, err);
+		/* Make platform_cpu_kill() fail. */
+		return 0;
+	}
+	return 1;
+}
+
 #endif
 
 bool __init psci_smp_available(void)
@@ -78,5 +98,6 @@ struct smp_operations __initdata psci_smp_ops = {
 	.smp_boot_secondary	= psci_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= psci_cpu_die,
+	.cpu_kill		= psci_cpu_kill,
 #endif
 };
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index a4136c3..857209b 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -74,4 +74,9 @@
 #define PSCI_RET_NOT_PRESENT			-7
 #define PSCI_RET_DISABLED			-8
 
+/* Return values from the PSCI_ID_AFFINITY_INFO Function. */
+#define PSCI_AFFINITY_INFO_RET_ON			0
+#define PSCI_AFFINITY_INFO_RET_OFF			1
+#define PSCI_AFFINITY_INFO_RET_ON_PENDING	2
+
 #endif /* _UAPI_LINUX_PSCI_H */
-- 
1.8.3.2
