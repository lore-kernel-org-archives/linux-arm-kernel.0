From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 20 Sep 2018 16:56:30 +0300
Subject: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN enabled.
In-Reply-To: <20180920135631.23833-1-aryabinin@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
Message-ID: <20180920135631.23833-2-aryabinin@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
code, thus it can potentially miss many bugs.

Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
enabled, so the generic implementations from lib/string.c will be used.

We can't just remove the asm functions because efistub uses them.
And we can't have two non-weak functions either, so declare the asm
functions as weak.

Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
Changes since v1:
 - Use WEAK() instead of .weak

 arch/arm64/include/asm/string.h | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
 arch/arm64/lib/memchr.S         |  2 +-
 arch/arm64/lib/memcmp.S         |  2 +-
 arch/arm64/lib/strchr.S         |  2 +-
 arch/arm64/lib/strcmp.S         |  2 +-
 arch/arm64/lib/strlen.S         |  2 +-
 arch/arm64/lib/strncmp.S        |  2 +-
 arch/arm64/lib/strnlen.S        |  2 +-
 arch/arm64/lib/strrchr.S        |  2 +-
 10 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33a5bd5..03a6c256b7ec 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
+#ifndef CONFIG_KASAN
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -34,6 +35,13 @@ extern __kernel_size_t strlen(const char *);
 #define __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *, const void *, size_t);
+
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *, int, __kernel_size_t);
+#endif
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
@@ -42,16 +50,10 @@ extern void *__memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCHR
-extern void *memchr(const void *, int, __kernel_size_t);
-
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, __kernel_size_t);
 extern void *__memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *, const void *, size_t);
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20b70b2..72f63a59b008 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -44,20 +44,23 @@ EXPORT_SYMBOL(__arch_copy_in_user);
 EXPORT_SYMBOL(memstart_addr);
 
 	/* string / mem functions */
+#ifndef CONFIG_KASAN
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memchr);
+#endif
+
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(memcmp);
 
 	/* atomic bitops */
 EXPORT_SYMBOL(set_bit);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 4444c1d25f4b..0f164a4baf52 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,7 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(memchr)
+WEAK(memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
 	b.mi	2f
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..fb295f52e9f8 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,7 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
-ENTRY(memcmp)
+WEAK(memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	tst	tmp1, #7
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..7c83091d1bcd 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(strchr)
+WEAK(strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
 	cmp	w2, w1
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..7d5d15398bfb 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,7 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
-ENTRY(strcmp)
+WEAK(strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..8e0b14205dcb 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,7 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strlen)
+WEAK(strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
 	ands	tmp1, srcin, #15
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..66bd145935d9 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,7 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
-ENTRY(strncmp)
+WEAK(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..355be04441fe 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,7 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strnlen)
+WEAK(strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..ea84924d5990 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
-ENTRY(strrchr)
+WEAK(strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
-- 
2.16.4
