From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jan 2014 17:13:17 +0900
Subject: [PATCH v2 4/6] arm64: audit: Add 32-bit (compat) syscall support
In-Reply-To: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1389946399-4525-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic audit code also support compat system calls now.
This patch adds a small piece of architecture dependent code.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/audit.h   |   20 ++++++++++++++++++++
 arch/arm64/include/asm/syscall.h |   10 ++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/include/asm/audit.h

diff --git a/arch/arm64/include/asm/audit.h b/arch/arm64/include/asm/audit.h
new file mode 100644
index 0000000..70eef50
--- /dev/null
+++ b/arch/arm64/include/asm/audit.h
@@ -0,0 +1,20 @@
+/*
+ * arch/arm64/include/asm/audit.h
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_AUDIT_H
+#define __ASM_AUDIT_H
+
+#include <linux/audit.h>
+
+#define audit_is_compat(arch) \
+		((arch == AUDIT_ARCH_ARM) || (arch == AUDIT_ARCH_ARMEB))
+
+#endif /* __ASM_AUDIT_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 3361fec..d7660e9 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -19,6 +19,7 @@
 #include <linux/audit.h>
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <asm/compat.h>
 
 
 static inline int syscall_get_nr(struct task_struct *task,
@@ -109,6 +110,15 @@ static inline void syscall_set_arguments(struct task_struct *task,
 static inline int syscall_get_arch(struct task_struct *task,
 				   struct pt_regs *regs)
 {
+#ifdef CONFIG_COMPAT
+	if (is_compat_thread(task_thread_info(task)))
+#ifdef __AARCH64EB__
+		return AUDIT_ARCH_ARMEB; /* only BE on BE */
+#else
+		return AUDIT_ARCH_ARM;
+#endif
+#endif
+
 #ifdef __AARCH64EB__
 	return AUDIT_ARCH_AARCH64EB;
 #else
-- 
1.7.9.5
