From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  7 Nov 2014 16:47:23 +0900
Subject: [RFC] ptrace: add generic SET_SYSCALL request
Message-ID: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new generic ptrace request, PTRACE_SET_SYSCALL.
It can be used to change a system call number as follows:
    ret = ptrace(pid, PTRACE_SET_SYSCALL, null, new_syscall_no);
'new_syscall_no' can be -1 to skip this system call, you need to modify
a register's value, in arch-specific way, as return value though.

Please note that we can't define PTRACE_SET_SYSCALL macro in
uapi/linux/ptrace.h partly because its value on arm, 23, is used as another
request on sparc.

This patch also contains an example of change on arch side, arm.
Only syscall_set_nr() is required to be defined in asm/syscall.h.

Currently only arm has this request, while arm64 would also have it
once my patch series of seccomp for arm64 is merged. It will also be
usable for most of other arches.
See the discussions in lak-ml:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300167.html

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm/include/asm/syscall.h |    7 +++++++
 arch/arm/kernel/ptrace.c       |    5 -----
 kernel/ptrace.c                |    6 ++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index e86c985..3e1d9c0 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -24,6 +24,13 @@ static inline int syscall_get_nr(struct task_struct *task,
 	return task_thread_info(task)->syscall;
 }
 
+static inline int syscall_set_nr(struct task_struct *task,
+				 struct pt_regs *regs, int syscall)
+{
+	task_thread_info(task)->syscall = syscall;
+	return 0;
+}
+
 static inline void syscall_rollback(struct task_struct *task,
 				    struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ef9119f..908bae8 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -853,11 +853,6 @@ long arch_ptrace(struct task_struct *child, long request,
 				       datap);
 			break;
 
-		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->syscall = data;
-			ret = 0;
-			break;
-
 #ifdef CONFIG_CRUNCH
 		case PTRACE_GETCRUNCHREGS:
 			ret = ptrace_getcrunchregs(child, datap);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54e7522..d7048fa 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1001,6 +1001,12 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 	}
 #endif
+
+#ifdef PTRACE_SET_SYSCALL
+	case PTRACE_SET_SYSCALL:
+		ret = syscall_set_nr(child, task_pt_regs(child), data);
+		break;
+#endif
 	default:
 		break;
 	}
-- 
1.7.9.5
