From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Nov 2013 14:52:10 +0400
Subject: [PATCH 3/4] ARM: sa1100: drop entry-macro.S
In-Reply-To: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
Message-ID: <1383303131-29550-3-git-send-email-dmitry_eremin@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mach-sa1100 was converted to MULTI_IRQ_HANDLER, drop now-unused
entry-macro.S file.

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 arch/arm/mach-sa1100/include/mach/entry-macro.S | 41 -------------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S

diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
deleted file mode 100644
index 8cf7630..0000000
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for SA1100-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xfa000000		@ ICIP = 0xfa050000
-		add	\base, \base, #0x00050000
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base]		@ get irqs
-		ldr	\irqnr, [\base, #4]		@ ICMR = 0xfa050004
-		ands	\irqstat, \irqstat, \irqnr
-		mov	\irqnr, #0
-		beq	1001f
-		tst	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tst	\irqstat, #0x0f
-		moveq	\irqstat, \irqstat, lsr #4
-		addeq	\irqnr, \irqnr, #4
-		tst	\irqstat, #0x03
-		moveq	\irqstat, \irqstat, lsr #2
-		addeq	\irqnr, \irqnr, #2
-		tst	\irqstat, #0x01
-		addeqs	\irqnr, \irqnr, #1
-1001:
-		.endm
-
-- 
1.8.4.rc3
