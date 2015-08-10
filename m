From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 10 Aug 2015 15:21:02 +0200
Subject: [PATCH v3 08/10] KVM: arm/arm64: vgic: support irqfd injection of a
 forwarded IRQ
In-Reply-To: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1439212864-12954-9-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently irqfd injection relies on kvm_vgic_inject_irq function.
However this function cannot be used anymore for mapped IRQs. So
let's change the implementation to use kvm_vgic_inject_mapped_irq
when the IRQ is forwarded.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index fbd5ba5..03a85b3 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -2529,13 +2529,19 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 int kvm_set_irq(struct kvm *kvm, int irq_source_id,
 		u32 irq, int level, bool line_status)
 {
+	struct irq_phys_map *map;
 	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
 
 	trace_kvm_set_irq(irq, level, irq_source_id);
 
 	BUG_ON(!vgic_initialized(kvm));
 
-	return kvm_vgic_inject_irq(kvm, 0, spi, level);
+	map = vgic_irq_map_search(kvm_get_vcpu(kvm, 0), spi);
+
+	if (!map)
+		return kvm_vgic_inject_irq(kvm, 0, spi, level);
+	else
+		return kvm_vgic_inject_mapped_irq(kvm, 0, map, level);
 }
 
 /* MSI not implemented yet */
-- 
1.9.1
