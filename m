From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 19 Nov 2014 14:50:43 +0800
Subject: [PATCH v9 1/2] kprobes: Pass the original kprobe for preparing
 optimized kprobe
In-Reply-To: <1416379844-25160-1-git-send-email-wangnan0@huawei.com>
References: <1416379844-25160-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1416379844-25160-2-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Pass the original kprobe for preparing an optimized kprobe arch-dep
part, since for some architecture (e.g. ARM32) requires the information
in original kprobe.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/kprobes/opt.c | 3 ++-
 include/linux/kprobes.h       | 3 ++-
 kernel/kprobes.c              | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index f1314d0..7028296 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -320,7 +320,8 @@ void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
  * Target instructions MUST be relocatable (checked inside)
  * This is called when new aggr(opt)probe is allocated or reused.
  */
-int arch_prepare_optimized_kprobe(struct optimized_kprobe *op)
+int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
+				  struct kprobe *__unused)
 {
 	u8 *buf;
 	int ret;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index f7296e5..7ab2c93 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -308,7 +308,8 @@ struct optimized_kprobe {
 /* Architecture dependent functions for direct jump optimization */
 extern int arch_prepared_optinsn(struct arch_optimized_insn *optinsn);
 extern int arch_check_optimized_kprobe(struct optimized_kprobe *op);
-extern int arch_prepare_optimized_kprobe(struct optimized_kprobe *op);
+extern int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
+					 struct kprobe *orig);
 extern void arch_remove_optimized_kprobe(struct optimized_kprobe *op);
 extern void arch_optimize_kprobes(struct list_head *oplist);
 extern void arch_unoptimize_kprobes(struct list_head *oplist,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3995f54..9f28aa7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -717,7 +717,7 @@ static void prepare_optimized_kprobe(struct kprobe *p)
 	struct optimized_kprobe *op;
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	arch_prepare_optimized_kprobe(op);
+	arch_prepare_optimized_kprobe(op, p);
 }
 
 /* Allocate new optimized_kprobe and try to prepare optimized instructions */
@@ -731,7 +731,7 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 
 	INIT_LIST_HEAD(&op->list);
 	op->kp.addr = p->addr;
-	arch_prepare_optimized_kprobe(op);
+	arch_prepare_optimized_kprobe(op, p);
 
 	return &op->kp;
 }
-- 
1.8.4
