From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:52 +0200
Subject: [PULL 42/79] arm64: KVM: Implement HVC_RESET_VECTORS stub hypercall
 in the init code
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-43-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to restore HYP mode to its original condition, KVM currently
implements __kvm_hyp_reset(). As we're moving towards a hyp-stub
defined API, it becomes necessary to implement HVC_RESET_VECTORS.

This patch adds the HVC_RESET_VECTORS hypercall to the KVM init
code, which so far lacked any form of hypercall support.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/hyp-init.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 6b29d3d..5e39ad5 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -22,6 +22,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sysreg.h>
+#include <asm/virt.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -58,6 +59,9 @@ __invalid:
 	 * x2: HYP vectors
 	 */
 __do_hyp_init:
+	/* Check for a stub HVC call */
+	cmp	x0, #HVC_STUB_HCALL_NR
+	b.lo	__kvm_handle_stub_hvc
 
 	msr	ttbr0_el2, x0
 
@@ -119,6 +123,9 @@ __do_hyp_init:
 	eret
 ENDPROC(__kvm_hyp_init)
 
+ENTRY(__kvm_handle_stub_hvc)
+	cmp	x0, #HVC_RESET_VECTORS
+	b.ne	1f
 	/*
 	 * Reset kvm back to the hyp stub.
 	 */
@@ -133,9 +140,15 @@ ENTRY(__kvm_hyp_reset)
 	/* Install stub vectors */
 	adr_l	x0, __hyp_stub_vectors
 	msr	vbar_el2, x0
+	b	exit
 
+1:	/* Bad stub call */
+	ldr	x0, =HVC_STUB_ERR
+
+exit:
 	eret
 ENDPROC(__kvm_hyp_reset)
+ENDPROC(__kvm_handle_stub_hvc)
 
 	.ltorg
 
-- 
2.9.0
