From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 14:10:10 +0100
Subject: [GIT PULL 1/2] arm64: KVM: Fix TLB invalidation by IPA/VMID
In-Reply-To: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
References: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1420981811-18731-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

It took about two years for someone to notice that the IPA passed
to TLBI IPAS2E1IS must be shifted by 12 bits. Clearly our reviewing
is not as good as it should be...

Paper bag time for me.

Reported-by: Mario Smarduch <m.smarduch@samsung.com>
Tested-by: Mario Smarduch <m.smarduch@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index fbe909f..c3ca89c 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -1014,6 +1014,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	 * Instead, we invalidate Stage-2 for this IPA, and the
 	 * whole of Stage-1. Weep...
 	 */
+	lsr	x1, x1, #12
 	tlbi	ipas2e1is, x1
 	/*
 	 * We have to ensure completion of the invalidation at Stage-2,
-- 
2.1.2.330.g565301e.dirty
