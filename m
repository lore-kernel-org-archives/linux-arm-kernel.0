From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Jan 2017 11:20:09 +0900
Subject: [PATCH v2 4/4] linux/const.h: move BIT(_ULL) to linux/const.h for use
 in assembly
In-Reply-To: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1483582810-7046-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2fc016c5bd8a ("linux/const.h: Add _BITUL() and _BITULL()")
introduced _BITUL() and _BITULL().  Its git-log says the difference
from the already existing BIT() are:

  1. The namespace is such that they can be used in uapi definitions.
  2. The type is set with the _AC() macro to allow it to be used in
     assembly.
  3. The type is explicitly specified to be UL or ULL.

However, I found _BITUL() is often used for "2. use in assembly",
while "1. use in uapi" is unneeded.  If we address only "2.", we can
improve the existing BIT() for that.  It will allow us to replace
many _BITUL() instances with BIT(), i.e. avoid needless use of
underscore-prefixed macros, in the end, for better de-couple of
userspace/kernel headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 include/linux/bitops.h | 3 +--
 include/linux/const.h  | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a83c822..5f45fa5 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -1,10 +1,9 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
+#include <linux/const.h>
 #include <asm/types.h>
 
 #ifdef	__KERNEL__
-#define BIT(nr)			(1UL << (nr))
-#define BIT_ULL(nr)		(1ULL << (nr))
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
diff --git a/include/linux/const.h b/include/linux/const.h
index 7b55a55..200892d 100644
--- a/include/linux/const.h
+++ b/include/linux/const.h
@@ -6,4 +6,7 @@
 #define UL(x)		(_UL(x))
 #define ULL(x)		(_ULL(x))
 
+#define BIT(x)		(_BITUL(x))
+#define BIT_ULL(x)	(_BITULL(x))
+
 #endif /* _LINUX_CONST_H */
-- 
2.7.4
