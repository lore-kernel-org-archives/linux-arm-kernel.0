From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Feb 2017 15:44:26 +0000
Subject: [PATCH 17/20] ARM: KVM: Implement HVC_SOFT_RESTART in the init code
In-Reply-To: <20170217154429.5000-1-marc.zyngier@arm.com>
References: <20170217154429.5000-1-marc.zyngier@arm.com>
Message-ID: <20170217154429.5000-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another missing stub hypercall is HVC_SOFT_RESTART. It turns out
that it is pretty easy to implement in terms of HVC_RESET_VECTORS
(since it needs to turn the MMU off).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/init.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 0ec1a83d03ea..489e0f79ac2c 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -127,8 +127,22 @@ ENTRY(__kvm_handle_stub_hvc)
 	mrc	p15, 4, r0, c12, c0, 0	@ get HVBAR
 	b	exit
 
+1:	cmp	r0, #HVC_SOFT_RESTART
+	bne	1f
+
+	/* The target is expected in r1 */
+	msr	ELR_hyp, r1
+	mrs	r0, cpsr
+	bic	r0, r0, #MODE_MASK
+	orr	r0, r0, #HYP_MODE
+THUMB(	orr	r0, r0, #PSR_T_BIT	)
+	msr	spsr_cxsf, r0
+	b	reset
+
 1:	cmp	r0, #HVC_RESET_VECTORS
 	bne	1f
+
+reset:
 	/* We're now in idmap, disable MMU */
 	mrc	p15, 4, r1, c1, c0, 0	@ HSCTLR
 	ldr	r0, =(HSCTLR_M | HSCTLR_A | HSCTLR_C | HSCTLR_I)
-- 
2.11.0
