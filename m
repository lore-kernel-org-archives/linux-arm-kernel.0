From: keescook@chromium.org (Kees Cook)
Date: Sat, 10 Nov 2012 14:44:42 -0800
Subject: [PATCH 1/4] arch/arm: add syscall_get_arch
In-Reply-To: <1352587485-18348-1-git-send-email-keescook@chromium.org>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
Message-ID: <1352587485-18348-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Drewry <wad@chromium.org>

Provide an ARM implementation of syscall_get_arch. This is a pre-requisite
for CONFIG_HAVE_ARCH_SECCOMP_FILTER.

Signed-off-by: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/syscall.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 9fdded6..f1d96d4 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_ARM_SYSCALL_H
 #define _ASM_ARM_SYSCALL_H
 
+#include <linux/audit.h> /* for AUDIT_ARCH_* */
+#include <linux/elf.h> /* for ELF_EM */
 #include <linux/err.h>
 #include <linux/sched.h>
 
@@ -95,4 +97,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->ARM_r0 + i, args, n * sizeof(args[0]));
 }
 
+static inline int syscall_get_arch(struct task_struct *task,
+				   struct pt_regs *regs)
+{
+	/* ARM tasks don't change audit architectures on the fly. */
+	return AUDIT_ARCH_ARM;
+}
+
 #endif /* _ASM_ARM_SYSCALL_H */
-- 
1.7.9.5
