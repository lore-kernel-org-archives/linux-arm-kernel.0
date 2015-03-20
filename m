From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 20 Mar 2015 16:13:23 -0500
Subject: [PATCH v11 4/4] ARM: add CONFIG_VDSO Kconfig and Makefile bits
In-Reply-To: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
References: <1426886003-30123-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1426886003-30123-5-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow users to enable the vdso in Kconfig; include the vdso in the
build if CONFIG_VDSO is enabled.  Add 'vdso_install' target.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/Makefile        |  8 ++++++++
 arch/arm/kernel/Makefile |  1 +
 arch/arm/mm/Kconfig      | 14 ++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7f99cd652203..6c13a84b6cd2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -263,6 +263,7 @@ core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)
 core-$(CONFIG_VFP)		+= arch/arm/vfp/
 core-$(CONFIG_XEN)		+= arch/arm/xen/
 core-$(CONFIG_KVM_ARM_HOST) 	+= arch/arm/kvm/
+core-$(CONFIG_VDSO)		+= arch/arm/vdso/
 
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
@@ -320,6 +321,12 @@ dtbs: prepare scripts
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
 
+PHONY += vdso_install
+vdso_install:
+ifeq ($(CONFIG_VDSO),y)
+	$(Q)$(MAKE) $(build)=arch/arm/vdso $@
+endif
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
@@ -344,4 +351,5 @@ define archhelp
   echo  '                  Install using (your) ~/bin/$(INSTALLKERNEL) or'
   echo  '                  (distribution) /sbin/$(INSTALLKERNEL) or'
   echo  '                  install to $$(INSTALL_PATH) and run lilo'
+  echo  '  vdso_install  - Install unstripped vdso.so to $$(INSTALL_MOD_PATH)/vdso'
 endef
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 902397dd1000..3e316ca54e40 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
 CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
+obj-$(CONFIG_VDSO)		+= vdso.o
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9b4f29e595a4..8a5f1e644104 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -825,6 +825,20 @@ config KUSER_HELPERS
 	  Say N here only if you are absolutely certain that you do not
 	  need these helpers; otherwise, the safe option is to say Y.
 
+config VDSO
+	bool "Enable VDSO for acceleration of some system calls"
+	depends on AEABI && MMU
+	default y if ARM_ARCH_TIMER
+	select GENERIC_TIME_VSYSCALL
+	help
+	  Place in the process address space an ELF shared object
+	  providing fast implementations of gettimeofday and
+	  clock_gettime.  Systems that implement the ARM architected
+	  timer will receive maximum benefit.
+
+	  You must have glibc 2.22 or later for programs to seamlessly
+	  take advantage of this.
+
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
 	depends on CPU_V6K && SMP
-- 
1.9.3
