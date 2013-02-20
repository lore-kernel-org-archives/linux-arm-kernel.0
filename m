From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Feb 2013 17:27:04 +0000
Subject: [PATCH v3 0/9] ARM: PRIMA2: bringup new CSR SiRFmarco SMP SoC
In-Reply-To: <1358857154-9915-1-git-send-email-Barry.Song@csr.com>
References: <1358857154-9915-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201302201727.04471.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Barry Song wrote:
>   ARM: PRIMA2: add new SiRFmarco SMP SoC infrastructures

There was a conflict between this patch and another one from
Dinh Nguyen. This is just to let you know that I have added this
resolution to the next/soc branch.

	Arnd

8<------
>From 9cb0d1babfcb1b4ac248c09425f7d5de1e771133 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2013 18:21:58 +0100
Subject: [PATCH] ARM: prima2: remove duplicate v7_invalidate_l1

Patch c08e20d "arm: Add v7_invalidate_l1 to cache-v7.S" added
a generic version of this function and removed all platform
specific versions, while 4898de3 "ARM: PRIMA2: add new SiRFmarco
SMP SoC infrastructures" added another one, leading to a link
error. I verified that the two are identical, so we can
just remove the one in mach-prima2.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
index ada82d0..5b8a408d 100644
--- a/arch/arm/mach-prima2/headsmp.S
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -12,46 +12,6 @@
 	__CPUINIT
 
 /*
- * Cold boot and hardware reset show different behaviour,
- * system will be always panic if we warm-reset the board
- * Here we invalidate L1 of CPU1 to make sure there isn't
- * uninitialized data written into memory later
- */
-ENTRY(v7_invalidate_l1)
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
-	mcr	p15, 2, r0, c0, c0, 0
-	mrc	p15, 1, r0, c0, c0, 0
-
-	ldr	r1, =0x7fff
-	and	r2, r1, r0, lsr #13
-
-	ldr	r1, =0x3ff
-
-	and	r3, r1, r0, lsr #3	@ NumWays - 1
-	add	r2, r2, #1		@ NumSets
-
-	and	r0, r0, #0x7
-	add	r0, r0, #4	@ SetShift
-
-	clz	r1, r3		@ WayShift
-	add	r4, r3, #1	@ NumWays
-1:	sub	r2, r2, #1	@ NumSets--
-	mov	r3, r4		@ Temp = NumWays
-2:	subs	r3, r3, #1	@ Temp--
-	mov	r5, r3, lsl r1
-	mov	r6, r2, lsl r0
-	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-	mcr	p15, 0, r5, c7, c6, 2
-	bgt	2b
-	cmp	r2, #0
-	bgt	1b
-	dsb
-	isb
-	mov	pc, lr
-ENDPROC(v7_invalidate_l1)
-
-/*
  * SIRFSOC specific entry point for secondary CPUs.  This provides
  * a "holding pen" into which all secondary cores are held until we're
  * ready for them to initialise.
