From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Apr 2016 19:42:34 -0700
Subject: [PATCH v2 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
References: <1460688157-6551-1-git-send-email-linux@roeck-us.net>
Message-ID: <1460688157-6551-4-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel restart handler instead of setting arm_pm_restart
directly. This enables support for replacing the PSCI restart handler
with a different handler if necessary for a specific board.

Select a priority of 129 to indicate a higher than default priority, but
keep it as low as possible since PSCI reset is known to fail on some
boards.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to v4.6-rc3, added Reviewed/by/Acked-by/Tested-by tags
    Variable name change: np -> nb

 drivers/firmware/psci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8b79a9..a0f71480f145 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -231,11 +231,18 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block psci_sys_reset_nb = {
+	.notifier_call = psci_sys_reset,
+	.priority = 129,
+};
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -461,7 +468,7 @@ static void __init psci_0_2_set_functions(void)
 
 	psci_ops.migrate_info_type = psci_migrate_info_type;
 
-	arm_pm_restart = psci_sys_reset;
+	register_restart_handler(&psci_sys_reset_nb);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.5.0
