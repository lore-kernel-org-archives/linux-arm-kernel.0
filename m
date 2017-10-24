From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 24 Oct 2017 07:47:14 -0700
Subject: [PATCH v3] arm64: optimize __memcpy_fromio and __memcpy_toio
Message-ID: <20171024144726.12855-1-salyzyn@android.com>
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
Cc: robin.murphy at arm.com

v2:
- simplify, do not try so hard, or through steps, to align on the
  normal memory side, as it was a diminishing return.  Dealing with
  any pathological short cases was unnecessary since there does not
  appear to be any.
- drop similar __memset_io changes completely.

v3:
- do not replace 8 with sizeof(u64)

---
 arch/arm64/kernel/io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 354be2a872ae..79b17384effa 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -25,8 +25,7 @@
  */
 void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)from, 8) ||
-			 !IS_ALIGNED((unsigned long)to, 8))) {
+	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
 		*(u8 *)to = __raw_readb(from);
 		from++;
 		to++;
@@ -54,23 +53,22 @@ EXPORT_SYMBOL(__memcpy_fromio);
  */
 void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)to, 8) ||
-			 !IS_ALIGNED((unsigned long)from, 8))) {
-		__raw_writeb(*(volatile u8 *)from, to);
+	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
+		__raw_writeb(*(u8 *)from, to);
 		from++;
 		to++;
 		count--;
 	}
 
 	while (count >= 8) {
-		__raw_writeq(*(volatile u64 *)from, to);
+		__raw_writeq(*(u64 *)from, to);
 		from += 8;
 		to += 8;
 		count -= 8;
 	}
 
 	while (count) {
-		__raw_writeb(*(volatile u8 *)from, to);
+		__raw_writeb(*(u8 *)from, to);
 		from++;
 		to++;
 		count--;
-- 
2.15.0.rc0.271.g36b669edcc-goog
