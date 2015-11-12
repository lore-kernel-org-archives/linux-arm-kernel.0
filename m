From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 12 Nov 2015 17:30:46 +0000
Subject: [PATCH v4 5/7] xen/arm: introduce xen_read_wallclock
In-Reply-To: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
Message-ID: <1447349448-22610-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read the wallclock from the shared info page at boot time.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v4:
- simplify xen_read_wallclock

Changes in v3:
- use ktime_get_ns instead of calling into the arch_timer functions
  directly
- read the wallclock from the late_initcall

Changes in v2:
- properly convert arch_timer ticker to nsec
- use timespec64 interfaces
- use sec_hi to get a 64-bit seconds value
---
 arch/arm/xen/enlighten.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 2f57ba3..6ae4ef5 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/timekeeping.h>
 
 #include <linux/mm.h>
 
@@ -95,6 +96,27 @@ static unsigned long long xen_stolen_accounting(int cpu)
 	return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
 }
 
+static void xen_read_wallclock(struct timespec64 *ts)
+{
+	u32 version;
+	struct timespec64 now, ts_monotonic;
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct pvclock_wall_clock *wall_clock = &(s->wc);
+
+	/* get wallclock at system boot */
+	do {
+		version = wall_clock->version;
+		rmb();		/* fetch version before time */
+		now.tv_sec  = ((uint64_t)wall_clock->sec_hi << 32) | wall_clock->sec;
+		now.tv_nsec = wall_clock->nsec;
+		rmb();		/* fetch time before checking version */
+	} while ((wall_clock->version & 1) || (version != wall_clock->version));
+
+	/* time since system boot */
+	ktime_get_ts64(&ts_monotonic);
+	*ts = timespec64_add(now, ts_monotonic);
+}
+
 static void xen_percpu_init(void)
 {
 	struct vcpu_register_vcpu_info info;
@@ -303,6 +325,11 @@ static int __init xen_pm_init(void)
 
 	pm_power_off = xen_power_off;
 	arm_pm_restart = xen_restart;
+	if (!xen_initial_domain()) {
+		struct timespec64 ts;
+		xen_read_wallclock(&ts);
+		do_settimeofday64(&ts);
+	}
 
 	return 0;
 }
-- 
1.7.10.4
