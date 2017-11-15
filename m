From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 15 Nov 2017 14:05:16 -0800
Subject: [PATCH 6/6] arm64: Wire up and expose the new compat vDSO
In-Reply-To: <20171115220529.14458-1-salyzyn@android.com>
References: <20171115220529.14458-1-salyzyn@android.com>
Message-ID: <20171115220529.14458-7-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Expose the new compat vDSO via the COMPAT_VDSO config option.

The option is not enabled in defconfig because we really need a 32-bit
compiler this time, and we rely on the user to provide it themselves
by setting CROSS_COMPILE_ARM32. Therefore enabling the option by
default would make little sense, since the user must explicitly set a
non-standard environment variable anyway.

CONFIG_COMPAT_VDSO is not directly used in the code, because we want
to ignore it (build as if it were not set) if the user didn't set
CROSS_COMPILE_ARM32. If the variable has been set to a valid prefix,
CONFIG_VDSO32 will be set; this is the option that the code and
Makefiles test.

For more flexibility, like CROSS_COMPILE, CROSS_COMPILE_ARM32 can also
be set via CONFIG_CROSS_COMPILE_ARM32 (the environment variable
overrides the config option, as expected).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm64/Kconfig         | 24 ++++++++++++++++++++++++
 arch/arm64/Makefile        | 35 +++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/Makefile |  3 +++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d8a4fda50477..379d0154b363 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1183,6 +1183,30 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config COMPAT_VDSO
+	bool "32-bit vDSO"
+	depends on COMPAT
+	default n
+	help
+	  Warning: a 32-bit toolchain is necessary to build the vDSO. You
+	  must explicitly define which toolchain should be used by setting
+	  CROSS_COMPILE_ARM32 to the prefix of the 32-bit toolchain (same format
+	  as CROSS_COMPILE). If CROSS_COMPILE_ARM32 is empty, a warning will be
+	  printed and the kernel will be built as if COMPAT_VDSO had not been
+	  set. If CROSS_COMPILE_ARM32 is set to an invalid prefix, compilation
+	  will be aborted.
+
+	  Provide a vDSO to 32-bit processes. It includes the symbols provided
+	  by the vDSO from the 32-bit kernel, so that a 32-bit libc can use
+	  the compat vDSO without modification. It also provides sigreturn
+	  trampolines, replacing the sigreturn page.
+
+config CROSS_COMPILE_ARM32
+	string "32-bit toolchain prefix"
+	help
+	  Same as setting CROSS_COMPILE_ARM32 in the environment, but saved for
+	  future builds. The environment variable overrides this config option.
+
 endmenu
 
 menu "Power management options"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 939b310913cf..baf36f0a992d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -45,10 +45,39 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_COMPAT_VDSO), y)
+  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_ARM32:"%"=%)
+
+  # Check that the user has provided a valid prefix for the 32-bit toolchain.
+  # To prevent selecting the system $(cc-name) by default, the prefix is not
+  # allowed to be empty, unlike CROSS_COMPILE. In the unlikely event that the
+  # system $(cc-name) is actually the 32-bit ARM compiler to be used, the
+  # variable can be set to the dirname (e.g. CROSS_COMPILE_ARM32=/usr/bin/).
+  # Note: this Makefile is read both before and after regenerating the config
+  # (if needed). Any warning appearing before the config has been regenerated
+  # should be ignored. If the error is triggered and you set
+  # CONFIG_CROSS_COMPILE_ARM32, set CROSS_COMPILE_ARM32 to an appropriate value
+  # when invoking make and fix CONFIG_CROSS_COMPILE_ARM32.
+  ifeq ($(CROSS_COMPILE_ARM32),)
+    $(error CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(cc-name),clang)
+    export CLANG_TRIPLE_ARM32 ?= $(CROSS_COMPILE_ARM32)
+    export CLANG_TARGET_ARM32 := --target=$(notdir $(CLANG_TRIPLE_ARM32:%-=%))
+    export CONFIG_VDSO32 := y
+    vdso32 := -DCONFIG_VDSO32=1
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)$(cc-name) 2> /dev/null),)
+    $(error $(CROSS_COMPILE_ARM32)$(cc-name) not found, check CROSS_COMPILE_ARM32)
+  else
+    export CROSS_COMPILE_ARM32
+    export CONFIG_VDSO32 := y
+    vdso32 := -DCONFIG_VDSO32=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(vdso32)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(vdso32)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -157,6 +186,8 @@ archclean:
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
+					  include/generated/vdso32-offsets.h)
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 6e969f3cde6c..5db2b239cd68 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -30,7 +30,9 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o	\
 					   sys_compat.o entry32.o
+ifneq ($(CONFIG_VDSO32),y)
 arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
+endif
 arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
@@ -58,6 +60,7 @@ arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_VDSO32)			+= vdso32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-- 
2.15.0.448.gf294e3d99a-goog
