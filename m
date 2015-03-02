From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:51 +0800
Subject: [RFC PATCH v4 13/34] early kprobes: alloc optimized kprobe before
 memory system is ready.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-14-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create static slots of 'struct optimized_kprobe', alloc such structure
from the slots for early kprobes. This patch is for optimization for
early kprobes.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1eb3000..ab3640b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -362,6 +362,7 @@ static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
 }
 
 #ifdef CONFIG_OPTPROBES
+DEFINE_EKPROBE_ALLOC_OPS(struct optimized_kprobe, early_aggr_kprobe, static)
 /* NOTE: change this value only with kprobe_mutex held */
 static bool kprobes_allow_optimization;
 
@@ -391,7 +392,8 @@ static void free_aggr_kprobe(struct kprobe *p)
 	op = container_of(p, struct optimized_kprobe, kp);
 	arch_remove_optimized_kprobe(op);
 	arch_remove_kprobe(p);
-	kfree(op);
+	if (likely(!ek_free_early_aggr_kprobe(op)))
+		kfree(op);
 }
 
 /* Return true(!0) if the kprobe is ready for optimization. */
@@ -746,7 +748,11 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
-	op = kzalloc(sizeof(struct optimized_kprobe), GFP_KERNEL);
+	if (unlikely(kprobes_is_early()))
+		op = ek_alloc_early_aggr_kprobe();
+	else
+		op = kzalloc(sizeof(struct optimized_kprobe), GFP_KERNEL);
+
 	if (!op)
 		return NULL;
 
@@ -784,7 +790,8 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 	if (!arch_prepared_optinsn(&op->optinsn)) {
 		/* If failed to setup optimizing, fallback to kprobe */
 		arch_remove_optimized_kprobe(op);
-		kfree(op);
+		if (likely(!ek_free_early_aggr_kprobe(op)))
+			kfree(op);
 		goto out;
 	}
 
@@ -914,6 +921,7 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 #define __disarm_kprobe(p, o)			arch_disarm_kprobe(p)
 #define kprobe_disarmed(p)			kprobe_disabled(p)
 #define wait_for_kprobe_optimizer()		do {} while (0)
+DEFINE_EKPROBE_ALLOC_OPS(struct kprobe, early_aggr_kprobe, static)
 
 /* There should be no unused kprobes can be reused without optimization */
 static void reuse_unused_kprobe(struct kprobe *ap)
@@ -925,11 +933,14 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 static void free_aggr_kprobe(struct kprobe *p)
 {
 	arch_remove_kprobe(p);
-	kfree(p);
+	if (likely(!ek_free_early_aggr_kprobe(p)))
+		kfree(p);
 }
 
 static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 {
+	if (unlikely(kprobes_is_early()))
+		return ek_alloc_early_aggr_kprobe();
 	return kzalloc(sizeof(struct kprobe), GFP_KERNEL);
 }
 #endif /* CONFIG_OPTPROBES */
-- 
1.8.4
