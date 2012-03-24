From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sat, 24 Mar 2012 14:29:39 +0400
Subject: [PATCH 05/10] blackfin: A couple of task->mm handling fixes
In-Reply-To: <20120324102609.GA28356@lizard>
References: <20120324102609.GA28356@lizard>
Message-ID: <20120324102939.GE29067@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch fixes two problems:

1. Working with task->mm w/o getting mm or grabing the task lock is
   dangerous as ->mm might disappear (exit_mm() assigns NULL under
   task_lock(), so tasklist lock is not enough).

   We can't use get_task_mm()/mmput() pair as mmput() might sleep,
   so we have to take the task lock while handle its mm.

2. Checking for process->mm is not enough because process' main
   thread may exit or detach its mm via use_mm(), but other threads
   may still have a valid mm.

   To catch this we use find_lock_task_mm(), which walks up all
   threads and returns an appropriate task (with task lock held).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/blackfin/kernel/trace.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
index 050db44..5102cdf 100644
--- a/arch/blackfin/kernel/trace.c
+++ b/arch/blackfin/kernel/trace.c
@@ -10,6 +10,8 @@
 #include <linux/hardirq.h>
 #include <linux/thread_info.h>
 #include <linux/mm.h>
+#include <linux/oom.h>
+#include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -27,7 +29,6 @@ void decode_address(char *buf, unsigned long address)
 	struct task_struct *p;
 	struct mm_struct *mm;
 	unsigned long flags, offset;
-	unsigned char in_atomic = (bfin_read_IPEND() & 0x10) || in_atomic();
 	struct rb_node *n;
 
 #ifdef CONFIG_KALLSYMS
@@ -113,15 +114,15 @@ void decode_address(char *buf, unsigned long address)
 	 */
 	write_lock_irqsave(&tasklist_lock, flags);
 	for_each_process(p) {
-		mm = (in_atomic ? p->mm : get_task_mm(p));
-		if (!mm)
-			continue;
+		struct task_struct *t;
 
-		if (!down_read_trylock(&mm->mmap_sem)) {
-			if (!in_atomic)
-				mmput(mm);
+		t = find_lock_task_mm(p);
+		if (!t)
 			continue;
-		}
+
+		mm = t->mm;
+		if (!down_read_trylock(&mm->mmap_sem))
+			goto __continue;
 
 		for (n = rb_first(&mm->mm_rb); n; n = rb_next(n)) {
 			struct vm_area_struct *vma;
@@ -130,7 +131,7 @@ void decode_address(char *buf, unsigned long address)
 
 			if (address >= vma->vm_start && address < vma->vm_end) {
 				char _tmpbuf[256];
-				char *name = p->comm;
+				char *name = t->comm;
 				struct file *file = vma->vm_file;
 
 				if (file) {
@@ -163,8 +164,7 @@ void decode_address(char *buf, unsigned long address)
 						name, vma->vm_start, vma->vm_end);
 
 				up_read(&mm->mmap_sem);
-				if (!in_atomic)
-					mmput(mm);
+				task_unlock(t);
 
 				if (buf[0] == '\0')
 					sprintf(buf, "[ %s ] dynamic memory", name);
@@ -174,8 +174,8 @@ void decode_address(char *buf, unsigned long address)
 		}
 
 		up_read(&mm->mmap_sem);
-		if (!in_atomic)
-			mmput(mm);
+__continue:
+		task_unlock(t);
 	}
 
 	/*
-- 
1.7.9.2
