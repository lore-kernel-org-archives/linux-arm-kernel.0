From: haibo.xu@arm.com (Haibo.Xu)
Date: Fri, 9 Nov 2018 09:53:28 +0800
Subject: [PATCH V2] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
Message-ID: <20181109015320.GA29354@haibo-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on arm64.
This follows the x86 semantics for invoking ptrace hooks, and has
been verified on an arm64 test machine.

This functionality is used by the Gvisor project, for running in
ptrace mode. On arm64 we will need ptrace mode rather than kvm mode
for situations where we are already running inside a virtual machine
(as nested virtualisation will only be available in newer cores).

Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
Signed-off-by: Bin.Lu <bin.lu@arm.com>
Reviewed-by: Steve Capper <Steve.Capper@arm.com>
---
 arch/arm64/include/asm/thread_info.h |  5 ++++-
 arch/arm64/include/uapi/asm/ptrace.h |  2 ++
 arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 46c3b93..5060d2d 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -75,6 +75,7 @@ struct thread_info {
  *  TIF_SYSCALL_TRACE  - syscall trace active
  *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
  *  TIF_SYSCALL_AUDIT  - syscall auditing
+ *  TIF_SYSCALL_EMU    - syscall emulation active
  *  TIF_SECOMP         - syscall secure computing
  *  TIF_SIGPENDING     - signal pending
  *  TIF_NEED_RESCHED   - rescheduling necessary
@@ -91,6 +92,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT      9
 #define TIF_SYSCALL_TRACEPOINT 10
 #define TIF_SECCOMP            11
+#define TIF_SYSCALL_EMU                12
 #define TIF_MEMDIE             18      /* is terminating due to OOM killer */
 #define TIF_FREEZE             19
 #define TIF_RESTORE_SIGMASK    20
@@ -106,6 +108,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT     (1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT        (1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP           (1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_EMU       (1 << TIF_SYSCALL_EMU)
 #define _TIF_UPROBE            (1 << TIF_UPROBE)
 #define _TIF_32BIT             (1 << TIF_32BIT)

@@ -115,7 +118,7 @@ struct thread_info {

 #define _TIF_SYSCALL_WORK      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
                                 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-                                _TIF_NOHZ)
+                                _TIF_NOHZ | _TIF_SYSCALL_EMU)

 #endif /* __KERNEL__ */
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index b5c3933..04ab06f 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -23,6 +23,8 @@

 #include <asm/hwcap.h>

+#define PTRACE_SYSEMU                  31
+#define PTRACE_SYSEMU_SINGLESTEP       32

 /*
  * PSR bits
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index fc35e06..ff3e322 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -165,6 +165,9 @@ void ptrace_disable(struct task_struct *child)
         * is likely to cause regressions on obscure architectures.
         */
        user_disable_single_step(child);
+#ifdef TIF_SYSCALL_EMU
+       clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+#endif
 }

 #ifdef CONFIG_HAVE_HW_BREAKPOINT
@@ -1351,6 +1354,11 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
        if (test_thread_flag(TIF_SYSCALL_TRACE))
                tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);

+       if (test_thread_flag(TIF_SYSCALL_EMU)) {
+               tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+               return -1;
+       }
+
        /* Do the secure computing after ptrace; failures should be fast. */
        if (secure_computing(NULL) == -1)
                return -1;
@@ -1373,6 +1381,15 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)

        if (test_thread_flag(TIF_SYSCALL_TRACE))
                tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
+
+       /*
+        * We only get here because of TIF_SINGLESTEP,
+        * for PTRACE_SYSEMU_SINGLESTEP, we already reported
+        * the syscall instruction in syscall_trace_enter().
+        */
+       if (test_thread_flag(TIF_SINGLESTEP) &&
+                       !test_thread_flag(TIF_SYSCALL_EMU))
+               tracehook_report_syscall_exit(regs, 1);
 }

 /*
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
