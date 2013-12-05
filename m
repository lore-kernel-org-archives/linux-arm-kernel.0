From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Thu, 05 Dec 2013 17:30:10 +0400
Subject: [PATCH 1/2] ARM64: check stack pointer in get_wchan
Message-ID: <20131205133010.16410.96824.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_wchan() is lockless. Task may wakeup at any time and change its own stack,
thus each next stack frame may be overwritten and filled with random stuff.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm64/kernel/process.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..0adb8f0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -308,6 +308,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
+	unsigned long stack_page;
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
@@ -315,9 +316,11 @@ unsigned long get_wchan(struct task_struct *p)
 	frame.fp = thread_saved_fp(p);
 	frame.sp = thread_saved_sp(p);
 	frame.pc = thread_saved_pc(p);
+	stack_page = (unsigned long)task_stack_page(p);
 	do {
-		int ret = unwind_frame(&frame);
-		if (ret < 0)
+		if (frame.sp < stack_page ||
+		    frame.sp >= stack_page + THREAD_SIZE ||
+		    unwind_frame(&frame))
 			return 0;
 		if (!in_sched_functions(frame.pc))
 			return frame.pc;
