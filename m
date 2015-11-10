From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:55 +0000
Subject: [PATCH v2 7/7] xen/arm: set the system time in Xen via the
 XENPF_settime64 hypercall
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-7-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If Linux is running as dom0, call XENPF_settime64 to update the system
time in Xen on pvclock_gtod notifications.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v2:
- properly convert arch_timer ticker to nsec
- rename dom0_op to platform_op
- use timespec64 interfaces
- use XENPF_settime64
---
 arch/arm/xen/enlighten.c |   54 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 32675b5..a991b25 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/pvclock_gtod.h>
 #include <linux/timekeeping.h>
 #include <clocksource/arm_arch_timer.h>
 
@@ -125,6 +126,52 @@ static void xen_read_wallclock(struct timespec64 *ts)
 
 }
 
+static int xen_pvclock_gtod_notify(struct notifier_block *nb,
+				   unsigned long was_set, void *priv)
+{
+	/* Protected by the calling core code serialization */
+	static struct timespec64 next_sync;
+
+	struct xen_platform_op op;
+	struct timespec64 now;
+
+	now = __current_kernel_time64();
+
+	/*
+	 * We only take the expensive HV call when the clock was set
+	 * or when the 11 minutes RTC synchronization time elapsed.
+	 */
+	if (!was_set && timespec64_compare(&now, &next_sync) < 0)
+		return NOTIFY_OK;
+
+	op.interface_version = XENPF_INTERFACE_VERSION;
+	op.cmd = XENPF_settime64;
+	op.u.settime64.mbz = 0;
+	op.u.settime64.secs = now.tv_sec;
+	op.u.settime64.nsecs = now.tv_nsec;
+	op.u.settime64.system_time = arch_timer_read_counter() * (u64)NSEC_PER_SEC;
+	do_div(op.u.settime64.system_time, arch_timer_get_rate());
+	printk("GTOD: Setting to %llu.%u@%llu\n",
+	       op.u.settime64.secs,
+	       op.u.settime64.nsecs,
+	       op.u.settime64.system_time);
+	(void)HYPERVISOR_platform_op(&op);
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
@@ -323,7 +370,12 @@ static int __init xen_guest_init(void)
 	pv_time_ops.steal_clock = xen_stolen_accounting;
 	static_key_slow_inc(&paravirt_steal_enabled);
 	xen_read_wallclock(&ts);
-	do_settimeofday64(&ts);
+	if (xen_initial_domain())
+		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
+	else {
+		xen_read_wallclock(&ts);
+		do_settimeofday64(&ts);
+	}
 
 	return 0;
 }
-- 
1.7.10.4
