From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 19:20:32 +0000
Subject: [PATCH v4 02/28] arm64: KVM: Move lr save/restore to do_el2_call
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170321192058.9300-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, we only save/restore lr if on VHE, as we rely only
the EL1 code to have preserved it in the non-VHE case.

As we're about to get rid of the latter, let's move the save/restore
code to the do_el2_call macro, unifying both code paths.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 5e9052f087f2..d8ef788646c6 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -32,17 +32,17 @@
 	 * Shuffle the parameters before calling the function
 	 * pointed to in x0. Assumes parameters in x[1,2,3].
 	 */
+	str	lr, [sp, #-16]!
 	mov	lr, x0
 	mov	x0, x1
 	mov	x1, x2
 	mov	x2, x3
 	blr	lr
+	ldr	lr, [sp], #16
 .endm
 
 ENTRY(__vhe_hyp_call)
-	str	lr, [sp, #-16]!
 	do_el2_call
-	ldr	lr, [sp], #16
 	/*
 	 * We used to rely on having an exception return to get
 	 * an implicit isb. In the E2H case, we don't have it anymore.
-- 
2.11.0
