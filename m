From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 27 Jun 2017 20:46:26 -0400
Subject: [PATCH 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <1498610786-6090-1-git-send-email-okaya@codeaurora.org>
References: <1498610786-6090-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1498610786-6090-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introducing memset test into dmatest. This change allows us to test
memset capable HW using the dmatest test procedure. The new dmatest
value for memset is 2 and it is not the default value.

Memset support patch shares the same code path as the other dmatest
code to reuse as much as we can.

The first value inside the source buffer is used as a pattern
to fill in the destination buffer space.

Prior to running the test, source/destination buffers are initialized
in the current code.

"The remaining bits are the inverse of a counter which increments by
 one for each byte address."

Memset test will fill in the upper bits of pattern with the inverse of
fixed counter value 1 as opposed to an incrementing value in a loop.

An example run is as follows:

echo dma0chan0 > /sys/module/dmatest/parameters/channel
echo 2 >  /sys/module/dmatest/parameters/dmatest
echo 2000 >  /sys/module/dmatest/parameters/timeout
echo 10 >  /sys/module/dmatest/parameters/iterations
echo 1 >  /sys/module/dmatest/parameters/run

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/dmatest.c | 107 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 79 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a07ef3d..4548565 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -60,7 +60,7 @@
 static unsigned int dmatest;
 module_param(dmatest, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(dmatest,
-		"dmatest 0-memcpy 1-slave_sg (default: 0)");
+		"dmatest 0-memcpy 1-slave_sg 2-memset (default: 0)");
 
 static unsigned int xor_sources = 3;
 module_param(xor_sources, uint, S_IRUGO | S_IWUSR);
@@ -158,6 +158,7 @@ struct dmatest_params {
 #define PATTERN_COPY		0x40
 #define PATTERN_OVERWRITE	0x20
 #define PATTERN_COUNT_MASK	0x1f
+#define PATTERN_MEMSET_IDX	0x01
 
 struct dmatest_thread {
 	struct list_head	node;
@@ -240,47 +241,70 @@ static unsigned long dmatest_random(void)
 }
 
 static void dmatest_init_srcs(u8 **bufs, unsigned int start, unsigned int len,
-		unsigned int buf_size)
+		unsigned int buf_size, bool is_memset)
 {
 	unsigned int i;
 	u8 *buf;
 
 	for (; (buf = *bufs); bufs++) {
-		for (i = 0; i < start; i++)
-			buf[i] = PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
-		for ( ; i < start + len; i++)
+		for (i = 0; i < start; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
+			buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
+		}
+
+		for ( ; i < start + len; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
 			buf[i] = PATTERN_SRC | PATTERN_COPY
-				| (~i & PATTERN_COUNT_MASK);
-		for ( ; i < buf_size; i++)
-			buf[i] = PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
+				| (~val & PATTERN_COUNT_MASK);
+		}
+
+		for ( ; i < buf_size; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
+			buf[i] = PATTERN_SRC | (~val & PATTERN_COUNT_MASK);
+		}
 		buf++;
 	}
 }
 
 static void dmatest_init_dsts(u8 **bufs, unsigned int start, unsigned int len,
-		unsigned int buf_size)
+		unsigned int buf_size, bool is_memset)
 {
 	unsigned int i;
 	u8 *buf;
 
 	for (; (buf = *bufs); bufs++) {
-		for (i = 0; i < start; i++)
-			buf[i] = PATTERN_DST | (~i & PATTERN_COUNT_MASK);
-		for ( ; i < start + len; i++)
+		for (i = 0; i < start; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
+			buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);
+		}
+
+		for ( ; i < start + len; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
 			buf[i] = PATTERN_DST | PATTERN_OVERWRITE
-				| (~i & PATTERN_COUNT_MASK);
-		for ( ; i < buf_size; i++)
-			buf[i] = PATTERN_DST | (~i & PATTERN_COUNT_MASK);
+				| (~val & PATTERN_COUNT_MASK);
+		}
+		for ( ; i < buf_size; i++) {
+			unsigned int val = is_memset ? PATTERN_MEMSET_IDX : i;
+
+			buf[i] = PATTERN_DST | (~val & PATTERN_COUNT_MASK);
+		}
 	}
 }
 
 static void dmatest_mismatch(u8 actual, u8 pattern, unsigned int index,
-		unsigned int counter, bool is_srcbuf)
+		unsigned int counter, bool is_srcbuf, bool is_memset)
 {
 	u8		diff = actual ^ pattern;
-	u8		expected = pattern | (~counter & PATTERN_COUNT_MASK);
+	u8		expected;
 	const char	*thread_name = current->comm;
+	unsigned int val = is_memset ? PATTERN_MEMSET_IDX : counter;
 
+	expected = pattern | (~val & PATTERN_COUNT_MASK);
 	if (is_srcbuf)
 		pr_warn("%s: srcbuf[0x%x] overwritten! Expected %02x, got %02x\n",
 			thread_name, index, expected, actual);
@@ -298,7 +322,7 @@ static void dmatest_mismatch(u8 actual, u8 pattern, unsigned int index,
 
 static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 		unsigned int end, unsigned int counter, u8 pattern,
-		bool is_srcbuf)
+		bool is_srcbuf, bool is_memset)
 {
 	unsigned int i;
 	unsigned int error_count = 0;
@@ -310,12 +334,16 @@ static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 	for (; (buf = *bufs); bufs++) {
 		counter = counter_orig;
 		for (i = start; i < end; i++) {
+			unsigned int val;
+
+			val = is_memset ? PATTERN_MEMSET_IDX : counter;
 			actual = buf[i];
-			expected = pattern | (~counter & PATTERN_COUNT_MASK);
+			expected = pattern | (~val & PATTERN_COUNT_MASK);
 			if (actual != expected) {
 				if (error_count < MAX_ERROR_COUNT)
 					dmatest_mismatch(actual, pattern, i,
-							 counter, is_srcbuf);
+							 counter, is_srcbuf,
+							 is_memset);
 				error_count++;
 			}
 			counter++;
@@ -435,6 +463,7 @@ static int dmatest_func(void *data)
 	s64			runtime = 0;
 	unsigned long long	total_len = 0;
 	u8			align = 0;
+	bool			is_memset = false;
 
 	set_freezable();
 
@@ -448,6 +477,10 @@ static int dmatest_func(void *data)
 	if (thread->type == DMA_MEMCPY) {
 		align = dev->copy_align;
 		src_cnt = dst_cnt = 1;
+	} else if (thread->type == DMA_MEMSET) {
+		align = dev->fill_align;
+		src_cnt = dst_cnt = 1;
+		is_memset = true;
 	} else if (thread->type == DMA_SG) {
 		align = dev->copy_align;
 		src_cnt = dst_cnt = sg_buffers;
@@ -571,9 +604,9 @@ static int dmatest_func(void *data)
 			dst_off = (dst_off >> align) << align;
 
 			dmatest_init_srcs(thread->srcs, src_off, len,
-					  params->buf_size);
+					  params->buf_size, is_memset);
 			dmatest_init_dsts(thread->dsts, dst_off, len,
-					  params->buf_size);
+					  params->buf_size, is_memset);
 
 			diff = ktime_sub(ktime_get(), start);
 			filltime = ktime_add(filltime, diff);
@@ -640,6 +673,11 @@ static int dmatest_func(void *data)
 			tx = dev->device_prep_dma_memcpy(chan,
 							 dsts[0] + dst_off,
 							 srcs[0], len, flags);
+		else if (thread->type == DMA_MEMSET)
+			tx = dev->device_prep_dma_memset(chan,
+						dsts[0] + dst_off,
+						*(thread->srcs[0] + src_off),
+						len, flags);
 		else if (thread->type == DMA_SG)
 			tx = dev->device_prep_dma_sg(chan, tx_sg, src_cnt,
 						     rx_sg, src_cnt, flags);
@@ -720,25 +758,28 @@ static int dmatest_func(void *data)
 		}
 
 		start = ktime_get();
