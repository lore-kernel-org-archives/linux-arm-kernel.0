From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Nov 2017 10:17:42 +0100
Subject: [PULL 17/27] KVM: arm/arm64: GICv4: Use pending_last as a scheduling
 hint
In-Reply-To: <20171113091752.10663-1-christoffer.dall@linaro.org>
References: <20171113091752.10663-1-christoffer.dall@linaro.org>
Message-ID: <20171113091752.10663-18-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When a vPE exits, the pending_last flag is set when there are pending
VLPIs stored in the pending table. Similarily, this flag will be set
when a doorbell interrupt fires, as it indicates the same condition.

Let's update kvm_vgic_vcpu_pending_irq() to account for that
flag as well, making a vcpu runnable when set.

Acked-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/vgic/vgic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index a05a5700910b..d29e91215366 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -781,6 +781,9 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (!vcpu->kvm->arch.vgic.enabled)
 		return false;
 
+	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
+		return true;
+
 	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-- 
2.14.2
