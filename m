From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:04:25 +0000
Subject: [RFC PATCH 02/45] KVM: arm/arm64: pmu: abstract access to number of
 SPIs
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the PMU uses a member of the struct vgic_dist directly,
which not only breaks abstraction, but will fail with the new VGIC.
Abstract this access in the VGIC header file.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/kvm/arm_vgic.h | 2 ++
 virt/kvm/arm/pmu.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 13a3d53..2b89e27 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -356,6 +356,8 @@ bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, struct irq_phys_map *map);
 #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
 #define vgic_initialized(k)	(!!((k)->arch.vgic.nr_cpus))
 #define vgic_ready(k)		((k)->arch.vgic.ready)
+#define vgic_valid_spi(k,i)	(((i) >= VGIC_NR_PRIVATE_IRQS) && \
+				 ((i) < (k)->arch.vgic.nr_irqs))
 
 int vgic_v2_probe(struct device_node *vgic_node,
 		  const struct vgic_ops **ops,
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index b5754c6..0b2c1fa 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -476,7 +476,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		 * the interrupt number is the same for all vcpus, while as an
 		 * SPI it must be a separate number per vcpu.
 		 */
-		if (irq < VGIC_NR_SGIS || irq >= vcpu->kvm->arch.vgic.nr_irqs ||
+		if (irq < VGIC_NR_SGIS || !vgic_valid_spi(vcpu->kvm, irq) ||
 		    !irq_is_valid(vcpu->kvm, irq, irq < VGIC_NR_PRIVATE_IRQS))
 			return -EINVAL;
 
-- 
2.7.3
