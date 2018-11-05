From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:47 +0000
Subject: [PATCH 08/10] arm64: string: use asm EXPORT_SYMBOL()
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-9-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a while now it's been possible to use EXPORT_SYMBOL() in assembly
files, which allows us to place exports immediately after assembly
functions, as we do for C functions.

As a step towards removing arm64ksyms.c, let's move the string routine
exports to the assembly files the functions are defined in. Routines
which should only be exported for !KASNA builds are exported using the
EXPORT_SYMBOL_NOKASAN() helper. As we have to include <asm/export.h>,
the existing includes are fixed to follow the usual ordering
conventions.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 20 --------------------
 arch/arm64/lib/memchr.S        |  3 +++
 arch/arm64/lib/memcmp.S        |  3 +++
 arch/arm64/lib/memcpy.S        |  4 ++++
 arch/arm64/lib/memmove.S       |  4 ++++
 arch/arm64/lib/memset.S        |  4 ++++
 arch/arm64/lib/strchr.S        |  3 +++
 arch/arm64/lib/strcmp.S        |  3 +++
 arch/arm64/lib/strlen.S        |  3 +++
 arch/arm64/lib/strncmp.S       |  3 +++
 arch/arm64/lib/strnlen.S       |  3 +++
 arch/arm64/lib/strrchr.S       |  3 +++
 12 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 02019667e319..c142103bc0fe 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -19,7 +19,6 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/string.h>
 #include <linux/cryptohash.h>
 #include <linux/delay.h>
 #include <linux/in6.h>
@@ -29,25 +28,6 @@
 
 #include <asm/checksum.h>
 
-	/* string / mem functions */
-#ifndef CONFIG_KASAN
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memchr);
-#endif
-
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
-EXPORT_SYMBOL(__memmove);
-
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 NOKPROBE_SYMBOL(_mcount);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 0f164a4baf52..2b0e7648a7dd 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -18,7 +18,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * Find a character in an area of memory.
@@ -42,3 +44,4 @@ WEAK(memchr)
 2:	mov	x0, #0
 	ret
 ENDPIPROC(memchr)
+EXPORT_SYMBOL_NOKASAN(memchr)
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index fb295f52e9f8..10d39668ef03 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -23,7 +23,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
 * compare memory areas(when two memory areas' offset are different,
@@ -256,3 +258,4 @@ CPU_LE( rev	data2, data2 )
 	mov	result, #0
 	ret
 ENDPIPROC(memcmp)
+EXPORT_SYMBOL_NOKASAN(memcmp)
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 67613937711f..7bfb34566d79 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -23,8 +23,10 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
 #include <asm/cache.h>
+#include <asm/export.h>
 
 /*
  * Copy a buffer from src to dest (alignment handled by the hardware)
@@ -74,4 +76,6 @@ ENTRY(memcpy)
 #include "copy_template.S"
 	ret
 ENDPIPROC(memcpy)
+EXPORT_SYMBOL(memcpy)
 ENDPROC(__memcpy)
+EXPORT_SYMBOL(__memcpy)
diff --git a/arch/arm64/lib/memmove.S b/arch/arm64/lib/memmove.S
index a5a4459013b1..bf9bedb78594 100644
--- a/arch/arm64/lib/memmove.S
+++ b/arch/arm64/lib/memmove.S
@@ -23,8 +23,10 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
 #include <asm/cache.h>
+#include <asm/export.h>
 
 /*
  * Move a buffer from src to test (alignment handled by the hardware).
@@ -197,4 +199,6 @@ ENTRY(memmove)
 	b.ne	.Ltail63
 	ret
 ENDPIPROC(memmove)
+EXPORT_SYMBOL(memmove)
 ENDPROC(__memmove)
+EXPORT_SYMBOL(__memmove)
diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
index f2670a9f218c..9542cfda590a 100644
--- a/arch/arm64/lib/memset.S
+++ b/arch/arm64/lib/memset.S
@@ -23,8 +23,10 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
 #include <asm/cache.h>
+#include <asm/export.h>
 
 /*
  * Fill in the buffer with character c (alignment handled by the hardware)
@@ -216,4 +218,6 @@ ENTRY(memset)
 	b.ne	.Ltail_maybe_long
 	ret
 ENDPIPROC(memset)
+EXPORT_SYMBOL(memset)
 ENDPROC(__memset)
+EXPORT_SYMBOL(__memset)
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index 7c83091d1bcd..02364e5363c4 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -18,7 +18,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * Find the first occurrence of a character in a string.
@@ -40,3 +42,4 @@ WEAK(strchr)
 	csel	x0, x0, xzr, eq
 	ret
 ENDPROC(strchr)
+EXPORT_SYMBOL_NOKASAN(strchr)
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 7d5d15398bfb..75954df67c35 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -23,7 +23,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * compare two strings
@@ -232,3 +234,4 @@ CPU_BE(	orr	syndrome, diff, has_nul )
 	sub	result, data1, data2, lsr #56
 	ret
 ENDPIPROC(strcmp)
+EXPORT_SYMBOL_NOKASAN(strcmp)
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 8e0b14205dcb..4330a231da43 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -23,7 +23,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * calculate the length of a string
@@ -124,3 +126,4 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )	/* Shift (tmp1 & 63).  */
 	csel	data2, data2, data2a, le
 	b	.Lrealigned
 ENDPIPROC(strlen)
+EXPORT_SYMBOL_NOKASAN(strlen)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index 66bd145935d9..47bc24ae5ebc 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -23,7 +23,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * compare two strings
@@ -308,3 +310,4 @@ CPU_BE( orr	syndrome, diff, has_nul )
 	mov	result, #0
 	ret
 ENDPIPROC(strncmp)
+EXPORT_SYMBOL_NOKASAN(strncmp)
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index 355be04441fe..e68b30f71ee9 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -23,7 +23,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * determine the length of a fixed-size string
@@ -169,3 +171,4 @@ CPU_LE( lsr	tmp2, tmp2, tmp4 )	/* Shift (tmp1 & 63).  */
 	mov	len, limit
 	ret
 ENDPIPROC(strnlen)
+EXPORT_SYMBOL_NOKASAN(strnlen)
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index ea84924d5990..668934e99172 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -18,7 +18,9 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * Find the last occurrence of a character in a string.
@@ -41,3 +43,4 @@ WEAK(strrchr)
 2:	mov	x0, x3
 	ret
 ENDPIPROC(strrchr)
+EXPORT_SYMBOL_NOKASAN(strrchr)
-- 
2.11.0
