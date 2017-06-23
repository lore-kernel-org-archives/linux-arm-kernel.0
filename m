From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:26 -0700
Subject: [PATCH v2 6/7] ARM: B15: Register reboot notifier for KEXEC
In-Reply-To: <20170623175227.19743-1-f.fainelli@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
Message-ID: <20170623175227.19743-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During kexec, we will go through kernel_kexec() -> syscore_suspend() if
CONFIG_KEXEC_JUMP is set, if not, down the road we end-up calling
kernel_restart_prepare() which invokes reboot notifiers with
SYS_RESTART.

We register a reboot notifier to make sure that the B15 read-ahead cache
is disabled, since it is another level of instruction and data cache,
and we want to avoid any potential side effects with booting a new
kernel with such a cache still turned on.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-b15-rac.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 9ee1d89cced0..f76988790011 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/syscore_ops.h>
+#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-b15-rac.h>
@@ -151,6 +152,29 @@ static void b15_rac_enable(void)
 	__b15_rac_enable(enable);
 }
 
+static int b15_rac_reboot_notifier(struct notifier_block *nb,
+				   unsigned long action,
+				   void *data)
+{
+	/* During kexec, we are not yet migrated on the boot CPU, so we need to
+	 * make sure we are SMP safe here. Once the RAC is disabled, flag it as
+	 * suspended such that the hotplug notifier returns early.
+	 */
+	if (action == SYS_RESTART) {
+		spin_lock(&rac_lock);
+		b15_rac_disable_and_flush();
+		clear_bit(RAC_ENABLED, &b15_rac_flags);
+		set_bit(RAC_SUSPENDED, &b15_rac_flags);
+		spin_unlock(&rac_lock);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block b15_rac_reboot_nb = {
+	.notifier_call	= b15_rac_reboot_notifier,
+};
+
 #ifdef CONFIG_HOTPLUG_CPU
 /* The CPU hotplug case is the most interesting one, we basically need to make
  * sure that the RAC is disabled for the entire system prior to having a CPU
@@ -191,6 +215,12 @@ static void b15_rac_enable(void)
 /* Running on the dying CPU */
 static int b15_rac_dying_cpu(unsigned int cpu)
 {
+	/* During kexec/reboot, the RAC is disabled via the reboot notifier
+	 * return early here.
+	 */
+	if (test_bit(RAC_SUSPENDED, &b15_rac_flags))
+		return 0;
+
 	spin_lock(&rac_lock);
 
 	/* Indicate that we are starting a hotplug procedure */
@@ -207,6 +237,12 @@ static int b15_rac_dying_cpu(unsigned int cpu)
 /* Running on a non-dying CPU */
 static int b15_rac_dead_cpu(unsigned int cpu)
 {
+	/* During kexec/reboot, the RAC is disabled via the reboot notifier
+	 * return early here.
+	 */
+	if (test_bit(RAC_SUSPENDED, &b15_rac_flags))
+		return 0;
+
 	spin_lock(&rac_lock);
 
 	/* And enable it */
@@ -272,6 +308,13 @@ static int __init b15_rac_init(void)
 		goto out;
 	}
 
+	ret = register_reboot_notifier(&b15_rac_reboot_nb);
+	if (ret) {
+		pr_err("failed to register reboot notifier\n");
+		iounmap(b15_rac_base);
+		goto out;
+	}
+
 #ifdef CONFIG_HOTPLUG_CPU
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 					"arm/cache-b15-rac:dead",
@@ -308,6 +351,7 @@ static int __init b15_rac_init(void)
 out_cpu_dead:
 	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CACHE_B15_RAC_DYING);
 out_unmap:
+	unregister_reboot_notifier(&b15_rac_reboot_nb);
 	iounmap(b15_rac_base);
 out:
 	of_node_put(dn);
-- 
2.9.3
