From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 21:19:11 +0100
Subject: [PATCH] ARM: define __BUG as asm(BUG_INSTR) without CONFIG_BUG
Message-ID: <3990954.Eb8lJumAbB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following (a long time after) a4b5d580e078 ("bug: Make BUG() always stop
the machine"), this adapts the ARM architecture to no longer rely
on the sub-optimal BUG() definition that has a silent endless loop
but instead use the same trapping instruction that we have for
the full BUG() support.

This avoids hundreds of warnings like

arch/arm/include/asm/xen/page.h: In function 'arbitrary_virt_to_machine':
arch/arm/include/asm/xen/page.h:85:1: warning: no return statement in function returning non-void [-Wreturn-type]

and also makes the code size slightly smaller. The behavior changes
from silently stopping the kernel to an oops, and follows what x86
does these days.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This patch was hiding in my randconfig-fixes branch merged into some other
commit, so I totally forgot about it.

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index e7335a92144e..4e6e88a6b2f4 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -5,8 +5,6 @@
 #include <linux/types.h>
 #include <asm/opcodes.h>
 
-#ifdef CONFIG_BUG
-
 /*
  * Use a suitable undefined instruction to use for ARM/Thumb2 bug handling.
  * We need to be careful not to conflict with those used by other modules and
@@ -47,7 +45,7 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#else  /* not CONFIG_DEBUG_BUGVERBOSE */
+#else
 
 #define __BUG(__file, __line, __value)				\
 do {								\
@@ -57,7 +55,6 @@ do {								\
 #endif  /* CONFIG_DEBUG_BUGVERBOSE */
 
 #define HAVE_ARCH_BUG
-#endif  /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
 
