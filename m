From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 5 Jan 2015 20:32:20 +0800
Subject: [PATCH] kprobes: bugfix: force unoptimize when disable kprobes.
Message-ID: <1420461140-27153-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original code failed to disarm the probed instruction after

echo 0 > /sys/kernel/debug/kprobes/enabled

if OPTPROBE is enabled.

This is caused by a piece of logically inconsistent code:

	unoptimize_kprobe(p, false);
	if (!kprobe_queued(p)) {
		...
	}

unoptimize_kprobe() with 'force' == false queues p onto
unoptimizing_list, so following kprobe_queued() check always fail unless
another core schedules optimizer and does the unoptimization very soon.
This logic causes arch_disarm_kprobe() failed to get execute, lefts a
breakpoint at the probed address, instead of restoring it.

This patch uses force unoptimize instead.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b185464..9fbe0c3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -869,7 +869,7 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 {
 	struct kprobe *_p;
 
-	unoptimize_kprobe(p, false);	/* Try to unoptimize */
+	unoptimize_kprobe(p, true);	/* Try to unoptimize */
 
 	if (!kprobe_queued(p)) {
 		arch_disarm_kprobe(p);
-- 
1.8.4
