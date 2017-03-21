From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 19:20:33 +0000
Subject: [PATCH v4 03/28] arm64: hyp-stub: Don't save lr in the EL1 code
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170321192058.9300-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EL2 code is not corrupting lr anymore, so don't bother preserving
it in the EL1 trampoline code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/hyp-stub.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index e4215ad06930..193dfb25ce2f 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -116,18 +116,14 @@ ENDPROC(\label)
  */
 
 ENTRY(__hyp_get_vectors)
-	str	lr, [sp, #-16]!
 	mov	x0, #HVC_GET_VECTORS
 	hvc	#0
-	ldr	lr, [sp], #16
 	ret
 ENDPROC(__hyp_get_vectors)
 
 ENTRY(__hyp_set_vectors)
-	str	lr, [sp, #-16]!
 	mov	x1, x0
 	mov	x0, #HVC_SET_VECTORS
 	hvc	#0
-	ldr	lr, [sp], #16
 	ret
 ENDPROC(__hyp_set_vectors)
-- 
2.11.0
