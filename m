From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Nov 2015 15:34:52 +0000
Subject: [PATCH v11 1/5] xen: move xen_setup_runstate_info and
 get_runstate_snapshot to drivers/xen/time.c
In-Reply-To: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
Message-ID: <1446737696-9749-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: konrad.wilk at oracle.com

---

Changes in v10:
- rebase
---
 arch/x86/xen/time.c   |   76 +----------------------------------------
 drivers/xen/Makefile  |    2 +-
 drivers/xen/time.c    |   91 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h |    5 +++
 4 files changed, 98 insertions(+), 76 deletions(-)
 create mode 100644 drivers/xen/time.c

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index f1ba6a0..041d4cd 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -32,86 +32,12 @@
 #define TIMER_SLOP	100000
 #define NS_PER_TICK	(1000000000LL / HZ)
 
-/* runstate info updated by Xen */
-static DEFINE_PER_CPU(struct vcpu_runstate_info, xen_runstate);
-
 /* snapshots of runstate info */
 static DEFINE_PER_CPU(struct vcpu_runstate_info, xen_runstate_snapshot);
 
 /* unused ns of stolen time */
 static DEFINE_PER_CPU(u64, xen_residual_stolen);
 
-/* return an consistent snapshot of 64-bit time/counter value */
-static u64 get64(const u64 *p)
-{
-	u64 ret;
-
-	if (BITS_PER_LONG < 64) {
-		u32 *p32 = (u32 *)p;
-		u32 h, l;
-
-		/*
-		 * Read high then low, and then make sure high is
-		 * still the same; this will only loop if low wraps
-		 * and carries into high.
-		 * XXX some clean way to make this endian-proof?
-		 */
-		do {
-			h = p32[1];
-			barrier();
-			l = p32[0];
-			barrier();
-		} while (p32[1] != h);
-
-		ret = (((u64)h) << 32) | l;
-	} else
-		ret = *p;
-
-	return ret;
-}
-
-/*
- * Runstate accounting
- */
-static void get_runstate_snapshot(struct vcpu_runstate_info *res)
-{
-	u64 state_time;
-	struct vcpu_runstate_info *state;
-
-	BUG_ON(preemptible());
-
-	state = this_cpu_ptr(&xen_runstate);
-
-	/*
-	 * The runstate info is always updated by the hypervisor on
-	 * the current CPU, so there's no need to use anything
-	 * stronger than a compiler barrier when fetching it.
-	 */
-	do {
-		state_time = get64(&state->state_entry_time);
-		barrier();
-		*res = *state;
-		barrier();
-	} while (get64(&state->state_entry_time) != state_time);
-}
-
-/* return true when a vcpu could run but has no real cpu to run on */
-bool xen_vcpu_stolen(int vcpu)
-{
-	return per_cpu(xen_runstate, vcpu).state == RUNSTATE_runnable;
-}
-
-void xen_setup_runstate_info(int cpu)
-{
-	struct vcpu_register_runstate_memory_area area;
-
-	area.addr.v = &per_cpu(xen_runstate, cpu);
-
-	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
-			       cpu, &area))
-		BUG();
-}
-
 static void do_stolen_accounting(void)
 {
 	struct vcpu_runstate_info state;
@@ -119,7 +45,7 @@ static void do_stolen_accounting(void)
 	s64 runnable, offline, stolen;
 	cputime_t ticks;
 
-	get_runstate_snapshot(&state);
+	xen_get_runstate_snapshot(&state);
 
 	WARN_ON(state.state != RUNSTATE_running);
 
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index aa8a7f7..9b7a35c 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-$(CONFIG_X86)			+= fallback.o
-obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o
+obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= events/
 obj-y	+= xenbus/
 
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
new file mode 100644
index 0000000..433fe24
--- /dev/null
+++ b/drivers/xen/time.c
@@ -0,0 +1,91 @@
+/*
+ * Xen stolen ticks accounting.
+ */
+#include <linux/kernel.h>
+#include <linux/kernel_stat.h>
+#include <linux/math64.h>
+#include <linux/gfp.h>
+
+#include <asm/xen/hypervisor.h>
+#include <asm/xen/hypercall.h>
+
+#include <xen/events.h>
+#include <xen/features.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
+#include <xen/xen-ops.h>
+
+/* runstate info updated by Xen */
+static DEFINE_PER_CPU(struct vcpu_runstate_info, xen_runstate);
+
+/* return an consistent snapshot of 64-bit time/counter value */
+static u64 get64(const u64 *p)
+{
+	u64 ret;
+
+	if (BITS_PER_LONG < 64) {
+		u32 *p32 = (u32 *)p;
+		u32 h, l;
+
+		/*
+		 * Read high then low, and then make sure high is
+		 * still the same; this will only loop if low wraps
+		 * and carries into high.
+		 * XXX some clean way to make this endian-proof?
+		 */
+		do {
+			h = p32[1];
+			barrier();
+			l = p32[0];
+			barrier();
+		} while (p32[1] != h);
+
+		ret = (((u64)h) << 32) | l;
+	} else
+		ret = *p;
+
+	return ret;
+}
+
+/*
+ * Runstate accounting
+ */
+void xen_get_runstate_snapshot(struct vcpu_runstate_info *res)
+{
+	u64 state_time;
+	struct vcpu_runstate_info *state;
+
+	BUG_ON(preemptible());
+
+	state = this_cpu_ptr(&xen_runstate);
+
+	/*
+	 * The runstate info is always updated by the hypervisor on
+	 * the current CPU, so there's no need to use anything
+	 * stronger than a compiler barrier when fetching it.
+	 */
+	do {
+		state_time = get64(&state->state_entry_time);
+		barrier();
+		*res = *state;
+		barrier();
+	} while (get64(&state->state_entry_time) != state_time);
+}
+
+/* return true when a vcpu could run but has no real cpu to run on */
+bool xen_vcpu_stolen(int vcpu)
+{
+	return per_cpu(xen_runstate, vcpu).state == RUNSTATE_runnable;
+}
+
+void xen_setup_runstate_info(int cpu)
+{
+	struct vcpu_register_runstate_memory_area area;
+
+	area.addr.v = &per_cpu(xen_runstate, cpu);
+
+	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
+			       cpu, &area))
+		BUG();
+}
+
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index e4e214a..86abe07 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -5,6 +5,7 @@
 #include <linux/notifier.h>
 #include <linux/efi.h>
 #include <asm/xen/interface.h>
+#include <xen/interface/vcpu.h>
 
 DECLARE_PER_CPU(struct vcpu_info *, xen_vcpu);
 
@@ -18,6 +19,10 @@ void xen_arch_suspend(void);
 void xen_resume_notifier_register(struct notifier_block *nb);
 void xen_resume_notifier_unregister(struct notifier_block *nb);
 
+bool xen_vcpu_stolen(int vcpu);
+void xen_setup_runstate_info(int cpu);
+void xen_get_runstate_snapshot(struct vcpu_runstate_info *res);
+
 int xen_setup_shutdown_event(void);
 
 extern unsigned long *xen_contiguous_bitmap;
-- 
1.7.10.4
