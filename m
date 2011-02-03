From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 3 Feb 2011 10:44:21 +0000
Subject: [PATCH] ARM: bitops: Use BX instead of MOV PC,LR
In-Reply-To: <20110202212449.GF31043@n2100.arm.linux.org.uk>
References: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102021421160.8580@xanadu.home>
	<20110202212449.GF31043@n2100.arm.linux.org.uk>
Message-ID: <20110203104420.GA2666@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel doesn't officially need to interwork, but using BX
wherever appropriate will help educate people into good assembler
coding habits.

BX is appropriate here because this code is predicated on

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

A bit of a pedantic one, but is there any chance of switching
to using BX here?

I spend a significant amount of my life trying to educate people
not to do things like mov pc,lr ... though in interworking userspace
is admittedly a different world from the kernel.

Cheers
Dave

 arch/arm/lib/bitops.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index a9d9d15..5527e23 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -12,7 +12,7 @@
 	strex	r0, r2, [r1]
 	cmp	r0, #0
 	bne	1b
-	mov	pc, lr
+	bx	lr
 	.endm
 
 	.macro	testop, instr, store
@@ -33,7 +33,7 @@
 	smp_dmb
 	cmp	r0, #0
 	movne	r0, #1
-2:	mov	pc, lr
+2:	bx	lr
 	.endm
 #else
 	.macro	bitop, instr
@@ -48,7 +48,7 @@
 	\instr	r2, r2, r3
 	str	r2, [r1, r0, lsl #2]
 	restore_irqs ip
-	mov	pc, lr
+	bx	lr
 	.endm
 
 /**
@@ -72,6 +72,6 @@
 	\store	r2, [r1]
 	moveq	r0, #0
 	restore_irqs ip
-	mov	pc, lr
+	bx	lr
 	.endm
 #endif
-- 
1.7.1
