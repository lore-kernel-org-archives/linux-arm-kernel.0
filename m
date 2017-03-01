From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu,  2 Mar 2017 00:49:19 +0530
Subject: [PATCH 11/20] arm64: introduce binfmt_elf32.c
In-Reply-To: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1488395968-14313-12-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we support more than one compat formats, it looks more reasonable
to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
specific definitions there and make code more maintainable and readable.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/include/asm/elf.h     | 22 ++--------------------
 arch/arm64/include/asm/hwcap.h   |  2 --
 arch/arm64/kernel/Makefile       |  2 +-
 arch/arm64/kernel/binfmt_elf32.c | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d35cea4..d059063 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1049,7 +1049,6 @@ config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select COMPAT
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a0188e2..453e0da 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -176,30 +176,12 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
+#ifdef CONFIG_AARCH32_EL0
 /* AArch32 registers. */
 #define COMPAT_ELF_NGREG		18
 typedef unsigned int			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
-
-/* AArch32 EABI. */
-#define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
-					 ((x)->e_machine == EM_ARM) && \
-					 ((x)->e_flags & EF_ARM_EABI_MASK))
-
-#define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)					\
-({									\
-	set_bit(TIF_32BIT, &current->mm->context.flags);		\
-	clear_thread_flag(TIF_32BIT_AARCH64);				\
-	set_thread_flag(TIF_32BIT);					\
- })
-#define COMPAT_ARCH_DLINFO
-extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
-				      int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
-
+#endif /* CONFIG_AARCH32_EL0 */
 #endif /* CONFIG_COMPAT */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 2c7fc5d..99dfd92 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -47,8 +47,6 @@
 #define ELF_HWCAP		(elf_hwcap)
 
 #ifdef CONFIG_AARCH32_EL0
-#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
-#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 #endif
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index b688bcd..aeaf474 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o entry32.o
+					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
new file mode 100644
index 0000000..7c38a22
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -0,0 +1,32 @@
+/*
+ * Support for AArch32 Linux ELF binaries.
+ */
+
+/* AArch32 EABI. */
+#define EF_ARM_EABI_MASK		0xff000000
+
+#define compat_start_thread		compat_start_thread
+#define COMPAT_SET_PERSONALITY(ex)					\
+({									\
+	set_bit(TIF_32BIT, &current->mm->context.flags);		\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
+	set_thread_flag(TIF_32BIT);					\
+ })
+
+#define COMPAT_ARCH_DLINFO
+#define COMPAT_ELF_HWCAP		(compat_elf_hwcap)
+#define COMPAT_ELF_HWCAP2		(compat_elf_hwcap2)
+
+#define compat_arch_setup_additional_pages \
+					aarch32_setup_vectors_page
+struct linux_binprm;
+extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
+				      int uses_interp);
+
+/* AArch32 EABI. */
+#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
+					 ((x)->e_machine == EM_ARM) && \
+					 ((x)->e_flags & EF_ARM_EABI_MASK))
+
+
+#include "../../../fs/compat_binfmt_elf.c"
-- 
2.7.4
