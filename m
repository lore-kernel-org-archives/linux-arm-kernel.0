From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jan 2014 14:56:42 +0000
Subject: [PATCH v2 10/10] ARM: KVM: add world-switch for AMAIR{0,1}
In-Reply-To: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
References: <1390402602-22777-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1390402602-22777-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HCR.TVM traps (among other things) accesses to AMAIR0 and AMAIR1.
In order to minimise the amount of surprise a guest could generate by
trying to access these registers with caches off, add them to the
list of registers we switch/handle.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h |  4 +++-
 arch/arm/kvm/coproc.c          |  6 ++++++
 arch/arm/kvm/interrupts_head.S | 12 ++++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 661da11..53b3c4a 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -48,7 +48,9 @@
 #define c13_TID_URO	26	/* Thread ID, User R/O */
 #define c13_TID_PRIV	27	/* Thread ID, Privileged */
 #define c14_CNTKCTL	28	/* Timer Control Register (PL1) */
-#define NR_CP15_REGS	29	/* Number of regs (incl. invalid) */
+#define c10_AMAIR0	29	/* Auxilary Memory Attribute Indirection Reg0 */
+#define c10_AMAIR1	30	/* Auxilary Memory Attribute Indirection Reg1 */
+#define NR_CP15_REGS	31	/* Number of regs (incl. invalid) */
 
 #define ARM_EXCEPTION_RESET	  0
 #define ARM_EXCEPTION_UNDEFINED   1
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 1839770..539f6d4 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -381,6 +381,12 @@ static const struct coproc_reg cp15_regs[] = {
 	{ CRn(10), CRm( 2), Op1( 0), Op2( 1), is32,
 			access_vm_reg, reset_unknown, c10_NMRR},
 
+	/* AMAIR0/AMAIR1: swapped by interrupt.S. */
+	{ CRn(10), CRm( 3), Op1( 0), Op2( 0), is32,
+			access_vm_reg, reset_unknown, c10_AMAIR0},
+	{ CRn(10), CRm( 3), Op1( 0), Op2( 1), is32,
+			access_vm_reg, reset_unknown, c10_AMAIR1},
+
 	/* VBAR: swapped by interrupt.S. */
 	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c12_VBAR, 0x00000000 },
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 7cb41e1..e4eaf30 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -303,13 +303,17 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 
 	mrc	p15, 0, r2, c14, c1, 0	@ CNTKCTL
 	mrrc	p15, 0, r4, r5, c7	@ PAR
+	mrc	p15, 0, r6, c10, c3, 0	@ AMAIR0
+	mrc	p15, 0, r7, c10, c3, 1	@ AMAIR1
 
 	.if \store_to_vcpu == 0
-	push	{r2,r4-r5}
+	push	{r2,r4-r7}
 	.else
 	str	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
 	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
 	strd	r4, r5, [r12]
+	str	r6, [vcpu, #CP15_OFFSET(c10_AMAIR0)]
+	str	r7, [vcpu, #CP15_OFFSET(c10_AMAIR1)]
 	.endif
 .endm
 
@@ -322,15 +326,19 @@ vcpu	.req	r0		@ vcpu pointer always in r0
  */
 .macro write_cp15_state read_from_vcpu
 	.if \read_from_vcpu == 0
-	pop	{r2,r4-r5}
+	pop	{r2,r4-r7}
 	.else
 	ldr	r2, [vcpu, #CP15_OFFSET(c14_CNTKCTL)]
 	add	r12, vcpu, #CP15_OFFSET(c7_PAR)
 	ldrd	r4, r5, [r12]
+	ldr	r6, [vcpu, #CP15_OFFSET(c10_AMAIR0)]
+	ldr	r7, [vcpu, #CP15_OFFSET(c10_AMAIR1)]
 	.endif
 
 	mcr	p15, 0, r2, c14, c1, 0	@ CNTKCTL
 	mcrr	p15, 0, r4, r5, c7	@ PAR
+	mcr	p15, 0, r6, c10, c3, 0	@ AMAIR0
+	mcr	p15, 0, r7, c10, c3, 1	@ AMAIR1
 
 	.if \read_from_vcpu == 0
 	pop	{r2-r12}
-- 
1.8.3.4
