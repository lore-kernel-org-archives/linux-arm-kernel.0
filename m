From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 20 Jan 2015 10:51:51 +0800
Subject: [PATCH] kprobes: bugfix: makes kprobes/enabled works correctly for
 optimized kprobes.
In-Reply-To: <54BCFC6E.1080007@hitachi.com>
References: <54BCFC6E.1080007@hitachi.com>
Message-ID: <1421722311-30455-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

debugfs/kprobes/enabled doesn't work correctly on optimized kprobes.
Masami Hiramatsu has a test report on x86_64 platform:

https://lkml.org/lkml/2015/1/19/274

This patch forces it to unoptimize kprobe if kprobes_all_disarmed
is set. It also checks the flag in unregistering path for skipping
unneeded disarming process when kprobes globally disarmed.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9471710..fb995ef 100644
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
