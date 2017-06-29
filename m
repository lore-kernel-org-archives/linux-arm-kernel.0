From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Jun 2017 21:51:56 -0400
Subject: [PATCH V2 2/2] dmaengine: dmatest: add support for memset test
In-Reply-To: <1498701116-9787-1-git-send-email-okaya@codeaurora.org>
References: <1498701116-9787-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1498701116-9787-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introducing memset test into dmatest. It allows us to test memset capable
HW using the dmatest suite. The new dmatest value is 2 and it is
changeable through sysfs.

Memset shares the same code path as the other dmatest code. The only
difference is that the first value inside the source buffer is used
to fill in the destination address space.

Source/destination buffers are initialized with the 1 counter value
prior to test so that we can do pattern check against a known expected
value.

An example run us as follows:

echo dma0chan0 > /sys/module/dmatest/parameters/channel
echo 2 >  /sys/module/dmatest/parameters/dmatest
echo 2000 >  /sys/module/dmatest/parameters/timeout
echo 10 >  /sys/module/dmatest/parameters/iterations
echo 1 >  /sys/module/dmatest/parameters/run

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/dmatest.c | 92 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a07ef3d..55f1504 100644
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
@@ -239,46 +240,66 @@ static unsigned long dmatest_random(void)
 	return buf;
 }
 
+static inline u8 gen_inv_idx(u8 index, bool is_memset)
+{
+	u8 val = is_memset ? PATTERN_MEMSET_IDX : index;
+
+	return (~val & PATTERN_COUNT_MASK);
+}
+
+static inline u8 gen_src_value(u8 index, bool is_memset)
+{
+	return PATTERN_SRC | gen_inv_idx(index, is_memset);
+}
+
+static inline u8 gen_dst_value(u8 index, bool is_memset)
+{
+	return PATTERN_DST | gen_inv_idx(index, is_memset);
+}
+
 static void dmatest_init_srcs(u8 **bufs, unsigned int start, unsigned int len,
-		unsigned int buf_size)
+		unsigned int buf_size, bool is_memset)
 {
 	unsigned int i;
 	u8 *buf;
 
 	for (; (buf = *bufs); bufs++) {
 		for (i = 0; i < start; i++)
-			buf[i] = PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_src_value(i, is_memset);
+
 		for ( ; i < start + len; i++)
-			buf[i] = PATTERN_SRC | PATTERN_COPY
-				| (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_src_value(i, is_memset) | PATTERN_COPY;
+
 		for ( ; i < buf_size; i++)
-			buf[i] = PATTERN_SRC | (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_src_value(i, is_memset);
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
 		for (i = 0; i < start; i++)
-			buf[i] = PATTERN_DST | (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_dst_value(i, is_memset);
+
 		for ( ; i < start + len; i++)
-			buf[i] = PATTERN_DST | PATTERN_OVERWRITE
-				| (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_dst_value(i, is_memset) |
+						PATTERN_OVERWRITE;
+
 		for ( ; i < buf_size; i++)
-			buf[i] = PATTERN_DST | (~i & PATTERN_COUNT_MASK);
+			buf[i] = gen_dst_value(i, is_memset);
 	}
 }
 
 static void dmatest_mismatch(u8 actual, u8 pattern, unsigned int index,
-		unsigned int counter, bool is_srcbuf)
+		unsigned int counter, bool is_srcbuf, bool is_memset)
 {
 	u8		diff = actual ^ pattern;
-	u8		expected = pattern | (~counter & PATTERN_COUNT_MASK);
+	u8		expected = pattern | gen_inv_idx(counter, is_memset);
 	const char	*thread_name = current->comm;
 
 	if (is_srcbuf)
@@ -298,7 +319,7 @@ static void dmatest_mismatch(u8 actual, u8 pattern, unsigned int index,
 
 static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 		unsigned int end, unsigned int counter, u8 pattern,
-		bool is_srcbuf)
+		bool is_srcbuf, bool is_memset)
 {
 	unsigned int i;
 	unsigned int error_count = 0;
@@ -311,11 +332,12 @@ static unsigned int dmatest_verify(u8 **bufs, unsigned int start,
 		counter = counter_orig;
 		for (i = start; i < end; i++) {
 			actual = buf[i];
-			expected = pattern | (~counter & PATTERN_COUNT_MASK);
+			expected = pattern | gen_inv_idx(counter, is_memset);
 			if (actual != expected) {
 				if (error_count < MAX_ERROR_COUNT)
 					dmatest_mismatch(actual, pattern, i,
-							 counter, is_srcbuf);
+							 counter, is_srcbuf,
+							 is_memset);
 				error_count++;
 			}
 			counter++;
@@ -435,6 +457,7 @@ static int dmatest_func(void *data)
 	s64			runtime = 0;
 	unsigned long long	total_len = 0;
 	u8			align = 0;
+	bool			is_memset = false;
 
 	set_freezable();
 
@@ -448,6 +471,10 @@ static int dmatest_func(void *data)
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
@@ -571,9 +598,9 @@ static int dmatest_func(void *data)
 			dst_off = (dst_off >> align) << align;
 
 			dmatest_init_srcs(thread->srcs, src_off, len,
-					  params->buf_size);
+					  params->buf_size, is_memset);
 			dmatest_init_dsts(thread->dsts, dst_off, len,
-					  params->buf_size);
+					  params->buf_size, is_memset);
 
 			diff = ktime_sub(ktime_get(), start);
 			filltime = ktime_add(filltime, diff);
@@ -640,6 +667,11 @@ static int dmatest_func(void *data)
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
@@ -722,23 +754,25 @@ static int dmatest_func(void *data)
 		start = ktime_get();
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
@@ -821,6 +855,8 @@ static int dmatest_add_threads(struct dmatest_info *info,
 
 	if (type == DMA_MEMCPY)
 		op = "copy";
+	else if (type == DMA_MEMSET)
+		op = "set";
 	else if (type == DMA_SG)
 		op = "sg";
 	else if (type == DMA_XOR)
@@ -883,6 +919,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
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
@@ -961,6 +1004,7 @@ static void run_threaded_test(struct dmatest_info *info)
 	params->noverify = noverify;
 
 	request_channels(info, DMA_MEMCPY);
+	request_channels(info, DMA_MEMSET);
 	request_channels(info, DMA_XOR);
 	request_channels(info, DMA_SG);
 	request_channels(info, DMA_PQ);
-- 
1.9.1
