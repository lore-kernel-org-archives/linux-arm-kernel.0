From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  6 Apr 2014 23:19:04 +0100
Subject: [PATCH 1/3] arm64: Provide read/write fault information in compat
 signal handlers
In-Reply-To: <1396822746-26241-1-git-send-email-catalin.marinas@arm.com>
References: <1396822746-26241-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1396822746-26241-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For AArch32, bit 11 (WnR) of the FSR/ESR register is set when the fault
was caused by a write access and applications like Qemu rely on such
information being provided in sigcontext. This patch introduces the
ESR_EL1 tracking for the arm64 kernel faults and sets bit 11 accordingly
in compat sigcontext.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/processor.h | 1 +
 arch/arm64/kernel/signal32.c       | 4 +++-
 arch/arm64/kernel/traps.c          | 7 +++++--
 arch/arm64/mm/fault.c              | 3 ++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 45b20cd6cbca..34de2a8f7d93 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -79,6 +79,7 @@ struct thread_struct {
 	unsigned long		tp_value;
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
+	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
 };
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b3fc9f5ec6d3..e4f0c0b0ca3a 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -500,7 +500,9 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
 
 	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
-	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.error_code, err);
+	/* compat tasks expect bit 11 as WnR status bit */
+	__put_user_error((current->thread.fault_code & (1 << 6)) << 5,
+			 &sf->uc.uc_mcontext.error_code, err);
 	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
 	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffadddb645d..c43cfa9b8304 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -251,10 +251,13 @@ void die(const char *str, struct pt_regs *regs, int err)
 void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      struct siginfo *info, int err)
 {
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		current->thread.fault_address = 0;
+		current->thread.fault_code = err;
 		force_sig_info(info->si_signo, info, current);
-	else
+	} else {
 		die(str, regs, err);
+	}
 }
 
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c23751b06120..625985f6531b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -123,6 +123,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	}
 
 	tsk->thread.fault_address = addr;
+	tsk->thread.fault_code = esr;
 	si.si_signo = sig;
 	si.si_errno = 0;
 	si.si_code = code;
@@ -525,7 +526,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	info.si_errno = 0;
 	info.si_code  = inf->code;
 	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, esr);
+	arm64_notify_die("", regs, &info, 0);
 
 	return 0;
 }
