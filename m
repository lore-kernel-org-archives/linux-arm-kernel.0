From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Aug 2017 17:18:17 +0100
Subject: [PATCH v2 2/2] perf/aux: Ensure aux_wakeup represents most recent
 wakeup index
In-Reply-To: <1502900297-21839-1-git-send-email-will.deacon@arm.com>
References: <1502900297-21839-1-git-send-email-will.deacon@arm.com>
Message-ID: <1502900297-21839-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aux_watermark member of struct ring_buffer represents the period (in
terms of bytes) at which wakeup events should be generated when data is
written to the aux buffer in non-snapshot mode. On hardware that cannot
generate an interrupt when the aux_head reaches an arbitrary wakeup index
(such as ARM SPE), the aux_head sampled from handle->head in
perf_aux_output_{skip,end} may in fact be past the wakeup index. This
can lead to wakeup slowly falling behind the head. For example, consider
the case where hardware can only generate an interrupt on a page-boundary
and the aux buffer is initialised as follows:

  // Buffer size is 2 * PAGE_SIZE
  rb->aux_head = rb->aux_wakeup = 0
  rb->aux_watermark = PAGE_SIZE / 2

following the first perf_aux_output_begin call, the handle is
initialised with:

  handle->head = 0
  handle->size = 2 * PAGE_SIZE
  handle->wakeup = PAGE_SIZE / 2

and the hardware will be programmed to generate an interrupt at
PAGE_SIZE.

When the interrupt is raised, the hardware head will be at PAGE_SIZE,
so calling perf_aux_output_end(handle, PAGE_SIZE) puts the ring buffer
into the following state:

  rb->aux_head = PAGE_SIZE
  rb->aux_wakeup = PAGE_SIZE / 2
  rb->aux_watermark = PAGE_SIZE / 2

and then the next call to perf_aux_output_begin will result in:

  handle->head = handle->wakeup = PAGE_SIZE

for which the semantics are unclear and, for a smaller aux_watermark
(e.g. PAGE_SIZE / 4), then the wakeup would in fact be behind head at
this point.

This patch fixes the problem by rounding down the aux_head (as sampled
from the handle) to the nearest aux_watermark boundary when updating
rb->aux_wakeup, therefore taking into account any overruns by the
hardware.

Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/events/internal.h    | 2 +-
 kernel/events/ring_buffer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 2941b868353c..5377c591c57a 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,7 +40,7 @@ struct ring_buffer {
 	/* AUX area */
 	long				aux_head;
 	local_t				aux_nest;
-	long				aux_wakeup;
+	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
 	unsigned long			aux_pgoff;
 	int				aux_nr_pages;
 	int				aux_overwrite;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 87c28faca8e4..dcb2e8c4ad54 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -454,7 +454,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	rb->user_page->aux_head = rb->aux_head;
 	if (rb->aux_head - rb->aux_wakeup >= rb->aux_watermark) {
 		wakeup = true;
-		rb->aux_wakeup += rb->aux_watermark;
+		rb->aux_wakeup = rounddown(rb->aux_head, rb->aux_watermark);
 	}
 
 	if (wakeup) {
@@ -488,7 +488,7 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
 	rb->user_page->aux_head = rb->aux_head;
 	if (rb->aux_head - rb->aux_wakeup >= rb->aux_watermark) {
 		perf_output_wakeup(handle);
-		rb->aux_wakeup += rb->aux_watermark;
+		rb->aux_wakeup = rounddown(rb->aux_head, rb->aux_watermark);
 		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
 	}
 
-- 
2.1.4
