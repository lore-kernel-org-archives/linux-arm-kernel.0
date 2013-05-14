From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:49 +0100
Subject: [PATCH v4 21/32] arm64: KVM: Build system integration
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-22-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig      |  2 ++
 arch/arm64/Makefile     |  2 +-
 arch/arm64/kvm/Kconfig  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/Makefile | 23 +++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/Kconfig
 create mode 100644 arch/arm64/kvm/Makefile

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 48347dc..a74f6fd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -237,6 +237,8 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+source "arch/arm64/kvm/Kconfig"
+
 source "arch/arm64/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index c95c5cb..ae89e63 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,7 @@ TEXT_OFFSET := 0x00080000
 
 export	TEXT_OFFSET GZFLAGS
 
-core-y		+= arch/arm64/kernel/ arch/arm64/mm/
+core-y		+= arch/arm64/kernel/ arch/arm64/mm/ arch/arm64/kvm/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
new file mode 100644
index 0000000..a76be8b
--- /dev/null
+++ b/arch/arm64/kvm/Kconfig
@@ -0,0 +1,59 @@
+#
+# KVM configuration
+#
+
+source "virt/kvm/Kconfig"
+
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	---help---
+	  Say Y here to get to see options for using your Linux host to run
+	  other operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and
+	  disabled.
+
+if VIRTUALIZATION
+
+config KVM
+	bool "Kernel-based Virtual Machine (KVM) support"
+	select PREEMPT_NOTIFIERS
+	select ANON_INODES
+	select KVM_MMIO
+	select KVM_ARM_HOST
+	select KVM_ARM_VGIC
+	select KVM_ARM_TIMER
+	---help---
+	  Support hosting virtualized guest machines.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  If unsure, say N.
+
+config KVM_ARM_HOST
+	bool
+	depends on KVM
+	depends on MMU
+	select	MMU_NOTIFIER
+	---help---
+	  Provides host support for ARM processors.
+
+config KVM_ARM_VGIC
+        bool
+	depends on KVM_ARM_HOST && OF
+	select HAVE_KVM_IRQCHIP
+	---help---
+	  Adds support for a hardware assisted, in-kernel GIC emulation.
+
+config KVM_ARM_TIMER
+        bool
+	depends on KVM_ARM_VGIC
+	select HAVE_KVM_IRQCHIP
+	---help---
+	  Adds support for the Architected Timers in virtual machines
+
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
new file mode 100644
index 0000000..75b8c48
--- /dev/null
+++ b/arch/arm64/kvm/Makefile
@@ -0,0 +1,23 @@
+#
+# Makefile for Kernel-based Virtual Machine module
+#
+
+ccflags-y += -Ivirt/kvm -Iarch/arm64/kvm
+CFLAGS_arm.o := -I.
+CFLAGS_mmu.o := -I.
+
+KVM=../../../virt/kvm
+ARM=../../../arch/arm/kvm
+
+obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
+
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
+
+kvm-$(CONFIG_KVM_ARM_HOST) += inject_fault.o
+kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
+kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
+
+obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
+obj-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
-- 
1.8.2.3
