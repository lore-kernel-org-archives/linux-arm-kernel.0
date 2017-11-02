From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Nov 2017 00:16:54 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
 <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
 <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1711020011400.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Nov 2017, Nicolas Pitre wrote:

> Well... I don't know what happened with Chris' testing either.
> 
> I *thought* I build tested it, but my .config had 
> CONFIG_DEBUG_SEMIHOSTING=y.

Here's the fixed patch. I won't submit it to the patch system before we 
understand how the previous one worked for Chris.

----- >8
Subject: debug printch/printascii: translate '\n' to "\r\n" not "\n\r"

Some terminals apparently have issues with "\n\r" and mess up the 
display. Let's use the traditional "\r\n" ordering.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reported-by: Chris Brandt <Chris.Brandt@renesas.com>

diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index ea9646cc2a..01d746efff 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -79,25 +79,28 @@ hexbuf:		.space 16
 
 ENTRY(printascii)
 		addruart_current r3, r1, r2
-		b	2f
-1:		waituart r2, r3
-		senduart r1, r3
-		busyuart r2, r3
-		teq	r1, #'\n'
-		moveq	r1, #'\r'
-		beq	1b
-2:		teq	r0, #0
+1:		teq	r0, #0
 		ldrneb	r1, [r0], #1
 		teqne	r1, #0
-		bne	1b
-		ret	lr
+		reteq	lr
+2:		teq     r1, #'\n'
+		bne	3f
+		mov	r1, #'\r'
+		waituart r2, r3
+		senduart r1, r3
+		busyuart r2, r3
+		mov	r1, #'\n'
+3:		waituart r2, r3
+		senduart r1, r3
+		busyuart r2, r3
+		b	1b
 ENDPROC(printascii)
 
 ENTRY(printch)
 		addruart_current r3, r1, r2
 		mov	r1, r0
 		mov	r0, #0
-		b	1b
+		b	2b
 ENDPROC(printch)
 
 #ifdef CONFIG_MMU
