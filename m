From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Nov 2009 20:04:59 +0000
Subject: [PATCH] Use definition for cmpxchg swi
Message-ID: <20091108200459.GA32760@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a definition for the cmpxchg SWI instead of hard-coding the number.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/unistd.h |    4 ++++
 arch/arm/kernel/entry-armv.S  |    7 ++++---
 arch/arm/kernel/traps.c       |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 7020217..a15e740 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -402,6 +402,10 @@
 #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
 #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
 
+#ifdef __KERNEL__
+#define __ARM_NR_cmpxchg		(__ARM_NR_BASE+0x00fff0)
+#endif
+
 /*
  * The following syscalls are obsolete and no longer available for EABI.
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0022b4d..d2903e3 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -21,6 +21,7 @@
 #include <mach/entry-macro.S>
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
+#include <asm/unistd.h>
 
 #include "entry-header.S"
 
@@ -908,10 +909,10 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	 * A special ghost syscall is used for that (see traps.c).
 	 */
 	stmfd	sp!, {r7, lr}
-	mov	r7, #0xff00		@ 0xfff0 into r7 for EABI
-	orr	r7, r7, #0xf0
-	swi	#0x9ffff0
+	ldr	r7, =1f			@ it's 20 bits
+	swi	__ARM_NR_cmpxchg
 	ldmfd	sp!, {r7, pc}
+1:	.word	__ARM_NR_cmpxchg
 
 #elif __LINUX_ARM_ARCH__ < 6
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 95718a6..3f361a7 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -528,7 +528,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 	 * __kuser_cmpxchg code in entry-armv.S should be aware of its
 	 * existence.  Don't ever use this from user code.
 	 */
-	case 0xfff0:
+	case NR(cmpxchg):
 	for (;;) {
 		extern void do_DataAbort(unsigned long addr, unsigned int fsr,
 					 struct pt_regs *regs);
