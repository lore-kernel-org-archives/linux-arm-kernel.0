From: eric.auger@linaro.org (Eric Auger)
Date: Sun, 23 Nov 2014 18:57:00 +0100
Subject: [PATCH v4 3/3] KVM: arm64: add irqfd support
In-Reply-To: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1416765420-12057-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel Schopp <joel.schopp@amd.com>

This patch enables irqfd for arm64.

Signed-off-by: Joel Schopp <joel.schopp@amd.com>
Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

[Eric Auger]
- originates from Joel's [RFC PATCH] arm64: KVM: add irqfd support
  http://www.spinics.net/lists/kvm-arm/msg10798.html
- isolates modifications really related to irqfd
---
 Documentation/virtual/kvm/api.txt | 4 ++--
 arch/arm64/include/uapi/asm/kvm.h | 3 +++
 arch/arm64/kvm/Kconfig            | 2 ++
 arch/arm64/kvm/Makefile           | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 4deccc0..c76ce04 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2206,7 +2206,7 @@ into the hash PTE second double word).
 4.75 KVM_IRQFD
 
 Capability: KVM_CAP_IRQFD
-Architectures: x86 s390 arm
+Architectures: x86 s390 arm arm64
 Type: vm ioctl
 Parameters: struct kvm_irqfd (in)
 Returns: 0 on success, -1 on error
@@ -2232,7 +2232,7 @@ Note that closing the resamplefd is not sufficient to disable the
 irqfd.  The KVM_IRQFD_FLAG_RESAMPLE is only necessary on assignment
 and need not be specified with KVM_IRQFD_FLAG_DEASSIGN.
 
-On arm, the gsi must be a shared peripheral interrupt (SPI).
+On arm/arm64, the gsi must be a shared peripheral interrupt (SPI).
 This means the corresponding programmed GIC interrupt ID is gsi+32.
 
 4.76 KVM_PPC_ALLOCATE_HTAB
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 8e38878..1ed4417 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -182,6 +182,9 @@ struct kvm_arch_memory_slot {
 /* Highest supported SPI, from VGIC_NR_IRQS */
 #define KVM_ARM_IRQ_GIC_MAX		127
 
+/* One single KVM irqchip, ie. the VGIC */
+#define KVM_NR_IRQCHIPS          1
+
 /* PSCI interface */
 #define KVM_PSCI_FN_BASE		0x95c1ba5e
 #define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 279e1a0..09c25c2 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,6 +26,7 @@ config KVM
 	select KVM_ARM_HOST
 	select KVM_ARM_VGIC
 	select KVM_ARM_TIMER
+	select HAVE_KVM_EVENTFD
 	---help---
 	  Support hosting virtualized guest machines.
 
@@ -50,6 +51,7 @@ config KVM_ARM_MAX_VCPUS
 config KVM_ARM_VGIC
 	bool
 	depends on KVM_ARM_HOST && OF
+	select HAVE_KVM_IRQFD
 	---help---
 	  Adds support for a hardware assisted, in-kernel GIC emulation.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 32a0961..2e6b827 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -11,7 +11,7 @@ ARM=../../../arch/arm/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += kvm.o
 
-kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/arm.o $(ARM)/mmu.o $(ARM)/mmio.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(ARM)/psci.o $(ARM)/perf.o
 
-- 
1.9.1
