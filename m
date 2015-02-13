From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:22 +0800
Subject: [RFC PATCH v3 02/26] kprobes: makes kprobes/enabled works correctly
 for optimized kprobes.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806022-61575-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

debugfs/kprobes/enabled doesn't work correctly on optimized kprobes.
Masami Hiramatsu has a test report on x86_64 platform:

https://lkml.org/lkml/2015/1/19/274

This patch forces it to unoptimize kprobe if kprobes_all_disarmed
is set. It also checks the flag in unregistering path for skipping
unneeded disarming process when kprobes globally disarmed.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/kprobes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c397900..c90e417 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -869,7 +869,8 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 {
 	struct kprobe *_p;
 
-	unoptimize_kprobe(p, false);	/* Try to unoptimize */
+	/* Try to unoptimize */
+	unoptimize_kprobe(p, kprobes_all_disarmed);
 
 	if (!kprobe_queued(p)) {
 		arch_disarm_kprobe(p);
@@ -1571,7 +1572,13 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 
 		/* Try to disarm and disable this/parent probe */
 		if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
-			disarm_kprobe(orig_p, true);
+			/*
+			 * If kprobes_all_disarmed is set, orig_p
+			 * should have already been disarmed, so
+			 * skip unneed disarming process.
+			 */
+			if (!kprobes_all_disarmed)
+				disarm_kprobe(orig_p, true);
 			orig_p->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
-- 
1.8.4
