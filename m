From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 23 Oct 2017 09:25:35 -0700
Subject: [PATCH v2] arm64: optimize __memcpy_fromio and __memcpy_toio
Message-ID: <20171023162611.37098-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__memcpy_fromio and __memcpy_toio functions do not deal well with
harmonically unaligned addresses unless they can ultimately be
copied as quads (u64) to and from the destination.  Without a
harmonically aligned relationship, they perform byte operations
over the entire buffer.

Dropped the fragment that tried to align on the normal memory,
placing a priority on using quad alignment on the io-side.

Removed the volatile on the source for __memcpy_toio as it is
unnecessary.

This change was motivated by performance issues in the pstore driver.
On a test platform, measuring probe time for pstore, console buffer
size of 1/4MB and pmsg of 1/2MB, was in the 90-107ms region. Change
managed to reduce it to 10-25ms, an improvement in boot time.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org

v2:
- simplify, do not try so hard, or through steps, to align on the
  normal memory side, as it was a diminishing return.  Dealing with
  any pathological short cases was unnecessary since there does not
  appear to be any.
- drop similar __memset_io changes completely.

---
 arch/arm64/kernel/io.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 354be2a872ae..fc039093fa9a 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -25,19 +25,18 @@
  */
 void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)from, 8) ||
-			 !IS_ALIGNED((unsigned long)to, 8))) {
+	while (count && !IS_ALIGNED((unsigned long)from, sizeof(u64))) {
 		*(u8 *)to = __raw_readb(from);
 		from++;
 		to++;
 		count--;
 	}
 
-	while (count >= 8) {
+	while (count >= sizeof(u64)) {
 		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
+		from += sizeof(u64);
+		to += sizeof(u64);
+		count -= sizeof(u64);
 	}
 
 	while (count) {
@@ -54,23 +53,22 @@ EXPORT_SYMBOL(__memcpy_fromio);
  */
 void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)to, 8) ||
-			 !IS_ALIGNED((unsigned long)from, 8))) {
-		__raw_writeb(*(volatile u8 *)from, to);
+	while (count && !IS_ALIGNED((unsigned long)to, sizeof(u64))) {
+		__raw_writeb(*(u8 *)from, to);
 		from++;
 		to++;
 		count--;
 	}
 
-	while (count >= 8) {
-		__raw_writeq(*(volatile u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
+	while (count >= sizeof(u64)) {
+		__raw_writeq(*(u64 *)from, to);
+		from += sizeof(u64);
+		to += sizeof(u64);
+		count -= sizeof(u64);
 	}
 
 	while (count) {
-		__raw_writeb(*(volatile u8 *)from, to);
+		__raw_writeb(*(u8 *)from, to);
 		from++;
 		to++;
 		count--;
@@ -89,16 +87,16 @@ void __memset_io(volatile void __iomem *dst, int c, size_t count)
 	qc |= qc << 16;
 	qc |= qc << 32;
 
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+	while (count && !IS_ALIGNED((unsigned long)dst, sizeof(u64))) {
 		__raw_writeb(c, dst);
 		dst++;
 		count--;
 	}
 
-	while (count >= 8) {
+	while (count >= sizeof(u64)) {
 		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
+		dst += sizeof(u64);
+		count -= sizeof(u64);
 	}
 
 	while (count) {
-- 
2.15.0.rc0.271.g36b669edcc-goog
