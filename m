From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:17 +0200
Subject: [PULL 67/79] arm64: hyp-stub: Zero x0 on successful stub handling
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-68-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We now return HVC_STUB_ERR when a stub hypercall fails, but we
leave whatever was in x0 on success. Zeroing it on return seems
like a good idea.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kernel/hyp-stub.S | 4 +++-
 arch/arm64/kvm/hyp-init.S    | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index d55604d..e1261fb 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -73,8 +73,10 @@ el1_sync:
 
 	/* Someone called kvm_call_hyp() against the hyp-stub... */
 	ldr	x0, =HVC_STUB_ERR
+	eret
 
-9:	eret
+9:	mov	x0, xzr
+	eret
 ENDPROC(el1_sync)
 
 .macro invalid_vector	label
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 3734e63..839425c 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -154,13 +154,13 @@ reset:
 	/* Install stub vectors */
 	adr_l	x5, __hyp_stub_vectors
 	msr	vbar_el2, x5
-	b	exit
+	mov	x0, xzr
+	eret
 
 1:	/* Bad stub call */
 	ldr	x0, =HVC_STUB_ERR
-
-exit:
 	eret
+
 ENDPROC(__kvm_handle_stub_hvc)
 
 	.ltorg
-- 
2.9.0
