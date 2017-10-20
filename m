From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 20 Oct 2017 13:22:36 -0700
Subject: [PATCH] arch64: optimize __memcpy_fromio,
 __memcpy_toio and __memset_io
Message-ID: <20171020202327.2592-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__memcpy_fromio and __memcpy_toio functions do not deal well with
harmonically unaligned addresses unless they can ultimately be
copied as quads (u64) to and from the destination.  Without a
harmonically aligned relationship, they perform byte operations
over the entire buffer.

Added optional paths that perform reads and writes at the best
alignment possible with source and destination, placing a priority
on using quads (8 byte transfers) on the io-side.

Removed the volatile on the source for __memcpy_toio as it is
unnecessary.

This change was motivated by performance issues in the pstore driver.
On a test platform, measuring probe time for pstore, console buffer
size of 1/4MB and pmsg of 1/2MB, was in the 90-107ms region. Change
managed to reduce it to worst case 15ms, an improvement in boot time.

Adjusted __memset_io to use the same pattern of access, although it
does not have a harmonic relationship between two pointers to worry
about, and thus the benefit is balance and not nearly as dramatic.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org

---
 arch/arm64/kernel/io.c | 199 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 156 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 354be2a872ae..14ef7c8f20ea 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -20,61 +20,147 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
+/* if/while helpers assume from, to and count vars accessible in caller */
+
+/* arguments to helpers to ensure proper combinations */
+#define	byte		b, u8
+#define	word		w, u16
+#define	longword	l, u32
+#define	quad		q, u64
+
+/* read helper for unaligned transfers needing intermediate hold and memcpy */
+#define	_do_unaligned_read(op, align_type, width, type) do {	\
+	op(count >= sizeof(type)) {				\
+		type hold = __raw_read##width##(from);		\
+								\
+		memcpy((align_type *)to, &hold, sizeof(type));	\
+		to += sizeof(type);				\
+		from += sizeof(type);				\
+		count -= sizeof(type);				\
+	}							\
+} while (0)
+#define if_unaligned_read(type, x) _do_unaligned_read(if, type, x)
+#define while_unaligned_read(type, x) _do_unaligned_read(while, type, x)
+
+/* read helper for aligned transfers */
+#define	_do_aligned_read(op, width, type) \
+	_do_unaligned_read(op, type, width, type)
+#define if_aligned_read(x) _do_aligned_read(if, x)
+#define while_aligned_read(x) _do_aligned_read(while, x)
+
 /*
  * Copy data from IO memory space to "real" memory space.
  */
+
 void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)from, 8) ||
-			 !IS_ALIGNED((unsigned long)to, 8))) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u16)))
+		if_aligned_read(byte);
 
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u16))) {
+		if (!IS_ALIGNED((unsigned long)from, sizeof(u32)))
+			if_unaligned_read(u8, word);
+		if (!IS_ALIGNED((unsigned long)from, sizeof(u64)))
+			if_unaligned_read(u8, longword);
+		while_unaligned_read(u8, quad);
+		if_unaligned_read(u8, longword);
+		if_unaligned_read(u8, word);
+		if_aligned_read(byte);
+		return;
 	}
 
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u32)))
+		if_aligned_read(word);
+
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u32))) {
+		if (!IS_ALIGNED((unsigned long)from, sizeof(u64)))
+			if_unaligned_read(u16, longword);
+		while_unaligned_read(u16, quad);
+		if_unaligned_read(u16, longword);
+		if_aligned_read(word);
+		if_aligned_read(byte);
+		return;
 	}
+
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u64)))
+		if_aligned_read(longword);
+
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u64)))
+		while_unaligned_read(u32, quad);
+	else
+		while_aligned_read(quad);
+
+	if_aligned_read(longword);
+	if_aligned_read(word);
+	if_aligned_read(byte);
 }
 EXPORT_SYMBOL(__memcpy_fromio);
 
