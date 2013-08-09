From: naesten@gmail.com (Samuel Bronson)
Date: Fri, 9 Aug 2013 20:42:07 +0000
Subject: [PATCH] ARM: Reunite some things that were separated in the UAPI split
Message-ID: <87txixus5y.fsf@naesten.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've discovered a couple of #defines that have been separated from
their comments, and a struct that's been separated from both its
comment and its userspace twin, by the UAPI split (commit
cb8db5d4578ac9d996200ab59aa655344d305f5b).

This patch puts them back together again.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 arch/arm/include/asm/ptrace.h      |    3 ---
 arch/arm/include/asm/unistd.h      |   10 ++++++++++
 arch/arm/include/uapi/asm/ptrace.h |    4 ++++
 arch/arm/include/uapi/asm/unistd.h |   11 -----------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 04c99f3..0dd539b 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -13,9 +13,6 @@
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
-struct pt_regs {
-	unsigned long uregs[18];
-};
 
 #define user_mode(regs)	\
 	(((regs)->ARM_cpsr & 0xf) == 0)
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 141baa3..829ebae 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -15,7 +15,17 @@
 
 #include <uapi/asm/unistd.h>
 
+/*
+ * This may need to be greater than __NR_last_syscall+1 in order to
+ * account for the padding in the syscall table
+ */
 #define __NR_syscalls  (380)
+
+/*
+ * *NOTE*: This is a ghost syscall private to the kernel.  Only the
+ * __kuser_cmpxchg code in entry-armv.S should be aware of its
+ * existence.  Don't ever use this from user code.
+ */
 #define __ARM_NR_cmpxchg		(__ARM_NR_BASE+0x00fff0)
 
 #define __ARCH_WANT_STAT64
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 5af0ed1..438f02f2 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -124,6 +124,10 @@
 struct pt_regs {
 	long uregs[18];
 };
+#else /* __KERNEL__ */
+struct pt_regs {
+	unsigned long uregs[18];
+};
 #endif /* __KERNEL__ */
 
 #define ARM_cpsr	uregs[16]
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index af33b44..946fad5 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -408,11 +408,6 @@
 #define __NR_finit_module		(__NR_SYSCALL_BASE+379)
 
 /*
- * This may need to be greater than __NR_last_syscall+1 in order to
- * account for the padding in the syscall table
- */
-
-/*
  * The following SWIs are ARM private.
  */
 #define __ARM_NR_BASE			(__NR_SYSCALL_BASE+0x0f0000)
@@ -423,12 +418,6 @@
 #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
 
 /*
- * *NOTE*: This is a ghost syscall private to the kernel.  Only the
- * __kuser_cmpxchg code in entry-armv.S should be aware of its
- * existence.  Don't ever use this from user code.
- */
-
-/*
  * The following syscalls are obsolete and no longer available for EABI.
  */
 #if !defined(__KERNEL__)
-- 
1.7.10.4
