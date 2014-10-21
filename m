From: joonwoop@codeaurora.org (Joonwoo Park)
Date: Mon, 20 Oct 2014 17:59:03 -0700
Subject: [PATCH] arm64: optimize memcpy_{from,to}io() and memset_io()
Message-ID: <1413853143-30978-1-git-send-email-joonwoop@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimize memcpy_{from,to}io() and memset_io() by transferring in 64 bit
as much as possible with minimized barrier usage.  This simplest
optimization brings faster throughput compare to current byte-by-byte read
and write with barrier in the loop.  Code's skeleton is taken from the
powerpc.

Link: http://lkml.kernel.org/p/20141020133304.GH23751 at e104818-lin.cambridge.arm.com
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Trilok Soni <tsoni@codeaurora.org>
Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
---
 arch/arm64/kernel/io.c | 66 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 7d37ead..354be2a 100644
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
+	u64 qc = (u8)c;
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
