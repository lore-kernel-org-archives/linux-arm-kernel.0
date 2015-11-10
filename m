From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:54 +0000
Subject: [PATCH v2 6/7] xen/arm: introduce xen_read_wallclock
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-6-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read the wallclock from the shared info page at boot time.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v2:
- properly convert arch_timer ticker to nsec
- use timespec64 interfaces
- use sec_hi to get a 64-bit seconds value
---
 arch/arm/Kconfig         |    1 +
 arch/arm/xen/enlighten.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 60be104..a9de420 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1852,6 +1852,7 @@ config XEN
 	depends on CPU_V7 && !CPU_V6
 	depends on !GENERIC_ATOMIC64
 	depends on MMU
+	depends on HAVE_ARM_ARCH_TIMER
 	select ARCH_DMA_ADDR_T_64BIT
 	select ARM_PSCI
 	select SWIOTLB_XEN
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 2f57ba3..32675b5 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -28,6 +28,8 @@
 #include <linux/cpufreq.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/timekeeping.h>
+#include <clocksource/arm_arch_timer.h>
 
 #include <linux/mm.h>
 
@@ -95,6 +97,34 @@ static unsigned long long xen_stolen_accounting(int cpu)
 	return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
 }
 
+static void xen_read_wallclock(struct timespec64 *ts)
+{
+	u32 version;
+	u64 delta;
+	struct timespec64 now;
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
+	delta = arch_timer_read_counter() * (u64)NSEC_PER_SEC;
+	do_div(delta, arch_timer_get_rate());     /* time since system boot */
+	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+
+	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
+	now.tv_sec = delta;
+
+	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
+
+}
+
 static void xen_percpu_init(void)
 {
 	struct vcpu_register_vcpu_info info;
@@ -218,6 +248,7 @@ static int __init xen_guest_init(void)
 	struct shared_info *shared_info_page = NULL;
 	struct resource res;
 	phys_addr_t grant_frames;
+	struct timespec64 ts;
 
 	if (!xen_domain())
 		return 0;
@@ -291,6 +322,8 @@ static int __init xen_guest_init(void)
 
 	pv_time_ops.steal_clock = xen_stolen_accounting;
 	static_key_slow_inc(&paravirt_steal_enabled);
+	xen_read_wallclock(&ts);
+	do_settimeofday64(&ts);
 
 	return 0;
 }
-- 
1.7.10.4
