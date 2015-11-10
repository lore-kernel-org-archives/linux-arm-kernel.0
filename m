From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:52 +0000
Subject: [PATCH v2 4/7] xen: introduce XENPF_settime64
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the current XENPF_settime hypercall and related struct to
XENPF_settime32.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: konrad.wilk at oracle.com
CC: david.vrabel at citrix.com
CC: boris.ostrovsky at oracle.com
---
 arch/x86/xen/time.c              |    8 ++++----
 include/xen/interface/platform.h |   18 ++++++++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 663c2ea..3bbd377 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -134,10 +134,10 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
 	if (!was_set && timespec_compare(&now, &next_sync) < 0)
 		return NOTIFY_OK;
 
-	op.cmd = XENPF_settime;
-	op.u.settime.secs = now.tv_sec;
-	op.u.settime.nsecs = now.tv_nsec;
-	op.u.settime.system_time = xen_clocksource_read();
+	op.cmd = XENPF_settime32;
+	op.u.settime32.secs = now.tv_sec;
+	op.u.settime32.nsecs = now.tv_nsec;
+	op.u.settime32.system_time = xen_clocksource_read();
 
 	(void)HYPERVISOR_platform_op(&op);
 
diff --git a/include/xen/interface/platform.h b/include/xen/interface/platform.h
index 8e03587..732efb0 100644
--- a/include/xen/interface/platform.h
+++ b/include/xen/interface/platform.h
@@ -35,14 +35,23 @@
  * Set clock such that it would read <secs,nsecs> after 00:00:00 UTC,
  * 1 January, 1970 if the current system time was <system_time>.
  */
-#define XENPF_settime             17
-struct xenpf_settime {
+#define XENPF_settime32             17
+struct xenpf_settime32 {
 	/* IN variables. */
 	uint32_t secs;
 	uint32_t nsecs;
 	uint64_t system_time;
 };
-DEFINE_GUEST_HANDLE_STRUCT(xenpf_settime_t);
+DEFINE_GUEST_HANDLE_STRUCT(xenpf_settime32_t);
+#define XENPF_settime64           62
+struct xenpf_settime64 {
+    /* IN variables. */
+    uint64_t secs;
+    uint32_t nsecs;
+    uint32_t mbz;
+    uint64_t system_time;
+};
+DEFINE_GUEST_HANDLE_STRUCT(xenpf_settime64_t);
 
 /*
  * Request memory range (@mfn, @mfn+ at nr_mfns-1) to have type @type.
@@ -495,7 +504,8 @@ struct xen_platform_op {
 	uint32_t cmd;
 	uint32_t interface_version; /* XENPF_INTERFACE_VERSION */
 	union {
-		struct xenpf_settime           settime;
+		struct xenpf_settime32         settime32;
+		struct xenpf_settime64         settime64;
 		struct xenpf_add_memtype       add_memtype;
 		struct xenpf_del_memtype       del_memtype;
 		struct xenpf_read_memtype      read_memtype;
-- 
1.7.10.4