+/* write helper for unaligned transfers needing intermediate hold and memcpy */
+#define	_do_unaligned_write(op, align_type, width, type) do {	\
+	op(count >= sizeof(type)) {				\
+		type hold;					\
+								\
+		memcpy(&hold, (align_type *)from, sizeof(type));\
+		__raw_write##width##(hold, to);			\
+		to += sizeof(type);				\
+		from += sizeof(type);				\
+		count -= sizeof(type);				\
+	}							\
+} while (0)
+#define if_unaligned_write(type, x) _do_unaligned_write(if, type, x)
+#define while_unaligned_write(type, x) _do_unaligned_write(while, type, x)
+
+/* write helper for aligned transfers */
+#define	_do_aligned_write(op, width, type) \
+	_do_unaligned_write(op, type, width, type)
+#define if_aligned_write(x) _do_aligned_write(if, x)
+#define while_aligned_write(x) _do_aligned_write(while, x)
+
 /*
  * Copy data from "real" memory space to IO memory space.
  */
 void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
-	while (count && (!IS_ALIGNED((unsigned long)to, 8) ||
-			 !IS_ALIGNED((unsigned long)from, 8))) {
-		__raw_writeb(*(volatile u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u16)))
+		if_aligned_write(byte);
 
-	while (count >= 8) {
-		__raw_writeq(*(volatile u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u16))) {
+		if (!IS_ALIGNED((unsigned long)to, sizeof(u32)))
+			if_unaligned_write(u8, word);
+		if (!IS_ALIGNED((unsigned long)to, sizeof(u64)))
+			if_unaligned_write(u8, longword);
+		while_unaligned_write(u8, quad);
+		if_unaligned_write(u8, longword);
+		if_unaligned_write(u8, word);
+		if_aligned_write(byte);
+		return;
 	}
 
-	while (count) {
-		__raw_writeb(*(volatile u8 *)from, to);
-		from++;
-		to++;
-		count--;
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u32)))
+		if_aligned_write(word);
+
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u32))) {
+		if (!IS_ALIGNED((unsigned long)to, sizeof(u64)))
+			if_unaligned_write(u16, longword);
+		while_unaligned_write(u16, quad);
+		if_unaligned_write(u16, longword);
+		if_aligned_write(word);
+		if_aligned_write(byte);
+		return;
 	}
+
+	if (!IS_ALIGNED((unsigned long)to, sizeof(u64)))
+		if_aligned_write(longword);
+
+	if (!IS_ALIGNED((unsigned long)from, sizeof(u64)))
+		while_unaligned_write(u32, quad);
+	else
+		while_aligned_write(quad);
+
+	if_aligned_write(longword);
+	if_aligned_write(word);
+	if_aligned_write(byte);
 }
 EXPORT_SYMBOL(__memcpy_toio);
 
@@ -89,22 +175,49 @@ void __memset_io(volatile void __iomem *dst, int c, size_t count)
 	qc |= qc << 16;
 	qc |= qc << 32;
 
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+	if ((count >= sizeof(u8)) &&
+	    !IS_ALIGNED((unsigned long)dst, sizeof(u16))) {
 		__raw_writeb(c, dst);
-		dst++;
-		count--;
+		dst += sizeof(u8);
+		count -= sizeof(u8);
+	}
+
+	if ((count >= sizeof(u16)) &&
+	    !IS_ALIGNED((unsigned long)dst, sizeof(u32))) {
+		__raw_writew((u16)qc, dst);
+		dst += sizeof(u16);
+		count -= sizeof(u16);
 	}
 
-	while (count >= 8) {
+	if ((count >= sizeof(u32)) &&
+	    !IS_ALIGNED((unsigned long)dst, sizeof(u64))) {
+		__raw_writel((u32)qc, dst);
+		dst += sizeof(u32);
+		count -= sizeof(u32);
+	}
+
+	while (count >= sizeof(u64)) {
 		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
+		dst += sizeof(u64);
+		count -= sizeof(u64);
+	}
+
+	if (count >= sizeof(u32)) {
+		__raw_writel((u32)qc, dst);
+		dst += sizeof(u32);
+		count -= sizeof(u32);
+	}
+
+	if (count >= sizeof(u16)) {
+		__raw_writew((u16)qc, dst);
+		dst += sizeof(u16);
+		count -= sizeof(u16);
 	}
 
-	while (count) {
+	if (count) {
 		__raw_writeb(c, dst);
-		dst++;
-		count--;
+		dst += sizeof(u8);
+		count -= sizeof(u8);
 	}
 }
 EXPORT_SYMBOL(__memset_io);
-- 
2.15.0.rc0.271.g36b669edcc-goog
