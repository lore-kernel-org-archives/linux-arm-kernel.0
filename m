From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Jun 2013 18:51:43 +0100
Subject: [PATCH] ARM: remove residual ARMv2 support from decompressor
Message-ID: <1370627503-28786-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm26 support in Linux is long gone, yet it left an interresting,
fossilized trace in the decompressor.

Remove it so people won't get confused about what teqp is actually
doing here...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/compressed/head.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..05e812e 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -141,7 +141,6 @@ start:
 		mov	r7, r1			@ save architecture ID
 		mov	r8, r2			@ save atags pointer
 
-#ifndef __ARM_ARCH_2__
 		/*
 		 * Booting from Angel - need to enter SVC mode and disable
 		 * FIQs/IRQs (numeric definitions from angel arm.h source).
@@ -157,10 +156,6 @@ not_angel:
 		safe_svcmode_maskall r0
 		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
 						@ SPSR
-#else
-		teqp	pc, #0x0c000003		@ turn off interrupts
-#endif
-
 		/*
 		 * Note that some cache flushing and other stuff may
 		 * be needed here - is there an Angel SWI call for this?
-- 
1.8.2.3
