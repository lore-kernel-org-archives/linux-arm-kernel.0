From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 12:03:04 +0100
Subject: [PATCH v2 07/13] arm: kvm: implement CPU PM notifier
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1381748590-14279-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upon CPU shutdown and consequent warm-reboot, the hypervisor CPU state
must be re-initialized. This patch implements a CPU PM notifier that
upon warm-boot calls a KVM hook to reinitialize properly the hypervisor
state so that the CPU can be safely resumed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..8fc60da 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -839,6 +840,33 @@ static struct notifier_block hyp_init_cpu_nb = {
 	.notifier_call = hyp_init_cpu_notify,
 };
 
+#ifdef CONFIG_CPU_PM
+static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
+				    unsigned long cmd,
+				    void *v)
+{
+	if (cmd == CPU_PM_EXIT) {
+		cpu_init_hyp_mode(NULL);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hyp_init_cpu_pm_nb = {
+	.notifier_call = hyp_init_cpu_pm_notifier,
+};
+
+static void __init hyp_cpu_pm_init(void)
+{
+	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
+}
+#else
+static inline void hyp_cpu_pm_init(void)
+{
+}
+#endif
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
@@ -999,6 +1027,8 @@ int kvm_arch_init(void *opaque)
 		goto out_err;
 	}
 
+	hyp_cpu_pm_init();
+
 	kvm_coproc_table_init();
 	return 0;
 out_err:
-- 
1.8.4
