From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Jan 2013 11:20:29 +0000
Subject: [PATCH] ARM: KVM: avoid add/sub on vcpu pointer
Message-ID: <1358248829-13764-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doing arithmetic on the vcpu pointer can be avoided by using
another register as a base. Saves a few instructions on the
switch path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts_head.S | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 0e423be..d2442f9 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -264,11 +264,10 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	str	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
 	str	r4, [vcpu, #CP15_OFFSET(c2_TTBCR)]
 	str	r5, [vcpu, #CP15_OFFSET(c3_DACR)]
-	add	vcpu, vcpu, #CP15_OFFSET(c2_TTBR0)
-	strd	r6, r7, [vcpu]
-	add	vcpu, vcpu, #CP15_OFFSET(c2_TTBR1) - CP15_OFFSET(c2_TTBR0)
-	strd	r8, r9, [vcpu]
-	sub	vcpu, vcpu, #CP15_OFFSET(c2_TTBR1)
+	add	r2, vcpu, #CP15_OFFSET(c2_TTBR0)
+	strd	r6, r7, [r2]
+	add	r2, vcpu, #CP15_OFFSET(c2_TTBR1)
+	strd	r8, r9, [r2]
 	str	r10, [vcpu, #CP15_OFFSET(c10_PRRR)]
 	str	r11, [vcpu, #CP15_OFFSET(c10_NMRR)]
 	str	r12, [vcpu, #CP15_OFFSET(c0_CSSELR)]
@@ -362,11 +361,10 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	ldr	r3, [vcpu, #CP15_OFFSET(c1_CPACR)]
 	ldr	r4, [vcpu, #CP15_OFFSET(c2_TTBCR)]
 	ldr	r5, [vcpu, #CP15_OFFSET(c3_DACR)]
-	add	vcpu, vcpu, #CP15_OFFSET(c2_TTBR0)
-	ldrd	r6, r7, [vcpu]
-	add	vcpu, vcpu, #CP15_OFFSET(c2_TTBR1) - CP15_OFFSET(c2_TTBR0)
-	ldrd	r8, r9, [vcpu]
-	sub	vcpu, vcpu, #CP15_OFFSET(c2_TTBR1)
+	add	r12, vcpu, #CP15_OFFSET(c2_TTBR0)
+	ldrd	r6, r7, [r12]
+	add	r12, vcpu, #CP15_OFFSET(c2_TTBR1)
+	ldrd	r8, r9, [r12]
 	ldr	r10, [vcpu, #CP15_OFFSET(c10_PRRR)]
 	ldr	r11, [vcpu, #CP15_OFFSET(c10_NMRR)]
 	ldr	r12, [vcpu, #CP15_OFFSET(c0_CSSELR)]
@@ -479,7 +477,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * for the host.
  *
  * Assumes vcpu pointer in vcpu reg
- * Clobbers r2-r4
+ * Clobbers r2-r5
  */
 .macro save_timer_state
 #ifdef CONFIG_KVM_ARM_TIMER
@@ -496,9 +494,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 
 	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
 	ldr	r4, =VCPU_TIMER_CNTV_CVAL
-	add	vcpu, vcpu, r4
-	strd	r2, r3, [vcpu]
-	sub	vcpu, vcpu, r4
+	add	r5, vcpu, r4
+	strd	r2, r3, [r5]
 
 1:
 #endif
@@ -513,7 +510,7 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  * for the host.
  *
  * Assumes vcpu pointer in vcpu reg
- * Clobbers r2-r4
+ * Clobbers r2-r5
  */
 .macro restore_timer_state
 	@ Disallow physical timer access for the guest
@@ -534,9 +531,8 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
 
 	ldr	r4, =VCPU_TIMER_CNTV_CVAL
-	add	vcpu, vcpu, r4
-	ldrd	r2, r3, [vcpu]
-	sub	vcpu, vcpu, r4
+	add	r5, vcpu, r4
+	ldrd	r2, r3, [r5]
 	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
 	isb
 
-- 
1.8.1
