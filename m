From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Mon,  6 Nov 2017 10:31:51 +0100
Subject: [PATCH v4] arm64: support __int128 on gcc 5+
In-Reply-To: <20171103141858.13149-1-Jason@zx2c4.com>
References: <20171103141858.13149-1-Jason@zx2c4.com>
Message-ID: <20171106093151.8312-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versions of gcc prior to gcc 5 emitted a __multi3 function call when
dealing with TI types, resulting in failures when trying to link to
libgcc, and more generally, bad performance. However, since gcc 5,
the compiler supports actually emitting fast instructions, which means
we can at long last enable this option and receive the speedups.

The gcc commit that added proper Aarch64 support is:
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=d1ae7bb994f49316f6f63e6173f2931e837a351d
This commit appears to be part of the gcc 5 release.

There are still a few instructions, __ashlti3 and __ashrti3, which
require libgcc, which is fine. Rather than linking to libgcc, we
simply provide them ourselves, since they're not that complicated.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v3->v4:
  - Typo in comment
  - Relabel second function

 arch/arm64/Makefile      |  2 ++
 arch/arm64/lib/Makefile  |  2 +-
 arch/arm64/lib/tishift.S | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/tishift.S

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 939b310913cf..1f8a0fec6998 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -53,6 +53,8 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index a0abc142c92b..55bdb01f1ea6 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -2,7 +2,7 @@ lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
-		   strchr.o strrchr.o
+		   strchr.o strrchr.o tishift.o
 
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
new file mode 100644
index 000000000000..bffe03c478a5
--- /dev/null
+++ b/arch/arm64/lib/tishift.S
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(__ashlti3)
+	cbz	x2, 1f
+	mov	x3, #64
+	sub	x3, x3, x2
+	cmp	x3, #0
+	b.le	2f
+	lsl	x1, x1, x2
+	lsr	x3, x0, x3
+	lsl	x2, x0, x2
+	orr	x1, x1, x3
+	mov	x0, x2
+1:
+	ret
+2:
+	neg	w1, w3
+	mov	x2, #0
+	lsl	x1, x0, x1
+	mov	x0, x2
+	ret
+ENDPROC(__ashlti3)
+
+ENTRY(__ashrti3)
+	cbz	x2, 1f
+	mov	x3, #64
+	sub	x3, x3, x2
+	cmp	x3, #0
+	b.le	2f
+	lsr	x0, x0, x2
+	lsl	x3, x1, x3
+	asr	x2, x1, x2
+	orr	x0, x0, x3
+	mov	x1, x2
+1:
+	ret
+2:
+	neg	w0, w3
+	asr	x2, x1, #63
+	asr	x0, x1, x0
+	mov	x1, x2
+	ret
+ENDPROC(__ashrti3)
-- 
2.15.0
