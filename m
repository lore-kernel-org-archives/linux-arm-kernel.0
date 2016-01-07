From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:34 +0300
Subject: [PATCH v6 16/21] arm64: signal: share lp64 signal routines to ilp32
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-17-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After that, it will be possible to reuse it in ilp32.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_common.h | 39 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c             | 17 ++++++---------
 2 files changed, 45 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal_common.h

diff --git a/arch/arm64/include/asm/signal_common.h b/arch/arm64/include/asm/signal_common.h
new file mode 100644
index 0000000..faa82c0
--- /dev/null
+++ b/arch/arm64/include/asm/signal_common.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 Cavium Networks.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_SIGNAL_COMMON_H
+#define __ASM_SIGNAL_COMMON_H
+
+#include <linux/uaccess.h>
+#include <asm/ucontext.h>
+#include <asm/fpsimd.h>
+
+struct sigframe {
+	struct ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx);
+int restore_fpsimd_context(struct fpsimd_context __user *ctx);
+int setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set);
+int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf);
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			void __user *frame, off_t sigframe_off, int usig);
+
+#endif /* __ASM_SIGNAL_COMMON_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 20dca65..a742a61 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -34,12 +34,7 @@
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
-
-struct sigframe {
-	struct ucontext uc;
-	u64 fp;
-	u64 lr;
-};
+#include <asm/signal_common.h>
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -49,7 +44,7 @@ struct rt_sigframe {
 	struct sigframe sig;
 };
 
-static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
 	int err;
@@ -69,7 +64,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state fpsimd;
 	__u32 magic, size;
@@ -96,7 +91,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_sigframe(struct pt_regs *regs,
+int restore_sigframe(struct pt_regs *regs,
 			    struct sigframe __user *sf)
 {
 	sigset_t set;
@@ -166,7 +161,7 @@ badframe:
 	return 0;
 }
 
-static int setup_sigframe(struct sigframe __user *sf,
+int setup_sigframe(struct sigframe __user *sf,
 			  struct pt_regs *regs, sigset_t *set)
 {
 	int i, err = 0;
@@ -233,7 +228,7 @@ static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			 void __user *frame, off_t sigframe_off, int usig)
 {
 	__sigrestore_t sigtramp;
-- 
2.5.0
