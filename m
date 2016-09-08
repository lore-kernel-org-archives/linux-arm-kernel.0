From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 15:01:03 +0100
Subject: [RFC PATCH 8/8] arm64: Wire up and expose the new compat vDSO
In-Reply-To: <20160908140103.7468-1-kevin.brodsky@arm.com>
References: <20160908140103.7468-1-kevin.brodsky@arm.com>
Message-ID: <20160908140103.7468-9-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the new compat vDSO via the COMPAT_VDSO config option.

The option is not enabled by default for two reasons:

* The vDSO page replaces the vector page. The vDSO provides its own
  sigreturn trampolines, replacing those in the vector page, but the
  kuser helpers are gone. As a result enabling the compat vDSO will
  break userspace programs relying on the kuser helpers.

* We really need a 32-bit compiler this time, and we rely on the user
  to provide it themselves by setting CROSS_COMPILE_ARM32. Therefore
  enabling the option by default would make little sense, since the
  user must explicitly set an environment variable anyway.

CONFIG_COMPAT_VDSO is not directly used in the code, because we want
to ignore it (build as if it were not set) if the user didn't set
CROSS_COMPILE_ARM32 properly. If the variable has been set to a valid
prefix, CONFIG_VDSO32 will be set; this is the option that the code
and Makefiles will test.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/Kconfig         | 20 ++++++++++++++++++++
 arch/arm64/Makefile        | 20 ++++++++++++++++++--
 arch/arm64/kernel/Makefile |  8 ++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..10afbd17b158 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1012,6 +1012,26 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config COMPAT_VDSO
+	bool "32-bit vDSO"
+	depends on COMPAT
+	default n
+	help
+	  Warning: this completely removes the compat vector page, including
+	  kuser helpers, which may break 32-bit processes.
+
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
+	  trampolines, and replaces the vector page.
+
 endmenu
 
 menu "Power management options"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b54f8c021d8..88c18fbb550b 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,10 +29,24 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+ifeq ($(CONFIG_COMPAT_VDSO), y)
+  # Check that the user has provided a valid prefix for arm32 (we allow
+  # CROSS_COMPILE_ARM32 to be defined but empty, in case the system gcc should
+  # be used)
+  ifeq ($(shell [ -v CROSS_COMPILE_ARM32 ] && echo y),)
+    $(warning CROSS_COMPILE_ARM32 not defined, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
+    $(warning $(CROSS_COMPILE_ARM32)gcc not found, the compat vDSO will not be built)
+  else
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
@@ -129,6 +143,8 @@ archclean:
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
+					  include/generated/vdso32-offsets.h)
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 14f7b651c787..509d0adc9bf0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,8 +25,11 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o entry32.o
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o sys_compat.o	\
+					   entry32.o
+ifneq ($(CONFIG_VDSO32),y)
+arm64-obj-y				+= kuser32.o
+endif
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
@@ -50,6 +53,7 @@ arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_VDSO32)			+= vdso32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-- 
2.9.3
