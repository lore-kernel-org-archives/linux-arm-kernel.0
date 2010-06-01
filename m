From: raj.khem@gmail.com (Mikael Pettersson)
Date: Tue,  1 Jun 2010 01:05:52 -0700
Subject: [PATCH] Augment __naked__ function attribute with __noinline__ and
	__noclone__
Message-ID: <1275379552-23449-1-git-send-email-mikpe@it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The asm() bodies of naked functions often depend on standard calling
conventions, therefore they must be noinline and noclone.  GCC 4.[56]
currently fail to enforce this, see GCC PR44290.  The effect is that
most arch/arm/mm/copypage-*.c modules get miscompiled, resulting in
kernel crashes during bootup.

Part of the fix is to augment the __naked attribute to imply noinline
and noclone.  This patch implements that, and has been verified to fix
the failure to boot a gcc-4.5 compiled 2.6.34 kernel on a Thecus n2100
(XScale-based mach-iop32x).

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/linux/compiler-gcc.h  |   11 ++++++++++-
 include/linux/compiler-gcc4.h |    4 ++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 73dcf80..83bd87c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -58,8 +58,12 @@
  * naked functions because then mcount is called without stack and frame pointer
  * being set up and there is no chance to restore the lr register to the value
  * before mcount was called.
+ *
+ * The asm() bodies of naked functions often depend on standard calling conventions,
+ * therefore they must be noinline and noclone.  GCC 4.[56] currently fail to enforce
+ * this, so we must do so ourselves.  See GCC PR44290.
  */
-#define __naked				__attribute__((naked)) notrace
+#define __naked				__attribute__((naked)) noinline __noclone notrace
 
 #define __noreturn			__attribute__((noreturn))
 
@@ -85,3 +89,8 @@
 #define _gcc_header(x) __gcc_header(linux/compiler-gcc##x.h)
 #define gcc_header(x) _gcc_header(x)
 #include gcc_header(__GNUC__)
+
+#if !defined(__noclone)
+#define __noclone	/* not needed */
+#endif
+
diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 94dea3f..fcfa5b9 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -48,6 +48,10 @@
  * unreleased.  Really, we need to have autoconf for the kernel.
  */
 #define unreachable() __builtin_unreachable()
+
+/* Mark a function definition as prohibited from being cloned. */
+#define __noclone	__attribute__((__noclone__))
+
 #endif
 
 #endif
-- 
1.7.0.4
