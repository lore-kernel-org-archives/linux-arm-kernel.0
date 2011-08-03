From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 3 Aug 2011 18:26:37 +0200
Subject: [PATCH] ARM: pxa: fix logic error in PJ4 iWMMXt handling
Message-ID: <20110803162637.GB919@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This got added in:

	commit ef6c84454f8567d4968c210d7d194fb711ed3739
	Author: Haojian Zhuang <haojian.zhuang@marvell.com>
	Date:   Wed Nov 24 11:54:25 2010 +0800

	    ARM: pxa: add iwmmx support for PJ4

which does:

-       mrc     p15, 0, r2, c15, c1, 0
-       orr     r2, r2, #0x3                    @ enable access to CP0 and CP1
-       mcr     p15, 0, r2, c15, c1, 0
+       @ enable access to CP0 and CP1
+       XSC(mrc p15, 0, r2, c15, c1, 0)
+       XSC(orr r2, r2, #0x3)
+       XSC(mcr p15, 0, r2, c15, c1, 0)

but then later does:

-       mrc     p15, 0, r4, c15, c1, 0
-       orr     r4, r4, #0x3                    @ enable access to CP0 and CP1
-       mcr     p15, 0, r4, c15, c1, 0
+       @ enable access to CP0 and CP1
+       XSC(mrc p15, 0, r4, c15, c1, 0)
+       XSC(orr r4, r4, #0xf)
+       XSC(mcr p15, 0, r4, c15, c1, 0)

Signed-off-by: Lennert Buytenhek <buytenh@laptop.org>

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 7fa3bb0..194a767 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -195,10 +195,10 @@ ENTRY(iwmmxt_task_disable)
 
 	@ enable access to CP0 and CP1
 	XSC(mrc	p15, 0, r4, c15, c1, 0)
-	XSC(orr	r4, r4, #0xf)
+	XSC(orr	r4, r4, #0x3)
 	XSC(mcr	p15, 0, r4, c15, c1, 0)
 	PJ4(mrc p15, 0, r4, c1, c0, 2)
-	PJ4(orr	r4, r4, #0x3)
+	PJ4(orr	r4, r4, #0xf)
 	PJ4(mcr	p15, 0, r4, c1, c0, 2)
 
 	mov	r0, #0				@ nothing to load
@@ -313,7 +313,7 @@ ENTRY(iwmmxt_task_switch)
 	teq	r2, r3				@ next task owns it?
 	movne	pc, lr				@ no: leave Concan disabled
 
-1:	@ flip Conan access
+1:	@ flip Concan access
 	XSC(eor	r1, r1, #0x3)
 	XSC(mcr	p15, 0, r1, c15, c1, 0)
 	PJ4(eor r1, r1, #0xf)
