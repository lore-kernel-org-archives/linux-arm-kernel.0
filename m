From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 17:23:17 -0800
Subject: [RFC/PATCH 3/3] ARM: Replace calls to __aeabi_{u}idiv with udiv/sdiv
 instructions
In-Reply-To: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448068997-26631-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM compiler inserts calls to __aeabi_uidiv() and
__aeabi_idiv() when it needs to perform division on signed and
unsigned integers. If a processor has support for the udiv and
sdiv division instructions the calls to these support routines
can be replaced with those instructions. Now that recordmcount
records the locations of calls to these library functions in
two sections (one for udiv and one for sdiv), iterate over these
sections early at boot and patch the call sites with the
appropriate division instruction when we determine that the
processor supports the division instructions. Using the division
instructions should be faster and less power intensive than
running the support code.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: M?ns Rullg?rd <mans@mansr.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Makefile                      |  7 +++++++
 arch/arm/Kconfig              | 14 ++++++++++++++
 arch/arm/kernel/module.c      | 44 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c       | 34 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S | 13 +++++++++++++
 kernel/trace/Kconfig          |  2 +-
 6 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 69be581e7c7a..9efc8274eba9 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,13 @@ ifdef CONFIG_DYNAMIC_FTRACE
 endif
 endif
 
+ifdef CONFIG_ARM_PATCH_UIDIV
+	ifndef BUILD_C_RECORDMCOUNT
+		BUILD_C_RECORDMCOUNT := y
+		export BUILD_C_RECORDMCOUNT
+	endif
+endif
+
 # We trigger additional mismatches with less inlining
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9246bd7cc3cf..9e2d2adcc85b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1640,6 +1640,20 @@ config AEABI
 
 	  To use this you need GCC version 4.0.0 or later.
 
+config ARM_PATCH_UIDIV
+	bool "Runtime patch calls to __aeabi_{u}idiv() with udiv/sdiv"
+	depends on CPU_V7 && !XIP_KERNEL && AEABI
+	help
+	  Some v7 CPUs have support for the udiv and sdiv instructions
+	  that can be used in place of calls to __aeabi_uidiv and __aeabi_idiv
+	  functions provided by the ARM runtime ABI.
+
+	  Enabling this option allows the kernel to modify itself to replace
+	  branches to these library functions with the udiv and sdiv
+	  instructions themselves. Typically this will be faster and less
+	  power intensive than running the library support code to do
+	  integer division.
+
 config OABI_COMPAT
 	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
 	depends on AEABI && !THUMB2_KERNEL
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index efdddcb97dd1..064e6ae60e08 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/gfp.h>
 
+#include <asm/hwcap.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
@@ -51,6 +52,43 @@ void *module_alloc(unsigned long size)
 }
 #endif
 
+#ifdef CONFIG_ARM_PATCH_UIDIV
+static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
+{
+	extern char __aeabi_uidiv[], __aeabi_idiv[];
+	unsigned long udiv_addr = (unsigned long)__aeabi_uidiv;
+	unsigned long sdiv_addr = (unsigned long)__aeabi_idiv;
+	unsigned int udiv_insn, sdiv_insn, mask;
+
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		mask = HWCAP_IDIVT;
+		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
+		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
+	} else {
+		mask = HWCAP_IDIVA;
+		udiv_insn = __opcode_to_mem_arm(0xe730f110);
+		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
+	}
+
+	if (elf_hwcap & mask) {
+		if (sym->st_value == udiv_addr) {
+			*(u32 *)loc = udiv_insn;
+			return 1;
+		} else if (sym->st_value == sdiv_addr) {
+			*(u32 *)loc = sdiv_insn;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+#else
+static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
+{
+	return 0;
+}
+#endif
+
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
@@ -109,6 +147,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				return -ENOEXEC;
 			}
 
+			if (module_patch_aeabi_uidiv(loc, sym))
+				break;
+
 			offset = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = (offset & 0x00ffffff) << 2;
 			if (offset & 0x02000000)
@@ -195,6 +236,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				return -ENOEXEC;
 			}
 
+			if (module_patch_aeabi_uidiv(loc, sym))
+				break;
+
 			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
 			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 20edd349d379..d2a3d165dcae 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -375,6 +375,39 @@ void __init early_print(const char *str, ...)
 	printk("%s", buf);
 }
 
+#ifdef CONFIG_ARM_PATCH_UIDIV
+static void __init patch_aeabi_uidiv(void)
+{
+	extern unsigned long *__start_udiv_loc[], *__stop_udiv_loc[];
+	extern unsigned long *__start_idiv_loc[], *__stop_idiv_loc[];
+	unsigned long **p;
+	unsigned int udiv_insn, sdiv_insn, mask;
+
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		mask = HWCAP_IDIVT;
+		udiv_insn = __opcode_to_mem_thumb32(0xfbb0f0f1);
+		sdiv_insn = __opcode_to_mem_thumb32(0xfb90f0f1);
+	} else {
+		mask = HWCAP_IDIVA;
+		udiv_insn = __opcode_to_mem_arm(0xe730f110);
+		sdiv_insn = __opcode_to_mem_arm(0xe710f110);
+	}
+
+	if (elf_hwcap & mask) {
+		for (p = __start_udiv_loc; p < __stop_udiv_loc; p++) {
+			unsigned long *inst = *p;
+			*inst = udiv_insn;
+		}
+		for (p = __start_idiv_loc; p < __stop_idiv_loc; p++) {
+			unsigned long *inst = *p;
+			*inst = sdiv_insn;
+		}
+	}
+}
+#else
+static void __init patch_aeabi_uidiv(void) { }
+#endif
+
 static void __init cpuid_init_hwcaps(void)
 {
 	int block;
@@ -642,6 +675,7 @@ static void __init setup_processor(void)
 	elf_hwcap = list->elf_hwcap;
 
 	cpuid_init_hwcaps();
+	patch_aeabi_uidiv();
 
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde5ce48..bc87a2e04e6f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -28,6 +28,18 @@
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
+#ifdef CONFIG_ARM_PATCH_UIDIV
+#define UIDIV_REC	. = ALIGN(8);					\
+			VMLINUX_SYMBOL(__start_udiv_loc) = .;		\
+			*(__udiv_loc)					\
+			VMLINUX_SYMBOL(__stop_udiv_loc) = .;		\
+			VMLINUX_SYMBOL(__start_idiv_loc) = .;		\
+			*(__idiv_loc)					\
+			VMLINUX_SYMBOL(__stop_idiv_loc) = .;
+#else
+#define UIDIV_REC
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
 #define ARM_CPU_KEEP(x)		x
@@ -210,6 +222,7 @@ SECTIONS
 	.init.data : {
 #ifndef CONFIG_XIP_KERNEL
 		INIT_DATA
+		UIDIV_REC
 #endif
 		INIT_SETUP(16)
 		INIT_CALLS
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 578b666ed7d9..22b229515416 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -59,7 +59,7 @@ config HAVE_C_RECORDMCOUNT
 
 config RUN_RECORDMCOUNT
 	def_bool y
-	depends on DYNAMIC_FTRACE && HAVE_FTRACE_MCOUNT_RECORD
+	depends on (DYNAMIC_FTRACE && HAVE_FTRACE_MCOUNT_RECORD) || ARM_PATCH_UIDIV
 
 config TRACER_MAX_TRACE
 	bool
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
