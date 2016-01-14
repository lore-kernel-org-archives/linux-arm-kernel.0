From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 14 Jan 2016 20:23:18 +0300
Subject: [PATCH v6 21/21] arm64: ilp32: wrap syscalls to remove top 32-bit
 vulnerability
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452792198-10718-22-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wrapper that clears top halves of registers looks like this:

0000000000000068 <compat_SyS_mknod>:
COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
68:   a9bf7bfd        stp     x29, x30, [sp,#-16]!
6c:   910003fd        mov     x29, sp
70:   2a0003e0        mov     w0, w0
74:   94000000        bl      0 <sys_mknod>
78:   a8c17bfd        ldp     x29, x30, [sp],#16
7c:   d65f03c0        ret

It looks quite nice overall. Unsafe pointer type is fixed with
"mov w0, w0", and safe types are untouched.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig                      |  1 +
 arch/arm64/include/asm/compat_wrapper.h | 14 ++++++++++++++
 arch/arm64/kernel/sys_ilp32.c           |  3 +++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/include/asm/compat_wrapper.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8606c15..0344fc0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -785,6 +785,7 @@ config AARCH32_EL0
 
 config ARM64_ILP32
 	bool "Kernel support for ILP32"
+	select COMPAT_WRAPPER
 	help
 	  This option enables support for AArch64 ILP32 user space.  ILP32
 	  is an ABI where long and pointers are 32bits but it uses the AARCH64
diff --git a/arch/arm64/include/asm/compat_wrapper.h b/arch/arm64/include/asm/compat_wrapper.h
new file mode 100644
index 0000000..651b4e8
--- /dev/null
+++ b/arch/arm64/include/asm/compat_wrapper.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_COMPAT_WRAPPER
+#define __ASM_COMPAT_WRAPPER
+
+/*
+ *  Compat system call wrappers.
+ */
+
+/*
+ * This file is empty as arm64 is satisfied with generic
+ * definitions of __SC_COMPAT_TYPE, _SC_COMPAT_CAST and
+ * COMPAT_SYSCALL_WRAPx.
+ */
+
+#endif /* __ASM_COMPAT_WRAPPER */
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index bed308c..c63725b 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
+#include <linux/compat_wrapper.h>
 #include <asm-generic/syscalls.h>
 
 /* Using non-compat syscalls where necessary */
@@ -50,11 +51,13 @@ asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
 
 #undef __SYSCALL
 #undef __SC_COMP
+#undef __SC_WRAP
 #undef __SC_3264
 #undef __SC_COMP_3264
 
 #define __SYSCALL_COMPAT
 #define __SYSCALL(nr, sym)	[nr] = sym,
+#define __SC_WRAP(nr, sym)	[nr] = compat_##sym,
 
 /*
  * The sys_call_ilp32_table array must be 4K aligned to be accessible from
-- 
2.5.0
