From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jun 2015 13:53:15 +0100
Subject: [PATCH 11/12] KVM: arm/arm64: vgic: Avoid injecting reserved IRQ
 numbers
In-Reply-To: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
References: <1434718396-13110-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1434718396-13110-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fd1d0ddf2ae9 (KVM: arm/arm64: check IRQ number on userland
injection) rightly limited the range of interrupts userspace can
inject in a guest, but failed to consider the (unlikely) case where
a guest is configured with 1024 interrupts.

In this case, interrupts ranging from 1020 to 1023 are unuseable,
as they have a special meaning for the GIC CPU interface.

Make sure that these number cannot be used as an IRQ. Also delete
a redundant (and similarily buggy) check in kvm_set_irq.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: <stable@vger.kernel.org> # 4.1, 4.0, 3.19, 3.18
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 78fb820..950064a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1561,7 +1561,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			goto out;
 	}
 
-	if (irq_num >= kvm->arch.vgic.nr_irqs)
+	if (irq_num >= min(kvm->arch.vgic.nr_irqs, 1020))
 		return -EINVAL;
 
 	vcpu_id = vgic_update_irq_pending(kvm, cpuid, irq_num, level);
@@ -2161,10 +2161,7 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id,
 
 	BUG_ON(!vgic_initialized(kvm));
 
-	if (spi > kvm->arch.vgic.nr_irqs)
-		return -EINVAL;
 	return kvm_vgic_inject_irq(kvm, 0, spi, level);
-
 }
 
 /* MSI not implemented yet */
-- 
2.1.4
