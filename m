From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:04:10 +0100
Subject: [PATCH v2 51/52] KVM: arm/arm64: GICv4: Use pending_last as a
 scheduling hint
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-52-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a vPE exits, the pending_last flag is set when there are
pending VLPIs stored in the pending table. Similarily, we set
this flag when a doorbell interrupt fires, as it indicates the
same condition.

Let's update kvm_vgic_vcpu_pending_irq() to account for that
flag as well, making a vcpu runnable when set.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 2106e4c06a12..9ab52108989d 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -785,6 +785,9 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (!vcpu->kvm->arch.vgic.enabled)
 		return false;
 
+	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
+		return true;
+
 	spin_lock(&vgic_cpu->ap_list_lock);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-- 
2.11.0
