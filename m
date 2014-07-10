From: behanw@converseincode.com (behanw at converseincode.com)
Date: Wed,  9 Jul 2014 22:32:52 -0700
Subject: [PATCH] arm: LLVMLinux: use static inline in ARM ftrace.h
Message-ID: <1404970372-5026-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

With compilers which follow the C99 standard (like modern versions of gcc and
clang), "extern inline" does the wrong thing (emits code for an externally
linkable version of the inline function). In this case using static inline
and removing the NULL version of return_address in return_address.c does
the right thing.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
CC: linux at arm.linux.org.uk
---
 arch/arm/include/asm/ftrace.h    | 2 +-
 arch/arm/kernel/return_address.c | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 39eb16b..bfe2a2f 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -45,7 +45,7 @@ void *return_address(unsigned int);
 
 #else
 
-extern inline void *return_address(unsigned int level)
+static inline void *return_address(unsigned int level)
 {
 	return NULL;
 }
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index fafedd8..f6aa84d 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -63,11 +63,6 @@ void *return_address(unsigned int level)
 #warning "TODO: return_address should use unwind tables"
 #endif
 
-void *return_address(unsigned int level)
-{
-	return NULL;
-}
-
 #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) / else */
 
 EXPORT_SYMBOL_GPL(return_address);
-- 
1.9.1
