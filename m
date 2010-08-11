From: janboe.ye@gmail.com (janboe)
Date: Thu, 12 Aug 2010 00:08:10 +0800
Subject: [PATCH] arm: remove backtrace.s when ARM_UNWIND enable
Message-ID: <20100811160810.GA6792@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

backtrace.s can only work with FRAME_POINTER, so disable when
ARM_UNWIND enabled

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/include/asm/system.h |    5 +++++
 arch/arm/kernel/armksyms.c    |    3 ++-
 arch/arm/kernel/traps.c       |    2 ++
 arch/arm/lib/Makefile         |    5 ++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5f4f480..0a05462 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -88,8 +88,13 @@ void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 #define xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
+#ifdef CONFIG_ARM_UNWIND
+#define __backtrace() \
+	(dump_stack())
+#else
 extern asmlinkage void __backtrace(void);
 extern asmlinkage void c_backtrace(unsigned long fp, int pmode);
+#endif
 
 struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8214bfe..aa0eb0c 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -49,8 +49,9 @@ extern void __aeabi_ulcmp(void);
 
 extern void fpundefinstr(void);
 
-
+#ifndef CONFIG_ARM_UNWIND
 EXPORT_SYMBOL(__backtrace);
+#endif
 
 	/* platform dependent support */
 EXPORT_SYMBOL(__udelay);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1621e53..5b3f3bf 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -603,7 +603,9 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 		dump_instr("", regs);
 		if (user_mode(regs)) {
 			__show_regs(regs);
+#ifdef CONFIG_ARM_UNWIND
 			c_backtrace(regs->ARM_fp, processor_mode(regs));
+#endif
 		}
 	}
 #endif
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 030ba72..e5699d5 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -4,7 +4,7 @@
 # Copyright (C) 1995-2000 Russell King
 #
 
-lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
+lib-y		:= changebit.o csumipv6.o csumpartial.o   \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
 		   delay.o findbit.o memchr.o memcpy.o		      \
 		   memmove.o memset.o memzero.o setbit.o              \
@@ -14,6 +14,9 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 		   ashldi3.o ashrdi3.o lshrdi3.o muldi3.o             \
 		   ucmpdi2.o lib1funcs.o div64.o sha1.o               \
 		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o
+ifneq ($(CONFIG_ARM_UNWIND),y)
+  lib-y	+= backtrace.o
+endif
 
 mmu-y	:= clear_user.o copy_page.o getuser.o putuser.o
 
-- 
1.7.1
