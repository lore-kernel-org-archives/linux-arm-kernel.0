From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 08 May 2015 17:08:42 +0100
Subject: [PATCH 1/2] ARM: kvm: fix a bad BSYM() usage
Message-ID: <E1YqkpO-0006zB-QJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BSYM() should only be used when refering to local symbols in the same
assembly file which are resolved by the assembler, and not for
linker-fixed up symbols.  The use of BSYM() with panic is incorrect as
the linker is involved in fixing up this relocation, and it knows
whether panic() is ARM or Thumb.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kvm/interrupts.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 79caf79b304a..87847d2c5f99 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -309,7 +309,7 @@ ENTRY(kvm_call_hyp)
 THUMB(	orr	r2, r2, #PSR_T_BIT	)
 	msr	spsr_cxsf, r2
 	mrs	r1, ELR_hyp
-	ldr	r2, =BSYM(panic)
+	ldr	r2, =panic
 	msr	ELR_hyp, r2
 	ldr	r0, =\panic_str
 	clrex				@ Clear exclusive monitor
-- 
1.8.3.1
