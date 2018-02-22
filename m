From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 22 Feb 2018 21:15:13 +0900
Subject: [PATCH v3 3/5] linux/const.h: move UL() macro to include/linux/const.h
In-Reply-To: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1519301715-31798-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM, ARM64 and UniCore32 duplicate the definition of UL():

  #define UL(x) _AC(x, UL)

This is not actually arch-specific, so it will be useful to move it
to a common header.  Currently, we only have the uapi variant for
linux/const.h, so I am creating include/linux/const.h.

I also added _UL(), _ULL() and ULL() because _AC() is mostly used in
the form either _AC(..., UL) or _AC(..., ULL).  I expect they will be
replaced in follow-up cleanups.  The underscore-prefixed ones should
be used for exported headers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
V2: https://patchwork.kernel.org/patch/9498275/


Changes in v3: None
Changes in v2: None

 arch/arm/include/asm/memory.h       | 6 ------
 arch/arm64/include/asm/memory.h     | 6 ------
 arch/unicore32/include/asm/memory.h | 6 ------
 include/linux/const.h               | 9 +++++++++
 include/uapi/linux/const.h          | 3 +++
 5 files changed, 12 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/const.h

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4966677..ed8fd0d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -22,12 +22,6 @@
 #include <mach/memory.h>
 #endif
 
-/*
- * Allow for constants defined here to be used from assembly code
- * by prepending the UL suffix only with actual C code compilation.
- */
-#define UL(x) _AC(x, UL)
-
 /* PAGE_OFFSET - the virtual address of the start of the kernel image */
 #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 50fa96a..49d9921 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -29,12 +29,6 @@
 #include <asm/sizes.h>
 
 /*
- * Allow for constants defined here to be used from assembly code
- * by prepending the UL suffix only with actual C code compilation.
- */
-#define UL(x) _AC(x, UL)
-
-/*
  * Size of the PCI I/O space. This must remain a power of two so that
  * IO_SPACE_LIMIT acts as a mask for the low bits of I/O addresses.
  */
diff --git a/arch/unicore32/include/asm/memory.h b/arch/unicore32/include/asm/memory.h
index 3bb0a29..66bb9f6 100644
--- a/arch/unicore32/include/asm/memory.h
+++ b/arch/unicore32/include/asm/memory.h
@@ -20,12 +20,6 @@
 #include <mach/memory.h>
 
 /*
- * Allow for constants defined here to be used from assembly code
- * by prepending the UL suffix only with actual C code compilation.
- */
-#define UL(x) _AC(x, UL)
-
-/*
  * PAGE_OFFSET - the virtual address of the start of the kernel image
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
diff --git a/include/linux/const.h b/include/linux/const.h
new file mode 100644
index 0000000..7b55a55
--- /dev/null
+++ b/include/linux/const.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_CONST_H
+#define _LINUX_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* _LINUX_CONST_H */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index c5a60eb..09bc0e0 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -22,6 +22,9 @@
 #define _AT(T,X)	((T)(X))
 #endif
 
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+
 #define _BITUL(x)	(_AC(1,UL) << (x))
 #define _BITULL(x)	(_AC(1,ULL) << (x))
 
-- 
2.7.4
