From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 09:52:57 -0400
Subject: [PATCH V2] dmenginer: dmatest: exclude compare and fill time during
 perf report
Message-ID: <1468849977-28538-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmatest is currently including compare and fill time into the
calculated performance numbers. This does not reflect the HW
capability and the results vary based on the transfer sizes used.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/dmatest.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index b8576fd..0b3e1f9 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -416,7 +416,9 @@ static int dmatest_func(void *data)
 	int			src_cnt;
 	int			dst_cnt;
 	int			i;
-	ktime_t			ktime;
+	ktime_t			ktime, start, diff;
+	ktime_t			filltime = ktime_set(0, 0);
+	ktime_t			comparetime = ktime_set(0, 0);
 	s64			runtime = 0;
 	unsigned long long	total_len = 0;
 
@@ -517,6 +519,7 @@ static int dmatest_func(void *data)
 			src_off = 0;
 			dst_off = 0;
 		} else {
+			start = ktime_get();
 			src_off = dmatest_random() % (params->buf_size - len + 1);
 			dst_off = dmatest_random() % (params->buf_size - len + 1);
 
@@ -527,6 +530,9 @@ static int dmatest_func(void *data)
 					  params->buf_size);
 			dmatest_init_dsts(thread->dsts, dst_off, len,
 					  params->buf_size);
+
+			diff = ktime_sub(ktime_get(), start);
+			filltime = ktime_add(filltime, diff);
 		}
 
 		um = dmaengine_get_unmap_data(dev->dev, src_cnt+dst_cnt,
@@ -657,6 +663,7 @@ static int dmatest_func(void *data)
 			continue;
 		}
 
+		start = ktime_get();
 		pr_debug("%s: verifying source buffer...\n", current->comm);
 		error_count = dmatest_verify(thread->srcs, 0, src_off,
 				0, PATTERN_SRC, true);
@@ -677,6 +684,9 @@ static int dmatest_func(void *data)
 				params->buf_size, dst_off + len,
 				PATTERN_DST, false);
 
+		diff = ktime_sub(ktime_get(), start);
+		comparetime = ktime_add(comparetime, diff);
+
 		if (error_count) {
 			result("data error", total_tests, src_off, dst_off,
 			       len, error_count);
@@ -686,7 +696,10 @@ static int dmatest_func(void *data)
 				       dst_off, len, 0);
 		}
 	}
-	runtime = ktime_us_delta(ktime_get(), ktime);
+	ktime = ktime_sub(ktime_get(), ktime);
+	ktime = ktime_sub(ktime, comparetime);
+	ktime = ktime_sub(ktime, filltime);
+	runtime = ktime_to_us(ktime);
 
 	ret = 0;
 err_dstbuf:
-- 
1.8.2.1
