From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:54 +0200
Subject: [PULL 44/79] arm64: KVM: Allow the main HYP code to use the init hyp
 stub implementation
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-45-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We now have a full hyp-stub implementation in the KVM init code,
but the main KVM code only supports HVC_GET_VECTORS, which is not
enough.

Instead of reinventing the wheel, let's reuse the init implementation
by branching to the idmap page when called with a hyp-stub hypercall.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index d8ef788..4f34c59 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -87,10 +87,24 @@ alternative_endif
 	/* Here, we're pretty sure the host called HVC. */
 	ldp	x0, x1, [sp], #16
 
-	cmp	x0, #HVC_GET_VECTORS
-	b.ne	1f
-	mrs	x0, vbar_el2
-	b	2f
+	/* Check for a stub HVC call */
+	cmp	x0, #HVC_STUB_HCALL_NR
+	b.hs	1f
+
+	/*
+	 * Compute the idmap address of __kvm_handle_stub_hvc and
+	 * jump there. Since we use kimage_voffset, do not use the
+	 * HYP VA for __kvm_handle_stub_hvc, but the kernel VA instead
+	 * (by loading it from the constant pool).
+	 *
+	 * Preserve x0-x4, which may contain stub parameters.
+	 */
+	ldr	x5, =__kvm_handle_stub_hvc
+	ldr_l	x6, kimage_voffset
+
+	/* x5 = __pa(x5) */
+	sub	x5, x5, x6
+	br	x5
 
 1:
 	/*
@@ -99,7 +113,7 @@ alternative_endif
 	kern_hyp_va	x0
 	do_el2_call
 
-2:	eret
+	eret
 
 el1_trap:
 	/*
-- 
2.9.0
