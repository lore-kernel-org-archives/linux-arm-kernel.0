From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 17:51:42 -0700
Subject: [PATCH] Fix smp_on_up detection
Message-ID: <mailman.230.1283477996.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to detect UP properly on older ARMv7 like Cortex-A8.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 0b4a626..86aa36d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -346,8 +346,8 @@ __fixup_smp:
 	bne	smp_on_up		@ no, assume UP
 	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
 	movs	r0, r0, lsr #30
-	teqne	r0, #3			@ check top two bits 00 or 11
-	movne	pc, lr
+	teq	r0, #2			@ check top two bits, 10 for SMP
+	moveq	pc, lr
 
 smp_on_up:
 	adr	r0, 1f

--CNK/L7dwKXQ4Ub8J--
