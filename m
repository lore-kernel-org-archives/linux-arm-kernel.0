From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 16:23:14 -0700
Subject: [PATCH] arm64: LLVMLinux: Provide __aeabi_* symbols which are needed
 for clang
Message-ID: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

These symbols are required when compiling the Linux kernel for arch ARM64 with
clang.

Author: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm64/lib/Makefile |  4 ++++
 arch/arm64/lib/eabi.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/lib/eabi.c

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index d98d3e3..0d3407c 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -3,3 +3,7 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o
+
+ifeq ($(COMPILER),clang)
+lib-y += eabi.o
+endif
diff --git a/arch/arm64/lib/eabi.c b/arch/arm64/lib/eabi.c
new file mode 100644
index 0000000..41b27b2
--- /dev/null
+++ b/arch/arm64/lib/eabi.c
@@ -0,0 +1,32 @@
+/*
+ *  linux/lib/eabi.c
+ *
+ *  Copyright (C) 2012  Mark Charlebois
+ */
+
+/*
+ * EABI routines
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/export.h>
+
+void __aeabi_memcpy(void *dest, const void *src, size_t n)
+{
+	(void)memcpy(dest, src, n);
+}
+EXPORT_SYMBOL(__aeabi_memcpy);
+
+void __aeabi_memmove(void *dest, const void *src, size_t n)
+{
+	(void)memmove(dest, src, n);
+}
+EXPORT_SYMBOL(__aeabi_memmove);
+
+void __aeabi_memset(void *s, size_t n, int c)
+{
+	(void)memset(s, c, n);
+}
+EXPORT_SYMBOL(__aeabi_memset);
-- 
1.9.1
