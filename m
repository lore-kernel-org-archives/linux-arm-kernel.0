From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue,  1 Jun 2010 17:59:24 -0400
Subject: [RFC PATCH] gcov: Add ARM eABI support
Message-ID: <1275429564-9922-1-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

Initially based on linux-2.6.30-gcov-arm-eabi.patch [1] and
linux-2.6.30-gcov-arm-hack.patch [2] with fixups to resolve
forward port conflicts.  Improved on [1] by making the
constructors section name a kernel config variable so the
correct section name is automatically selected based on the
build target.

[1] http://ltp.cvs.sourceforge.net/viewvc/*checkout*/ltp/utils/analysis/gcov-kernel/linux-2.6.30-gcov-arm-eabi.patch?revision=1.1
[2] http://ltp.cvs.sourceforge.net/viewvc/*checkout*/ltp/utils/analysis/gcov-kernel/linux-2.6.30-gcov-arm-hack.patch?revision=1.1

Signed-off-by: David Singleton <dsingleton@mvista.com>
Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/boot/bootp/Makefile      |    2 ++
 arch/arm/boot/compressed/Makefile |    2 ++
 arch/arm/include/asm/elf.h        |    1 +
 arch/arm/kernel/module.c          |    1 +
 include/asm-generic/vmlinux.lds.h |    2 +-
 kernel/gcov/Kconfig               |    8 +++++++-
 kernel/module.c                   |    2 +-
 7 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index c394e30..5761f00 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -5,6 +5,8 @@
 # architecture-specific flags and dependencies.
 #
 
+GCOV_PROFILE	:= n
+
 LDFLAGS_bootp	:=-p --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 53faa90..e1aee30 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -8,6 +8,8 @@ HEAD	= head.o
 OBJS	= misc.o decompress.o
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
+GCOV_PROFILE		:= n
+
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 51662fe..6b19f46 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -52,6 +52,7 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_ABS32		2
 #define R_ARM_CALL		28
 #define R_ARM_JUMP24		29
+#define R_ARM_TARGET1		38
 #define R_ARM_V4BX		40
 #define R_ARM_PREL31		42
 #define R_ARM_MOVW_ABS_NC	43
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index c628bdf..2e04a98 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -129,6 +129,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			break;
 
 		case R_ARM_ABS32:
+		case R_ARM_TARGET1:
 			*(u32 *)loc += sym->st_value;
 			break;
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 48c5299..4dfce1a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -442,7 +442,7 @@
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			VMLINUX_SYMBOL(__ctors_start) = .; \
-			*(.ctors)			   \
+			*(CONFIG_GCOV_CTORS)			   \
 			VMLINUX_SYMBOL(__ctors_end) = .;
 #else
 #define KERNEL_CTORS()
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 70a298d..8564dc8 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -34,7 +34,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
 	bool "Profile entire Kernel"
 	depends on GCOV_KERNEL
-	depends on S390 || X86 || (PPC && EXPERIMENTAL) || MICROBLAZE
+	depends on S390 || X86 || (PPC && EXPERIMENTAL) || MICROBLAZE || ARM
 	default n
 	---help---
 	This options activates profiling for the entire kernel.
@@ -45,4 +45,10 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_CTORS
+	string
+	depends on GCOV_KERNEL
+	default ".init_array" if ARM && AEABI
+	default ".ctors"
+
 endmenu
diff --git a/kernel/module.c b/kernel/module.c
index 0129769..b4eaed9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2296,7 +2296,7 @@ static noinline struct module *load_module(void __user *umod,
 					    "__kcrctab_unused_gpl");
 #endif
 #ifdef CONFIG_CONSTRUCTORS
-	mod->ctors = section_objs(hdr, sechdrs, secstrings, ".ctors",
+	mod->ctors = section_objs(hdr, sechdrs, secstrings, CONFIG_GCOV_CTORS,
 				  sizeof(*mod->ctors), &mod->num_ctors);
 #endif
 
-- 
1.6.3.3.328.ga9ee94
