From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:53 +0000
Subject: [RFC PATCH v3 11/11] arm64: Wire up and expose the new compat vDSO
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-12-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the new compat vDSO via the COMPAT_VDSO config option.

The option is not enabled in defconfig because we really need a 32-bit
compiler this time, and we rely on the user to provide it themselves
by setting CROSS_COMPILE_ARM32. Therefore enabling the option by
default would make little sense, since the user must explicitly set a
non-standard environment variable anyway.

CONFIG_COMPAT_VDSO is not directly used in the code, because we want
to ignore it (build as if it were not set) if the user didn't set
CROSS_COMPILE_ARM32 properly. If the variable has been set to a valid
prefix, CONFIG_VDSO32 will be set; this is the option that the code
and Makefiles test.

For more flexibility, like CROSS_COMPILE, CROSS_COMPILE_ARM32 can also
be set via CONFIG_CROSS_COMPILE_ARM32 (the environment variable
overrides the config option, as expected).

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig         | 23 +++++++++++++++++++++++
 arch/arm64/Makefile        | 28 ++++++++++++++++++++++++++--
 arch/arm64/kernel/Makefile |  8 ++++++--
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 265d88c44cfc..721b8151ff8c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1046,6 +1046,29 @@ config SYSVIPC_COMPAT
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
+	  as CROSS_COMPILE). If a 32-bit compiler cannot be found, a warning
+	  will be printed and the kernel will be built as if COMPAT_VDSO had not
+	  been set.
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
index 3635b8662724..370d8de0c100 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -37,10 +37,32 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+ifeq ($(CONFIG_COMPAT_VDSO), y)
+  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_ARM32:"%"=%)
+
+  # Check that the user has provided a valid prefix for the 32-bit toolchain.
+  # To prevent selecting the system gcc by default, the prefix is not allowed to
+  # be empty, unlike CROSS_COMPILE. In the unlikely event that the system gcc
+  # is actually the 32-bit ARM compiler to be used, the variable can be set to
+  # the dirname (e.g. CROSS_COMPILE_ARM32=/usr/bin/).
+  # Note: this Makefile is read both before and after regenerating the
+  # config (if needed). Any warning appearing before the config has been
+  # regenerated should be ignored.
+  ifeq ($(CROSS_COMPILE_ARM32),)
+    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
+    $(warning $(CROSS_COMPILE_ARM32)gcc not found, the compat vDSO will not be built)
+  else
+    export CROSS_COMPILE_ARM32
+    export CONFIG_VDSO32 := y
+    vdso32 := -DCONFIG_VDSO32=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(vdso32)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
-KBUILD_AFLAGS	+= $(lseinstr)
+KBUILD_AFLAGS	+= $(lseinstr) $(vdso32)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
@@ -139,6 +161,8 @@ archclean:
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
+					  include/generated/vdso32-offsets.h)
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 0850506d0217..b0e1005037cd 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,11 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o sigreturn32.o signal32.o	\
-					   sys_compat.o entry32.o
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o sys_compat.o	\
+					   entry32.o
+ifneq ($(CONFIG_VDSO32),y)
+arm64-obj-y				+= sigreturn32.o
+endif
 arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
@@ -53,6 +56,7 @@ arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_VDSO32)			+= vdso32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-- 
2.10.2
