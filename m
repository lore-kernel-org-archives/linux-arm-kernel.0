From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Mar 2016 09:33:34 +0000
Subject: [PATCH v3 12/12] arm64: KVM: vgic-v3: Only wipe LRs on vcpu exit
In-Reply-To: <1457343214-19547-1-git-send-email-marc.zyngier@arm.com>
References: <1457343214-19547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1457343214-19547-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we're always writing all possible LRs, setting the empty
ones with a zero value. This is obvious doing a low of work for
nothing, and we're better off clearing those we've actually
dirtied on the exit path (it is very rare to inject more than one
interrupt at a time anyway).

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 8134947..fff7cd4 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -196,6 +196,7 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
 			}
 
 			cpu_if->vgic_lr[i] = __gic_v3_get_lr(i);
+			__gic_v3_set_lr(0, i);
 		}
 
 		switch (nr_pri_bits) {
@@ -293,12 +294,10 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
 		}
 
 		for (i = 0; i <= max_lr_idx; i++) {
-			val = 0;
-
-			if (live_lrs & (1 << i))
-				val = cpu_if->vgic_lr[i];
+			if (!(live_lrs & (1 << i)))
+				continue;
 
-			__gic_v3_set_lr(val, i);
+			__gic_v3_set_lr(cpu_if->vgic_lr[i], i);
 		}
 	}
 
-- 
2.1.4
