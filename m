From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Nov 2015 17:09:45 +0000
Subject: [PATCH 3/3] xen/arm: set the system time in Xen via the XENPF_settime
 hypercall
In-Reply-To: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
Message-ID: <1446743385-12848-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If Linux is running as dom0, call XENPF_settime to update the system
time in Xen on pvclock_gtod notifications.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
---
 arch/arm/xen/enlighten.c |   52 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index b6aea9c..0176db0 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/pvclock_gtod.h>
 #include <linux/timekeeping.h>
 #include <clocksource/arm_arch_timer.h>
 
@@ -123,6 +124,50 @@ static void xen_read_wallclock(struct timespec *ts)
 	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
 }
 
+static int xen_pvclock_gtod_notify(struct notifier_block *nb,
+				   unsigned long was_set, void *priv)
+{
+	/* Protected by the calling core code serialization */
+	static struct timespec next_sync;
+
+	struct xen_platform_op op;
+	struct timespec now;
+
+	now = __current_kernel_time();
+
+	/*
+	 * We only take the expensive HV call when the clock was set
+	 * or when the 11 minutes RTC synchronization time elapsed.
+	 */
+	if (!was_set && timespec_compare(&now, &next_sync) < 0)
+		return NOTIFY_OK;
+
+	op.interface_version = XENPF_INTERFACE_VERSION;
+	op.cmd = XENPF_settime;
+	op.u.settime.secs = now.tv_sec;
+	op.u.settime.nsecs = now.tv_nsec;
+	op.u.settime.system_time = arch_timer_read_counter();
+	printk("GTOD: Setting to %ld.%ld@%lld\n",
+	       (long)op.u.settime.secs,
+	       (long)op.u.settime.nsecs,
+	       (long long)op.u.settime.system_time);
+	(void)HYPERVISOR_dom0_op(&op);
+
+	/*
+	 * Move the next drift compensation time 11 minutes
+	 * ahead. That's emulating the sync_cmos_clock() update for
+	 * the hardware RTC.
+	 */
+	next_sync = now;
+	next_sync.tv_sec += 11 * 60;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block xen_pvclock_gtod_notifier = {
+	.notifier_call = xen_pvclock_gtod_notify,
+};
+
 static void xen_percpu_init(void)
 {
 	struct vcpu_register_vcpu_info info;
@@ -321,7 +366,12 @@ static int __init xen_guest_init(void)
 	pv_time_ops.steal_clock = xen_stolen_accounting;
 	static_key_slow_inc(&paravirt_steal_enabled);
 	xen_read_wallclock(&ts);
-	do_settimeofday(&ts);
+	if (xen_initial_domain())
+		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
+	else {
+		xen_read_wallclock(&ts);
+		do_settimeofday(&ts);
+	}
 
 	return 0;
 }
-- 
1.7.10.4
