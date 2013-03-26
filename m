From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:01:17 +0000
Subject: [PATCH v2 22/30] arm64: KVM: Build system integration
In-Reply-To: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
References: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364317285-20937-23-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig      |  2 ++
 arch/arm64/Makefile     |  2 +-
 arch/arm64/kvm/Kconfig  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/Makefile | 18 +++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/Kconfig
 create mode 100644 arch/arm64/kvm/Makefile

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43b0e9f..d984a46 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -240,6 +240,8 @@ source "drivers/Kconfig"
 
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
index 0000000..b2ce0a7
--- /dev/null
+++ b/arch/arm64/kvm/Makefile
@@ -0,0 +1,18 @@
+#
+# Makefile for Kernel-based Virtual Machine module
+#
+
+ccflags-y += -Ivirt/kvm -Iarch/arm64/kvm
+CFLAGS_arm.o := -I.
+CFLAGS_mmu.o := -I.
+
+obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+
+obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../arch/arm/kvm/, arm.o mmu.o mmio.o psci.o perf.o)
+
+obj-$(CONFIG_KVM_ARM_HOST) += inject_fault.o
+obj-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o idmap.o
+obj-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
+
+obj-$(CONFIG_KVM_ARM_VGIC) += $(addprefix ../../../arch/arm/kvm/, vgic.o)
+obj-$(CONFIG_KVM_ARM_TIMER) += $(addprefix ../../../arch/arm/kvm/, arch_timer.o)
-- 
1.8.1.4
