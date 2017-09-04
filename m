From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 4 Sep 2017 13:17:40 +0800
Subject: [PATCH] binder: fix "cast to pointer from integer of different size"
 warning
Message-ID: <20170904051740.2636-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binder driver now could cause warnings as below on 32bit platforms
if ANDROID_BINDER_IPC_32BIT is unselected:

drivers/android/binder.c:1550:15: warning: cast to pointer from integer
of different size [-Wint-to-pointer-cast]

This patch fix all of them.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/android/binder.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f7665c31feca..2812586bfae5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1547,7 +1547,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				       debug_id, (u64)fda->num_fds);
 				continue;
 			}
-			fd_array = (u32 *)(parent_buffer + fda->parent_offset);
+			fd_array = (u32 *)(parent_buffer +
+					   (uintptr_t)fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
 				task_close_fd(proc, fd_array[fd_index]);
 		} break;
@@ -1751,7 +1752,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 	 * back to the kernel address space to access it
 	 */
 	parent_buffer = parent->buffer - target_proc->user_buffer_offset;
-	fd_array = (u32 *)(parent_buffer + fda->parent_offset);
+	fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
 	if (!IS_ALIGNED((unsigned long)fd_array, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
@@ -1786,7 +1787,7 @@ static int binder_fixup_parent(struct binder_transaction *t,
 			       binder_size_t last_fixup_min_off)
 {
 	struct binder_buffer_object *parent;
-	u8 *parent_buffer;
+	uintptr_t parent_buffer;
 	struct binder_buffer *b = t->buffer;
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
@@ -1817,9 +1818,9 @@ static int binder_fixup_parent(struct binder_transaction *t,
 				  proc->pid, thread->pid);
 		return -EINVAL;
 	}
-	parent_buffer = (u8 *)(parent->buffer -
-			       target_proc->user_buffer_offset);
-	*(binder_uintptr_t *)(parent_buffer + bp->parent_offset) = bp->buffer;
+	parent_buffer = parent->buffer - target_proc->user_buffer_offset;
+	*(binder_uintptr_t *)(parent_buffer +
+			      (uintptr_t)bp->parent_offset) = bp->buffer;
 
 	return 0;
 }
-- 
2.14.1
