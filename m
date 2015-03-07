From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  6 Mar 2015 16:54:52 -0800
Subject: [PATCH 4/5] ARM: B15: Add CPU hotplug awareness
In-Reply-To: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1425689693-31034-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Brahma-B15 readahead cache needs to be disabled,
respectively re-enable during a CPU hotplug. In case we were not to do,
CPU hotplug would occasionally fail with random crashes when a given CPU
exits the coherency domain while the RAC is still enabled, as it would
get stale data from the RAC.

In order to avoid adding any specific B15 readahead-cache awareness to
arch/arm/mach-bcm/hotplug-brcmstb.c we use a CPU notifier which allows
us to catch CPU hotplug events and disable/flush enable the RAC
accordingly.

Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-b15-rac.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 1c5bca6e906b..73d29741f096 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/of_address.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-b15-rac.h>
@@ -44,6 +46,7 @@ extern void v7_flush_icache_all(void);
 
 static void __iomem *b15_rac_base;
 static DEFINE_SPINLOCK(rac_lock);
+static u32 rac_config0_reg;
 
 /* Initialization flag to avoid checking for b15_rac_base, and to prevent
  * multi-platform kernels from crashing here as well.
@@ -142,6 +145,94 @@ static void b15_rac_enable(void)
 	__b15_rac_enable(enable);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void b15_rac_hotplug_start(void)
+{
+	/* Indicate that we are starting a hotplug procedure */
+	clear_bit(RAC_ENABLED, &b15_rac_flags);
+
+	/* Disable the readahead cache and save its value to a global */
+	rac_config0_reg = b15_rac_disable_and_flush();
+}
+
+static void b15_rac_hotplug_end(void)
+{
+	/* And enable it */
+	__b15_rac_enable(rac_config0_reg);
+	set_bit(RAC_ENABLED, &b15_rac_flags);
+}
+
+/* The CPU hotplug case is the most interesting one, we basically need to make
+ * sure that the RAC is disabled for the entire system prior to having a CPU
+ * die, in particular prior to this dying CPU having exited the coherency
+ * domain.
+ *
+ * Once this CPU is marked dead, we can safely re-enable the RAC for the
+ * remaining CPUs in the system which are still online.
+ *
+ * Offlining a CPU is the problematic case, onlining a CPU is not much of an
+ * issue since the CPU and its cache-level hierarchy will start filling with
+ * the RAC disabled, so L1 and L2 only.
+ *
+ * In this function, we should NOT have to verify any unsafe setting/condition
+ * b15_rac_base:
+ *
+ *   It is protected by the RAC_ENABLED flag which is cleared by default, and
+ *   being cleared when initial procedure is done. b15_rac_base had been set at
+ *   that time.
+ *
+ * RAC_ENABLED:
+ *   There is a small timing windows, in b15_rac_init(), between
+ *      register_cpu_notifier(&b15_rac_cpu_nb);
+ *      ...
+ *      set RAC_ENABLED
+ *   However, there is no hotplug activity based on the Linux booting procedure.
+ *
+ * Regarding the notification actions, we will receive CPU_DOWN_PREPARE,
+ * CPU_DOWN_FAILED, CPU_DYING, CPU_DEAD, and CPU_POST_DEAD notification (see
+ * _cpu_down() for detail).
+ *
+ * Since we have to disable RAC for all cores, we keep RAC on as long as as
+ * possible (disable it as late as possible) to gain the cache benefit.
+ *
+ * Thus, CPU_DYING/CPU_DEAD pair are chosen.
+ *
+ * We are choosing not do disable the RAC on a per-CPU basis, here, if we did
+ * we would want to consider disabling it as early as possible to benefit the
+ * other active CPUs.
+ */
+static int b15_rac_cpu_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	action &= ~CPU_TASKS_FROZEN;
+
+	if (action != CPU_DYING && action != CPU_DOWN_FAILED &&
+	    action != CPU_DEAD)
+		return NOTIFY_OK;
+
+	spin_lock(&rac_lock);
+	switch (action) {
+	/* called on the dying CPU, exactly what we want */
+	case CPU_DYING:
+		b15_rac_hotplug_start();
+		break;
+
+	/* called on a non-dying CPU, what we want too */
+	case CPU_DOWN_FAILED:
+	case CPU_DEAD:
+		b15_rac_hotplug_end();
+		break;
+	}
+	spin_unlock(&rac_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block b15_rac_cpu_nb = {
+	.notifier_call	= b15_rac_cpu_notify,
+};
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __init b15_rac_init(void)
 {
 	struct device_node *dn;
@@ -161,6 +252,15 @@ static int __init b15_rac_init(void)
 		goto out;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	ret = register_cpu_notifier(&b15_rac_cpu_nb);
+	if (ret) {
+		pr_err("failed to register notifier block\n");
+		iounmap(b15_rac_base);
+		goto out;
+	}
+#endif
+
 	spin_lock(&rac_lock);
 	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
 	for_each_possible_cpu(cpu)
-- 
2.1.0
