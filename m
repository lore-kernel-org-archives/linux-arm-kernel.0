From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 22 Apr 2014 19:48:57 -0500
Subject: [PATCH v6 6/6] ARM: add CONFIG_VDSO Kconfig and Makefile bits
In-Reply-To: <cover.1398213562.git.nathan_lynch@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
Message-ID: <82f013e124b7133ccf6b25f2910142775f4838f6.1398213562.git.nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow users to enable the vdso in Kconfig; include the vdso in the
build if CONFIG_VDSO is enabled.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/Makefile |  1 +
 arch/arm/mm/Kconfig      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a766bcbaf8ad..c70b5a4855d9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
+obj-$(CONFIG_VDSO)		+= vdso.o vdso/
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index f5ad9ee70426..0e89f59ff4c3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -824,6 +824,21 @@ config KUSER_HELPERS
 	  Say N here only if you are absolutely certain that you do not
 	  need these helpers; otherwise, the safe option is to say Y.
 
+config VDSO
+	bool "Enable vDSO for acceleration of some system calls"
+	depends on AEABI && MMU
+	default y if ARM_ARCH_TIMER
+	select GENERIC_TIME_VSYSCALL
+	help
+	  Place in the process address space an ELF shared object
+	  providing fast implementations of several system calls,
+	  including gettimeofday and clock_gettime.  Systems that
+	  implement the ARM architected timer will receive maximum
+	  benefit.
+
+	  You must have glibc 2.20 or later for programs to seamlessly
+	  take advantage of this.
+
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
 	depends on CPU_V6K && SMP
-- 
1.8.3.1
