From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:44 -0400
Subject: [PATCH 4/6] ARM: zImage: gather some string functions into string.c
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This is a small subset of string functions needed by commits to come.
Except for memcpy() which is unchanged from its original location, their
implementation is meant to be small, and -Os is enforced to prevent gcc
from doing pointless loop unrolling.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/Makefile |    4 +
 arch/arm/boot/compressed/misc.c   |   42 +------------
 arch/arm/boot/compressed/string.c |  127 +++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/compressed/string.c

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 4867647b97..c20ddc69d9 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -26,6 +26,10 @@ HEAD	= head.o
 OBJS	+= misc.o decompress.o
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
+# string library code (-Os is enforced to keep it much smaller)
+OBJS		+= string.o
+CFLAGS_string.o	:= -Os
+
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 832d37236c..8e2a8fca5e 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -18,14 +18,9 @@
 
 unsigned int __machine_arch_type;
 
-#define _LINUX_STRING_H_
-
 #include <linux/compiler.h>	/* for inline */
-#include <linux/types.h>	/* for size_t */
-#include <linux/stddef.h>	/* for NULL */
+#include <linux/types.h>
 #include <linux/linkage.h>
-#include <asm/string.h>
-
 
 static void putstr(const char *ptr);
 extern void error(char *x);
@@ -101,41 +96,6 @@ static void putstr(const char *ptr)
 	flush();
 }
 
-
-void *memcpy(void *__dest, __const void *__src, size_t __n)
-{
-	int i = 0;
-	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
-
-	for (i = __n >> 3; i > 0; i--) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 2) {
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1 << 1) {
-		*d++ = *s++;
-		*d++ = *s++;
-	}
-
-	if (__n & 1)
-		*d++ = *s++;
-
-	return __dest;
-}
-
 /*
  * gzip declarations
  */
diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
new file mode 100644
index 0000000000..36e53ef920
--- /dev/null
+++ b/arch/arm/boot/compressed/string.c
@@ -0,0 +1,127 @@
+/*
+ * arch/arm/boot/compressed/string.c
+ *
+ * Small subset of simple string routines
+ */
+
+#include <linux/string.h>
+
+void *memcpy(void *__dest, __const void *__src, size_t __n)
+{
+	int i = 0;
+	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
+
+	for (i = __n >> 3; i > 0; i--) {
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+	}
+
+	if (__n & 1 << 2) {
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+		*d++ = *s++;
+	}
+
+	if (__n & 1 << 1) {
+		*d++ = *s++;
+		*d++ = *s++;
+	}
+
+	if (__n & 1)
+		*d++ = *s++;
+
+	return __dest;
+}
+
+void *memmove(void *__dest, __const void *__src, size_t count)
+{
+	unsigned char *d = __dest;
+	const unsigned char *s = __src;
+
+	if (__dest == __src)
+		return __dest;
+
+	if (__dest < __src)
+		return memcpy(__dest, __src, count);
+
+	while (count--)
+		d[count] = s[count];
+	return __dest;
+}
+
+size_t strlen(const char *s)
+{
+	const char *sc = s;
+
+	while (*sc != '\0')
+		sc++;
+	return sc - s;
+}
+
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1 = cs, *su2 = ct, *end = su1 + count;
+	int res = 0;
+
+	while (su1 < end) {
+		res = *su1++ - *su2++;
+		if (res)
+			break;
+	}
+	return res;
+}
+
+int strcmp(const char *cs, const char *ct)
+{
+	unsigned char c1, c2;
+	int res = 0;
+
+	do {
+		c1 = *cs++;
+		c2 = *ct++;
+		res = c1 - c2;
+		if (res)
+			break;
+	} while (c1);
+	return res;
+}
+
+void *memchr(const void *s, int c, size_t count)
+{
+	const unsigned char *p = s;
+
+	while (count--)
+		if ((unsigned char)c == *p++)
+			return (void *)(p - 1);
+	return NULL;
+}
+
+char *strchr(const char *s, int c)
+{
+	while (*s != (char)c)
+		if (*s++ == '\0')
+			return NULL;
+	return (char *)s;
+}
+
+#undef memset
+
+void *memset(void *s, int c, size_t count)
+{
+	char *xs = s;
+	while (count--)
+		*xs++ = c;
+	return s;
+}
+
+void __memzero(void *s, size_t count)
+{
+	memset(s, 0, count);
+}
-- 
1.7.7-rc0
