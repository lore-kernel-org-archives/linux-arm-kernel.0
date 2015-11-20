From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:17:44 +0000
Subject: [PATCH v5 7/7] xen/x86: support XENPF_settime64
In-Reply-To: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
Message-ID: <1448029064-22285-7-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try XENPF_settime64 first, if it is not available fall back to
XENPF_settime32.

No need to call __current_kernel_time() when all the info needed are
already passed via the struct timekeeper * argument.

Return NOTIFY_BAD in case of errors.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
CC: konrad.wilk at oracle.com
CC: david.vrabel at citrix.com
CC: boris.ostrovsky at oracle.com
---
 arch/x86/xen/time.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 3bbd377..4b8af45 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/pvclock_gtod.h>
+#include <linux/timekeeper_internal.h>
 
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
@@ -123,9 +124,13 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
 	static struct timespec next_sync;
 
 	struct xen_platform_op op;
-	struct timespec now;
+	struct timespec64 now;
+	struct timekeeper *tk = priv;
+	static bool settime64_supported = true;
+	int ret;
 
-	now = __current_kernel_time();
+	now.tv_sec = tk->xtime_sec;
+	now.tv_nsec = (long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
 
 	/*
 	 * We only take the expensive HV call when the clock was set
@@ -134,12 +139,28 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
 	if (!was_set && timespec_compare(&now, &next_sync) < 0)
 		return NOTIFY_OK;
 
-	op.cmd = XENPF_settime32;
-	op.u.settime32.secs = now.tv_sec;
-	op.u.settime32.nsecs = now.tv_nsec;
-	op.u.settime32.system_time = xen_clocksource_read();
+again:
+	if (settime64_supported) {
+		op.cmd = XENPF_settime64;
+		op.u.settime64.mbz = 0;
+		op.u.settime64.secs = now.tv_sec;
+		op.u.settime64.nsecs = now.tv_nsec;
+		op.u.settime64.system_time = xen_clocksource_read();
+	} else {
+		op.cmd = XENPF_settime32;
+		op.u.settime32.secs = now.tv_sec;
+		op.u.settime32.nsecs = now.tv_nsec;
+		op.u.settime32.system_time = xen_clocksource_read();
+	}
+
+	ret = HYPERVISOR_platform_op(&op);
 
-	(void)HYPERVISOR_platform_op(&op);
+	if (ret == -ENOSYS && settime64_supported) {
+		settime64_supported = false;
+		goto again;
+	}
+	if (ret < 0)
+		return NOTIFY_BAD;
 
 	/*
 	 * Move the next drift compensation time 11 minutes
-- 
1.7.10.4
