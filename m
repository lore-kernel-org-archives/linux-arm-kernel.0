From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  4 Nov 2016 17:32:03 +0000
Subject: [PATCH v8 16/16] arm: add support for vGICv3 and vITS
In-Reply-To: <20161104173203.21168-1-andre.przywara@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
Message-ID: <20161104173203.21168-17-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

KVM/arm got support for vGICv3 and vITS recently, so make use of it.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/aarch32/arm-cpu.c              | 2 +-
 arm/aarch32/include/kvm/kvm-arch.h | 3 ---
 arm/aarch64/include/kvm/kvm-arch.h | 3 ---
 arm/include/arm-common/kvm-arch.h  | 2 ++
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arm/aarch32/arm-cpu.c b/arm/aarch32/arm-cpu.c
index 27a8e17..16bba55 100644
--- a/arm/aarch32/arm-cpu.c
+++ b/arm/aarch32/arm-cpu.c
@@ -12,7 +12,7 @@ static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	int timer_interrupts[4] = {13, 14, 11, 10};
 
-	gic__generate_fdt_nodes(fdt, IRQCHIP_GICV2);
+	gic__generate_fdt_nodes(fdt, kvm->cfg.arch.irqchip);
 	timer__generate_fdt_nodes(fdt, kvm, timer_interrupts);
 }
 
diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index 1632e3c..cd31e72 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -1,9 +1,6 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
-#define ARM_GIC_DIST_SIZE	0x1000
-#define ARM_GIC_CPUI_SIZE	0x2000
-
 #define ARM_KERN_OFFSET(...)	0x8000
 
 #define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 4925736..9de623a 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -1,9 +1,6 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
-#define ARM_GIC_DIST_SIZE	0x10000
-#define ARM_GIC_CPUI_SIZE	0x20000
-
 #define ARM_KERN_OFFSET(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
 				0x8000				:	\
 				0x80000)
diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index 0f5fb7f..c83c45f 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -18,6 +18,8 @@
 #define ARM_GIC_DIST_BASE	(ARM_AXI_AREA - ARM_GIC_DIST_SIZE)
 #define ARM_GIC_CPUI_BASE	(ARM_GIC_DIST_BASE - ARM_GIC_CPUI_SIZE)
 #define ARM_GIC_SIZE		(ARM_GIC_DIST_SIZE + ARM_GIC_CPUI_SIZE)
+#define ARM_GIC_DIST_SIZE	0x10000
+#define ARM_GIC_CPUI_SIZE	0x20000
 
 #define ARM_IOPORT_SIZE		(ARM_MMIO_AREA - ARM_IOPORT_AREA)
 #define ARM_VIRTIO_MMIO_SIZE	(ARM_AXI_AREA - (ARM_MMIO_AREA + ARM_GIC_SIZE))
-- 
2.9.0
