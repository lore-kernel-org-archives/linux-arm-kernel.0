From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 21 Aug 2014 17:56:44 +0900
Subject: [PATCH v6 5/6] arm64: add SIGSYS siginfo for compat task
In-Reply-To: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1408611405-8943-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SIGSYS is primarily used in secure computing to notify tracer.
This patch allows signal handler on compat task to get correct information
with SA_SYSINFO specified when this signal is delivered.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/compat.h |    7 +++++++
 arch/arm64/kernel/signal32.c    |    8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 253e33b..c877915 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -205,6 +205,13 @@ typedef struct compat_siginfo {
 			compat_long_t _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
 			int _fd;
 		} _sigpoll;
+
+		/* SIGSYS */
+		struct {
+			compat_uptr_t _call_addr; /* calling user insn */
+			int _syscall;	/* triggering system call number */
+			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
+		} _sigsys;
 	} _sifields;
 } compat_siginfo_t;
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 1b9ad02..aa550d6 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -186,6 +186,14 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 		err |= __put_user(from->si_uid, &to->si_uid);
 		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
 		break;
+#ifdef __ARCH_SIGSYS
+	case __SI_SYS:
+		err |= __put_user((compat_uptr_t)(unsigned long)
+				from->si_call_addr, &to->si_call_addr);
+		err |= __put_user(from->si_syscall, &to->si_syscall);
+		err |= __put_user(from->si_arch, &to->si_arch);
+		break;
+#endif
 	default: /* this is just in case for now ... */
 		err |= __put_user(from->si_pid, &to->si_pid);
 		err |= __put_user(from->si_uid, &to->si_uid);
-- 
1.7.9.5
