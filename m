From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 12 Jan 2017 11:26:05 +0000
Subject: [RFC PATCH 06/10] arm64/sve: Disallow VL setting for individual
 threads by default
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

General-purpose code in userspace is not expected to work correctly
if multiple threads are allowed to run concurrently with different
vector lengths in a single process.

This patch adds an explicit flag PR_SVE_SET_VL_THREAD to request
this behaviour.  Without the flag, vector length setting is
permitted only for a single-threaded process (which matches the
expected usage model of setting the vector length at process
startup).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 12 +++++++++++-
 include/uapi/linux/prctl.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5f2c24a..32caca3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -21,6 +21,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/hardirq.h>
@@ -498,8 +499,17 @@ int sve_set_vector_length(struct task_struct *task,
 {
 	BUG_ON(task == current && preemptible());
 
+	/*
+	 * To avoid accidents, forbid setting for individual threads of a
+	 * multithreaded process.  User code that knows what it's doing can
+	 * pass PR_SVE_SET_VL_THREAD to override this restriction:
+	 */
+	if (!(flags & PR_SVE_SET_VL_THREAD) && get_nr_threads(task) != 1)
+		return -EINVAL;
+
+	flags &= ~(unsigned long)PR_SVE_SET_VL_THREAD;
 	if (flags)
-		return -EINVAL; /* No flags defined yet */
+		return -EINVAL; /* No other flags defined yet */
 
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index e32e2da..c55530b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -199,6 +199,7 @@ struct prctl_mm_map {
 
 /* arm64 Scalable Vector Extension controls */
 #define PR_SVE_SET_VL			48	/* set task vector length */
+# define PR_SVE_SET_VL_THREAD		(1 << 1) /* set just this thread */
 #define PR_SVE_GET_VL			49	/* get task vector length */
 
 #endif /* _LINUX_PRCTL_H */
-- 
2.1.4
