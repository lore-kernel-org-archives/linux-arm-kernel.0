From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:48 +0200
Subject: [PULL 38/79] arm64: hyp-stub: Don't save lr in the EL1 code
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-39-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The EL2 code is not corrupting lr anymore, so don't bother preserving
it in the EL1 trampoline code.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kernel/hyp-stub.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index e4215ad..193dfb2 100644
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
2.9.0
