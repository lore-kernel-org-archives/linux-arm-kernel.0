From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:55 +0200
Subject: [PATCH 06/11] ARM: pm: let platforms select cpu_suspend support
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for the cpu_suspend functions is only built-in
when CONFIG_PM_SLEEP is enabled, but omap3/4, exynos4
and pxa always call cpu_suspend when CONFIG_PM is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig              |    4 ++++
 arch/arm/kernel/Makefile      |    2 +-
 arch/arm/mach-exynos4/Kconfig |    1 +
 arch/arm/mach-omap2/Kconfig   |    2 ++
 arch/arm/mm/proc-v7.S         |    2 +-
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 497af51..3445f50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -631,6 +631,7 @@ config ARCH_PXA
 	select SPARSE_IRQ
 	select AUTO_ZRELADDR
 	select MULTI_IRQ_HANDLER
+	select ARM_CPU_SUSPEND if PM
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
@@ -2077,6 +2078,9 @@ config ARCH_SUSPEND_POSSIBLE
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
 	def_bool y
 
+config ARM_CPU_SUSPEND
+	def_bool PM_SLEEP
+
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index f7887dc..4ce3303 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
-obj-$(CONFIG_PM_SLEEP)		+= sleep.o
+obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 0c77ab9..fc1f92d 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -12,6 +12,7 @@ if ARCH_EXYNOS4
 config CPU_EXYNOS4210
 	bool
 	select S3C_PL330_DMA
+	select ARM_CPU_SUSPEND if PM
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..89bfb49 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -36,6 +36,7 @@ config ARCH_OMAP3
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
+	select ARM_CPU_SUSPEND if PM
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -50,6 +51,7 @@ config ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
+	select ARM_CPU_SUSPEND if PM
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a30e785..591accd 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -217,7 +217,7 @@ ENDPROC(cpu_v7_set_pte_ext)
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
 .equ	cpu_v7_suspend_size, 4 * 9
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM_CPU_SUSPEND
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r11, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
-- 
1.7.5.4
