From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:34 +0300
Subject: [PATCH v6 05/17] arm64:ilp32: share signal structures between ILP32
 and LP64 ABIs
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-6-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Defines the macros which allow the signal structures to be the same between
ILP32 and LP64.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/uapi/asm/siginfo.h | 21 +++++++++++++++++++++
 arch/arm64/include/uapi/asm/signal.h  | 31 +++++++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h    | 17 +++++++++++++----
 include/uapi/asm-generic/signal.h     | 27 +++++++++++++++++++++++----
 4 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/siginfo.h b/arch/arm64/include/uapi/asm/siginfo.h
index 5a74a08..d9ac7d4 100644
--- a/arch/arm64/include/uapi/asm/siginfo.h
+++ b/arch/arm64/include/uapi/asm/siginfo.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Cavium Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -18,6 +19,26 @@
 
 #define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 
+#ifdef __ILP32__
+# ifdef __AARCH64EB__
+#  define __SIGINFO_INNER(type, field)		\
+		int __pad#field;		\
+		type field
+# else
+#  define __SIGINFO_INNER(type, field)		\
+		type field;			\
+		int __pad#field
+# endif
+
+# undef __SIGINFO_VOIDPOINTER
+# define __SIGINFO_VOIDPOINTER(field)		\
+		__SIGINFO_INNER(void __user*, field)
+# undef __SIGINFO_BAND
+
+# define __SIGINFO_BAND(field)			\
+	__SIGINFO_INNER(long, field)
+#endif
+
 #include <asm-generic/siginfo.h>
 
 #endif
diff --git a/arch/arm64/include/uapi/asm/signal.h b/arch/arm64/include/uapi/asm/signal.h
index 991bf5d..5053af4 100644
--- a/arch/arm64/include/uapi/asm/signal.h
+++ b/arch/arm64/include/uapi/asm/signal.h
@@ -22,6 +22,37 @@
 #define MINSIGSTKSZ 5120
 #define SIGSTKSZ    16384
 
+/* For ILP32, sigset should be the same size fields as LP64 so use
+   unsigned long long. */
+#ifdef __ILP32__
+#define __SIGSET_INNER_TYPE __extension__ unsigned long long
+#define _NSIG_BPW 64
+
+# ifdef __AARCH64EB__
+#  define __SIGNAL_INNER(type, field)		\
+	__extension__ struct {			\
+		int __pad_##field;		\
+		type field;			\
+	} __attribute__((aligned(8)))
+# else
+#  define __SIGNAL_INNER(type, field)		\
+	__extension__ struct {			\
+		type field;			\
+		int __pad_##field;		\
+	} __attribute__((aligned(8)))
+# endif
+
+# define __SIGACTION_HANDLER(field)		\
+	__SIGNAL_INNER(__sighandler_t, field)
+
+#define __SIGACTION_FLAGS(field)		\
+	__extension__ unsigned long long field
+
+#define __SIGACTION_RESTORER(field)		\
+	__SIGNAL_INNER(__sigrestore_t, field)
+
+#endif
+
 #include <asm-generic/signal.h>
 
 #endif
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 1e35520..be640a9 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -4,9 +4,17 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+#ifndef __SIGINFO_VOIDPOINTER
+#define __SIGINFO_VOIDPOINTER(field) void __user *field
+#endif
+
+#ifndef __SIGINFO_BAND
+#define __SIGINFO_BAND(field) __ARCH_SI_BAND_T field
+#endif
+
 typedef union sigval {
 	int sival_int;
-	void __user *sival_ptr;
+	__SIGINFO_VOIDPOINTER(sival_ptr);
 } sigval_t;
 
 /*
@@ -86,7 +94,7 @@ typedef struct siginfo {
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
-			void __user *_addr; /* faulting insn/memory ref. */
+			__SIGINFO_VOIDPOINTER(_addr); /* faulting insn/memory ref. */
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
@@ -99,13 +107,13 @@ typedef struct siginfo {
 
 		/* SIGPOLL */
 		struct {
-			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			__SIGINFO_BAND(_band);	/* POLL_IN, POLL_OUT, POLL_MSG */
 			int _fd;
 		} _sigpoll;
 
 		/* SIGSYS */
 		struct {
-			void __user *_call_addr; /* calling user insn */
+			__SIGINFO_VOIDPOINTER(_call_addr); /* calling user insn */
 			int _syscall;	/* triggering system call number */
 			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
 		} _sigsys;
@@ -290,6 +298,7 @@ typedef struct sigevent {
 		int _pad[SIGEV_PAD_SIZE];
 		 int _tid;
 
+		/* Note these two are handled only in userspace */
 		struct {
 			void (*_function)(sigval_t);
 			void *_attribute;	/* really pthread_attr_t */
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 3094618..92d8ce3 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -4,7 +4,9 @@
 #include <linux/types.h>
 
 #define _NSIG		64
+#ifndef _NSIG_BPW
 #define _NSIG_BPW	__BITS_PER_LONG
+#endif
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
 #define SIGHUP		 1
@@ -85,9 +87,13 @@
 #define SIGSTKSZ	8192
 #endif
 
+#ifndef __SIGSET_INNER_TYPE
+#define __SIGSET_INNER_TYPE unsigned long
+#endif
+
 #ifndef __ASSEMBLY__
 typedef struct {
-	unsigned long sig[_NSIG_WORDS];
+	__SIGSET_INNER_TYPE sig[_NSIG_WORDS];
 } sigset_t;
 
 /* not actually used, but required for linux/syscalls.h */
@@ -100,11 +106,24 @@ typedef unsigned long old_sigset_t;
 #endif
 
 #ifndef __KERNEL__
+
+#ifndef __SIGACTION_HANDLER
+#define __SIGACTION_HANDLER(field)	__sighandler_t field
+#endif
+
+#ifndef __SIGACTION_FLAGS
+#define __SIGACTION_FLAGS(field)	unsigned long field
+#endif
+
+#ifndef __SIGACTION_RESTORER
+#define __SIGACTION_RESTORER(field)	__sigrestore_t field
+#endif
+
 struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
+	__SIGACTION_HANDLER(sa_handler);
+	__SIGACTION_FLAGS(sa_flags);
 #ifdef SA_RESTORER
-	__sigrestore_t sa_restorer;
+	__SIGACTION_RESTORER(sa_restorer);
 #endif
 	sigset_t sa_mask;		/* mask last for extensibility */
 };
-- 
2.1.4
