From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 17:32:15 +0100
Subject: [PATCH] ARM64: do not include ptrace.h from compat.h
Message-ID: <4870233.DUFZXD30Rq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

including ptrace.h brings a definition of BITS_PER_PAGE into device
drivers and cause a build warning in allmodconfig builds:

drivers/block/drbd/drbd_bitmap.c:482:0: warning: "BITS_PER_PAGE" redefined
 #define BITS_PER_PAGE  (1UL << (PAGE_SHIFT + 3))

This uses a slightly different way to express current_pt_regs()
that avoids the use of the header and gets away with the already
included asm/ptrace.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 7fbed6919b54..eb8432bb82b8 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -23,7 +23,6 @@
  */
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/ptrace.h>
 
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
@@ -234,7 +233,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
-#define compat_user_stack_pointer() (user_stack_pointer(current_pt_regs()))
+#define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