+
 		pr_debug("%s: verifying source buffer...\n", current->comm);
 		error_count = dmatest_verify(thread->srcs, 0, src_off,
-				0, PATTERN_SRC, true);
+				0, PATTERN_SRC, true, is_memset);
 		error_count += dmatest_verify(thread->srcs, src_off,
 				src_off + len, src_off,
-				PATTERN_SRC | PATTERN_COPY, true);
+				PATTERN_SRC | PATTERN_COPY, true, is_memset);
 		error_count += dmatest_verify(thread->srcs, src_off + len,
 				params->buf_size, src_off + len,
-				PATTERN_SRC, true);
+				PATTERN_SRC, true, is_memset);
 
 		pr_debug("%s: verifying dest buffer...\n", current->comm);
 		error_count += dmatest_verify(thread->dsts, 0, dst_off,
-				0, PATTERN_DST, false);
+				0, PATTERN_DST, false, is_memset);
+
 		error_count += dmatest_verify(thread->dsts, dst_off,
 				dst_off + len, src_off,
-				PATTERN_SRC | PATTERN_COPY, false);
+				PATTERN_SRC | PATTERN_COPY, false, is_memset);
+
 		error_count += dmatest_verify(thread->dsts, dst_off + len,
 				params->buf_size, dst_off + len,
-				PATTERN_DST, false);
+				PATTERN_DST, false, is_memset);
 
 		diff = ktime_sub(ktime_get(), start);
 		comparetime = ktime_add(comparetime, diff);
@@ -821,6 +862,8 @@ static int dmatest_add_threads(struct dmatest_info *info,
 
 	if (type == DMA_MEMCPY)
 		op = "copy";
+	else if (type == DMA_MEMSET)
+		op = "set";
 	else if (type == DMA_SG)
 		op = "sg";
 	else if (type == DMA_XOR)
@@ -883,6 +926,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
 		}
 	}
 
+	if (dma_has_cap(DMA_MEMSET, dma_dev->cap_mask)) {
+		if (dmatest == 2) {
+			cnt = dmatest_add_threads(info, dtc, DMA_MEMSET);
+			thread_count += cnt > 0 ? cnt : 0;
+		}
+	}
+
 	if (dma_has_cap(DMA_SG, dma_dev->cap_mask)) {
 		if (dmatest == 1) {
 			cnt = dmatest_add_threads(info, dtc, DMA_SG);
@@ -961,6 +1011,7 @@ static void run_threaded_test(struct dmatest_info *info)
 	params->noverify = noverify;
 
 	request_channels(info, DMA_MEMCPY);
+	request_channels(info, DMA_MEMSET);
 	request_channels(info, DMA_XOR);
 	request_channels(info, DMA_SG);
 	request_channels(info, DMA_PQ);
-- 
1.9.1
