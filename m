From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 10:53:35 -0800
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Message-ID: <20121114185335.GU6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
to not boot when enabled. The ARM core on it is an earlier r1p2:

CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d

Unfortunately I don't have the details of errata 751472, but I'm
guessing we need to disable it for r1p*.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Can somebody with access to the errata check if it has more
info on which revisions this should be set on? Maybe it's just
r2p* - r3p0?

--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -236,6 +236,8 @@ __v7_setup:
 	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 #endif
 #if defined(CONFIG_ARM_ERRATA_751472) && defined(CONFIG_SMP)
+	teq	r5, #0x00100000			@ fails at least on r1p2
+	beq	1f
 	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
 	ALT_UP_B(1f)
 	mrclt	p15, 0, r10, c15, c0, 1		@ read diagnostic register
