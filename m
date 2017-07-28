From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Jul 2017 17:54:22 +0100
Subject: [PATCH 1/2] perf/aux: Make aux_{head, wakeup} ring_buffer members long
Message-ID: <1501260863-14687-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aux_head and aux_wakeup members of struct ring_buffer are defined
using the local_t type, despite the fact that they are only accessed via
the perf_aux_output_* functions, which cannot race with each other for a
given ring buffer.

This patch changes the type of the members to long, so we can avoid
using the local_* API where it isn't needed.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/events/internal.h    |  4 ++--
 kernel/events/ring_buffer.c | 27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 486fd78eb8d5..2941b868353c 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -38,9 +38,9 @@ struct ring_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
-	local_t				aux_head;
+	long				aux_head;
 	local_t				aux_nest;
-	local_t				aux_wakeup;
+	long				aux_wakeup;
 	unsigned long			aux_pgoff;
 	int				aux_nr_pages;
 	int				aux_overwrite;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 14a240ff439d..330df5a7f762 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -367,7 +367,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	if (WARN_ON_ONCE(local_xchg(&rb->aux_nest, 1)))
 		goto err_put;
 
-	aux_head = local_read(&rb->aux_head);
+	aux_head = rb->aux_head;
 
 	handle->rb = rb;
 	handle->event = event;
@@ -382,7 +382,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	 */
 	if (!rb->aux_overwrite) {
 		aux_tail = ACCESS_ONCE(rb->user_page->aux_tail);
-		handle->wakeup = local_read(&rb->aux_wakeup) + rb->aux_watermark;
+		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
 		if (aux_head - aux_tail < perf_aux_size(rb))
 			handle->size = CIRC_SPACE(aux_head, aux_tail, perf_aux_size(rb));
 
@@ -434,12 +434,12 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		handle->aux_flags |= PERF_AUX_FLAG_OVERWRITE;
 
 		aux_head = handle->head;
-		local_set(&rb->aux_head, aux_head);
+		rb->aux_head = aux_head;
 	} else {
 		handle->aux_flags &= ~PERF_AUX_FLAG_OVERWRITE;
 
-		aux_head = local_read(&rb->aux_head);
-		local_add(size, &rb->aux_head);
+		aux_head = rb->aux_head;
+		rb->aux_head += size;
 	}
 
 	if (size || handle->aux_flags) {
@@ -451,11 +451,11 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		                     handle->aux_flags);
 	}
 
-	aux_head = rb->user_page->aux_head = local_read(&rb->aux_head);
+	aux_head = rb->user_page->aux_head = rb->aux_head;
 
-	if (aux_head - local_read(&rb->aux_wakeup) >= rb->aux_watermark) {
+	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
 		wakeup = true;
-		local_add(rb->aux_watermark, &rb->aux_wakeup);
+		rb->aux_wakeup += rb->aux_watermark;
 	}
 
 	if (wakeup) {
@@ -485,14 +485,13 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
 	if (size > handle->size)
 		return -ENOSPC;
 
-	local_add(size, &rb->aux_head);
+	rb->aux_head += size;
 
-	aux_head = rb->user_page->aux_head = local_read(&rb->aux_head);
-	if (aux_head - local_read(&rb->aux_wakeup) >= rb->aux_watermark) {
+	aux_head = rb->user_page->aux_head = rb->aux_head;
+	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
 		perf_output_wakeup(handle);
-		local_add(rb->aux_watermark, &rb->aux_wakeup);
-		handle->wakeup = local_read(&rb->aux_wakeup) +
-				 rb->aux_watermark;
+		rb->aux_wakeup += rb->aux_watermark;
+		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
 	}
 
 	handle->head = aux_head;
-- 
2.1.4
