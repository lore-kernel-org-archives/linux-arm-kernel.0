From: awallis@codeaurora.org (Adam Wallis)
Date: Wed, 15 Nov 2017 08:29:51 -0500
Subject: [PATCH v2][for 4.15] dmaengine: dmatest: move callback wait queue to
 thread context
Message-ID: <1510752591-22702-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
introduced a bug (that is in fact documented by the patch commit text)
that leaves behind a dangling pointer. Since the done_wait structure is
allocated on the stack, future invocations to the DMATEST can produce
undesirable results (e.g., corrupted spinlocks).

Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
out") attempted to WARN the user that the stack was likely corrupted but
did not fix the actual issue.

This patch fixes the issue by pushing the wait queue and callback
structs into the the thread structure. If a failure occurs due to time,
dmaengine_terminate_all will force the callback to safely call
wake_up_all() without possibility of using a freed pointer.

Cc: stable at vger.kernel.org # 4.13.x: a9df21e: dmatest: Warn User
Cc: stable at vger.kernel.org # 4.13.x
Cc: stable at vger.kernel.org # 4.14.x
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
changes from v1: Added pre-req patches for stable


 drivers/dma/dmatest.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 47edc7f..2573b6c 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -155,6 +155,12 @@ struct dmatest_params {
 #define PATTERN_COUNT_MASK	0x1f
 #define PATTERN_MEMSET_IDX	0x01
 
+/* poor man's completion - we want to use wait_event_freezable() on it */
+struct dmatest_done {
+	bool			done;
+	wait_queue_head_t	*wait;
+};
+
 struct dmatest_thread {
 	struct list_head	node;
 	struct dmatest_info	*info;
@@ -165,6 +171,8 @@ struct dmatest_thread {
 	u8			**dsts;
 	u8			**udsts;
 	enum dma_transaction_type type;
+	wait_queue_head_t done_wait;
+	struct dmatest_done test_done;
 	bool			done;
 };
 
@@ -342,11 +350,6 @@ static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 	return error_count;
 }
 
-/* poor man's completion - we want to use wait_event_freezable() on it */
-struct dmatest_done {
-	bool			done;
-	wait_queue_head_t	*wait;
-};
 
 static void dmatest_callback(void *arg)
 {
@@ -424,9 +427,8 @@ static unsigned long long dmatest_KBs(s64 runtime, unsigned long long len)
  */
 static int dmatest_func(void *data)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(done_wait);
 	struct dmatest_thread	*thread = data;
-	struct dmatest_done	done = { .wait = &done_wait };
+	struct dmatest_done	*done = &thread->test_done;
 	struct dmatest_info	*info;
 	struct dmatest_params	*params;
 	struct dma_chan		*chan;
@@ -673,9 +675,9 @@ static int dmatest_func(void *data)
 			continue;
 		}
 
-		done.done = false;
+		done->done = false;
 		tx->callback = dmatest_callback;
-		tx->callback_param = &done;
+		tx->callback_param = done;
 		cookie = tx->tx_submit(tx);
 
 		if (dma_submit_error(cookie)) {
@@ -688,21 +690,12 @@ static int dmatest_func(void *data)
 		}
 		dma_async_issue_pending(chan);
 
-		wait_event_freezable_timeout(done_wait, done.done,
+		wait_event_freezable_timeout(thread->done_wait, done->done,
 					     msecs_to_jiffies(params->timeout));
 
 		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
 
-		if (!done.done) {
-			/*
-			 * We're leaving the timed out dma operation with
-			 * dangling pointer to done_wait.  To make this
-			 * correct, we'll need to allocate wait_done for
-			 * each test iteration and perform "who's gonna
-			 * free it this time?" dancing.  For now, just
-			 * leave it dangling.
-			 */
-			WARN(1, "dmatest: Kernel stack may be corrupted!!\n");
+		if (!done->done) {
 			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
@@ -789,7 +782,7 @@ static int dmatest_func(void *data)
 		dmatest_KBs(runtime, total_len), ret);
 
 	/* terminate all transfers on specified channels */
-	if (ret)
+	if (ret || failed_tests)
 		dmaengine_terminate_all(chan);
 
 	thread->done = true;
@@ -849,6 +842,8 @@ static int dmatest_add_threads(struct dmatest_info *info,
 		thread->info = info;
 		thread->chan = dtc->chan;
 		thread->type = type;
+		thread->test_done.wait = &thread->done_wait;
+		init_waitqueue_head(&thread->done_wait);
 		smp_wmb();
 		thread->task = kthread_create(dmatest_func, thread, "%s-%s%u",
 				dma_chan_name(chan), op, i);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
