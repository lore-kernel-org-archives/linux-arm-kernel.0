From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Jul 2013 13:02:57 +0100
Subject: [PATCH] arm64: KVM: Kconfig integration
Message-ID: <1372939377-24657-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally plug KVM/arm64 into the config system, making it possible
to enable KVM support on AArch64 CPUs.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig              |  2 ++
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kvm/Kconfig          | 54 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/kvm/Kconfig

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4143d9b..9737e97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -270,6 +270,8 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+source "arch/arm64/kvm/Kconfig"
+
 source "arch/arm64/Kconfig.debug"
 
 source "security/Kconfig"
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 49c162c..666e231 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <linux/kvm_host.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/cputable.h>
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
new file mode 100644
index 0000000..84f54f0
--- /dev/null
+++ b/arch/arm64/kvm/Kconfig
@@ -0,0 +1,54 @@
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
+	select MMU_NOTIFIER
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
+	---help---
+	  Adds support for the Architected Timers in virtual machines
+
+endif # VIRTUALIZATION
-- 
1.8.2.3
