From: julien.grall@arm.com (Julien Grall)
Date: Thu, 10 May 2018 15:04:40 +0100
Subject: [RFC 12/13] kvmtool: arm64: Switch memory layout
In-Reply-To: <20180510140441.24573-1-julien.grall@arm.com>
References: <20180510140441.24573-1-julien.grall@arm.com>
Message-ID: <20180510140441.24573-13-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If the guest wants to use a larger physical address space place
the RAM at upper half of the address space. Otherwise, it uses the
default layout.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch32/include/kvm/kvm-arch.h |  1 +
 arm/aarch64/include/kvm/kvm-arch.h | 13 ++++++++++---
 arm/include/arm-common/kvm-arch.h  |  8 ++++++--
 arm/kvm.c                          |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index 2ee0cb1..f0f0943 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -4,6 +4,7 @@
 #define ARM_KERN_OFFSET(...)	0x8000
 
 #define ARM_MAX_PHYS_SHIFT(...)	32
+#define ARM_MEMORY_AREA(...)	ARM32_MEMORY_AREA
 
 #include "arm-common/kvm-arch.h"
 
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 53ac20f..9c9009b 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -1,12 +1,19 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
+#include "arm-common/kvm-arch.h"
+
+#define ARM64_MEMORY_AREA(phys_shift)	(1UL << (phys_shift - 1))
+
+#define ARM_MEMORY_AREA(cfg)	((cfg)->arch.aarch32_guest ?			\
+				 ARM32_MEMORY_AREA		:		\
+				 ARM64_MEMORY_AREA((cfg)->arch.phys_shift))
+
 #define ARM_KERN_OFFSET(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
 				0x8000				:	\
 				0x80000)
 
-#define ARM_MAX_PHYS_SHIFT(cfg)	((cfg)->arch.aarch32_guest ? 32 : 40)
-
-#include "arm-common/kvm-arch.h"
+#define ARM_MAX_PHYS_SHIFT(cfg)	((cfg)->arch.aarch32_guest ? 32 :	\
+				 (cfg)->arch.phys_shift)
 
 #endif /* KVM__KVM_ARCH_H */
diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index 884dda8..4be9589 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -10,7 +10,11 @@
 #define ARM_IOPORT_AREA		_AC(0x0000000000000000, UL)
 #define ARM_MMIO_AREA		_AC(0x0000000000010000, UL)
 #define ARM_AXI_AREA		_AC(0x0000000040000000, UL)
-#define ARM_MEMORY_AREA		_AC(0x0000000080000000, UL)
+
+#define ARM32_MEMORY_AREA	_AC(0x0000000080000000, UL)
+#define ARM32_MAX_MEMORY	((1ULL << 32) - ARM32_MEMORY_AREA)
+
+#define ARM_IOMEM_AREA_END	ARM32_MEMORY_AREA
 
 #define ARM_GIC_DIST_BASE	(ARM_AXI_AREA - ARM_GIC_DIST_SIZE)
 #define ARM_GIC_CPUI_BASE	(ARM_GIC_DIST_BASE - ARM_GIC_CPUI_SIZE)
@@ -21,7 +25,7 @@
 #define ARM_IOPORT_SIZE		(ARM_MMIO_AREA - ARM_IOPORT_AREA)
 #define ARM_VIRTIO_MMIO_SIZE	(ARM_AXI_AREA - (ARM_MMIO_AREA + ARM_GIC_SIZE))
 #define ARM_PCI_CFG_SIZE	(1ULL << 24)
-#define ARM_PCI_MMIO_SIZE	(ARM_MEMORY_AREA - \
+#define ARM_PCI_MMIO_SIZE	(ARM_IOMEM_AREA_END - \
 				(ARM_AXI_AREA + ARM_PCI_CFG_SIZE))
 
 #define KVM_IOPORT_AREA		ARM_IOPORT_AREA
diff --git a/arm/kvm.c b/arm/kvm.c
index 8a7c611..5a2bd28 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -127,7 +127,7 @@ static void kvm__arch_sanitize_cfg(struct kvm_config *cfg)
 		 */
 		if (cfg->nr_ram > 1)
 			die("sanitize: Base address should be specified for all the banks\n");
-		bank0->base = ARM_MEMORY_AREA;
+		bank0->base = ARM_MEMORY_AREA(cfg);
 		/*
 		 * Keep compatibility with old KVM command line behavior where
 		 * the memory is capped.
-- 
2.11.0
