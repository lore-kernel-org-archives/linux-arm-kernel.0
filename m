From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 17 Dec 2015 10:39:26 -0800 (PST)
Subject: [PATCH 3/3] Use the new batched user accesses in generic user string
 handling
Message-ID: <alpine.LFD.2.20.1512171037350.27310@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Dec 2015 10:05:19 -0800
Subject: [PATCH 3/3] Use the new batched user accesses in generic user string handling

This converts the generic user string functions to use the batched user
access functions.

It makes a big difference on x86 microarchitectures that implement SMAP.  
The STAC/CLAC instructions are not very fast, and doing them for each 
access inside the loop that copies strings from user space (which is what 
the pathname handling does for every pathname the kernel uses, for 
example) is very inefficient.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 lib/strncpy_from_user.c | 11 ++++++++---
 lib/strnlen_user.c      | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index e0af6ff73d14..33840324138c 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -39,7 +39,7 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src, long
 		unsigned long c, data;
 
 		/* Fall back to byte-at-a-time if we get a page fault */
-		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
+		if (unlikely(unsafe_get_user(c,(unsigned long __user *)(src+res))))
 			break;
 		*(unsigned long *)(dst+res) = c;
 		if (has_zero(c, &data, &constants)) {
@@ -55,7 +55,7 @@ byte_at_a_time:
 	while (max) {
 		char c;
 
-		if (unlikely(__get_user(c,src+res)))
+		if (unlikely(unsafe_get_user(c,src+res)))
 			return -EFAULT;
 		dst[res] = c;
 		if (!c)
@@ -107,7 +107,12 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-		return do_strncpy_from_user(dst, src, count, max);
+		long retval;
+
+		user_access_begin();
+		retval = do_strncpy_from_user(dst, src, count, max);
+		user_access_end();
+		return retval;
 	}
 	return -EFAULT;
 }
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 3a5f2b366d84..2625943625d7 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -45,7 +45,7 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	src -= align;
 	max += align;
 
-	if (unlikely(__get_user(c,(unsigned long __user *)src)))
+	if (unlikely(unsafe_get_user(c,(unsigned long __user *)src)))
 		return 0;
 	c |= aligned_byte_mask(align);
 
@@ -61,7 +61,7 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 		if (unlikely(max <= sizeof(unsigned long)))
 			break;
 		max -= sizeof(unsigned long);
-		if (unlikely(__get_user(c,(unsigned long __user *)(src+res))))
+		if (unlikely(unsafe_get_user(c,(unsigned long __user *)(src+res))))
 			return 0;
 	}
 	res -= align;
@@ -112,7 +112,12 @@ long strnlen_user(const char __user *str, long count)
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-		return do_strnlen_user(str, count, max);
+		long retval;
+
+		user_access_begin();
+		retval = do_strnlen_user(str, count, max);
+		user_access_end();
+		return retval;
 	}
 	return 0;
 }
@@ -141,7 +146,12 @@ long strlen_user(const char __user *str)
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-		return do_strnlen_user(str, ~0ul, max);
+		long retval;
+
+		user_access_begin();
+		retval = do_strnlen_user(str, ~0ul, max);
+		user_access_end();
+		return retval;
 	}
 	return 0;
 }
-- 
2.7.0.rc1
