From: joonwoop@codeaurora.org (Joonwoo Park)
Date: Mon, 13 Oct 2014 21:12:41 -0700
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
In-Reply-To: <20141014040450.GA19810@codeaurora.org>
References: <1406701706-12808-1-git-send-email-joonwoop@codeaurora.org>
 <20140801063009.GA24602@codeaurora.org>
 <20141003163141.GC2384@e104818-lin.cambridge.arm.com>
 <20141009023933.GA21161@codeaurora.org>
 <20141009101613.GD17836@e104818-lin.cambridge.arm.com>
 <20141014040450.GA19810@codeaurora.org>
Message-ID: <20141014041241.GB19810@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 1cb0bb81e0d399255e679337929a8438946a4b9a Mon Sep 17 00:00:00 2001
From: Joonwoo Park <joonwoop@codeaurora.org>
Date: Mon, 28 Jul 2014 17:32:06 -0700
Subject: [PATCH v2] arm64: optimize memcpy_{from,to}io() and memset_io()

Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
as much as possible with minimized barrier usage.  This simplest
optimization brings faster throughput compare to current byte-by-byte read
and write with barrier in the loop.  Code's skeleton is taken from the
powerpc.

Reviewed-by: Trilok Soni <tsoni@codeaurora.org>
Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
---
 Changes in v2:
 * dropped barriers.
 * Use IS_ALIGNED() macro.
 * use __raw_read{b,q} and __raw_write{b,q}.
 * fix bug in __memcpy_toio()

 arch/arm64/kernel/io.c | 66 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 7d37ead..a47cd65 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -25,12 +25,26 @@
  */
 void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
-	unsigned char *t = to;
-	while (count) {
+	while (count && (!IS_ALIGNED((unsigned long)from, 8) ||
+			 !IS_ALIGNED((unsigned long)to, 8))) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
 		count--;
-		*t = readb(from);
-		t++;
+	}
+
+	while (count >= 8) {
+		*(u64 *)to = __raw_readq(from);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
 		from++;
+		to++;
+		count--;
 	}
 }
 EXPORT_SYMBOL(__memcpy_fromio);
@@ -40,12 +54,26 @@ EXPORT_SYMBOL(__memcpy_fromio);
  */
 void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
-	const unsigned char *f = from;
-	while (count) {
+	while (count && (!IS_ALIGNED((unsigned long)to, 8) ||
+			 !IS_ALIGNED((unsigned long)from, 8))) {
+		__raw_writeb(*(volatile u8 *)from, to);
+		from++;
+		to++;
 		count--;
-		writeb(*f, to);
-		f++;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(*(volatile u64 *)from, to);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(*(volatile u8 *)from, to);
+		from++;
 		to++;
+		count--;
 	}
 }
 EXPORT_SYMBOL(__memcpy_toio);
@@ -55,10 +83,28 @@ EXPORT_SYMBOL(__memcpy_toio);
  */
 void __memset_io(volatile void __iomem *dst, int c, size_t count)
 {
-	while (count) {
+	u64 qc = c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+	qc |= qc << 32;
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+		__raw_writeb(c, dst);
+		dst++;
 		count--;
-		writeb(c, dst);
+	}
+
+	while (count >= 8) {
+		__raw_writeq(qc, dst);
+		dst += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
 		dst++;
+		count--;
 	}
 }
 EXPORT_SYMBOL(__memset_io);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
