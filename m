From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:58 -0500
Subject: [PATCH v7 9/9] ARM: add CONFIG_VDSO Kconfig and Makefile bits
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-10-git-send-email-nathan_lynch@mentor.com>
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
index 38ddd9f83d0e..87d4cdc3f3f9 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o perf_event_cpu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
+obj-$(CONFIG_VDSO)		+= vdso.o vdso/
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index eda0dd0ab97b..616f46794502 100644
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
1.9.3
