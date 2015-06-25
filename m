From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Jun 2015 01:33:36 +0200
Subject: [PATCH] ARM64: kernel: psci: use restart_handlers instead of
 arm_pm_restart
Message-ID: <1622532.VhvqsHJ0rH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hogging the arm_pm_restart callback, register a restart_handler
to make it possible for machines to register more board-specific
restart functionality.

The priority is set to 127, 1 below the "default" to facilitate for
example the use of regular per-soc restart handlers at their default
priority 128 and others like the gpio-restart at priority 129 or above.

Non-psci restarts can be necessary when either the psci implementation
is faulty and does not implement the restart callback or devices need
even more custom restart operations, like recent rk3288-chromebooks.
While the soc-level restart could restart those, an external component
needed to be also reset (via gpio-restart) to allow the device to even
boot again.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/kernel/psci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 869f202..2e0b1e9 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -252,11 +252,18 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block psci_restart_handler = {
+	.notifier_call = psci_sys_reset,
+	.priority = 127,
+};
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -321,7 +328,7 @@ static void __init psci_0_2_set_functions(void)
 
 	psci_ops.migrate_info_type = psci_migrate_info_type;
 
-	arm_pm_restart = psci_sys_reset;
+	register_restart_handler(&psci_restart_handler);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.1.4
