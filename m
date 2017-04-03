From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Apr 2017 19:38:05 +0100
Subject: [PATCH v5 32/34] arm64: hyp-stub: Zero x0 on successful stub handling
In-Reply-To: <20170403183807.1620-1-marc.zyngier@arm.com>
References: <20170403183807.1620-1-marc.zyngier@arm.com>
Message-ID: <20170403183807.1620-33-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now return HVC_STUB_ERR when a stub hypercall fails, but we
leave whatever was in x0 on success. Zeroing it on return seems
like a good idea.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/hyp-stub.S | 4 +++-
 arch/arm64/kvm/hyp-init.S    | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index d55604d91e33..e1261fbaa374 100644
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
index 3734e6315cd7..839425c24b1c 100644
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
2.11.0
