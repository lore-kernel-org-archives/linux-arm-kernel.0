From: amanieu@gmail.com (Amanieu d'Antras)
Date: Thu,  5 Nov 2015 00:50:26 +0000
Subject: [PATCH v2 07/20] arm64: Use generic compat_siginfo_t
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Message-ID: <1446684640-4112-8-git-send-email-amanieu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/arm64/include/asm/compat.h | 60 -----------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 5eae749..dc7cfc1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -155,69 +155,9 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
-#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER32
 #define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[128/sizeof(int) - 3];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;	/* timer id */
-			int _overrun;		/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;       /* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;	/* sender's pid */
-			__compat_uid32_t _uid;	/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;	/* which child */
-			__compat_uid32_t _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-		struct {
-			compat_uptr_t _addr; /* faulting insn/memory ref. */
-			short _addr_lsb; /* LSB of the reported address */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			compat_long_t _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			compat_uptr_t _call_addr; /* calling user insn */
-			int _syscall;	/* triggering system call number */
-			compat_uint_t _arch;	/* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
-
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
-- 
2.6.2
