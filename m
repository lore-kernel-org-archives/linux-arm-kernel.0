From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  4 Jul 2014 16:28:30 +0900
Subject: [PATCH v10 2/3] arm64: Add audit support
In-Reply-To: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
References: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1404458911-8214-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On AArch64, audit is supported through generic lib/audit.c and
compat_audit.c, and so this patch adds arch specific definitions required.

Acked-by Will Deacon <will.deacon@arm.com>
Acked-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig               |    2 ++
 arch/arm64/include/asm/syscall.h |   14 ++++++++++++++
 include/uapi/linux/audit.h       |    1 +
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a474de34..3a18571 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
+	select AUDIT_ARCH_COMPAT_GENERIC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
@@ -28,6 +29,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 383771e..709a574 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_SYSCALL_H
 #define __ASM_SYSCALL_H
 
+#include <uapi/linux/audit.h>
+#include <linux/compat.h>
 #include <linux/err.h>
 
 extern const void *sys_call_table[];
@@ -105,4 +107,16 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[i], args, n * sizeof(args[0]));
 }
 
+/*
+ * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
+ * AArch64 has the same system calls both on little- and big- endian.
+ */
+static inline int syscall_get_arch(void)
+{
+	if (is_compat_task())
+		return AUDIT_ARCH_ARM;
+
+	return AUDIT_ARCH_AARCH64;
+}
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index cf67147..3b9ff33 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -342,6 +342,7 @@ enum {
 #define __AUDIT_ARCH_64BIT 0x80000000
 #define __AUDIT_ARCH_LE	   0x40000000
 
+#define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
-- 
1.7.9.5
