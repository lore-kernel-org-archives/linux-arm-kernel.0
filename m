From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Feb 2016 11:00:32 +0000
Subject: [PATCH v2 15/28] ARM: KVM: Add VFP lazy save/restore handler
In-Reply-To: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454583645-10144-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the arm64 version, add the code that deals with VFP traps,
re-enabling VFP, save/restoring the registers and resuming the guest.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/hyp/entry.S | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/kvm/hyp/entry.S b/arch/arm/kvm/hyp/entry.S
index 32f79b0..21c2388 100644
--- a/arch/arm/kvm/hyp/entry.S
+++ b/arch/arm/kvm/hyp/entry.S
@@ -66,5 +66,36 @@ ENTRY(__guest_exit)
 	bx	lr
 ENDPROC(__guest_exit)
 
+/*
+ * If VFPv3 support is not available, then we will not switch the VFP
+ * registers; however cp10 and cp11 accesses will still trap and fallback
+ * to the regular coprocessor emulation code, which currently will
+ * inject an undefined exception to the guest.
+ */
+#ifdef CONFIG_VFPv3
+ENTRY(__vfp_guest_restore)
+	push	{r3, r4, lr}
+
+	@ NEON/VFP used.  Turn on VFP access.
+	mrc	p15, 4, r1, c1, c1, 2		@ HCPTR
+	bic	r1, r1, #(HCPTR_TCP(10) | HCPTR_TCP(11))
+	mcr	p15, 4, r1, c1, c1, 2		@ HCPTR
+	isb
+
+	@ Switch VFP/NEON hardware state to the guest's
+	mov	r4, r0
+	ldr	r0, [r0, #VCPU_HOST_CTXT]
+	add	r0, r0, #CPU_CTXT_VFP
+	bl	__vfp_save_state
+	add	r0, r4, #(VCPU_GUEST_CTXT + CPU_CTXT_VFP)
+	bl	__vfp_restore_state
+
+	pop	{r3, r4, lr}
+	pop	{r0, r1, r2}
+	clrex
+	eret
+ENDPROC(__vfp_guest_restore)
+#endif
+
 	.popsection
 
-- 
2.1.4
