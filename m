From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:36:04 +0100
Subject: [RFC PATCH 12/14] arm64: kernel: add cpu_{suspend}/{resume} build
 infrastructure
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-13-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable the suspend infrastructure for the ARM64 kernel the
corresponding Kconfig and Makefile entries must be updated.

This patch adds a menu entry for power management options and
entries to enable newly added suspend/resume implementation.

Makefile changes add appropriate entries to include corresponding
files in the kernel image.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig         | 12 ++++++++++++
 arch/arm64/kernel/Makefile |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5855519..827d95e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -272,6 +272,18 @@ config SYSVIPC_COMPAT
 
 endmenu
 
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
+config ARM_CPU_SUSPEND
+	def_bool y
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..ad63448 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+arm64-obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
-- 
1.8.3.4
