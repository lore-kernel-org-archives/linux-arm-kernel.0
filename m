From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Dec 2014 17:18:47 +0000
Subject: [PATCH] arm64: KVM: Fix TLB invalidation by IPA/VMID
Message-ID: <1419009527-21565-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It took about two years for someone to notice that the IPA passed
to TLBI IPAS2E1IS must be shifted by 12 bits. Clearly our reviewing
is not as good as it should be...

Paper bag time for me.

Reported-by: Mario Smarduch <m.smarduch@samsung.com>
Tested-by: Mario Smarduch <m.smarduch@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b72aa9f..a767f6a 100644
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
2.1.3
