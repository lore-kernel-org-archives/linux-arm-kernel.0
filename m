From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jun 2013 13:08:48 +0100
Subject: [PATCH v2 3/3] ARM: KVM: clear exclusive monitor on all exception
 returns
In-Reply-To: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
References: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371816528-25078-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we clear the exclusive movitor on all exception returns,
which otherwise could lead to lock corruptions.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 20e03d9..16cd4ba 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -292,6 +292,7 @@ THUMB(	orr	r2, r2, #PSR_T_BIT	)
 	ldr	r2, =BSYM(panic)
 	msr	ELR_hyp, r2
 	ldr	r0, =\panic_str
+	clrex				@ Clear exclusive monitor
 	eret
 .endm
 
@@ -441,6 +442,7 @@ guest_trap:
 
 4:	pop	{r0, r1}		@ Failed translation, return to guest
 	mcrr	p15, 0, r0, r1, c7	@ PAR
+	clrex
 	pop	{r0, r1, r2}
 	eret
 
@@ -467,6 +469,7 @@ switch_to_guest_vfp:
 
 	pop	{r3-r7}
 	pop	{r0-r2}
+	clrex
 	eret
 #endif
 
-- 
1.8.2.3
