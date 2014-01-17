From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jan 2014 17:13:16 +0900
Subject: [PATCH v2 3/6] arm64: Add audit support
In-Reply-To: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1389946399-4525-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On AArch64, audit can be enabled with CONFIG_AUDIT_GENERIC.
Most of audit features are implemented in generic way. This patch
adds a small piece of architecture dependent code.
syscall_get_arch(), which is used in seccomp, should just return
AUDIT_ARCH_*.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/syscall.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 70ba9d4..3361fec 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -16,7 +16,9 @@
 #ifndef __ASM_SYSCALL_H
 #define __ASM_SYSCALL_H
 
+#include <linux/audit.h>
 #include <linux/err.h>
+#include <linux/sched.h>
 
 
 static inline int syscall_get_nr(struct task_struct *task,
@@ -104,4 +106,14 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[i], args, n * sizeof(args[0]));
 }
 
+static inline int syscall_get_arch(struct task_struct *task,
+				   struct pt_regs *regs)
+{
+#ifdef __AARCH64EB__
+	return AUDIT_ARCH_AARCH64EB;
+#else
+	return AUDIT_ARCH_AARCH64;
+#endif
+}
+
 #endif	/* __ASM_SYSCALL_H */
-- 
1.7.9.5
