From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:53:59 +0000
Subject: [PATCH v4 09/13] KVM: arm/arm64: vgic: support irqfd injection of a
 mapped IRQ
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-10-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now irqfd injection was only possible for unmapped IRQ. This
patch adds support for injecting mapped interrupts.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index dba8eb6..e96f79e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2476,13 +2476,21 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 int kvm_set_irq(struct kvm *kvm, int irq_source_id,
 		u32 irq, int level, bool line_status)
 {
+	struct vgic_dist *dist = &kvm->arch.vgic;
 	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
+	struct irq_phys_map *map;
+	int vcpu_id;
 
 	trace_kvm_set_irq(irq, level, irq_source_id);
 
 	BUG_ON(!vgic_initialized(kvm));
 
-	return kvm_vgic_inject_irq(kvm, 0, spi, level);
+	vcpu_id = dist->irq_spi_cpu[irq];
+	map = vgic_irq_map_search(kvm_get_vcpu(kvm, vcpu_id), spi);
+	if (!map)
+		return kvm_vgic_inject_irq(kvm, vcpu_id, spi, level);
+	else
+		return kvm_vgic_inject_mapped_irq(kvm, vcpu_id, map, level);
 }
 
 /* MSI not implemented yet */
-- 
1.9.1
