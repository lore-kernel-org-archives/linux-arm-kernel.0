From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 20 Jul 2015 14:02:07 +0100
Subject: [PATCH 05/14] arm: use new phandle allocation functions
In-Reply-To: <1437397336-21385-1-git-send-email-andre.przywara@arm.com>
References: <1437397336-21385-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1437397336-21385-6-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To refer to the GIC FDT node, we used to pass the GIC phandle to most
of the functions dealing with FDT nodes.
Since we now have a global phandle reference, use that to refer to the
GIC handle in various places and get rid of the now unneeded parameter
passing.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/aarch32/arm-cpu.c                 | 4 ++--
 arm/aarch64/arm-cpu.c                 | 5 +++--
 arm/fdt.c                             | 6 +++---
 arm/gic.c                             | 2 +-
 arm/include/arm-common/gic.h          | 2 +-
 arm/include/arm-common/kvm-cpu-arch.h | 3 +--
 arm/include/arm-common/pci.h          | 2 +-
 arm/pci.c                             | 3 ++-
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arm/aarch32/arm-cpu.c b/arm/aarch32/arm-cpu.c
index d8d6293..27a8e17 100644
--- a/arm/aarch32/arm-cpu.c
+++ b/arm/aarch32/arm-cpu.c
@@ -8,11 +8,11 @@
 #include <linux/byteorder.h>
 #include <linux/types.h>
 
-static void generate_fdt_nodes(void *fdt, struct kvm *kvm, u32 gic_phandle)
+static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	int timer_interrupts[4] = {13, 14, 11, 10};
 
-	gic__generate_fdt_nodes(fdt, gic_phandle, IRQCHIP_GICV2);
+	gic__generate_fdt_nodes(fdt, IRQCHIP_GICV2);
 	timer__generate_fdt_nodes(fdt, kvm, timer_interrupts);
 }
 
diff --git a/arm/aarch64/arm-cpu.c b/arm/aarch64/arm-cpu.c
index 3dc8ea3..4e7b029 100644
--- a/arm/aarch64/arm-cpu.c
+++ b/arm/aarch64/arm-cpu.c
@@ -9,10 +9,11 @@
 #include <linux/byteorder.h>
 #include <linux/types.h>
 
-static void generate_fdt_nodes(void *fdt, struct kvm *kvm, u32 gic_phandle)
+static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	int timer_interrupts[4] = {13, 14, 11, 10};
-	gic__generate_fdt_nodes(fdt, gic_phandle, kvm->cfg.arch.irqchip);
+
+	gic__generate_fdt_nodes(fdt, kvm->cfg.arch.irqchip);
 	timer__generate_fdt_nodes(fdt, kvm, timer_interrupts);
 }
 
diff --git a/arm/fdt.c b/arm/fdt.c
index 4b68a97..0418072 100644
--- a/arm/fdt.c
+++ b/arm/fdt.c
@@ -128,7 +128,7 @@ static int setup_fdt(struct kvm *kvm)
 						     kvm->arch.dtb_guest_start);
 	void (*generate_mmio_fdt_nodes)(void *, struct device_header *,
 					void (*)(void *, u8, enum irq_type));
-	void (*generate_cpu_peripheral_fdt_nodes)(void *, struct kvm *, u32)
+	void (*generate_cpu_peripheral_fdt_nodes)(void *, struct kvm *)
 					= kvm->cpus[0]->generate_fdt_nodes;
 
 	/* Create new tree without a reserve map */
@@ -169,7 +169,7 @@ static int setup_fdt(struct kvm *kvm)
 	/* CPU and peripherals (interrupt controller, timers, etc) */
 	generate_cpu_nodes(fdt, kvm);
 	if (generate_cpu_peripheral_fdt_nodes)
-		generate_cpu_peripheral_fdt_nodes(fdt, kvm, gic_phandle);
+		generate_cpu_peripheral_fdt_nodes(fdt, kvm);
 
 	/* Virtio MMIO devices */
 	dev_hdr = device__first_dev(DEVICE_BUS_MMIO);
@@ -188,7 +188,7 @@ static int setup_fdt(struct kvm *kvm)
 	}
 
 	/* PCI host controller */
-	pci__generate_fdt_nodes(fdt, gic_phandle);
+	pci__generate_fdt_nodes(fdt);
 
 	/* PSCI firmware */
 	_FDT(fdt_begin_node(fdt, "psci"));
diff --git a/arm/gic.c b/arm/gic.c
index b60437e..2c1a547 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -194,7 +194,7 @@ static int gic__init_gic(struct kvm *kvm)
 }
 late_init(gic__init_gic)
 
-void gic__generate_fdt_nodes(void *fdt, u32 phandle, enum irqchip_type type)
+void gic__generate_fdt_nodes(void *fdt, enum irqchip_type type)
 {
 	const char *compatible;
 	u64 reg_prop[] = {
diff --git a/arm/include/arm-common/gic.h b/arm/include/arm-common/gic.h
index 4fde5ac..b43a180 100644
--- a/arm/include/arm-common/gic.h
+++ b/arm/include/arm-common/gic.h
@@ -30,6 +30,6 @@ struct kvm;
 
 int gic__alloc_irqnum(void);
 int gic__create(struct kvm *kvm, enum irqchip_type type);
-void gic__generate_fdt_nodes(void *fdt, u32 phandle, enum irqchip_type type);
+void gic__generate_fdt_nodes(void *fdt, enum irqchip_type type);
 
 #endif /* ARM_COMMON__GIC_H */
diff --git a/arm/include/arm-common/kvm-cpu-arch.h b/arm/include/arm-common/kvm-cpu-arch.h
index 329979a..2f84a77 100644
--- a/arm/include/arm-common/kvm-cpu-arch.h
+++ b/arm/include/arm-common/kvm-cpu-arch.h
@@ -24,8 +24,7 @@ struct kvm_cpu {
 
 	struct kvm_coalesced_mmio_ring	*ring;
 
-	void		(*generate_fdt_nodes)(void *fdt, struct kvm* kvm,
-					      u32 gic_phandle);
+	void		(*generate_fdt_nodes)(void *fdt, struct kvm* kvm);
 };
 
 struct kvm_arm_target {
diff --git a/arm/include/arm-common/pci.h b/arm/include/arm-common/pci.h
index ee87725..9008a0e 100644
--- a/arm/include/arm-common/pci.h
+++ b/arm/include/arm-common/pci.h
@@ -1,6 +1,6 @@
 #ifndef ARM_COMMON__PCI_H
 #define ARM_COMMON__PCI_H
 
-void pci__generate_fdt_nodes(void *fdt, u32 gic_phandle);
+void pci__generate_fdt_nodes(void *fdt);
 
 #endif /* ARM_COMMON__PCI_H */
diff --git a/arm/pci.c b/arm/pci.c
index 99a8130..9630657 100644
--- a/arm/pci.c
+++ b/arm/pci.c
@@ -21,11 +21,12 @@ struct of_interrupt_map_entry {
 	struct of_gic_irq		gic_irq;
 } __attribute__((packed));
 
-void pci__generate_fdt_nodes(void *fdt, u32 gic_phandle)
+void pci__generate_fdt_nodes(void *fdt)
 {
 	struct device_header *dev_hdr;
 	struct of_interrupt_map_entry irq_map[OF_PCI_IRQ_MAP_MAX];
 	unsigned nentries = 0;
+	u32 gic_phandle = fdt__get_phandle(PHANDLE_GIC);
 	/* Bus range */
 	u32 bus_range[] = { cpu_to_fdt32(0), cpu_to_fdt32(1), };
 	/* Configuration Space */
-- 
2.3.5
