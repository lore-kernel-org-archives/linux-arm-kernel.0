From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 14:20:05 +0100
Subject: [PATCH 4/5] ARM: KVM: clear exclusive monitor on all exception returns
In-Reply-To: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371648006-8036-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we clear the exclusive movitor on all exception returns,
which otherwise could lead to lock corruptions.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 3124e0f..750f051 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -301,6 +301,7 @@ THUMB(	orr	r2, r2, #PSR_T_BIT	)
 	ldr	r2, =BSYM(panic)
 	msr	ELR_hyp, r2
 	ldr	r0, =\panic_str
+	clrex				@ Clear exclusive monitor
 	eret
 .endm
 
@@ -450,6 +451,7 @@ guest_trap:
 
 4:	pop	{r0, r1}		@ Failed translation, return to guest
 	mcrr	p15, 0, r0, r1, c7	@ PAR
+	clrex
 	pop	{r0, r1, r2}
 	eret
 
@@ -476,6 +478,7 @@ switch_to_guest_vfp:
 
 	pop	{r3-r7}
 	pop	{r0-r2}
+	clrex
 	eret
 #endif
 
-- 
1.8.2.3
