From: joel.schopp@amd.com (Joel Schopp)
Date: Mon, 11 Aug 2014 17:48:34 -0500
Subject: [RFC PATCH] arm64: KVM: add irqfd support
Message-ID: <20140811224834.21813.82517.stgit@joelaarch64.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends on Eric Auger's "ARM: KVM: add irqfd support" patch.

Enable vfio of platform devices for ARM64.  This patch fixes the ARM64 compile.
However this patch has only been compile tested.  It seemed worth sharing as it
will allow us to carry both the ARM and ARM64 patches together as we do more
testing.

Cc: Eirc Auger <eric.auger@linaro.org>
Signed-off-by: Joel Schopp <joel.schopp@amd.com>
---
 Documentation/virtual/kvm/api.txt |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |    4 ++++
 arch/arm64/kvm/Kconfig            |    4 +++-
 arch/arm64/kvm/Makefile           |    2 +-
 drivers/vfio/platform/Kconfig     |    2 +-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 04310d9..bc64ce9 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2132,7 +2132,7 @@ into the hash PTE second double word).
 4.75 KVM_IRQFD
 
 Capability: KVM_CAP_IRQFD
-Architectures: x86 s390 arm
+Architectures: x86 s390 arm arm64
 Type: vm ioctl
 Parameters: struct kvm_irqfd (in)
 Returns: 0 on success, -1 on error
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index e633ff8..3df8baa 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -180,6 +180,10 @@ struct kvm_arch_memory_slot {
 /* Highest supported SPI, from VGIC_NR_IRQS */
 #define KVM_ARM_IRQ_GIC_MAX		127
 
+/* One single KVM irqchip, ie. the VGIC */
+#define KVM_NR_IRQCHIPS          1
+
+
 /* PSCI interface */
 #define KVM_PSCI_FN_BASE		0x95c1ba5e
 #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8ba85e9..cbd3525 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
+	select HAVE_KVM_EVENTFD
 	---help---
 	  Support hosting virtualized guest machines.
 
@@ -50,13 +51,14 @@ config KVM_ARM_MAX_VCPUS
 config KVM_ARM_VGIC
 	bool
 	depends on KVM_ARM_HOST && OF
-	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_IRQFD
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
 config KVM_ARM_TIMER
 	bool
 	depends on KVM_ARM_VGIC
+	select HAVE_KVM_IRQCHIP
 	---help---
 	  Adds support for the Architected Timers in virtual machines.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 72a9fd5..40b9970 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -11,7 +11,7 @@ ARM=../../../arch/arm/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
 
-kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
 
diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
index c51af17..43ee890 100644
--- a/drivers/vfio/platform/Kconfig
+++ b/drivers/vfio/platform/Kconfig
@@ -1,6 +1,6 @@
 config VFIO_PLATFORM
 	tristate "VFIO support for platform devices"
-	depends on VFIO && EVENTFD && ARM
+	depends on VFIO && EVENTFD && (ARM || ARM64)
 	help
 	  Support for platform devices with VFIO. This is required to make
 	  use of platform devices present on the system using the VFIO
