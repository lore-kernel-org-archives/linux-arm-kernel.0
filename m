From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:29 +0300
Subject: [PATCH v6 11/21] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to handle ILP32 binaries

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/binfmt_ilp32.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f1b798a..ad7158c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,6 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o binfmt_elf32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
new file mode 100644
index 0000000..02a7a6c
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_ilp32.c
@@ -0,0 +1,21 @@
+/*
+ * Support for ILP32 Linux/aarch64 ELF binaries.
+ */
+
+/* AARCH64 ILP32 EABI. */
+#define compat_elf_check_arch(x)	(((x)->e_machine == EM_AARCH64)	\
+					&& (x)->e_ident[EI_CLASS] == ELFCLASS32)
+
+#define COMPAT_SET_PERSONALITY(ex)					\
+do {									\
+	set_thread_flag(TIF_32BIT_AARCH64);				\
+	clear_thread_flag(TIF_32BIT);					\
+} while (0)
+
+#define COMPAT_ARCH_DLINFO						\
+do {									\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
+		    (elf_addr_t)(long)current->mm->context.vdso);	\
+} while (0)
+
+#include "../../../fs/compat_binfmt_elf.c"
-- 
2.5.0
