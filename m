From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:45 +0000
Subject: [RFC PATCH v3 03/11] arm64: compat: Add CONFIG_KUSER_HELPERS
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-4-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
config option (enabled by default). When disabled, all kuser
helpers-related code is removed from the kernel and no mapping is done
at the fixed high address (0xffff0000); any attempt to use a kuser
helper from a 32-bit process will result in a segfault.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig              | 29 ++++++++++++++++++++
 arch/arm64/kernel/Makefile      |  3 ++-
 arch/arm64/kernel/kuser32.S     | 48 +++------------------------------
 arch/arm64/kernel/sigreturn32.S | 59 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vdso.c        |  6 +++++
 5 files changed, 99 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef880d234..265d88c44cfc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1013,6 +1013,35 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable the kuser helpers page in 32-bit processes"
+	depends on COMPAT
+	default y
+	help
+	  Warning: disabling this option may break 32-bit applications.
+
+	  Provide kuser helpers in a special purpose fixed-address page. The
+	  kernel provides helper code to userspace in read-only form at a fixed
+	  location to allow userspace to be independent of the CPU type fitted
+	  to the system. This permits 32-bit binaries to be run on ARMv4 through
+	  to ARMv8 without modification.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
+	  However, the fixed-address nature of these helpers can be used by ROP
+	  (return-orientated programming) authors when creating exploits.
+
+	  If all of the 32-bit binaries and libraries which run on your platform
+	  are built specifically for your platform, and make no use of these
+	  helpers, then you can turn this option off to hinder such exploits.
+	  However, in that case, if a binary or library relying on those helpers
+	  is run, it will receive a SIGSEGV signal, which will terminate the
+	  program. Typically, binaries compiled for ARMv7 or later do not use
+	  the kuser helpers.
+
+	  Say N here only if you are absolutely certain that you do not need
+	  these helpers; otherwise, the safe option is to say Y.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d66bbaafc0c..0850506d0217 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,9 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o sigreturn32.o signal32.o	\
 					   sys_compat.o entry32.o
+arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 997e6b27ff6a..d15b5c2935b3 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -20,16 +20,13 @@
  *
  * AArch32 user helpers.
  *
- * Each segment is 32-byte aligned and will be moved to the top of the high
- * vector page.  New segments (if ever needed) must be added in front of
- * existing ones.  This mechanism should be used only for things that are
- * really small and justified, and not be abused freely.
+ * These helpers are provided for compatibility with AArch32 binaries that
+ * still need them. They are installed at a fixed address by
+ * aarch32_setup_additional_pages().
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
 
-#include <asm/unistd.h>
-
 	.align	5
 	.globl	__kuser_helper_start
 __kuser_helper_start:
@@ -77,42 +74,3 @@ __kuser_helper_version:			// 0xffff0ffc
 	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
 	.globl	__kuser_helper_end
 __kuser_helper_end:
-
-/*
- * AArch32 sigreturn code
- *
- * For ARM syscalls, the syscall number has to be loaded into r7.
- * We do not support an OABI userspace.
- *
- * For Thumb syscalls, we also pass the syscall number via r7. We therefore
- * need two 16-bit instructions.
- */
-	.globl __aarch32_sigret_code_start
-__aarch32_sigret_code_start:
-
-	/*
-	 * ARM Code
-	 */
-	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
-
-	/*
-	 * ARM code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
-
-        .globl __aarch32_sigret_code_end
-__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
new file mode 100644
index 000000000000..f2615e2286c5
--- /dev/null
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -0,0 +1,59 @@
+/*
+ * sigreturn trampolines for AArch32.
+ *
+ * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
+ * Copyright (C) 2012 ARM Ltd.
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
+ *
+ *
+ * AArch32 sigreturn code
+ *
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ *
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefore
+ * need two 16-bit instructions.
+ */
+
+#include <asm/unistd.h>
+
+	.globl __aarch32_sigret_code_start
+__aarch32_sigret_code_start:
+
+	/*
+	 * ARM Code
+	 */
+	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3		// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef		// svc	#__NR_compat_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
+
+	/*
+	 * ARM code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
+
+        .globl __aarch32_sigret_code_end
+__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 6208b7ba4593..d189e5be5039 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -107,6 +107,8 @@ static int sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifdef CONFIG_KUSER_HELPERS
+
 /* kuser helpers page */
 static struct page *kuser_helpers_page __ro_after_init;
 static const struct vm_special_mapping kuser_helpers_spec = {
@@ -148,6 +150,8 @@ static int kuser_helpers_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#endif /* CONFIG_KUSER_HELPERS */
+
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
@@ -160,7 +164,9 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_KUSER_HELPERS
 	ret = kuser_helpers_setup(mm);
+#endif
 
 out:
 	up_write(&mm->mmap_sem);
-- 
2.10.2
