From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:46 +0200
Subject: [PULL 36/79] arm64: hyp-stub: Stop pointlessly clobbering lr
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-37-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When entering the kernel hyp stub, we check whether or not we've
made it here through an HVC instruction, clobbering lr (aka x30)
in the process.

This is completely pointless, as HVC is the only way to get here
(all traps to EL2 are disabled, no interrupt override is applied).

So let's remove this bit of code whose only point is to corrupt
a valuable register.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kernel/hyp-stub.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index d3b5f75..e4215ad 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -55,12 +55,6 @@ ENDPROC(__hyp_stub_vectors)
 	.align 11
 
 el1_sync:
-	mrs	x30, esr_el2
-	lsr	x30, x30, #ESR_ELx_EC_SHIFT
-
-	cmp	x30, #ESR_ELx_EC_HVC64
-	b.ne	9f				// Not an HVC trap
-
 	cmp	x0, #HVC_GET_VECTORS
 	b.ne	1f
 	mrs	x0, vbar_el2
-- 
2.9.0
