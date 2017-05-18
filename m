From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 May 2017 18:24:30 +0100
Subject: [PATCH v3 2/5] perf/core: Export AUX buffer helpers to modules
In-Reply-To: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
Message-ID: <1495128273-13941-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf PMU drivers using AUX buffers cannot be built as modules unless
the AUX helpers are exported.

This patch exports perf_aux_output_{begin,end,skip} and perf_get_aux to
modules.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/events/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 2831480c63a2..cd5e902a27ac 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -411,6 +411,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(perf_aux_output_begin);
 
 /*
  * Commit the data written by hardware into the ring buffer by adjusting
@@ -470,6 +471,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 	rb_free_aux(rb);
 	ring_buffer_put(rb);
 }
+EXPORT_SYMBOL_GPL(perf_aux_output_end);
 
 /*
  * Skip over a given number of bytes in the AUX buffer, due to, for example,
@@ -498,6 +500,7 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(perf_aux_output_skip);
 
 void *perf_get_aux(struct perf_output_handle *handle)
 {
@@ -507,6 +510,7 @@ void *perf_get_aux(struct perf_output_handle *handle)
 
 	return handle->rb->aux_priv;
 }
+EXPORT_SYMBOL_GPL(perf_get_aux);
 
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 
-- 
2.1.4
