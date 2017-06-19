From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 19 Jun 2017 18:49:54 +0300
Subject: [PATCH 11/20] arm64: introduce binfmt_elf32.c
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170619155003.13218-12-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we support more than one compat formats, it looks more reasonable
to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
specific definitions there and make code more maintainable and readable.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/include/asm/elf.h     | 30 +++---------------------------
 arch/arm64/include/asm/hwcap.h   |  2 --
 arch/arm64/kernel/Makefile       |  2 +-
 arch/arm64/kernel/binfmt_elf32.c | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8713a2807582..168ab2cc426b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1085,7 +1085,6 @@ config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8f7bafa60d01..2a727658f51c 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -174,39 +174,15 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #endif
 
 #ifdef CONFIG_COMPAT
-
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
+#endif /* CONFIG_COMPAT */
 
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
-/*
- * Unlike the native SET_PERSONALITY macro, the compat version inherits
- * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
- * arch/arm/.
- */
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
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 2c7fc5d89813..99dfd9277559 100644
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
index 49fefa42d136..de6c84702d83 100644
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
index 000000000000..ff1f192a738a
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -0,0 +1,37 @@
+/*
+ * Support for AArch32 Linux ELF binaries.
+ */
+
+/* AArch32 EABI. */
+#define EF_ARM_EABI_MASK		0xff000000
+
+#define compat_start_thread		compat_start_thread
+/*
+ * Unlike the native SET_PERSONALITY macro, the compat version inherits
+ * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
+ * arch/arm/.
+ */
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
2.11.0
