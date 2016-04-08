From: linux@roeck-us.net (Guenter Roeck)
Date: Fri,  8 Apr 2016 05:53:57 -0700
Subject: [PATCH 4/6] ARM: Register with kernel restart handler
In-Reply-To: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
Message-ID: <1460120039-2497-5-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By making use of the kernel restart handler, board specific restart
handlers can be prioritized amongst available mechanisms for a particular
board or system.

Select the default priority of 128 to indicate that the restart callback
in the machine description is the default restart mechanism.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/setup.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 139791ed473d..232dba199702 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1002,6 +1002,20 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+
+static int arm_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	__arm_pm_restart(action, data);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block arm_restart_nb = {
+	.notifier_call = arm_restart,
+	.priority = 128,
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
@@ -1044,8 +1058,10 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(mdesc);
 
-	if (mdesc->restart)
-		arm_pm_restart = mdesc->restart;
+	if (mdesc->restart) {
+		__arm_pm_restart = mdesc->restart;
+		register_restart_handler(&arm_restart_nb);
+	}
 
 	unflatten_device_tree();
 
-- 
2.5.0
