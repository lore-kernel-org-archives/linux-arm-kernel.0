From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu,  6 Sep 2018 20:05:33 +0300
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
Message-ID: <20180906170534.20726-1-aryabinin@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
code, thus it can potentially miss many bugs.

Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
enabled, so the generic implementations from lib/string.c will be used.

Declare asm functions as weak instead of removing them because they
still can be used by efistub.

Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/arm64/include/asm/string.h | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
 arch/arm64/lib/memchr.S         |  1 +
 arch/arm64/lib/memcmp.S         |  1 +
 arch/arm64/lib/strchr.S         |  1 +
 arch/arm64/lib/strcmp.S         |  1 +
 arch/arm64/lib/strlen.S         |  1 +
 arch/arm64/lib/strncmp.S        |  1 +
 arch/arm64/lib/strnlen.S        |  1 +
 arch/arm64/lib/strrchr.S        |  1 +
 10 files changed, 21 insertions(+), 8 deletions(-)

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
index 4444c1d25f4b..b790ec0228f6 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,6 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
+.weak memchr
 ENTRY(memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..de9975b0afda 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,6 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
+.weak memcmp
 ENTRY(memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..10799adb8d5f 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,6 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
+.weak strchr
 ENTRY(strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..5629b4fa5431 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,6 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
+.weak strcmp
 ENTRY(strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..f00df4b1b8d9 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,6 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
+.weak strlen
 ENTRY(strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..28563ac1c19f 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,6 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
+.weak strncmp
 ENTRY(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..bdbfd41164f4 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,6 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
+.weak strnlen
 ENTRY(strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..31c77f605014 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,6 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
+.weak strrchr
 ENTRY(strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
-- 
2.16.4
