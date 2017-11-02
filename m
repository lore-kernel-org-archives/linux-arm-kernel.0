From: awallis@codeaurora.org (Adam Wallis)
Date: Thu,  2 Nov 2017 08:53:30 -0400
Subject: [PATCH v2] dmaengine: dmatest: warn user when dma test times out
Message-ID: <1509627210-16904-1-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
introduced a bug (that is in fact documented by the patch commit text)
that leaves behind a dangling pointer. Since the done_wait structure is
allocated on the stack, future invocations to the DMATEST can produce
undesirable results (e.g., corrupted spinlocks). Ideally, this would be
cleaned up in the thread handler, but at the very least, the kernel
is left in a very precarious scenario that can lead to some long debug
sessions when the crash comes later.

This bug has also been captured at
https://bugzilla.kernel.org/show_bug.cgi?id=197605

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
changes from v1: No longer using BUG at request of Vinod

 drivers/dma/dmatest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 34ff532..47edc7f 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -702,6 +702,7 @@ static int dmatest_func(void *data)
 			 * free it this time?" dancing.  For now, just
 			 * leave it dangling.
 			 */
+			WARN(1, "dmatest: Kernel stack may be corrupted!!\n");
 			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
