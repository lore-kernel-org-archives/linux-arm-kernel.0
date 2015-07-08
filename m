From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 18:13:37 +0800
Subject: [PATCH 4/4] arm: psci: add cpuidle_ops support
In-Reply-To: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
References: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436350417-6712-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements cpuidle_ops using psci. After this patch, we can use
cpuidle-arm.c with psci backend for both arm and arm64.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/psci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
index 7f6ff02..c5b94f5 100644
--- a/arch/arm/kernel/psci.c
+++ b/arch/arm/kernel/psci.c
@@ -13,6 +13,7 @@
  * Author: Will Deacon <will.deacon@arm.com>
  */
 
+#include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/of.h>
@@ -21,6 +22,7 @@
 
 #include <uapi/linux/psci.h>
 
+#include <asm/cpuidle.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
 
@@ -47,6 +49,24 @@
  *
  */
 
+#ifdef CONFIG_CPU_IDLE
+static int psci_cpuidle_suspend(int cpu, unsigned long arg)
+{
+	return cpu_psci_cpu_suspend(arg);
+}
+
+static int psci_cpuidle_init(struct device_node *node, int cpu)
+{
+	return cpu_psci_cpu_init_idle(cpu);
+}
+
+static struct cpuidle_ops psci_cpuidle_ops __initdata = {
+	.suspend = psci_cpuidle_suspend,
+	.init = psci_cpuidle_init,
+};
+CPUIDLE_METHOD_OF_DECLARE(psci_idle, "psci", &psci_cpuidle_ops);
+#endif
+
 #ifdef CONFIG_SMP
 extern void secondary_startup(void);
 
-- 
2.1.4
