From: msalter@redhat.com (Mark Salter)
Date: Wed, 31 Aug 2011 17:26:36 -0400
Subject: [PATCH 01/24] fix default __strnlen_user macro
In-Reply-To: <1314826019-22330-1-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
Message-ID: <1314826019-22330-2-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing __strnlen_user macro simply resolved to strnlen. However, the
count returned by strnlen_user should include the NULL byte. This patch
fixes the __strnlen_user macro to include the NULL byte in the count.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index ac68c99..1d0fdf8 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -289,7 +289,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
  * Return 0 on exception, a value greater than N if too long
  */
 #ifndef __strnlen_user
-#define __strnlen_user strnlen
+#define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
 #endif
 
 static inline long strnlen_user(const char __user *src, long n)
-- 
1.7.6
