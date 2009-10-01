From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:20 +0200
Subject: [PATCH] FCSE: add Makefile and compilation option.
In-Reply-To: <1254432860-11511-10-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-8-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-9-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-10-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-11-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/kernel/Makefile |    1 +
 arch/arm/mm/Kconfig      |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 79087dd..574e77e 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -52,5 +52,6 @@ endif
 
 head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
+obj-$(CONFIG_ARM_FCSE)	+= fcse.o
 
 extra-y := $(head-y) init_task.o vmlinux.lds
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8d43e58..fb9a4a5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -776,3 +776,48 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARCH_OMAP3
 	default 5
+
+config ARM_FCSE
+	bool "Fast Context Switch Extension (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && !SMP && !CPU_32v6 && !CPU_32v7
+	default n
+	help
+	  The Fast Context Switch Extension (FCSE for short) is an extension of
+	  some ARM processors which allows to switch contexts between processes
+	  without flushing cache and saves a few tens of microseconds in the
+	  worst case.
+
+	  Enabling this option makes linux use the FCSE.
+
+	  We propose two modes:
+	  - the guaranteed mode: we guarantee that there will never be any cache
+	    flush when switching context, but this means that there can not be
+	    more than 95 running processes in the system, each with a virtual
+	    memory space smaller than 32MB, and that the shared memory
+	    mappings do not use cache;
+	  - the best effort mode: we allow some cache flushes to happen from
+	    time to time, but do not limit the number of processes or the
+	    virtual memory space available for each process, and the shared
+	    memory mappings use cache.
+
+if ARM_FCSE
+
+choice
+	prompt "FCSE mode"
+	default ARM_FCSE_BEST_EFFORT
+	help
+	  This option allow setting which FCSE mode will be used.
+
+config ARM_FCSE_GUARANTEED
+	bool "guaranteed"
+	help
+	  Select guaranteed mode.
+
+config ARM_FCSE_BEST_EFFORT
+	bool "best effort"
+	help
+	  Select best-effort mode.
+
+endchoice
+
+endif
-- 
1.5.6.5
