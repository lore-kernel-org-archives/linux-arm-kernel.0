From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 16 May 2013 14:16:10 +0300
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
Message-ID: <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several ways to make sure might_fault
calling function does not sleep.
One is to use it on kernel or otherwise locked memory - apparently
nfs/sunrpc does this. As noted by Ingo, this is handled by the
migh_fault() implementation in mm/memory.c but not the one in
linux/kernel.h so in the current code might_fault() schedules
differently depending on CONFIG_PROVE_LOCKING, which is an undesired
semantical side effect.

Another is to call pagefault_disable: in this case the page fault
handler will go to fixups processing and we get an error instead of
sleeping, so the might_sleep annotation is a false positive.
vhost driver wants to do this now in order to reuse socket ops
under a spinlock (and fall back on slower thread handler
on error).

Address both issues by:
	- dropping the unconditional call to might_sleep
	  from the fast might_fault code in linux/kernel.h
	- checking for pagefault_disable() in the
	  CONFIG_PROVE_LOCKING implementation

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/kernel.h |  1 -
 mm/memory.c            | 14 +++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e96329c..322b065 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -198,7 +198,6 @@ void might_fault(void);
 #else
 static inline void might_fault(void)
 {
-	might_sleep();
 }
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index 6dc1882..1b8327b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4222,13 +4222,17 @@ void might_fault(void)
 	if (segment_eq(get_fs(), KERNEL_DS))
 		return;
 
-	might_sleep();
 	/*
-	 * it would be nicer only to annotate paths which are not under
-	 * pagefault_disable, however that requires a larger audit and
-	 * providing helpers like get_user_atomic.
+	 * It would be nicer to annotate paths which are under preempt_disable
+	 * but not under pagefault_disable, however that requires a new flag
+	 * for differentiating between the two.
 	 */
-	if (!in_atomic() && current->mm)
+	if (in_atomic())
+		return;
+
+	might_sleep();
+
+	if (current->mm)
 		might_lock_read(&current->mm->mmap_sem);
 }
 EXPORT_SYMBOL(might_fault);
-- 
MST
