From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:36 +0100
Subject: [PATCH 5/8] add memory operations
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1386767259-15693-6-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is from Kernel 3.10.

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 string.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 string.h |   10 ++++++
 types.h  |    3 ++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/string.c b/string.c
index ced25c8..ec66b27 100644
--- a/string.c
+++ b/string.c
@@ -1,4 +1,3 @@
-#include "types.h"
 #include "string.h"
 
 int hexlut[1 + 'F' - '0'] = {
@@ -97,3 +96,119 @@ int getaddrs(void **k, void **d, const char *str)
 
 	return 0;
 }
+
+/**
+ * memchr - Find a character in an area of memory.
+ * @s: The memory area
+ * @c: The byte to search for
+ * @n: The size of the area.
+ *
+ * returns the address of the first occurrence of @c, or %NULL
+ * if @c is not found
+ */
+void *memchr(const void *s, int c, size_t n)
+{
+	const unsigned char *p = s;
+	while (n-- != 0) {
+		if ((unsigned char)c == *p++) {
+			return (void *)(p - 1);
+		}
+	}
+	return NULL;
+}
+
+/**
+ * strchr - Find the first occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ */
+char *strchr(const char *s, int c)
+{
+	for (; *s != (char)c; ++s)
+		if (*s == '\0')
+			return NULL;
+	return (char *)s;
+}
+
+/**
+ * memset - Fill a region of memory with the given value
+ * @s: Pointer to the start of the area.
+ * @c: The byte to fill the area with
+ * @count: The size of the area.
+ *
+ * Do not use memset() to access IO space, use memset_io() instead.
+ */
+void *memset(void *s, int c, size_t count)
+{
+	char *xs = s;
+
+	while (count--)
+		*xs++ = c;
+	return s;
+}
+
+/**
+ * memcpy - Copy one area of memory to another
+ * @dest: Where to copy to
+ * @src: Where to copy from
+ * @count: The size of the area.
+ *
+ * You should not use this function to access IO space, use memcpy_toio()
+ * or memcpy_fromio() instead.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
+/**
+ * memmove - Copy one area of memory to another
+ * @dest: Where to copy to
+ * @src: Where to copy from
+ * @count: The size of the area.
+ *
+ * Unlike memcpy(), memmove() copes with overlapping areas.
+ */
+void *memmove(void *dest, const void *src, size_t count)
+{
+	char *tmp;
+	const char *s;
+
+	if (dest <= src) {
+		tmp = dest;
+		s = src;
+		while (count--)
+			*tmp++ = *s++;
+	} else {
+		tmp = dest;
+		tmp += count;
+		s = src;
+		s += count;
+		while (count--)
+			*--tmp = *--s;
+	}
+	return dest;
+}
+
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+#undef memcmp
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
diff --git a/string.h b/string.h
index 0b99785..41ddd3a 100644
--- a/string.h
+++ b/string.h
@@ -1,9 +1,19 @@
 #ifndef _STRING_H
 #define _STRING_H
 
+#include "types.h"
+
 int strlen(const char *);
 int strncmp(const char *, const char *, int);
 void *gethexaddr(const char *, const char **);
 int getaddrs(void **, void **, const char *);
 
+void *memchr(const void *s, int c, size_t n);
+char *strchr(const char *s, int c);
+
+void *memset(void *s, int c, size_t count);
+void *memcpy(void *dest, const void *src, size_t count);
+void *memmove(void *dest, const void *src, size_t count);
+int memcmp(const void *cs, const void *ct, size_t count);
+
 #endif
diff --git a/types.h b/types.h
index 636f95b..b8b4a95 100644
--- a/types.h
+++ b/types.h
@@ -4,6 +4,9 @@
 typedef unsigned char u8;
 typedef unsigned int u32;
 typedef unsigned long long u64;
+
+typedef unsigned long size_t;
+
 #define NULL	((void *) 0)
 
 #endif /* _TYPES_H */
-- 
1.7.9.5
