From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:27 +0200
Subject: [PULL 77/79] KVM: arm/arm64: vgic-v3: Fix off-by-one LR access
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-78-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When iterating over the used LRs, be careful not to try to access
an unused LR, or even an unimplemented one if you're unlucky...

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 91922c1..bce6037 100644
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
2.9.0
