From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:14 +0100
Subject: [PATCH 7/8] arm64: kvm: use inner-shareable barriers for
 inner-shareable maintenance
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to ensure completion of inner-shareable maintenance instructions
(cache and TLB) on AArch64, we can use the -ish suffix to the dsb
instruction.

This patch relaxes our dsb sy instructions to dsb ish where possible.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kvm/hyp.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 2c56012cb2d2..b0d1512acf08 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -630,9 +630,15 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
 	 * whole of Stage-1. Weep...
 	 */
 	tlbi	ipas2e1is, x1
-	dsb	sy
+	/*
+	 * We have to ensure completion of the invalidation at Stage-2,
+	 * since a table walk on another CPU could refill a TLB with a
+	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
+	 * the Stage-1 invalidation happened first.
+	 */
+	dsb	ish
 	tlbi	vmalle1is
-	dsb	sy
+	dsb	ish
 	isb
 
 	msr	vttbr_el2, xzr
@@ -643,7 +649,7 @@ ENTRY(__kvm_flush_vm_context)
 	dsb	ishst
 	tlbi	alle1is
 	ic	ialluis
-	dsb	sy
+	dsb	ish
 	ret
 ENDPROC(__kvm_flush_vm_context)
 
-- 
1.9.2
