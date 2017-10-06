From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Oct 2017 16:33:53 +0100
Subject: [PATCH v4 18/26] KVM: arm/arm64: GICv4: Use pending_last as a
 scheduling hint
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171006153401.5481-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a vPE exits, the pending_last flag is set when there are
pending VLPIs stored in the pending table. Similarily, we set
this flag when a doorbell interrupt fires, as it indicates the
same condition.

Let's update kvm_vgic_vcpu_pending_irq() to account for that
flag as well, making a vcpu runnable when set.

Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 9d557efd1f7d..0691a2250949 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -769,6 +769,9 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 	if (!vcpu->kvm->arch.vgic.enabled)
 		return false;
 
+	if (vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last)
+		return true;
+
 	spin_lock(&vgic_cpu->ap_list_lock);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
-- 
2.14.1
