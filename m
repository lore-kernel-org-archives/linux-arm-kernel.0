From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:48 +0100
Subject: [PULL 19/19] KVM: arm/arm64: Fix broken GICH_ELRSR big endian
 conversion
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-17-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

We are incorrectly rearranging 32-bit words inside a 64-bit typed value
for big endian systems, which would result in never marking a virtual
interrupt as inactive on big endian systems (assuming 32 or fewer LRs on
the hardware).  Fix this by not doing any word order manipulation for
the typed values.

Cc: <stable@vger.kernel.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/hyp/vgic-v2-sr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/virt/kvm/arm/hyp/vgic-v2-sr.c b/virt/kvm/arm/hyp/vgic-v2-sr.c
index a3f18d362366..d7fd46fe9efb 100644
--- a/virt/kvm/arm/hyp/vgic-v2-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v2-sr.c
@@ -34,11 +34,7 @@ static void __hyp_text save_elrsr(struct kvm_vcpu *vcpu, void __iomem *base)
 	else
 		elrsr1 = 0;
 
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	cpu_if->vgic_elrsr = ((u64)elrsr0 << 32) | elrsr1;
-#else
 	cpu_if->vgic_elrsr = ((u64)elrsr1 << 32) | elrsr0;
-#endif
 }
 
 static void __hyp_text save_lrs(struct kvm_vcpu *vcpu, void __iomem *base)
-- 
2.14.2
