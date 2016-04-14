From: geoff@infradead.org (Geoff Levand)
Date: Thu, 14 Apr 2016 21:21:36 +0000
Subject: [PATCH v16 04/20] arm64: kvm: Move lr save/restore from do_el2_call
 into EL1
In-Reply-To: <cover.1460668521.git.geoff@infradead.org>
References: <cover.1460668521.git.geoff@infradead.org>
Message-ID: <73b97dfba14c36409c32db3462f1eab9345b135d.1460668521.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

Today the 'hvc' calling kvm or the hyp-stub is expected to preserve all
registers. Kvm saves/restores the registers it needs on the EL2 stack using
do_el2_call. The hyp-stub has no stack, later patches need at least one
register they can use.

Allow theses calls to clobber the link register, and add code to
save/restore this register at the call sites.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/virt.h  |  4 ----
 arch/arm64/kernel/hyp-stub.S   | 10 ++++++++--
 arch/arm64/kvm/hyp.S           |  7 ++++++-
 arch/arm64/kvm/hyp/hyp-entry.S |  2 ++
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index b8fddde..23e9c6f 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -27,15 +27,11 @@
 	 * Shuffle the parameters before calling the function
 	 * pointed to in x0. Assumes parameters in x[1,2,3].
 	 */
-	sub	sp, sp, #16
-	str	lr, [sp]
 	mov	lr, x0
 	mov	x0, x1
 	mov	x1, x2
 	mov	x2, x3
 	blr	lr
-	ldr	lr, [sp]
-	add	sp, sp, #16
 .endm
 #else
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..7eab8ac 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -101,10 +101,16 @@ ENDPROC(\label)
  */
 
 ENTRY(__hyp_get_vectors)
+	str	lr, [sp, #-16]!
 	mov	x0, xzr
-	// fall through
-ENTRY(__hyp_set_vectors)
 	hvc	#0
+	ldr	lr, [sp], #16
 	ret
 ENDPROC(__hyp_get_vectors)
+
+ENTRY(__hyp_set_vectors)
+	str	lr, [sp, #-16]!
+	hvc	#0
+	ldr	lr, [sp], #16
+	ret
 ENDPROC(__hyp_set_vectors)
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 48f19a3..4ee5612 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -38,13 +38,18 @@
  * A function pointer with a value of 0 has a special meaning, and is
  * used to implement __hyp_get_vectors in the same way as in
  * arch/arm64/kernel/hyp_stub.S.
+ * HVC behaves as a 'bl' call and will clobber lr.
  */
 ENTRY(__kvm_call_hyp)
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN	
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	str     lr, [sp, #-16]!
 	hvc	#0
+	ldr     lr, [sp], #16
 	ret
 alternative_else
 	b	__vhe_hyp_call
 	nop
+	nop
+	nop
 alternative_endif
 ENDPROC(__kvm_call_hyp)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 358f27a..2cee779 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -39,7 +39,9 @@
 .endm
 
 ENTRY(__vhe_hyp_call)
+	str	lr, [sp, #-16]!
 	do_el2_call
+	ldr	lr, [sp], #16
 	/*
 	 * We used to rely on having an exception return to get
 	 * an implicit isb. In the E2H case, we don't have it anymore.
-- 
2.5.0
