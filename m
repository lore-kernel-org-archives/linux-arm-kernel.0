From: max@stro.at (maximilian attems)
Date: Tue, 17 May 2011 18:17:10 +0200
Subject: [PATCH] [klibc] arm: use bx on thumb2 v3
Message-ID: <1305649031-15622-1-git-send-email-max@stro.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use klibc way to define a system dependent preprocessor
definition: disabled by default and enabled for newer arm.

Based on a patch by vorlon that got tested on his beagleboard,
should be functional equivalent.
Fixes: https://bugs.launchpad.net/ubuntu/+source/klibc/+bug/527720

Cc: Steve Langasek <steve.langasek@canonical.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: maximilian attems <max@stro.at>
---
 usr/include/arch/arm/klibc/archconfig.h |    6 +++++-
 usr/include/arch/arm/klibc/asmmacros.h  |    6 ++++++
 usr/include/klibc/sysconfig.h           |    9 +++++++++
 usr/klibc/arch/arm/setjmp.S             |   10 ++++++----
 usr/klibc/arch/arm/vfork.S              |    5 +++--
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/usr/include/arch/arm/klibc/archconfig.h b/usr/include/arch/arm/klibc/archconfig.h
index e34bdb7..36e9ab5 100644
--- a/usr/include/arch/arm/klibc/archconfig.h
+++ b/usr/include/arch/arm/klibc/archconfig.h
@@ -9,6 +9,10 @@
 #ifndef _KLIBC_ARCHCONFIG_H
 #define _KLIBC_ARCHCONFIG_H
 
-/* All defaults */
+/* newer arm arch support bx instruction */
+#if (!defined(__ARM_ARCH_2__) && !defined(__ARM_ARCH_3__) \
+	&& !defined(__ARM_ARCH_3M__) && !defined(__ARM_ARCH_4__))
+# define _KLIBC_ARM_USE_BX 1
+#endif
 
 #endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/arm/klibc/asmmacros.h b/usr/include/arch/arm/klibc/asmmacros.h
index 8a21c94..45bea0e 100644
--- a/usr/include/arch/arm/klibc/asmmacros.h
+++ b/usr/include/arch/arm/klibc/asmmacros.h
@@ -27,4 +27,10 @@
 	 (((x) & ~0xf000000f) == 0) || \
 	 (((x) & ~0xc000003f) == 0))
 
+#if _KLIBC_ARM_USE_BX
+# define BX(x) bx	##x
+#else
+# define BX(x) mov	pc, ##x
+#endif
+
 #endif /* _KLIBC_ASMMACROS_H */
diff --git a/usr/include/klibc/sysconfig.h b/usr/include/klibc/sysconfig.h
index bf1daf5..a1c37fd 100644
--- a/usr/include/klibc/sysconfig.h
+++ b/usr/include/klibc/sysconfig.h
@@ -196,4 +196,13 @@
 # define _KLIBC_SYS_SOCKETCALL 0
 #endif
 
+/*
+ * _KLIBC_ARM_USE_BX
+ *
+ *	This arm architecture supports bx instruction.
+ */
+#ifndef _KLIBC_ARM_USE_BX
+# define _KLIBC_ARM_USE_BX 0
+#endif
+
 #endif /* _KLIBC_SYSCONFIG_H */
diff --git a/usr/klibc/arch/arm/setjmp.S b/usr/klibc/arch/arm/setjmp.S
index 2232458..6018bda 100644
--- a/usr/klibc/arch/arm/setjmp.S
+++ b/usr/klibc/arch/arm/setjmp.S
@@ -4,6 +4,8 @@
 # setjmp/longjmp for the ARM architecture
 #
 
+#include <klibc/asmmacros.h>
+
 #ifndef	__thumb__
 
 #
@@ -29,7 +31,7 @@
 setjmp:
 	stmia	r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
 	mov	r0, #0
-	mov	pc, lr
+	BX(lr)
 	.size setjmp,.-setjmp
 
 	.text
@@ -39,7 +41,7 @@ setjmp:
 longjmp:
 	ldmia	r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
 	mov	r0, r1
-	mov	pc, lr
+	BX(lr)
 	.size longjmp,.-longjmp
 
 #else /* __thumb__ */
@@ -75,7 +77,7 @@ setjmp:
 	mov	r7, sp
 	stmia	r0!, {r3, r4, r5, r6, r7}
 	mov	r0, #0
-	mov	pc, lr
+	BX(lr)
 	.size setjmp,.-setjmp
 
 	.text
@@ -96,7 +98,7 @@ longjmp:
 	mov	r0, r1
 	bne	1f
 	mov	r0, #1
-1:	mov	pc, r3
+1:	BX(r3)
 	.size longjmp,.-longjmp
 
 #endif /* __thumb__ */
diff --git a/usr/klibc/arch/arm/vfork.S b/usr/klibc/arch/arm/vfork.S
index 3b2d9f7..7130b65 100644
--- a/usr/klibc/arch/arm/vfork.S
+++ b/usr/klibc/arch/arm/vfork.S
@@ -4,6 +4,7 @@
  * vfork - nasty system call which must not use the stack.
  */
 
+#include <klibc/asmmacros.h>
 #include <asm/unistd.h>
 
 	.type	vfork,#function
@@ -25,7 +26,7 @@ vfork:
         ldrcs	r3, 1f
         mvncs	r0, #0
         strcs	r2, [r3]
-	mov	pc, lr
+	BX(lr)
 
 	.balign 4
 1:
@@ -49,7 +50,7 @@ vfork:
 	str	r2, [r1]
 	neg	r0, r0
 1:
-	mov	pc, lr
+	BX(lr)
 
 	.balign	4
 2:
-- 
1.7.2.5
