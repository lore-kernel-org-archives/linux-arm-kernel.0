From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jan 2017 12:05:08 +0100
Subject: [PATCH 2/6] ARM: xen: Register with kernel restart handler
In-Reply-To: <20170130110512.6943-1-thierry.reding@gmail.com>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
Message-ID: <20170130110512.6943-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guenter Roeck <linux@roeck-us.net>

Register with kernel restart handler instead of setting arm_pm_restart
directly.

Select a high priority of 192 to ensure that default restart handlers
are replaced if Xen is running.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/xen/enlighten.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 11d9f2898b16..85d678e1d826 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -29,6 +29,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/pvclock_gtod.h>
+#include <linux/reboot.h>
 #include <linux/time64.h>
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
@@ -191,14 +192,22 @@ static int xen_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
+static int xen_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
 {
 	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
 	int rc;
 	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
 	BUG_ON(rc);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xen_restart_nb = {
+	.notifier_call = xen_restart,
+	.priority = 192,
+};
+
 static void xen_power_off(void)
 {
 	struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
@@ -423,7 +432,7 @@ static int __init xen_pm_init(void)
 		return -ENODEV;
 
 	pm_power_off = xen_power_off;
-	arm_pm_restart = xen_restart;
+	register_restart_handler(&xen_restart_nb);
 	if (!xen_initial_domain()) {
 		struct timespec64 ts;
 		xen_read_wallclock(&ts);
-- 
2.11.0
