From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Apr 2017 10:19:44 +0100
Subject: [PATCH 2/2] KVM: arm/arm64: vgic-v3: Fix off-by-one LR access
In-Reply-To: <20170410091944.19963-1-marc.zyngier@arm.com>
References: <20170410091944.19963-1-marc.zyngier@arm.com>
Message-ID: <20170410091944.19963-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When iterating over the used LRs, be careful not to try to access
an unused LR, or even an unimplemented one if you're unlucky...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 91922c1eddc8..bce6037cf01d 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -143,7 +143,7 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
 		val = read_gicreg(ICH_VTR_EL2);
 		nr_pri_bits = vtr_to_nr_pri_bits(val);
 
-		for (i = 0; i <= used_lrs; i++) {
+		for (i = 0; i < used_lrs; i++) {
 			if (cpu_if->vgic_elrsr & (1 << i))
 				cpu_if->vgic_lr[i] &= ~ICH_LR_STATE;
 			else
-- 
2.11.0
